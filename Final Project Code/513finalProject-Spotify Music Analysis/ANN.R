###### Statement ######
#  Company    : Stevens 
#  Project    : HW 8 ANN
#  First Name : Hangbo
#  Last Name  : Li
#  Id			    : 10432871
#  Date       : Nov 25, 2018

rm(list=ls())
bcw<-
  read.csv("C:/Users/Administrator/Desktop/513/data.csv"
           , header = TRUE, sep = ',', na.strings = '?', stringsAsFactors = FALSE)
bcw <- na.omit(bcw)
str(bcw)
# summary(bcw)

# # split dataset

test <- bcw[seq(1, nrow(bcw), by = 5),]
# print(test)
testend <- test[,c(-1,-4,-9,-12,-13,-15,-16)]
test <- test[,c(-1,-4,-9,-12,-13,-15,-16,-17)]
str(test)
training <- bcw[-seq(1, nrow(bcw), by = 5),]
# print(training)
training <- training[,c(-1,-4,-9,-12,-13,-15,-16)]
str(training)

library("neuralnet")
# ?neuralnet()
# class(training$Attrition)
#install.packages("nnet")
library("nnet")

net_bc2  <- neuralnet(likeness ~acousticness+danceability+energy
                      +instrumentalness+key+liveness +mode+speechiness+valence

                      ,training, linear.output = F, hidden=10, threshold=0.005)
plot(net_bc2)
net_bc2


net_bc2_results <-compute(net_bc2, test[,c("acousticness" ,"danceability" , "energy" ,
                                           "instrumentalness" ,"key" ,"liveness" ,
                                           "mode" ,"speechiness","valence")])
net_bc2_results
ANN=as.numeric(net_bc2_results$net.result)
print(ANN)
ANN_cat<-ifelse(ANN<0.5,0,1)
print(ANN_cat)




table(Actual=testend$likeness,ANN_cat)

wrong<- (testend$likeness!=ANN_cat)
wrong
rate<-sum(wrong)/length(wrong)
print(rate)
