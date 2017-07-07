ReadNanoStringFile <- function( FileName){
source("R/assertFileNameCellName.r")
source("R/ParseNanoStringName.r")

	FileProperties <- ParseNanoStringName( FileName)

	cat( "Processing file ", FileName, "\n")

	datafile 	<- file( FileName, open = "r" ) 
	data 		<- read.csv( datafile, sep=",", header=TRUE, stringsAsFactors=FALSE, check.names = FALSE )
	close(datafile)

	cell_inds	<- grep( "study", colnames( data ) )	
	cell_strs 	<- colnames( data)[cell_inds]
	cell_lists	<- lapply( cell_strs, ParseNanoStringName)

	if( !assertFileNameCellName( cell_lists, FileProperties)){ return(ans <- NA)}

	if( sum( colnames(data)[cell_inds] != data[1, cell_inds]) == 0) { data <- data[-1,]} else { cat( "No name string with duplicates", "\n"); return( ans<-NA)}
	
	CellDescs <- as.data.frame( do.call( cbind, cell_lists))
	
	resTable <- data[, cell_inds]
	colnames(resTable) 		<- paste( unlist( CellDescs["hpf",]),".",unlist( CellDescs["num",]), sep = "")
	colnames(CellDescs)	  	<- colnames(resTable)
	rownames(resTable) 		<- data[, "Gene Name"]

	GenesProbes	<- data[,c("Gene Name", "Annotation", "Accession #", "Class Name", "Target Sequence")]

	ans		<- list()	 	
	ans$genes	<- resTable	
	ans$CellDescs	<- CellDescs
	ans$GenesProbes	<- GenesProbes	
	ans
}

