rm(list=ls(all=TRUE))
library(readxl)
library(randomForest)
library(rmweather)
library(openair)
library(knitr)
library(ranger)
library(plyr)
library(dplyr)
modelout <- "Model outputs/"
#filename = "Beijing_Urban"
filenamelist<-list("beijing","chengdu","chongqing","harbin","hefei","hohhot","shenyang","shijiazhuang","urumqi","wuhan","xian","zhengzhou")

for (filename in filenamelist){
  polllist<-list("PM2.5")
  for (poll in polllist){
    a=paste("D:/COVID-19/",modelout,filename,"/",filename,"_",poll,"_RW.RData",sep='')
    load(a)
    testing_model <- rmw_predict_the_test_set(model = RF_modelo$model,df = RF_modelo$observations) 
    model_performance<-modStats(testing_model, mod = "value", obs = "value_predict", 
                                statistic = c("n", "FAC2","MB", "MGE", "NMB", "NMGE", "RMSE", "r","COE", "IOA"),
                                type = "default", rank.name = NULL)
    
    normli<-cbind(RF_modelo$normalised,RF_modelo$observations$value)
    write.table(testing_model, file=paste("D:/COVID-19/",modelout,filename,"/",filename,"_",poll,"_testing_model.csv",sep=""), sep=",", row.names=FALSE)
    write.table(normli, file=paste("D:/COVID-19/",modelout,filename,"/",filename,"_",poll,"_normalised.csv",sep=""), sep=",", row.names=FALSE)
  }
}
