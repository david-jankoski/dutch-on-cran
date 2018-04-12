
x <- "https://www.netherlandsgenealogy.com/surnames-all.php?tree="

x <-
  x %>%
  httr::GET() %>%
  httr::content()

surnames <-
  x %>%
  rvest::html_nodes(".titlebox")

surnames <- surnames[-(1:2)]

surnames_index <-
  surnames %>%
  rvest::html_nodes("p") %>%
  rvest::html_text()

surnames <-
  surnames %>%
  set_names(surnames_index) %>%
  map(~ {

    .x %>%
      rvest::html_nodes(".sntable") %>%
      rvest::html_nodes("a") %>%
      rvest::html_text()
  })





# CRAN db side --------------------------------

cran_db <- tools::CRAN_package_db()

keep_cols <- c("Package", "Author", "Authors@R", "Contact", "Maintainer","Date")

auths <- cran_db[ , keep_cols]

colnames(auths)[3] <- "NiceAuthors"
sample_auths <- cran_db[sample(20), keep_cols]

# Authors@R - eaasy
nice_auths <-
  auths %>%
  filter(!is.na(NiceAuthors)) %>%
  mutate(
    Surnames =
      map(NiceAuthors, ~ {
        # since its text, need to parse, eval it to get
        # vec of persons, then sub them (see help ?person)
        srnms <- eval(parse(text = .x))
        map_chr(srnms, format, include = "family")
      })
  )

surnames_by_pkg <-
  nice_auths %>%
  select(Package, Surnames) %>%
  unnest(Surnames)

# Author - bit more difficult need to
# remove stuff in between [] and <>, split on comma, remove "and"
auths %>%
  filter(is.na(NiceAuthors)) %>%
  mutate(

  )

t <- auths[c(2,7,13,16,22), "Author"]

gsub(pattern = "\\[{1}(a-z)*,+(a-z)\\]{1}", "", t)
