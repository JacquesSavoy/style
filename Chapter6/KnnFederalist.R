# 
# Example for K-NN strategy with the Federalist Papers corpus
#
# See Section 6.5.1
#
#  Federalist example:  Instances-based approach
#
options(digits=3)
# Read the data frame from the file
mydata <- read.table("./Data/FederalistFreq.txt",
                     header=TRUE, row.names=1)
# How many instances and features + the decision
dim(mydata)
# Store the number of features + the decision
decIndex  <- dim(mydata)[2]
# Store the column with the decision
predIndex <- decIndex - 1
# View some examples
mydata[c(1, 51, 52, 65, 66, 70, 71),]
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
mydata.norm <- apply(mydata[,1:predIndex], 2, standardize)
mydata.norm[1:3,1:5]
#
# Normalize by the sum over each row (or paper)
mydata.norm <- apply(mydata[,1:predIndex], 1, normalizeSum)
mydata.norm[1:3,1:5]
#
# Normalize by the sum over each column (or predictor)
mydata.norm <- apply(mydata[,1:predIndex], 2, normalizeSum)
mydata.norm[1:3,1:5]
# View more examples
mydata.norm[c(1, 51, 52, 65, 66, 70, 71), 1:6]
#
# Split the dataset into a training and a test sample
mydata.train <- mydata.norm[1:70,]
mydata.train.labels <- mydata[1:70, decIndex]
mydata.test  <- mydata.norm[71:82,]
mydata.test.labels  <- mydata[71:82, decIndex]
# Load the library
library(class)
# et the seed for the random generator
set.seed(7539)
#
#  The k-NN classifier
#
knn.pred <- knn(train=mydata.train, test=mydata.test,
                cl=mydata.train.labels, k=3)
knn.pred[1:9]
sum(knn.pred == mydata.test.labels)
#
# Considering only the term {by, upon, would}
#
aRange <- c(2, 3, 5)  # Select only three predictors
knn.pred <- knn(train=mydata.train[,aRange], test=mydata.test[,aRange],
                cl=mydata.train.labels, k=3)
sum(knn.pred == mydata.test.labels)

#
# Considering only Hamilton & Madison
#
knn.pred <- knn(train=mydata.train[1:65,aRange], test=mydata.test[,aRange],
                cl=mydata.train.labels[1:65], k=3)
sum(knn.pred == mydata.test.labels)
summary(knn.pred)



