# 
# Example for the SVM model:  The Federalist Papers
# See Section 6.5.3
#
options(digits = 4)
dat <- read.table("./Data/FungH-M.txt", header=TRUE, row.names=1)
dim(dat)
decIndex  <- dim(dat)[2]
predIndex <- decIndex - 1
# View some points
dat[c(1, 51, 52, 65, 66, 77), c(1:decIndex)]
aRange <- 1:65        # Only articles written by Hamilton & Madison 
aTestRange <- 66:77   # The 12 test articles
# 
# Plot all articles according to the frequencies of "to" and "upon"
# Measured in per thousand
#
af1 <- 1; af2 <- 2
plot(dat[aRange, af1], dat[aRange, af2],
     xlab = "Relative frequency of 'to' (in per thousand)",
     ylab = "Relative frequency of 'upon' (in per thousand)",
     col = c("red", "blue")[dat[aRange,decIndex]],
     pch = c(18, 19)[dat[aRange,decIndex]])
# The labels for each article 
text(dat[aRange, af1], dat[aRange, af2], cex=0.9, col="black",
     labels=row.names(dat[aRange,]))
#
# To obtain the Figure 6.2 see below (6 points must be removed)
#
# Load the library for the SVM 
library(e1071)
#
# Call the SVM, linear kernel
#
svmfit = svm(decision~., data=dat[aRange,],
             kernel="linear", cost=10, scale=F)
summary(svmfit)
# The list of the support vectors
svmfit$index
# The support vectors
dat[svmfit$index,]
# Prediction for the 12 disputed articles
pred <- predict(svmfit, dat[aTestRange,])
pred
sum(pred==dat[aTestRange,decIndex])

#
# Prediction on Papers #49, #50 and #51
#
newData <- data.frame(to=c(31.3, 22.27, 22.91),
                upon=c(0.0, 0.8, 0.0),
                would=c(11.87, 8.75, 4.21))
pred <- predict(svmfit, newData)
pred


#
# To obtain the same figure as Figure 6.2
# we need to remove six points H6, H8, H11, H21, H32, and H84
#
dat1 <- dat[-c(2, 5, 6, 12, 23, 50),]
aRange1 <- 1:59
plot(dat1[aRange1, af1], dat1[aRange1, af2],
     xlab = "Relative frequency of 'to' (in per thousand)",
     ylab = "Relative frequency of 'upon' (in per thousand)",
     col = c("red", "blue")[dat1[aRange1,decIndex]],
     pch = c(18, 19)[dat1[aRange1,decIndex]])
# The labels for each article 
text(dat1[aRange1, af1], dat1[aRange1, af2], cex=0.9, col="black",
     labels=row.names(dat1[aRange1,]))
#