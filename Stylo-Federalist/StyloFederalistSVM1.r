#
# Exemple #4 with the Federalist Papers
# StyloFederalistSVM1.r
#
# Working with Stylo library
library(stylo)

# Import the articles from the given folder
# The directory contains only the needed files
raw.corpus <- load.corpus(files = "all",
                          corpus.dir="./Federalist/")
# View the data: 51 Hamilton + 14 Madison + 5 Jay + 12 Test 
summary (raw.corpus)

# Tokenize the corpus
tokenized.corpus <- txt.to.words.ext(raw.corpus, language = "English", 
                                    preserve.case=FALSE)

# Select the part written by Hamilton
corpus.hamilton <- tokenized.corpus[grep("Hamilton", names(tokenized.corpus))]
# Select the part written by Madison
corpus.madison <- tokenized.corpus[grep("Madison", names(tokenized.corpus))]
# Select the part written by Jay
corpus.jay <- tokenized.corpus[grep("Jay", names(tokenized.corpus))]

# Select the test part
corpus.test  <- tokenized.corpus[grep("Test", names(tokenized.corpus))]
summary(corpus.test)

# Select the training part:  Onyl Hamilton & Madison
corpus.train <- tokenized.corpus[grep("Hamilton|Madison", 
                                      names(tokenized.corpus))]
summary(corpus.train)

# Select the feature:  limited to three
listFung <- c("to", "upon", "would")

# Represent each text with these three word-types
freqs <- make.table.of.frequencies(tokenized.corpus, features = listFung)

freqs[c(1,51,52,56,57,69,70,71),]

# Show two words (to / upon) 
plot(freqs[,1], freqs[,2], type="p", pch=1, col="white",
     xlim=c(-0.1,6), ylim=c(-0.1,0.8),
     xlab="to", ylab="upon", main="Federalist Papers")

points(freqs[1:51,1],  freqs[1:51,2],  pch=20, col="red")    # Hamilton
# points(freqs[52:56,1], freqs[52:56,2], pch=20, col="black") # Jay
points(freqs[57:70,1], freqs[57:70,2], pch=15, col="blue")   # Madison
points(freqs[71:82,1], freqs[71:82,3], pch=18, col="green")  # Test

# Show two words (to / would) 
plot(freqs[,1], freqs[,3], type="p", pch=1, col="white",
     xlim=c(-0.1,6), ylim=c(-0.1,3),
     xlab="to", ylab="would", main="Federalist Papers")
points(freqs[1:51,1],  freqs[1:51,3],  pch=20, col="red")    #Hamilton
# points(freqs[52:56,1], freqs[52:56,3], pch=20, col="black") # Jay
points(freqs[57:70,1], freqs[57:70,3], pch=15, col="blue")   # Madison
points(freqs[71:82,1], freqs[71:82,3], pch=18, col="green")  # Test


# Scatter plot of the relative frequencies of "upon" and "would"
plot(freqs[,2], freqs[,3], type="p", pch=1, col="white",
     xlim=c(-0.1,0.8), ylim=c(-0.1,3),
     xlab="upon", ylab="would", main="Federalist Papers")
points(freqs[1:51,2],  freqs[1:51,3],  pch=20, col="red")    #Hamilton
# points(freqs[52:56,2], freqs[52:56,3], pch=20, col="black") # Jay
points(freqs[57:70,2], freqs[57:70,3], pch=15, col="blue")   # Madison
points(freqs[71:82,2], freqs[71:82,3], pch=18, col="green")  # Test


# Split the test and the training labels
test.labels <- c("FederalistTest49.txt","FederalistTest50.txt",
                 "FederalistTest51.txt","FederalistTest52.txt",
                 "FederalistTest53.txt","FederalistTest54.txt",
                 "FederalistTest55.txt","FederalistTest56.txt",
                 "FederalistTest57.txt","FederalistTest58.txt",
                 "FederalistTest62.txt","FederalistTest63.txt")
# Split the test and the training sample
# Represent each text in the test set with these 3 words
freqs.test <- freqs[(rownames(freqs) %in% test.labels),]
dim(freqs.test)

# Represent each text in the training set with these 3 words
freqs.train <-  freqs[!(rownames(freqs) %in% test.labels),]
freqs.train <-  freqs[c(c(1:51), c(57:70)),]  # Only Hamilton & Madison
dim(freqs.train)

# Apply the SVM method with 3 selected words
classify(training.frequencies = freqs.train,
         test.frequencies = freqs.test,
         mfw.min = 3, mfw.max=3, classification="svm",
         gui = FALSE)

# Apply the Delta method with 3 selected words
classify(training.frequencies = freqs.train,
         test.frequencies = freqs.test,
         mfw.min = 3, mfw.max=3, classification="Delta",
         gui = FALSE)

