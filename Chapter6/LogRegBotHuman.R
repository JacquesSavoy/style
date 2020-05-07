# 
# Example with the Logistic Regresion model
#
# See Section 6.5.4
#
#  Logistic Regression:  a small example
#  Predicting if a set of tweet was written by a Human or genereated by a Bot
#
options(digits=3)
mydata <- read.table("./Data/ExampleBotHuman.txt", header=T, row.names=1)
dim(mydata)
decIndex <- dim(mydata)[2]
# view some examples
mydata[c(1, 51, 63, 80), 1:decIndex]
#
# Plot the relationship between mention and the decision
#
aVar1 <- 4  # The mention is in the 4th positon 
yValue <- as.integer(mydata[,decIndex]) - 1
plot(mydata[,aVar1], yValue,
     xlab="Number of mentions",
     ylab="Bot vs. Human",
     col=c("blue","red")[mydata$decision], lwd=2,
     pch=c(22, 19)[mydata$decision])
#
# Logistic Regression
#
logReg.mod1 <- glm(decision ~ mention, data=mydata,
                   family=binomial)
summary(logReg.mod1)$coef
#
# Compute the prob for an instance
coefs <- logReg.mod1$coefficients
m <- 50
1.0 / (1 + exp(-(coefs[1] + coefs[2]*m)) ) 
#
# Logistic regression with face
#
logReg.mod2 <- glm(decision ~ face, family = binomial, data=mydata)
summary(logReg.mod2)$coef
#
# Logistic regression with two variables mention & face
#
logReg.mod3 <- glm(decision ~ mention+face, family = binomial, data = mydata)
summary(logReg.mod3)$coef

# Prediction with a set of new values
newData <- data.frame(mention = c(10, 20, 30),
                        face = c(10, 10, 10))
newData
pred <- predict(logReg.mod3, newData, type="response")
pred

# A small example to verify the previous value
coefs <- logReg.mod3$coefficients
m <- 10; f <- 10
aValue <- (coefs[1] + coefs[2]*m + coefs[3]*f)
1.0 / ( 1 + exp(-aValue))   


