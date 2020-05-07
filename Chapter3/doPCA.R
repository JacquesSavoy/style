#
#  Figure 3.1  Data centered
#
data <- read.table("DataTable3.7.txt", header=T, row.names=1) 
data
options(digits=4)
#
# Call the PCA function
# Standardized and center the data
#
voc.pca <- prcomp(t(data), scale=T, center=T)
summary(voc.pca)
voc.pca$rotation
#
# The new position of the articles
voc.pca$x
