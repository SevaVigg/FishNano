require(data.table)

ipmc_orig	<- ipmc_nh

ipmc_nh 	<- FindClusters(ipmc_nh, genes.use = rownames(ipmc_nh@data), k.param = 8, k.scale = 1000)

png("Plot/SNNClusterTree.png")
	ipmc_nh 	<- BuildClusterTree(ipmc_nh, genes.use = allGenes, do.reorder = TRUE,reorder.numeric = TRUE)
dev.off()


c48_drop 	<- which(ipmc_nh@ident %in% c(4,5,6,7,8))
c48_keep	<- which( ! ipmc_nh@ident %in% c(4,5,6,7,8))



ipmc_nh <- RunTSNE(ipmc_nh, genes.use = allGenes_nh)

Cells <- rbind(Cells, ipmc_nh@ident)
rownames(Cells)[length(rownames(Cells))]	<- "ipmc_ids"

png("Plot/TSNEClustersAll.png")
TSNEPlot(ipmc_nh)
dev.off()


