source("R/ParseNanoStringName.r")
source("R/assertFileNameCellName.r")

StartDir <- getwd()
SourcePath <- file.path( StartDir, "Source", "Raw", "Zerbra_fish_cells", "Filtered", fsep = "/" )

filenames <- list.files(path = SourcePath, pattern=".csv$", full.names = TRUE )

FileName <- filenames[2]

FileProperties <- ParseNanoStringName( FileName)


getTables <- function (filename, FileProperties) {
	cat("Processing file ", filename, "\n")

	datafile 	<- file( filename, open = "r" ) 
	data 		<- read.csv( datafile, sep=",", header=TRUE, stringsAsFactors=FALSE, check.names = FALSE )
	close(datafile)

	cell_inds	<- grep( "study", colnames( data ) )	
	cell_strs 	<- colnames( data)[cell_inds]
	cell_lists	<- lapply( cell_strs, ParseNanoStringName)

	if( !assertFileNameCellName( cell_lists, FileProperties)){ return(ans <- NA)}

	if( sum( colnames(data)[cell_inds] != data[1, cell_inds]) == 0) { data <- data[-1,]} else { cat( "No extra string", "\n"); return( ans<-NA)}
	
	Descs <- as.data.frame( do.call( cbind, cell_lists))
	
	resTable <- data[, cell_inds]
	colnames(resTable) <- paste( unlist( Descs["hpf",]),".",unlist( Descs["num",]), sep = "")
	colnames(Descs)	   <- colnames(resTable)
	rownames(resTable) <- data[, "Gene Name"]

	GenesProbes	<- data[,c("Gene Name", "Annotation", "Accession #", "Class Name", "Target Sequence")]

	ans		<- list()	 	
	ans$genes	<- resTable	
	ans$Descs	<- Descs
	ans$GenesProbes	<- GenesProbes	
	ans
}



resTable       <- getTables(FileName, FileProperties )	

