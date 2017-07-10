updateCellNameFromFileProp <- function( cell_lists, FileProperties){

Vars = names(FileProperties)

updateCellName <- lapply(cell_lists, function(x) {if( is.na(x[[testVar]])){x[[testVar]] <- FileProperties[[testVar]]}else{x} }) 
updateCellName
}

