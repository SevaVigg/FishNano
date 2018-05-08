dir.create(file.path(getwd(), "Plot", "clustersCurves"), showWarnings = FALSE)
plotDir	<- file.path(getwd(), "Plot", "clustersCurves")

source("R/seuratNorm.r")

origIdent <- ipmc@ident

comps <- 15

source("R/calcTSNE_PCASpace.r")
resolDec <- 70 

source("R/FetchTSNEClustersPCASpace.r")
clust <- ipmc@ident

source("R/getClusterTypes.r")

clustTypes 	<- getClusterTypes(ipmc)

ipmc_MD 	<- RunTSNE(ipmc, dims.use = 1:comps, theta = 0, perplexity = 15, dim.embed = comps)

tSNEVals_MD	<- as.matrix(ipmc_MD@dr$tsne@cell.embeddings)

if(!require(slingshot)){
  install.packages("slingshot")
}
 
slingObj_MD 	<- slingshot(tSNEVals_MD, clust, start.clus = clustTypes["Tl"],end.clus=c(clustTypes["I"], clustTypes["M"]))

cat("Now getting principle curves\n")

slingObj_MD	<- getCurves(slingObj_MD, extend = "n", shrink = TRUE, thresh = 0.001, maxit = 10)
psTime		<- pseudotime(slingObj_MD)
source("R/getPseudoOrder.r")
curves		<- getPseudoOrder(slingObj_MD)


source("R/setClusterColors.r")
cellColors <- setClusterColors(ipmc, clustTypes)

ipmc_2D		<- RunTSNE(ipmc, dims.use = 1:comps, theta = 0, perplexity = 15, dim.embed = 2)
plotVals	<- ipmc_2D@dr$tsne@cell.embeddings
curveVals	<- plotVals[ names(curves[["curve23"]]),]  

plot( plotVals[,2]~plotVals[,1], cex = 0.7, pch = 16, col = cellColors)
lines( curveVals)

# И вот последняя строчка должна бы строить на двумерной картинки линеаджи так, как в многомерии, но поскольку кластеры смещаются - получается плохо
#lines( slingObj_MD, lwd = 1, type="lineages", cex = 0.5)






