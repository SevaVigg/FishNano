updateFilePropFromCellList <- function( cell_lists, FileProperties){

Vars <- names(FileProperties)

cellVars <- sapply( cell_lists, function(s) s)

updateFileProp <- lapply(Vars, function(testVar){if( is.na(FileProperties[[testVar]])){
							if( any( cellVars[testVar, ] != cellVars[,1][[testVar]])){ 
								cat( "Different cell values of ", testVar, "\n"); return(NA)
									      }else{ cellVars[ ,1][[testVar]]}			#end if different cells
										}else{ FileProperties[[testVar]]}		#end if file is na
						}
			)
updateFileProp
}

