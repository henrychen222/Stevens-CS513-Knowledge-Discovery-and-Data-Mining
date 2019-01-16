# duration loudness tempo




# clear environment
rm(list = ls())

# load data
fileData <-
  read.csv("/Users/weichen/Downloads/data.csv",
           na.strings = "?")

### remove all the records with missing value
fileData <- na.omit(fileData)
fileData <- fileData[,c(-1, -13, -15, -16)]
# fileData <- fileData[,c(-1, -4, -9, -12, -13, -15, -16)]

# Use every 5th record to create the test dataset and use the remaining records to create the training dataset.
index <-
  seq(1, nrow(fileData), by = 5)  
print(nrow(fileData))
print(index)
cat("\n\n")

test_data <- fileData[index,]
train_data <- fileData[-index,]

print(train_data)
cat("\n\n")
print(test_data)



#install.packages('randomForest')
library(randomForest)

fit <- randomForest( factor(likeness)~., data=train_data, importance=TRUE, ntree=1000)
importance(fit)
varImpPlot(fit)
Prediction <- predict(fit, test_data)
table(actual=test_data$likeness ,Prediction)


wrong<- (test_data$likeness!=Prediction )
error_rate<-sum(wrong)/length(wrong)
error_rate


