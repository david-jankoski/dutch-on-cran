library("magrittr")
library("stringr")
library("purrr")
library("dplyr")

# load the CRAN pkg db 
cran <- tools::CRAN_package_db()

# get only cols of interest, remove orphaned pkgs
cols_of_interest <- 
  c(
    "Package", "Description", 
    "Author", "Maintainer", "URL",
    "Date", "Packaged", "Published"
  )

cran <- cran[cran$Maintainer != "ORPHANED", cols_of_interest]

# maintainers, remove pesky < > 
maintainers <- stringr::str_extract(cran$Maintainer, "<.*>")

maintainers <- 
  maintainers %>% 
  stringr::str_replace("<", "") %>% 
  stringr::str_replace(">", "")

# get the domains from maintainer emails
doms <- 
  maintainers %>% 
  strsplit("@") %>% 
  map_chr(2L) %>% 
  strsplit("\\.") %>% 
  map_chr(~ last(.))

# which ones are 100% dutch ?
dutchies <- grepl("nl", doms)

# omg omg omg look at all this meetup material :-)
sprintf("hey there are %d dutch pkgs on cran! sooo many meetups :-) ", sum(dutchies))

dutch_pkgs <- cran[which(dutchies), ]

# from the several datetime columns "Packaged"/"Published"
# seem most reliable
dutch_pkgs <- arrange(dutch_pkgs, desc(Packaged))
