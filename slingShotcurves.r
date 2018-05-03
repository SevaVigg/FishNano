require(slingshot)

seurObj <- MIGN

tSNEVals<-seurObj@dr$tsne@cell.embeddings
clust <- seurObj@ident
sds <- slingshot(tSNEVals, clust, start.clus = "5",end.clus=c("1", "2", "10"),extend="n",shrink=FALSE,thresh=0.1)

cellColors <- rep("grey", length(seurObj@ident))
cellColors[seurObj@ident == "1"] 	<- "black"
cellColors[seurObj@ident == "2"] 	<- "darkblue"
cellColors[seurObj@ident == "5"] 	<- "red"
cellColors[seurObj@ident == "10"]	<- "green"

tSNE1	<- tSNEVals[ , 1]
tSNE2	<- tSNEVals[ , 2]
tSNE3	<- tSNEVals[ , 3]

plot(tSNE2 ~ tSNE1, col = cellColors, cex = 0.7, pch = 16)
lines(sds, lwd = 1, type="lineages", cex = 0.5)

png(find.path(plotDir, "principal_curves.version_4.png"))
	plot(tSNE3 ~ tSNE1, col = cellColors, cex = 0.7, pch = 16)
	lines(sds, lwd = 1, type="curves")
dev.off()

png(find.path(plotDir, "lineages_version_4.png")
	plot(tSNE1 ~ tSNE3, col = cellColors, cex = 0.7, pch = 16)
	lines(sds, lwd = 2,type="lineages")
dev.off()
