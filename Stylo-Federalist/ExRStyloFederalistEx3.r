#
# Exemple #3 with the Federalist Papers
#
# Working with Stylo library
library(stylo)

# Import the articles from the given folder
# one file per author
raw.corpus <- load.corpus(files = "all",
                          corpus.dir="./Federalist/")
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

#
# Using the list of words specified by Mosteller & Wallace
# to form the set of seelcted words
#
# The list contains 24 entries
#
listMostellerWallace <- c("upon", "also", "an", "by", "of",
                          "on", "there", "this", "to", "although", "both",
                          "whilst", "always", "though", "commonly",
                          "consequently", "considerable", "according",
                          "apt", "innovations", 
                          "kind", "matter", "particularly",  "work")

# Represent each text in the training corpus with a list of selected words
freqs.train <- make.table.of.frequencies(corpus.train,
                                         features = listMostellerWallace)
# Represent each text in the test corpus with a list of selected words
freqs.test <- make.table.of.frequencies(corpus.test,
                                        features = listMostellerWallace)

# Verify the number of articles and features in both the training ansd test set
dim(freqs.train)
dim(freqs.test)

# If the two freqs table don't have the same number of features:  Fails!
# Apply the Delta method with 35 selected words
classify(training.frequencies = freqs.train,
         test.frequencies = freqs.test,
         mfw.min = 24, mfw.max = 24, classification = "delta",
         gui = FALSE)


