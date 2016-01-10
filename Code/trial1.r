suppressMessages(library(evtree))

runTrail1 = function(){

	firstHalf = "train_1stHalf"
	secondHalf = "train_2ndHalf"
	outputPath = "Figures/"
	frmla = country_destination ~ date_account_created+timestamp_first_active+date_first_booking+gender+age+signup_method+signup_flow+language+affiliate_channel+affiliate_provider+first_affiliate_tracked+signup_app+first_device_type+first_browser

	# divide train set into two parts
		# dividing DONE by CMD
	# saving in ffdf 
	# readCsvSaveffdf(firstHalf, firstHalf)
	# readCsvSaveffdf(secondHalf, secondHalf)


	# make decision tree model from 1st part
	firstHalf = readData("train_1stHalf")
	model = evtree(frmla, data = firstHalf)

	modelObjectName = "tree.rds"
	saveRDS(model, modelObjectName)

	png(paste0(outputPath, "tree_model_train_1stHalf_trial1",".png", sp = ""))
	
	tree = plot(model)
	print(tree)
	dev.off()


	# apply the model to the 2nd part

	# measure performance

}