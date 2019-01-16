rm(list=ls())
bcw<-
  read.csv("C:/Users/Administrator/Desktop/513/data2.csv"
           , header = TRUE, sep = ',', na.strings = '?', stringsAsFactors = FALSE)
#View(bcw)

#install.packages("rpart")
# library(rpart)
require(rpart)

# # split dataset

test <- bcw[seq(1, nrow(bcw), by = 5),]
# print(test)
test <- test[,c(-1,-4,-9,-12,-13,-15,-16)]
str(test)
training <- bcw[-seq(1, nrow(bcw), by = 5),]
# print(training)
training <- training[,c(-1,-4,-9,-12,-13,-15,-16)]
str(training)


myTree <- rpart(formula = likeness ~ acousticness +	danceability
 + energy +	instrumentalness +	key +	liveness
 + mode +	speechiness  + valence, method = "class", data = training) #EmployeeID not in


# Prediction #
pred_result <- predict(myTree, test, type = "class")
pred_result

table(actual = test[, 10], pred_result)  # test[,2]: all data in $Attrition column from test dataset

#install.packages("rattle")
#show
library(rattle)
fancyRpartPlot(myTree)

# error rate
table(actual = test[, 10], pred_result)
wrong <- (test[, 10] != pred_result)
error_rate <- sum(wrong) / length(wrong)
error_rate
