# 1. Preparation

# Loading required libraries
library(cluster)
library(dplyr)
library(factoextra)
library(fpc)
library(ggplot2)
library(tidyverse)

# Setting random seed
set.seed(100)

# Reading in the data
df <- read.csv("~/Desktop/Sports Analytics/GK Clustering (2022-23)/GK Clustering.csv")

# Subsetting the data
df <- df[, c(1:5, 7, 8, 10, 11, 13, 14, 16:24, 26, 28, 29)] # Selecting features of interest 
df <- subset(df, df$X90sPlayed >= 5) # Removing GKs who played less than 5 full games

# Converting variables to per 90 
df$GA <- df$GA/df$X90sPlayed
df$FreeKickGA <- df$FreeKickGA/df$X90sPlayed
df$CornerKickGA <- df$CornerKickGA/df$X90sPlayed
df$LaunchCmp <- df$LaunchCmp/df$X90sPlayed
df$PassAtt <- df$PassAtt/df$X90sPlayed
df$ThrowAtt <- df$ThrowAtt/df$X90sPlayed
df$GoalKicksAtt <- df$GoalKicksAtt/df$X90sPlayed
df$CrossesFaced <- df$CrossesFaced/df$X90sPlayed

# Standardizing the data
df.scale <- scale(df[, -c(1:4)], center = TRUE, scale = TRUE)
df.final <- cbind(df[, c(1:4)], df.scale)

# Removing NAs
df.final <- na.omit(df.final)

# Finding duplicates
df.final$Player[duplicated(df.final$Player)]



# 2. Diagnostics to look for optimal number of clusters to find

# Elbow plot
fviz_nbclust(df.final[, -c(1:4)], kmeans, method = "wss")

# Gap statistic plot
gap_stat <- clusGap(df.final[, -c(1:4)], FUN = kmeans, nstart = 25, K.max = 10, B = 50)
fviz_gap_stat(gap_stat)

# CH score plot
ch <- rep(0, 10)
for (i in 1:10){
  km <- kmeans(df.final[, -c(1:4)], centers = i)
  ch[i] <- calinhara(df.final[, -c(1:4)],km$cluster)
} 
plot(ch,
     main = "Calinski-Harabasz Index Plot",
     xlab = "Clusters",
     ylab = "Calinski-Harabasz Index Score",
     type = "b"
)



# 3. K-means clustering

# Clustering
km.5 <- kmeans(x = df.final[, -c(1:4)], centers = 5, nstart = 100)

# Cluster assignments
km.clusters.5 <- km.5$cluster 

# Visualizing clusters in two dimensions
fviz_cluster(km.5, data = df.final[, -c(1:4)]) + ggtitle("Five Cluster Results") 

# Principal component analysis (PCA) to find loadings of first two PCs
pca <- princomp(df.final[, -c(1:4)])

# Loadings of the first two principal components (exported this to Tableau to create a better visualization)
pca$loadings[, c(1, 2)]

# Finding coordinates of cluster centroids
c1.centroid <- as.data.frame(km.5$centers[1,])
c2.centroid <- as.data.frame(km.5$centers[2,])
c3.centroid <- as.data.frame(km.5$centers[3,])
c4.centroid <- as.data.frame(km.5$centers[4,])
c5.centroid <- as.data.frame(km.5$centers[5,])
centroids <- cbind(c1.centroid, c2.centroid, c3.centroid, c4.centroid, c5.centroid)

# Finding cluster assignments for each player
players <- df.final[, c(1:4)]
km.clusters.5 <- as.vector(km.clusters.5)
cluster.assignments <- cbind(players, km.clusters.5)