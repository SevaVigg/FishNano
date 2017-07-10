assertFileNameCellName <- function( cell_lists, FileProperties){

assert 			<- list()
assert$num		<- TRUE
assert$SampleStr	<- TRUE
assert$dateEx		<- TRUE

assertVar <- function(Var, assert) {
			lapply( cell_lists, function(x) { 
					if(FileProperties[[Var]] != x[[Var]]) {
						cat( "Error. Cell ", x[[Var]],  " has ", Var," ", x[[Var]], 
						     " which does not correspond to file ", Var, " ", FileProperties[[Var]], "\n") 
						return( assert[[Var]] <- FALSE ) 
									}
							} 
				)
			}

assertRes	<-sapply( names(assert), function(x) assertVar(x, assert))

assert
}

