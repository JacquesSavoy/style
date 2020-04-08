# 
# Example for K-NN strategy with the Federalist Papers corpus
# See Section 6.5.1
#
#  Federalist example:  Instances-based approach
#
options(digits=3)
dat <- read.table("./Data/FederalistFreq.txt", header=TRUE, row.names=1)
dim(dat)
decIndex  <- dim(dat)[2]
predIndex <- decIndex - 1
# View some examples
dat[c(1, 51, 52, 65, 66, 70, 71),]
#
# Normalize the data with three possible functions
#
normalizeSum <- function(x) {
  return (x / sum(x)) }
normalizeMinMax <- function(x) {
  return ((x - min(x)) / (max(x) - min(x)))  }
standardize <- function(x) {
  return ((x - mean(x)) / sd(x))  }
#
# Verify the effect of the normalization
#
# Standardize each column (or attribute)
dat.norm <- apply(dat[,1:predIndex], 2, standardize)
dat.norm[1:3,1:5]
#
# Normalize by the sum over each row (or paper)
dat.norm <- apply(dat[,1:predIndex], 1, normalizeSum)
dat.norm[1:3,1:5]
#
# Normalize by the sum over each column (or predictor)
dat.norm <- apply(dat[,1:predIndex], 2, normalizeSum)
dat.norm[1:3,1:5]
# View more examples
dat.norm[c(1, 51, 52, 65, 66, 70, 71), 1:6]
#
# Split the dataset into a training and a test sample
dat.train <- dat.norm[1:70,]
dat.train.labels <- dat[1:70, decIndex]
dat.test  <- dat.norm[71:82,]
dat.test.labels  <- dat[71:82, decIndex]
# Load the library
library(class)
# et the seed for the random generator
set.seed(7539)
#
#  The k-NN classifier
#
knn.pred <- knn(train=dat.train, test=dat.test, cl=dat.train.labels, k=3)
knn.pred[1:9]
sum(knn.pred == dat.test.labels)
#
# Considering only the term {by, upon, would}
#
aRange <- c(2, 3, 5)  # Select only three predictors
knn.pred <- knn(train=dat.train[,aRange], test=dat.test[,aRange],
                cl=dat.train.labels, k=3)
sum(knn.pred == dat.test.labels)

#
# Considering only Hamilton & Madison
#
knn.pred <- knn(train=dat.train[1:65,aRange], test=dat.test[,aRange],
                cl=dat.train.labels[1:65], k=3)
sum(knn.pred == dat.test.labels)
summary(knn.pred)
