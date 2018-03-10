
#This snippet identifies clusters in the PCA space and appends cluster ids to the cell annotation file
#it uses ipmc Seurat object prepared by CalcTSNE_PCASpace.r

#dir.create(file.path(getwd(), "Res"), showWarnings = FALSE)
#dir.create(file.path(getwd(), "Plot"), showWarnings = FALSE)

dir.create(file.path(getwd(), "Res", "PCASpaceClusters"), showWarnings = FALSE)
dir.create(file.path(getwd(), "Plot", "PCAClusterPlot"), showWarnings = FALSE)

resDir 	<- file.path(getwd(), "Res", "PCASpaceClusters")
plotDir	<- file.path(getwd(), "Plot", "PCAClusterPlot")

#Fetch Clusters

ipmc	 	<- FindClusters(ipmc, reduction.type = "pca", dims.use = 1:comps, resolution = 0.6, print.output = 0)

png(file.path(plotDir, paste0("SNN_ClusterTreePCAS", "_c", comps, ".png")))
	ipmc 	<- BuildClusterTree(ipmc, pcs.use = 1:5, do.reorder = TRUE, reorder.numeric = TRUE, show.progress = FALSE)
dev.off()

Cells <- rbind(Cells, ipmc@ident)
rownames(Cells)[length(rownames(Cells))]	<- paste0("ClusterPCASp_c", comps)

IPclust <- Cells["ClusterPCASp_c5", Cells["CellType",]=="IP"]

png(file.path(plotDir, paste0("TSNE_ClustersPCAS", "_c", comps, ".png")))
	TSNEPlot(ipmc)
dev.off()

#write.table(Cells, file = file.path( resDir, "CellClustersAll.tsv"), sep = "\t")
#write.table(Genes, file = file.path( resDir, "GenesAllCl.tsv"), sep = "\t")







