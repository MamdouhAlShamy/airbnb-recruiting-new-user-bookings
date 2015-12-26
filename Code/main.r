#main.r
codePath = "/media/mms/HomeLand/Know/DataAnalysisProjects/Airbnb/Code/"
source(paste0(codePath, "ReadCsvSaveffdf.r"))
source(paste0(codePath, "SummaryStatistics.r"))
# source(paste0(codePath, "DataManipulation.r"))
# source(paste0(codePath, "Regression.r"))

# src = "sessions_train"
# readCsvSaveffdf(src, src)

src = "sessions_train"
data = readData(src)
for(i in 2:5){
	# i = 2
	plotPieChart(data, i)	
}
