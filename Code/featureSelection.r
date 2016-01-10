suppressMessages(library(leaps))

featureSelectionRegSub = function(dataSrc){
	suppressMessages(library(doMC))
	registerDoMC(cores = 4)

	data = readData(dataSrc)
	frmla = country_destination ~ gender+age+signup_method+signup_flow+language+affiliate_channel+affiliate_provider+first_affiliate_tracked+signup_app+first_device_type
	
	leaps = regsubsets(frmla, data = data, nbest = 10, really.big= T)


	modelObjectName = "leaps.rds"
	saveRDS(leaps, modelObjectName)
}

plotfeatureSelectionRegSubResults = function(){
	model = readRDS("leaps.rds")

	summary(model)
}

featureImportance = function(){
	suppressMessages(library(caret))
	suppressMessages(library(doMC))
	registerDoMC(cores = 4)

	frmla = country_destination ~ gender+age+signup_method+signup_flow+language+affiliate_channel+affiliate_provider+first_affiliate_tracked+signup_app+first_device_type
	
	data = readData("train_users_2")

	control = trainControl(method="repeatedcv", number = 5, repeats = 3)
	print(">> control DONE")

	model = train(frmla, data = data, method = "lvq", trControl = control)
	print(">> model DONE")

	importance = varImp(model, scale = FALSE)

	print(importance)
}





featureSelection = function(){
	# ensure the results are repeatable
	set.seed(7)
	# load the library
	library(caret)
	# load the data
	data = readData("train_1stHalf")
	# define the control using a random forest selection function
	control <- rfeControl(functions=rfFuncs, method="cv", number=10)
	# run the RFE algorithm
	results <- rfe(data[,3:15], data[,16], sizes=c(3:15), rfeControl=control)
	# summarize the results
	print(results)
	# list the chosen features
	predictors(results)
	# plot the results
	png("predictors.png")
	g = plot(results, type=c("g", "o"))
	print(g)
	dev.off()
}