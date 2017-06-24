ParseNanoStringName <- function(SourceNameStr){

source("R/getRegExpSubStr.r")

numStr 	<- getRegExpSubStr( SourceNameStr, regexpr( "[0-9][0-9]*.RCC", SourceNameStr) ) 	#strins contain .RCC suffix
num	<- as.numeric( substr( numStr, 1, nchar(numStr)-4) )

dateStr	<- getRegExpSubStr( SourceNameStr, regexpr( "201[0-9]*", SourceNameStr ) )

hourStr	<- getRegExpSubStr( SourceNameStr, regexpr( "[0-9][0-9]* *[hH][pP][fF]", SourceNameStr ) )  #strings contain hpf suffix
hour	<- as.numeric( substr( hourStr, 1, nchar( hourStr)-3) ) 

dateInd	<- getRegExpSubStr( SourceNameStr, regexpr( " *[0-9][0-9]*-[0-9][0-9]*[\\-]*", SourceNameStr) )  # like " 03-05-" suffix
dateInd <- getRegExpSubStr( dateInd, regexpr( "[0-9][0-9]*-[0-9][0-9]*", dateInd ) )			 # like "03-05"

SampleStr	<- getRegExpSubStr( SourceNameStr, regexpr( "sample[s]* *[0-9][0-9]*-[0-9][0-9] *", SourceNameStr) )  	# like "sample[s] 1-2"
StartSample	<- as.numeric( getRegExpSubStr( SampleStr, regexpr( "[0-9][0-9]*", SampleStr) )	)				# like 1
EndSample	<- getRegExpSubStr( SampleStr, regexpr( "\\- *[0-9][0-9]*", SampleStr) )			        # like "-2"
EndSample	<- as.numeric( substr( EndSample, 2, nchar( EndSample) ) )								# like 2

ans		<- list()
ans$num 	<- num
ans$date	<- dateStr
ans$hour	<- hour
ans$dateInd	<- dateInd
ans$StartSample	<- StartSample
ans$EndSample	<- EndSample

ans

}

