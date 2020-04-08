# 
# Example for naïve Bayes strategy with the Federalist Papers
# See Section 6.5.2
#
#  Federalist example: Instance-based model
#
dat <- read.table("./Data/FederalistFreqMixedWoJay.txt", header=T, row.names=1)
dim(dat)
decIndex  <- dim(dat)[2]
predIndex <- decIndex - 1
# View some examples
dat[c(1, 51, 52, 65, 66, 77), c(1:decIndex)]
#
# Plot the points
#
# par(mar=c(4.1, 4.1, 2.1, 1.1))  # Modify the margins (bottom, left, top, right)
af1 <- 1; af2 <- 2
plot(dat[1:65, af1], dat[1:65, af2],
     xlim = c(0, 80), ylim = c(-2, 20),
     xlab = "Frequency of the term 'by' (per thousand)",
     ylab = "Frequency of the term 'upon' (per thousand)", 
     pch = c(19, 15)[dat[1:65,decIndex]],
     col = c("red", "blue")[dat[1:65,decIndex]])
# And the disputed papers
points(dat[66:77, af1], dat[66:77, af2], pch = 17, col = "black")
#
# Text for only four selected points
#
somePoints <- c(66, 70, 71, 77)
text(dat[somePoints,af1], dat[somePoints,af2], adj = c(1, 1.5),
     cex=0.9, labels=row.names(dat)[somePoints], col = "black")
#
# Split the dataset into a training and a test set
dat.train <- dat[1:65,]
dat.train.labels <- dat[1:65, decIndex]
dat.test<- dat[66:77, 1:predIndex]
dat.test.labels <- dat[66:77, decIndex]
#
# Load the library
library(e1071)
options(digits=3)
#
# Naive Bayes
#
NB.mod1 <- naiveBayes(decision~., data=dat.train)
pred1 <- predict(NB.mod1, dat.test)
pred1
sum(pred1 == dat.test.labels)
table(pred1, dat.test.labels)
#
# With Laplace smoothing
#
NB.mod2 <- naiveBayes(decision ~., data=dat.train, laplace = 1)
pred2 <- predict(NB.mod2, dat.test)
sum(pred2 == dat.test.labels)
#
# View inside the generated model
#
NB.mod1

dat[1,]
selH <- dat$decision == "H"
selM <- dat.train.labels == "M"
sum(dat[,1])
mean(dat[selH,1]); sd(dat[selH,1])
mean(dat[selM,1]); sd(dat[selM,1])

