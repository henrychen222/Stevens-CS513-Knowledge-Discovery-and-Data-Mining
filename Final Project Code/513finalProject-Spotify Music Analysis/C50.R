#  Course          : CS 513
#  Name            : Shan Jiang
#  CWID            : 10432908
#  purpose         : Apply C5.0 to IBM Employee Attrition V2 dataset

remove(list=ls())

# load data into memory
data <- read.csv("C:/Users/Administrator/Desktop/513/data2.csv",na.strings = "?")
#View(data)

# Store every fifth record in a "test" dataset
test <- data[seq(1, nrow(data), by = 5),]
# print(test)
test <- test[,c(-1,-4,-9,-12,-13,-15,-16)]
str(test)
training <- data[-seq(1, nrow(data), by = 5),]
# print(training)
training <- training[,c(-1,-4,-9,-12,-13,-15,-16)]
str(training)

#install.packages("C50")
library(C50)
vars <- c("acousticness", "danceability", "energy", "instrumentalness", "key", "liveness", "mode", "speechiness", "valence")
str(data[, c(vars, "likeness")])

training$likeness<-as.factor(training$likeness)
str(training$likeness)
mytree <- C5.0(x = training[, vars], y = training$likeness)
mytree

# detailed summary
summary(mytree)
# visualize the results
plot(mytree)

prediction <- predict(mytree, newdata = test[, vars])
prediction

# error rate
table(actual = test[, 10], prediction)  # test_data[,2]: all data in $Attrition column
wrong <- (test[, 10] != prediction)
error_rate <- sum(wrong) / length(wrong)
error_rate
