ParseNanoStringName <- function(SourceNameStr){

source("R/getRegExpSubStr.r")

numStr 	<- getRegExpSubStr( SourceNameStr, regexpr( "[0-9][0-9]*.RCC", SourceNameStr) ) 	#strins contain .RCC suffix
num	<- as.numeric( substr( numStr, 1, nchar(numStr)-4) )

dateStr	<- getRegExpSubStr( SourceNameStr, regexpr( "201[0-9]*", SourceNameStr ) )
date	<- unlist( dateStr )

hourStr	<- getRegExpSubStr( SourceNameStr, regexpr( "[0-9][0-9]* *[hH][pP][fF]", SourceNameStr ) )  #strings contain .hpf suffix
hour	<- as.numeric( substr( hourStr, 1, nchar( hourStr)-3) ) 

dateInd	<- getRegExpSubStr( SourceNameStr, regexpr( " *[0-9][0-9]*-[0-9][0-9]*[\\-]*", SourceNameStr) )  #strings contain .hpf suffix
dateInd	<- unlist( substr( dateInd, 1, nchar(dateInd)-1) )

ans		<- list()
ans$num 	<- num
ans$date	<- date
ans$hour	<- hour
ans$dateInd	<- dateInd

ans
}

