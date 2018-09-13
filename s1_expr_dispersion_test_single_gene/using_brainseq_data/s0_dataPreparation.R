library(SummarizedExperiment)
# data source: http://eqtl.brainseq.org/phase1/
load("rse_gene_BrainSeq_Phase1_hg19_TopHat2_EnsemblV75.rda")

# Use geneMetadata to identify rows for protein-coding genes, and extract 
# corresponding rows from counts.
counts <- rse_gene@assays$data$counts[rse_gene@rowRanges$Symbol!="",]
geneMetadata <- rse_gene@rowRanges[rse_gene@rowRanges$Symbol!="",]

# Compute RPKM or TPM values for genes, using gene length info in geneMetadata
FPKM <- (t(t(counts)/(colSums(counts)/1e6)))/(width(geneMetadata)/1e3)

# Remove extremely lowly expressed genes (such as 5% of genes with smallest average RPKM
meanExp <- rowMeans(FPKM)
FPKM <- FPKM[meanExp > quantile(meanExp, 0.55),]
geneMetadata <- geneMetadata[meanExp > quantile(meanExp, 0.55),]


# Do quantile normalization
qn <- function(df){
  df_rank <- apply(df,2,rank,ties.method="min")
  df_sorted <- data.frame(apply(df, 2, sort))
  df_mean <- apply(df_sorted, 1, mean)
  
  index_to_mean <- function(my_index, my_mean){
    return(my_mean[my_index])
  }
  
  df_final <- apply(df_rank, 2, index_to_mean, my_mean=df_mean)
  rownames(df_final) <- rownames(df)
  return(df_final)
}
qnFPKM <- qn(FPKM)
qnFPKM <- round(qnFPKM,4)

# use PEER with selected known covariates (in patientMetadta) to process the RPKM matrix
covs <- colData(rse_gene)
write.csv(covs[,c("Age","Sex","Race","Manner_Of_Death", "Antipsychotics", "Antidepressants", "Cotinine", "Nicotine", "SmokingEither", "AgeOnsetSchizo", "PMI", "Dx")],"Cov.csv")
covs <- covs[,c("Age","Sex","Race","Manner_Of_Death", "Antipsychotics", "Antidepressants", "Cotinine", "Nicotine", "SmokingEither", "AgeOnsetSchizo", "PMI")]

library(peer)
model = PEER()
PEER_setPhenoMean(model,as.matrix(t(qnFPKM)))
PEER_setCovariates(model, as.matrix(covs))
PEER_setNk(model,10)
PEER_update(model)
qnFPKMn <- PEER_getResiduals(model)
qnFPKMn <- t(qnFPKMn)

# Separate RPKM matrix into Dx and Dc matrices for cases and controls
Dc <- apply(qnFPKM[,colData(rse_gene)[,"Dx"] == "Control"],1,median) + qnFPKMn[,colData(rse_gene)[,"Dx"] == "Control"]
Dx <- apply(qnFPKM[,colData(rse_gene)[,"Dx"] == "Schizo"],1,median) + qnFPKMn[,colData(rse_gene)[,"Dx"] == "Schizo"]
write.table(x = Dc, file = "Dc.csv", row.names = FALSE, col.names = FALSE, sep=",")
write.table(x = Dx, file = "Dx.csv", row.names = FALSE, col.names = FALSE, sep=",")

#Make gene names (symbols) into a list, and create a mat file contains the variables Dx, Dc and geneid (see below for the example)
write.table(x= geneMetadata$Symbol, quote = FALSE, file="genid.csv", row.names = FALSE, col.names = FALSE, sep=",")
