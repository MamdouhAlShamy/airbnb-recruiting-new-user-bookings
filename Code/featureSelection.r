suppressMessages(library(leaps))
suppressMessages(require(ggplot2))
suppressMessages(library(Boruta))


modelObjectName = "leaps_nb10FW.rds"

featureSelectionBoruta = function(dataSrc){
	suppressMessages(library(doMC))
	registerDoMC(cores = 4)
	data = readData(dataSrc)
	str(data)
	frmla = country_destination ~ gender+age+signup_method+signup_flow+language+affiliate_channel+affiliate_provider+first_affiliate_tracked+signup_app+first_device_type
	print("ready to model")
	model = Boruta(formula = frmla , data  = data, doTrace = 2, ntree= 500)
	print(model)
}

featureSelectionRegSubConfig = function(dataSrc, nbest, nvmax, method){

	suppressMessages(library(doMC))
	registerDoMC(cores = 4)

	data = readData(dataSrc)
	frmla = country_destination ~ gender+age+signup_method+signup_flow+language+affiliate_channel+affiliate_provider+first_affiliate_tracked+signup_app+first_device_type
	
	leaps = regsubsets(frmla, data = data, nbest = nbest, method = method, nvmax = nvmax, really.big= T)
	
	modelName = paste0("featureSelectionRegSub_", nbest, nvmax, method)
	saveRDS(leaps, modelName)

	print(summary(leaps))

	# png(paste0("featureSelectionRegSub_", nbest, nvmax, method,"_bic.png")
	# 	, width = 5
	# 	, height = 5
	# 	, units = "in"
	# 	, res = 1400
	# 	, pointsize = 5)
	# g = plot(leaps, scale = "bic")
	# print(g)
	# dev.off()

	# png(paste0("featureSelectionRegSub_", nbest, nvmax, method,"_adjr2.png")
	# 	, width = 5
	# 	, height = 5
	# 	, units = "in"
	# 	, res = 1400
	# 	, pointsize = 5)
	# g = plot(leaps, scale = "adjr2")
	# print(g)
	# dev.off()
}


featureSelectionRegSub = function(dataSrc){
	suppressMessages(library(doMC))
	registerDoMC(cores = 4)

	data = readData(dataSrc)
	frmla = country_destination ~ gender+age+signup_method+signup_flow+language+affiliate_channel+affiliate_provider+first_affiliate_tracked+signup_app+first_device_type
	
	leaps = regsubsets(frmla, data = data, nbest = 10, method = forward, really.big= T)

	saveRDS(leaps, modelObjectName)
}

plotfeatureSelectionRegSubResults = function(){
	model = readRDS(modelObjectName)

	png("featureSelectionRegSub_bic.png"
		, width = 5
		, height = 5
		, units = "in"
		, res = 1400
		, pointsize = 5)
	g = plot(model, scale = "bic")
	print(g)
	dev.off()

	png("featureSelectionRegSub_adjr2.png"
		, width = 5
		, height = 5
		, units = "in"
		, res = 1400
		, pointsize = 5)
	g = plot(model, scale = "adjr2")
	print(g)
	dev.off()
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