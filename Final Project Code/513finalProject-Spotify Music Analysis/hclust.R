# clear environment
rm(list = ls())

# load data
fileData <-
  read.csv("/Users/weichen/Downloads/data2.csv",
           na.strings = "?")

### remove all the records with missing value
fileData <- na.omit(fileData)

# select data here (remove duration_ms loudness tempo time_signature song_title artist)
fileData <- fileData[, c(-1,-4,-9,-12,-13,-15,-16)]
fileData

?hclust
?dist
?cutree

dist<-dist(fileData)
# hc_result<-hclust(dist,method ="average" )
hc_result<-hclust(dist,method ="centroid" )
# hc_result<-hclust(dist,method ="single" )
# hc_result<-hclust(dist,method ="complete" )
# hc_result<-hclust(dist,method ="median" )
# hc_result<-hclust(dist,method ="mcquitty" )
hc_result

plot(hc_result, cex = 0.6, hang = -1)

hclust_2<-cutree(hc_result,10)
hclust_2

table(Hclust=hclust_2,Actual=fileData[,10])


#################################### kmeans ###############################
newData <-
  model.matrix(
    ~ likeness + acousticness + danceability + energy + instrumentalness
    + key + liveness + mode
    + speechiness + valence,
    fileData
  )

head(newData)
newData <- newData[,-1]
newData

# in 2 clusters
kmeans_result <-
  kmeans(newData, center = 2, nstart = 10)

str(kmeans_result)

kmeans_result$cluster

# plot kmeans result
# plot(kmeans_result$cluster)

# install.packages("fpc")
library(fpc)
plotcluster(newData, kmeans_result$cluster)

### Tabulate the clustered rows against the “likeness” column
table(kmeans_result$cluster, fileData[, 10])


##### Compare two methods with each 2 clusters ##########
table(kmeans_result$cluster, hclust_2)
