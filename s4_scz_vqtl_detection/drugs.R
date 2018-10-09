library(XML)
library(RCurl)
input <- "https://bioinfo.uth.edu/SZGR/displayDrug.do"
download.file(input, destfile = "all.txt")
all <- readHTMLTable(readLines("all.txt"))[[1]]

lsapply(as.vector(all[,1]), function(id){
  input <- paste0("https://bioinfo.uth.edu/SZGR/displayDrugTarget.do?drugid=",id)
  download.file(url = input, destfile = paste0(id,".txt")) 
  out <- readHTMLTable(readLines(paste0(id,".txt")))[[1]]
  out <- paste0(out[-nrow(out),2],collapse = ";")
})

