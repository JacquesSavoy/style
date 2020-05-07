# 
# Example for the SVM model:  The Federalist Papers
#
# See Section 6.5.3
#
options(digits = 4)
mydata <- read.table("./Data/FederalistFung.txt", header=TRUE,
                     row.names=1)
dim(mydata)
decIndex  <- dim(mydata)[2]
predIndex <- decIndex - 1
# View some points
mydata[c(1, 51, 52, 65, 66, 77), c(1:decIndex)]
aRange <- 1:65        # Only articles written by Hamilton & Madison 
aTestRange <- 66:77   # The 12 test articles
# 
# Plot all articles according to the frequencies of "to" and "upon"
# Measured in per thousand
#
aVar1 <- 1; aVar2 <- 2
plot(mydata[aRange, aVar1], mydata[aRange, aVar2],
     xlab = "Relative frequency of 'to' (in per thousand)",
     ylab = "Relative frequency of 'upon' (in per thousand)",
     col = c("red", "blue")[mydata[aRange,decIndex]],
     pch = c(18, 19)[mydata[aRange,decIndex]])
# The labels for each article 
text(mydata[aRange, aVar1], mydata[aRange, aVar2], cex=0.9, col="black",
     labels=row.names(mydata[aRange,]))
#
# To obtain the Figure 6.2 see below (6 points must be removed)
#
# Load the library for the SVM 
library(e1071)
#
# Call the SVM, linear kernel
#
svmfit = svm(decision~., data=mydata[aRange,],
             kernel="linear", cost=10, scale=F)
summary(svmfit)
# The list of the support vectors
svmfit$index
# The support vectors
mydata[svmfit$index,]
# Prediction for the 12 disputed articles
pred <- predict(svmfit, mydata[aTestRange,])
pred
sum(pred==mydata[aTestRange,decIndex])

#
# Prediction on Papers #49, #50 and #51
#
newData <- data.frame(to=c(34.6, 24.5, 25.6),
                upon=c(0.0, 0.908, 0.0),
                would=c(13.4, 9.99, 4.7))
pred <- predict(svmfit, newData)
pred

