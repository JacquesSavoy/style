#
#  Figure 3.1  Data centered
#
data <- read.table("DataTable3.7.txt", header=T, row.names=1) 
data
options(digits=4)

author <- c("H", "H", "H", "H", "M", "M", "M", "M",  "Q", "Q")
authorCol <- c(1,1,1,1, 3, 3,3,3, 0,0)

x <- c(6, 6, 6, 5, 19, 15, 20, 16, 16, 19)
y <- c(3, 8, 3, 10, 1, 4, 0, 0, 0, 2)

x <- x - mean(x)
y <- y - mean(y)

param <- par()
# mar <- c(5.1 4.1 4.1 2.1)
# omd <- c( 0 1 0 1)
#

par(mar=c(5,5,1,1))
#par(omd=c(0,1,0,0))
par(cex.lab=1.5)

# pdf(file="Fig4a.pdf")

plot(x,y, pch=20,
     xlab = "Centered Frequency 'on'", ylab = "Centered Frequency 'upon' ")

text(x, y, col=1+unclass(authorCol), labels=abbreviate(names(data)), cex=1.4)

abline(v=0); abline(h=0)

# dev.off()