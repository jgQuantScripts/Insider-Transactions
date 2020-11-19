# **********************************************************************************
#                         WRAPPERS
# **********************************************************************************
require("rvest")
formatVOL <- function(x){as.numeric(gsub(",","",x))}
# **********************************************************************************
#                INSIDER TRANSACTIONS
# **********************************************************************************
url <- "https://finviz.com/insidertrading.ashx"
TABLE <- read_html(url)
TABLE <- TABLE  %>% html_nodes("table") %>% .[[6]] %>%html_table(header=TRUE,fill=TRUE)
noms <- names(TABLE)
noms <- gsub("#","Num",noms)
noms <- gsub("\\$","Dollar",noms)
noms <- gsub("\\(","",noms)
noms <- gsub("\\)","",noms)
noms <- gsub(" ","",noms)
colnames(TABLE) <- noms
TABLE$Date <- as.Date(as.character(TABLE$Date),format="%b %d")
TABLE$NumShares<- formatVOL(TABLE$NumShares)
TABLE$ValueDollar<- formatVOL(TABLE$ValueDollar)
TABLE$NumSharesTotal<- formatVOL(TABLE$NumSharesTotal)
TABLE$SECForm4 <- as.POSIXct(as.character(TABLE$SECForm4), format ="%b %d %I:%M %p")
