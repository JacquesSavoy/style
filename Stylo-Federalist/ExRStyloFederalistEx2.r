#
# Exemple #2 with the Federalist Papers
#
# Working with Stylo library
library(stylo)

# Import the articles from the given folder
# one file per author
raw.corpus <- load.corpus(files = "all",
                          corpus.dir="./Federalist/")
#      is simpler (if the directory contains only those files)

# View the data
summary (raw.corpus)

# Tokenize the corpus
tokenized.corpus <- txt.to.words.ext(raw.corpus, language="English", 
                                    preserve.case=FALSE)

# Select the training part
corpus.train <- tokenized.corpus[grep("Hamilton|Madison|Jay",
                    names(tokenized.corpus))]
summary(corpus.train)

# Select the features:  Here the 500 Most Frequent Words
myFrequentFeatures <- make.frequency.list(corpus.train, head=500)

# Represent each text with these three word-types
freqs <- make.table.of.frequencies(tokenized.corpus, features = myFrequentFeatures)

freqs[c(1,51,52,56,57,69,70,71), 1:5]

test.labels <- c("FederalistTest49.txt","FederalistTest50.txt",
                "FederalistTest51.txt","FederalistTest52.txt",
                "FederalistTest53.txt","FederalistTest54.txt",
                "FederalistTest55.txt","FederalistTest56.txt",
                "FederalistTest57.txt","FederalistTest58.txt",
                "FederalistTest62.txt","FederalistTest63.txt")
# Split the test and the training sample
# Represent each text in the test set with these 35 words
freqs.test <- freqs[(rownames(freqs) %in% test.labels),]
dim(freqs.test)

# Represent each text in the training set with these 35 words
freqs.train <-  freqs[!(rownames(freqs) %in% test.labels),]
freqs.train <-  freqs[c(c(1:51), c(57:70)),]  # Only Hamilton & Madison
dim(freqs.train)

# If you want to see the selected articles in the training and test set
test.labels  <- rownames(freqs.test)
train.labels <- rownames(freqs.train)

# Apply the Delta method with the selected MFW
classify(training.frequencies = freqs.train,
         test.frequencies = freqs.test,
         mfw.min = 200, mfw.max=200, classification="delta",
         gui = FALSE)

#
# From 50 MFT to 500 by step 50
#
classify(training.frequencies = freqs.train,
         test.frequencies = freqs.test,
         mfw.min = 50, mfw.max=500, mfw.incr=50,
         classification="delta", gui = FALSE)


