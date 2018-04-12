### Description

I started this out of curiosity to see if can get to all the people which are (most probably) Dutch and have a package on CRAN, either as authors, maintainers or maybe even woodcutter (“wdc”), lyricist (“lyr”) or costume designer (“cst”) (or many other funny roles according to the [full comprehensive list](http://www.loc.gov/marc/relators/relaterm.html)).  

My main motivation was to help out the organiser of the amstRdam meetup group to find potential new speakers. This nice little group of people is keen on meeting more often, however it seems to be difficult to find people who are willing to share their work. (I suspect that this might be also out of reasons like not really believing that the work is worth of attention. Which I think should not be the point of having a meetup group - some basic show and tell is also great and we will get together afterall and have a chat and a beer :)  

### Idea

1. The CRAN db is provided by this nice recently introduced function `tools::CRAN_package_db()`. Currently it lists 12497 packages, so we need to find a way to "weed" out the dutchies :)  

2. First simple attempt is to find all listed names which have .nl as email ending.
