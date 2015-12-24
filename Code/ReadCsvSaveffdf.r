suppressMessages(library(ff))
suppressMessages(library(ffbase))

dataPath = "/media/mms/HomeLand/Know/DataAnalysisProjects/Airbnb/Data/Raw/"

readCsvSaveffdf = function(src, dest){
	data <-  read.csv.ffdf(file =paste0(dataPath, src, ".csv")
						, header = T
						, VERBOSE=TRUE)

	save.ffdf(data, dir=paste0(dataPath, dest))	
}

readData = function(src){
	load.ffdf(dir = paste0(dataPath, src) )
	return(data)
}

readffdfSaveCsv = function(src, dest){
	data = readData(src)
	write.csv(data, paste0(dataPath, dest, ".csv"), row.names=FALSE)
}

saveCsv = function(data, dest){
	write.csv(data, paste0(dataPath, dest, ".csv"), row.names=FALSE)
}
