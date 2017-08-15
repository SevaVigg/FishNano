findDuplicated <- function(CellTable){
	dupInd 		<- which(duplicated(t(CellTable$genes)))
	dupTable	<- apply(CellTable$genes[dupInd], 2, function(y) {which(apply(CellTable$genes,2, function(x) all(x == y)))})
	dupTable
}				#main
