suppressMessages(library(ff))
suppressMessages(library(ffbase))
suppressMessages(library(ffbase2))
suppressMessages(library(magrittr))
suppressMessages(library(ggplot2))
suppressMessages(library(RColorBrewer))

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

getNumberOfUniqueIds = function(src){
	load.ffdf(dir = paste0(dataPath, src) )
	
	x = data %>%
		tbl_ffdf() %>%
		group_by(user_id) %>%
		summarise(uniqueId = n_distinct(user_id))

	nrow(x)

}


plotPieChart = function(data, i){
	featureNameN = colnames(data)[i]
  	feature_df <<- data.frame(featureName = data[, i])

	png(paste0("Figures/sessions_train/", featureNameN,".png", sp = ""))
	pie <- ggplot(feature_df, aes(x = factor(1),  fill = factor(featureName))) +
 	geom_bar(width = 5) +
 	coord_polar(theta = "y") +
 	scale_fill_brewer(palette = "Set3") +
 	labs(title = featureNameN)

 	print(pie)

	dev.off()

}