# clear environment
rm(list = ls())

# load data
fileData <-
  read.csv("/Users/weichen/Downloads/data.csv",
           na.strings = "?")

### remove all the records with missing value
fileData <- na.omit(fileData)
# fileData <- fileData[, c(-1,-13,-15,-16)]
fileData <- fileData[,c(-1, -4, -9, -12, -13, -15, -16)]

# Use every 5th record to create the test dataset and use the remaining records to create the training dataset.
index <-
  seq(1, nrow(fileData), by = 5)
print(nrow(fileData))
print(index)
cat("\n\n")

test_data <- fileData[index, ]
train_data <- fileData[-index, ]

print(train_data)
cat("\n\n")
print(test_data)


library(e1071)
? svm
## svm
svm.model <- svm(factor(likeness) ~ ., data = train_data)
svm.pred <- predict(svm.model,  test_data)

# 4 columns cut, 17-4 = 13 column is likeness
# table(actual = test_data[, 13], svm.pred)
table(actual = test_data[, 10], svm.pred)

SVM_wrong <- (test_data$likeness != svm.pred)
rate <- sum(SVM_wrong) / length(SVM_wrong)
rate
