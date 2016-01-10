suppressMessages(library(ff))
suppressMessages(library(ffbase))
suppressMessages(library(ffbase2))
suppressMessages(library(magrittr))

dataPath = "Data/Raw/"

replaceNAFromFeature= function(featureIndex, src){
	# read
	data = readData(src)

	# replace
	data[, featureIndex] = replace(data[, featureIndex], is.na(data[,featureIndex]), 0)
	print("Done")

}