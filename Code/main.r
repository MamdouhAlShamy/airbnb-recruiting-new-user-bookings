#main.r
codePath = "/media/mms/HomeLand/Know/DataAnalysisProjects/Airbnb/Code/"
source(paste0(codePath, "ReadCsvSaveffdf.r"))
# source(paste0(codePath, "DataManipulation.r"))
# source(paste0(codePath, "Regression.r"))




SummaryStatistics = function(ffdfName){
	
	data = readData(ffdfName)
	
	print(paste0("# dim: ", nrow(data), " x ", ncol(data)))

	for(i in 1:ncol(data)){
		print(paste("* ", colnames(data)[i], ": " ))
		str(data[, i])
	}

	print("****")

	for(i in 1:ncol(data)){
		print(colnames(data)[i])
		print(str(data[,i]))
		print(summary(data[, i]))
		print("-")
		print("---------------------------")
		print("-")
	}

}


SummaryStatistics("age_gender_bkts")