plotDir <- file.path(getwd(), "Plot")
SNEdropDir <- file.path(getwd(), "Plot", "tSNEdrop")

resDir	<- file.path(getwd(), "Res")

dir.create( plotDir, showWarnings = FALSE)
dir.create( SNEdropDir, showWarnings = FALSE)

drawDir <- SNEdropDir


source("R/seurat_new.r")
ipmc_orig <- ipmc_nh
source("R/TSNEClusters.r")
ipmc_48 <- SubsetData(ipmc_orig, cells.use = ipmc_orig@meta.data$cellNames[c48_keep])
ipmc_48 <- RunTSNE(ipmc_48, genes.use = rownames(ipmc_48@data))
ipmc_48 <- FindClusters(ipmc_48, genes.use = rownames(ipmc_48@data), k.param = 8, k.scale = 1000)
ipmc_48 <- BuildClusterTree(ipmc_48, genes.use = rownames(ipmc_48@data), do.reorder = TRUE, reorder.numeric = TRUE)

Cells <- rbind(Cells[,c48_keep], ipmc_48@ident)
rownames(Cells)[length(rownames(Cells))]	<- "id_ipmc_48"


png(paste0(drawDir, .Platform$file.sep, "clusterTree.png"))
	ipmc_48 <- BuildClusterTree(ipmc_48, genes.use = allGenes, do.reorder = TRUE,reorder.numeric = TRUE)
dev.off()

cellColors <- c("red", "orange", "black", "green", "blue", "magenta")

png(paste0(drawDir, .Platform$file.sep, "tSNPEplot.png"))
	TSNEPlot(ipmc_48, colors.use = cellColors)
dev.off()

nClust	<- nlevels(ipmc_48@ident)

geneLogMeans <- sapply(c("sox9b", "snail2", "ltk", "pnp4a", "mlphb"), function(gene){
		lapply(1:nClust, function(x) mean(as.numeric(ipmc_48@data[gene,which(ipmc_48@ident == x)])))
		})

png( filename = paste0(drawDir, .Platform$file.sep, "drop48LogMeans.png"))
	matplot(geneLogMeans, type = "b")
	legend("topright", legend = colnames(geneLogMeans), pch = 1, col = 1:nClust)
dev.off()

geneLogMedians <- sapply(c("sox9b", "snail2", "ltk", "pnp4a", "mlphb"), function(gene){
		lapply(1:nClust, function(x) median(as.numeric(ipmc_48@data[gene,which(ipmc_48@ident == x)])))
		})

png(paste0(drawDir, .Platform$file.sep, "drop48LogMedians.png"))
	matplot(geneLogMedians, type = "b")
	legend("topright", legend = colnames(geneLogMedians), pch = 1, col = 1:nClust)
dev.off()

png( filename = paste0(drawDir, .Platform$file.sep, "VlnLtk_48drop.png"))
	VlnPlot(ipmc_48, "ltk")
dev.off()

png( filename = paste0(drawDir, .Platform$file.sep, "VlnSnail2_48drop.png"))
	VlnPlot(ipmc_48, "snail2")
dev.off()
 
png( filename = paste0(drawDir, .Platform$file.sep, "VlnSox9b_48drop.png"))
	 VlnPlot(ipmc_48, "sox9b")
dev.off()

png( filename = paste0(drawDir, .Platform$file.sep, "VlnPnp4a_48drop.png"))
	VlnPlot(ipmc_48, "pnp4a")
dev.off()

png( filename = paste0(drawDir, .Platform$file.sep, "VlnPax7b_48drop.png"))
	VlnPlot(ipmc_48, "pax7b")
dev.off()
