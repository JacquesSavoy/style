# 
# Example with the Logistic Regresion model
# See Section 6.5.4
#
#  Logistic Regression:  a small example
#  Predicting if a set of tweet was written by a Human or genereated by a Bot
#
options(digits=4)
dat <- read.table("./Data/ExampleBotHuman.txt", header=T, row.names=1)
dim(dat)
decIndex <- dim(dat)[2]
# view some examples
dat[c(1, 51, 63, 80), 1:decIndex]
#
# Plot the relationship between mention and the decision
#
af1 <- 4  # The mention is in the 4th positon 
yValue <- as.integer(dat[,decIndex]) - 1
plot(dat[,af1], yValue,
     xlab="Number of mentions",
     ylab="Bot vs. Human",
     col=c("blue","red")[dat$decision], lwd=2,
     pch=c(22, 19)[dat$decision])
#
# Logistic Regression
#
options(digits=3)
LogReg.mod1 <- glm(decision ~ mention, family=binomial, data=dat)
summary(LogReg.mod1)$coef
#
# Compute the prob for an instance
coefs <- LogReg.mod1$coefficients
m <- 50
1.0 / (1 + exp(-(coefs[1] + coefs[2]*m)) ) 
#
# Logistic regression with face
#
LogReg.mod2 <- glm(decision ~ face, family = binomial, data=dat)
summary(LogReg.mod2)$coef
#
# Logistic regression with two variables mention & face
#
LogReg.mod3 <- glm(decision ~ mention+face, family = binomial, data = dat)
summary(LogReg.mod3)$coef

# Prediction with a set of new values
newData <- data.frame(mention = c(10, 20, 30),
                        face = c(10, 10, 10))
newData
pred <- predict(LogReg.mod3, newData, type="response")
pred

# A small example to verify the previous value
coefs <- LogReg.mod3$coefficients
m <- 10; f <- 10
aValue <- (coefs[1] + coefs[2]*m + coefs[3]*f)
1.0 / ( 1 + exp(-aValue))   


