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


plotPieChart = function(data, outputPath, featureIndex){
	featureName = colnames(data)[featureIndex]
  	feature_df <<- data.frame(featureName = data[, featureIndex])

	png(paste0(outputPath, featureName,".png", sp = ""))

	pie <- ggplot(feature_df, aes(x = factor(1),  fill = factor(featureName))) +
 	geom_bar(width = 5) +
 	coord_polar(theta = "y") +
 	scale_fill_brewer(palette = "Set3") +
 	labs(title = featureName) 
 	# theme(legend.position="bottom")


 	print(pie)
	dev.off()

}

plotHistogram = function(data, outputPath, featureIndex){

	featureName = colnames(data)[featureIndex]
  	feature_df <<- data.frame(featureName = data[, featureIndex])

  	featureSummary = summary(feature_df$featureName)
    
	png(paste0(outputPath, featureName,".png", sp = ""))

    # Histogram
    histogram = ggplot(data = feature_df
                       , aes(x = feature_df$featureName)) +
      xlab(featureName) +
      ylab("Freq") +
      geom_histogram() +
      geom_vline(xintercept = featureSummary["Mean"]
                 , color = "red"
                 , size = 1) +
      geom_vline(xintercept = featureSummary["Median"]
                 , color = "blue"
                 , size = 1) +
      scale_x_log10()
    
 	print(histogram)
	dev.off()

}

SummaryTrainOrTest = function(data, outputPath){
	plotHistogram(data, outputPath, 6)

	for (i in c(5,7,9:ncol(data)))
		plotPieChart(data, outputPath, i)
}