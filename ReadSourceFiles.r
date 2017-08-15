source("R/ReadNanoStringFile.r")
source("R/findDuplicated.r")

StartDir <- getwd()

RawPath 	<- file.path( StartDir, "Source", "Raw", "Zerbra_fish_cells")
SourcePath	<- file.path( RawPath, "All")
#FilteredPath	<- file.path( RawPath, "Filtered")
BadPath		<- file.path( RawPath, "BadFiles")
ResPath		<- file.path( StartDir, "Res")

dir.create( BadPath, showWarnings = FALSE)
dir.create( ResPath, showWarnings = FALSE)

filenames <- list.files(path = SourcePath, pattern=".csv$", full.names = TRUE )

for( FileName in filenames){								#find the first correct file
	CellTable       <- ReadNanoStringFile( FileName)
	filenames	<- filenames[-1]	
	if(is.na( CellTable)){
		file.rename( from = FileName,  to = file.path( BadPath, basename(FileName))); 
		next }else{ break}
}


for( FileName in filenames){
	NewTable	<- ReadNanoStringFile( FileName)
	filenames	<- filenames[-1]
	if(is.na(NewTable)){file.rename(from = FileName,  to = file.path( BadPath, basename(FileName))); next }

	
	if( !all(unlist(lapply( rownames(NewTable$CellDescs), function(Var) {
			if( all(!is.element(NewTable$CellDescs[Var,], CellTable$CellDescs[Var,])) 
			    & identical(CellTable$GenesProbes, NewTable$GenesProbes)){
			return( TRUE)}else{return(FALSE)}
								})))){
			CellTable$genes <- cbind(CellTable$genes, NewTable$genes)
			CellTable$CellDescs <- cbind(CellTable$CellDescs, NewTable$CellDescs)
	    }else{
		cat(FileName, " already present", "\n")
	}
}

dupTable  		<- findDuplicated(CellTable)					#Save duplicated entries
dupRecord		<- data.frame( 	unlist(CellTable$CellDescs["FileName",dupTable[1,]]), 
					unlist(CellTable$CellDescs["batch", dupTable[1,]]),
					unlist(CellTable$CellDescs["num", dupTable[1,]]),
					unlist(CellTable$CellDescs["FileName", dupTable[2,]]), 
					unlist(CellTable$CellDescs["batch", dupTable[2,]]), 
					unlist(CellTable$CellDescs["num", dupTable[2,]])	)
names(dupRecord)	<- c("File1", "batch1", "num1", "File2", "batch2", "num2")

dupFileName		<- paste0( ResPath, .Platform$file.sep, "Duplicates", ".csv" )
dupFile			<- file(dupFileName, open = "w")
write.table( dupRecord, file = dupFile, sep = "\t", row.names = FALSE)
close(dupFile)

CellTable$genes 	<- CellTable$genes[-dupTable[2,]]
CellTable$CellDescs 	<- CellTable$CellDescs[-dupTable[2,]]



