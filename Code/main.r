#main.r
codePath = "Code/"
source(paste0(codePath, "ReadCsvSaveffdf.r"))
# source(paste0(codePath, "SummaryStatistics.r"))
source(paste0(codePath, "DataManipulation.r"))
# source(paste0(codePath, "Regression.r"))
# source(paste0(codePath, "trial1.r"))
source(paste0(codePath, "featureSelection.r"))


featureSelectionRegSub("train_users_2")
plotfeatureSelectionRegSubResults()

# featureSelection()


# replaceNAFromFeature(6, "train_1stHalf")
# runTrail1()



# data = readData("test_users")
# outputPath = ("Figures/test/")
# SummaryTrainOrTest(data, outputPath)


# src = "sessions_train"
# readCsvSaveffdf(src, src)

# SummaryStatistics("train_users_2")

# for (i in 9:ncol(data))
	# plotPieChart(data, outputPath, i)
