assertFileNameCellName <- function( cell_lists, FileProperties){

ans <- TRUE

	lapply( cell_lists, function(x) { if(FileProperties$hpf != x$hpf) 
		{cat( "Error. Cell ", x$num,  " has hpf ", x$hpf, 
			" which does not correspond to file hpf ", FileProperties$hpf, "\n") 
		return(ans <- FALSE)} } )

	lapply( cell_lists, function(x) { if( FileProperties$SampleStart != x$SampleStart) 
		{cat( "Error. Cell ", x$num, " has SampleStart ", x$SampleStart, 
			" which does not correspond to file SampleStart ", FileProperties$SampleStart, "\n") 
		return(ans <- FALSE)} } )

	lapply( cell_lists, function(x) { if( FileProperties$SampleEnd != x$SampleEnd) 
		{cat( "Error. Cell ", x$num, " has SampleEnd ", x$SampleEnd, 
			" which does not correspond to file SampleEnd ", FileProperties$SampleEnd, "\n") 
		return(ans <- FALSE)} } )

	lapply( cell_lists, function(x) { if( FileProperties$dateEx != x$dateEx) 
		{cat( "Error. Cell ", x$num, " has dateEx ", x$dateEx, 
			" which does not correspond to file dateEx ", FileProperties$dateEx, "\n") 
		return(ans <- FALSE)} } )


ans
}

