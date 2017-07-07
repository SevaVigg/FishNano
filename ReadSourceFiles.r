source("R/ReadNanoStringFile.r")

StartDir <- getwd()
SourcePath <- file.path( StartDir, "Source", "Raw", "Zerbra_fish_cells", "Filtered", fsep = "/" )

filenames <- list.files(path = SourcePath, pattern=".csv$", full.names = TRUE )

FileName <- filenames[1]

CellTable       <- ReadNanoStringFile( FileName)	

for( FileName in filenames[-1]){
	NewTable	<- ReadNanoStringFile( FileName)

	if( all(!is.element(NewTable$CellDescs["batch",], CellTable$CellDescs["batch",])) 
		& identical(CellTable$GenesProbes, NewTable$GenesProbes)){
	
			CellTable$genes <- cbind(CellTable$genes, NewTable$genes)
			CellTable$CellDescs <- cbind(CellTable$CellDescs, NewTable$CellDescs)
		}else{
		cat(FileName, " already present", "\n")
	}
}
