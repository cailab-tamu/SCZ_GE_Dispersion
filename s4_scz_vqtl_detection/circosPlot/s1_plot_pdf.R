#install.packages("circlize")
library(circlize)

file <- "T6sig.txt"
fileContent <- read.csv(file, stringsAsFactors = FALSE)
genePosition <- read.csv("hg19_genePosition.txt", sep = "\t", stringsAsFactors = FALSE)
genePosition <- genePosition[genePosition[,2] %in% c(1:22,"X","Y"),]
genePosition <- genePosition[genePosition[,1] %in% fileContent[,2],]

fileContent <- fileContent[fileContent[,2] %in% genePosition[,1],]

bed1 <- data.frame(chr=paste0("chr",fileContent[,3]), start=fileContent[,4], end=fileContent[,4])
temp <- t(sapply(fileContent[,2], function(x){
  y <- genePosition[,1] %in% x
  c(min(genePosition[y,2]),min(genePosition[y,3]),min(genePosition[y,4]))
}))
temp[,1] <- paste0("chr",temp[,1])
colnames(temp) <- c("chr","start","end")
bed2 <- as.data.frame(temp)
pdf(file = gsub(".txt",".pdf",basename(file)))
circos.initializeWithIdeogram()
colors <- sample(1:5, 20, replace = TRUE)
circos.genomicLink(bed1,bed2)
circos.clear()
dev.off()
