# 
# Example for naïve Bayes strategy with the Federalist Papers
#
# See Section 6.5.2
#
#  Federalist example: Instance-based model
#
mydata <- read.table("./Data/FederalistFreqMixed.txt",
                     header=T, row.names=1)
dim(mydata)
decIndex  <- dim(mydata)[2]
predIndex <- decIndex - 1
# View some examples
mydata[c(1, 51, 52, 65, 66, 77), c(1:decIndex)]
#
# Plot the points
#
# par(mar=c(4.1, 4.1, 2.1, 1.1))  # Modify the margins (bottom, left, top, right)
aVar1 <- 1; aVar2 <- 2
plot(mydata[1:65, aVar1], mydata[1:65, aVar2],
     xlim = c(0, 80), ylim = c(-2, 20),
     xlab = "Frequency of the term 'by' (per thousand)",
     ylab = "Frequency of the term 'upon' (per thousand)", 
     pch = c(19, 15)[mydata[1:65,decIndex]],
     col = c("red", "blue")[mydata[1:65,decIndex]])
# And the disputed papers
points(mydata[66:77, aVar1], mydata[66:77, aVar2],
       pch = 17, col = "black")
#
# Text for only four selected points
#
somePoints <- c(66, 70, 71, 77)
text(mydata[somePoints,aVar1], mydata[somePoints,aVar2],
     adj=c(1, 1.5), cex=0.9, col="black",
     labels=row.names(mydata)[somePoints])
#
# Split the dataset into a training and a test set
mydata.train <- mydata[1:65,]
mydata.train.labels <- mydata[1:65, decIndex]
mydata.test<- mydata[66:77, 1:predIndex]
mydata.test.labels <- mydata[66:77, decIndex]
#
# Load the library
library(e1071)
options(digits=3)
#
# Naive Bayes
#
NB.mod1 <- naiveBayes(decision~.,
                      data=mydata.train)
pred1 <- predict(NB.mod1, mydata.test)
pred1
sum(pred1 == mydata.test.labels)
table(pred1, mydata.test.labels)
#
# With Laplace smoothing
#
NB.mod2 <- naiveBayes(decision ~., data=mydata.train,
                      laplace = 1)
pred2 <- predict(NB.mod2, mydata.test)
sum(pred2 == mydata.test.labels)
#
# View inside the generated model
#
NB.mod1

mydata[1,]
selH <- mydata$decision == "H"
selM <- mydata.train.labels == "M"
sum(mydata[,1])
mean(mydata[selH,1]); sd(mydata[selH,1])
mean(mydata[selM,1]); sd(mydata[selM,1])

