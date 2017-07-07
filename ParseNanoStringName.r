ParseNanoStringName <- function(SourceNameStr){

source("R/getRegExpSubStr.r")

numStr 	<- getRegExpSubStr( SourceNameStr, regexpr( "[0-9][0-9]*.RCC", SourceNameStr) ) 	#strings contain .RCC suffix
num	<- as.numeric( substr( numStr, 1, nchar(numStr)-4) )

batchStr	<- getRegExpSubStr( SourceNameStr, regexpr( "201[0-9]*", SourceNameStr ) )

hpfStr	<- getRegExpSubStr( SourceNameStr, regexpr( "[0-9][0-9]* *[hH][pP][fF]", SourceNameStr ) )  #strings contain hpf suffix
hpf	<- as.numeric( substr( hpfStr, 1, nchar( hpfStr)-3) ) 

dateEx	<- getRegExpSubStr( SourceNameStr, regexpr( " *[0-9][0-9]*-[0-9][0-9]*[\\-]*", SourceNameStr) )  # like " 03-05-" suffix
dateEx <- getRegExpSubStr( dateEx, regexpr( "[0-9][0-9]*-[0-9][0-9]*", dateEx ) )			 # like "03-05"

if( regexpr( "sample[s]*", SourceNameStr) != -1){
	SampleStr	<- getRegExpSubStr( SourceNameStr, regexpr( "sample[s]* *[0-9][0-9]*-[0-9][0-9] *", SourceNameStr) )  	# like "sample[s] 1-2"
	SampleStart	<- as.numeric( getRegExpSubStr( SampleStr, regexpr( "[0-9][0-9]*", SampleStr) )	)			# like 1
	SampleEnd	<- getRegExpSubStr( SampleStr, regexpr( "\\- *[0-9][0-9]*", SampleStr) )			        # like "-2"
	SampleEnd	<- as.numeric( substr( SampleEnd, 2, nchar( SampleEnd) ) )						# like 2	
	
	}else{															
	
	SampleDateStr	<- getRegExpSubStr( SourceNameStr, regexpr( "[0-9][0-9]*-[0-9][0-9]* *[0-9][0-9]*-[0-9][0-9]*", SourceNameStr) ) # like 04-06 1-12
	SampleStr	<- getRegExpSubStr( SampleDateStr, regexpr( "[0-9][0-9]*-[0-9[0-9]*$", SampleDateStr))				 # like 1-12
	SampleStart	<- as.numeric( getRegExpSubStr( SampleStr, regexpr( "[0-9][0-9]*", SampleStr) )	)			# like 1
	SampleEnd	<- getRegExpSubStr( SampleStr, regexpr( "\\- *[0-9][0-9]*", SampleStr) )			        # like "-2"
	SampleEnd	<- as.numeric( substr( SampleEnd, 2, nchar( SampleEnd) ) )						# like 2
}					


ans		<- list()
ans$num 	<- num + SampleStart - 1
ans$batch	<- batchStr
ans$hpf		<- hpf
ans$dateEx	<- dateEx
ans$SampleStart	<- SampleStart
ans$SampleEnd	<- SampleEnd

ans

}

