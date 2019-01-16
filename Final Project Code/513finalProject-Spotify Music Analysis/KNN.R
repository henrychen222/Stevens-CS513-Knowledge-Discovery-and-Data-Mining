#  First Name       : Hangbo
#  Last Name        : Li  
#  Student ID       : 10432871
#  Creation date    : 5/12/2018


rm(list=ls())
bcw<-
  read.csv("C:/Users/Administrator/Desktop/513/data.csv")
#View(bcw)

# # split dataset

test <- bcw[seq(1, nrow(bcw), by = 5),]
# print(test)
test <- test[,c(-1,-4,-9,-12,-13,-15,-16)]
str(test)
training <- bcw[-seq(1, nrow(bcw), by = 5),]
# print(training)
training <- training[,c(-1,-4,-9,-12,-13,-15,-16)]
str(training)

#k = 1
library(class)
predict_k1 <- knn(training[1:9],test[1:9],training[,10],k=1)
print(predict_k1)
print(test)

error <- 0
i <- 1
while (i < length(predict_k1)) {
  if (predict_k1[i] != test[i,10]) {
    error <- error + 1
  }
  i <- i + 1
}
error_rate <- error / length(predict_k1)
print(error)
print(error_rate)


#  k = 2
predict_k2 <- knn(training[1:9],test[1:9],training[,10],k=2)
#print(predict_k2)
error <- 0
i <- 1
while (i < length(predict_k2)) {
  if (predict_k2[i] != test[i,10]) {
    error <- error + 1
  }
  i <- i + 1
}
error_rate <- error / length(predict_k2)
print(error)
print(error_rate)

#  k = 5
predict_k5 <- knn(training[1:9],test[1:9],training[,10],k=5)
error <- 0
i <- 1
while (i < length(predict_k5)) {
  if (predict_k5[i] != test[i,10]) {
    error <- error + 1
  }
  i <- i + 1
}
error_rate <- error / length(predict_k5)
print(error)
print(error_rate)

#  k = 10
predict_k10 <- knn(training[1:9],test[1:9],training[,10],k=10)
error <- 0
i <- 1
while (i < length(predict_k10)) {
  if (predict_k10[i] != test[i,10]) {
    error <- error + 1
  }
  i <- i + 1
}
error_rate <- error / length(predict_k10)
print(error)
print(error_rate)