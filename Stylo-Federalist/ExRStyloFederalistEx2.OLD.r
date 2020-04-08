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

# Select the part written by Hamilton
corpus.hamilton <- tokenized.corpus[grep("Hamilton", names(tokenized.corpus))]
# Select the part written by Madison
corpus.madison <- tokenized.corpus[grep("Madison", names(tokenized.corpus))]
# Select the part written by Jay
corpus.jay <- tokenized.corpus[grep("Jay", names(tokenized.corpus))]

# Select the test part
corpus.test  <- tokenized.corpus[grep("Test", names(tokenized.corpus))]
summary(corpus.test)

# Select the training part
corpus.train <- tokenized.corpus[grep("Hamilton|Madison|Jay", 
                                      names(tokenized.corpus))]
summary(corpus.train)

corpus.test <- tokenized.corpus[grep("Test", 
                                      names(tokenized.corpus))]
summary(corpus.test)

# Select the features:  Here the 400 Most Frequent Words
myFrequentFeatures <- make.frequency.list(corpus.train, head=400)

# Represent each text in the training corpus with these 400 MFW
freqs.train <- make.table.of.frequencies(corpus.train,
                       features = myFrequentFeatures)
# Represent each text in the test corpus with these 400 MFW
freqs.test <- make.table.of.frequencies(corpus.test,
                        features = myFrequentFeatures)

dim(freqs.train)
dim(freqs.test)
# The final set of selected words are those that appear in the test set
words.test  <- colnames(freqs.test)
# Maybe reduce the number of words in the training set
#   by ignoring those words that never appear in the test set
freqs.train <- freqs.train[, words.test]

# If you want ot see the selected articles in the training and test set
test.labels  <- rownames(freqs.test)
train.labels <- rownames(freqs.train)

# Apply the Delta method with the selected MFW
classify(training.frequencies = freqs.train,
         test.frequencies = freqs.test,
         mfw.min = 200, mfw.max=200, classification="delta",
         gui = FALSE)

#
# From 50 MFT to 400 by step 50
#
classify(training.frequencies = freqs.train,
         test.frequencies = freqs.test,
         mfw.min = 50, mfw.max=400, mfw.incr=50,
         classification="delta", gui = FALSE)


