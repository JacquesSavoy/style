#
# Second exemple with the Federalist Papers
#
# Objective:
#   1) Reload the corpus Federalist papers, tokenize it, 
#       and generate the training and test set
#   2) Determine the 50 most frequent tokens
#   3) Represent these 50 MFWs into a table
#   4) Do a plot to see the the relative frequencies of 'by' and 'would'
#
# As done in the first example, load the Federalist Corpus
library(stylo)
raw.corpus <- load.corpus(files = "all",
                          corpus.dir="./Federalist/") 
# Tokenize the corpus
tokenized.corpus <- txt.to.words.ext(raw.corpus, language="English", 
                                    preserve.case=FALSE)
# Define the test sample, the 12 doubful articles
corpus.test  <- tokenized.corpus[grep("Test", names(tokenized.corpus))]
# Specify the training sample
corpus.train <- tokenized.corpus[grep("Hamilton|Madison|Jay", 
                                      names(tokenized.corpus))]
# Verify that you have 70 articles (51 by Hamilton, 14 by Madison and 5 by Jay)
length(corpus.train)

# Select the feature:  Here the 50 Most Frequent Word-types (50MFWs)
# BUT from the training set only!
myFrequentFeatures <- make.frequency.list(corpus.train, head=50)

# To view the first 10 (and 'the' must be in the first position)
myFrequentFeatures[1:10]

# Represent each text with these 50 MFWs (relative frequency)
freqs <- make.table.of.frequencies(tokenized.corpus,
                                   features = myFrequentFeatures)
# The size of the freqs table (must be 83 x 50)
dim(freqs)

# To see some examples 
# First dimension = article
# Second dimension = the selected words
freqs[c(4, 28, 52, 56, 60, 62),c(1, 13, 15, 26, 50)]

# Only for Article#59
freqs[28,]
# Only for 'would', 'may' and 'can' in Madison's papers
freqs[57:70, c(15, 31, 50)]

# Represent each text with these 50 MFWs and using absolute frequency
freqs.abs <- make.table.of.frequencies(tokenized.corpus,
                                   relative=FALSE,
                                   features = myFrequentFeatures)
# The absolute frequencies
freqs.abs[c(4, 28, 52, 56, 60, 62),c(1, 13, 15, 26, 50)]


# Select 'by' and 'would' as predictors (relative frequency)
plot(freqs[1:51,13], freqs[1:51,15], xlim=c(0,1.4), ylim=c(0.0, 2.3),
     xlab="Relative frequencies of 'by'",
     ylab="Relative frequencies of 'would'",
     pch=18, col="red")

# The articles writtenby Jay in darkgreen
points(freqs[52:56,13], freqs[52:56,15], pch=15,col="darkgreen")
# The articles written by Madison in darkorchid
points(freqs[57:70,13], freqs[57:70,15], pch=20,col="darkorchid")
# The doubtful articles in blue
points(freqs[71:82,13], freqs[71:82,15], pch=20,col="blue")

# If needed one can a short label for each article
# As for example for the test set, in blue, size=90%
text(freqs[71:82,13], freqs[71:82,15],
     labels=abbreviate(names(corpus.test)),
     col="blue", cex=0.9)

# For texts written by Hamilton
text(freqs[1:51,13], freqs[1:51,15],
     labels=abbreviate(names(corpus.train)[1:51]),
     col="red", cex=0.9)
# For texts written by Jay
text(freqs[52:56,13], freqs[52:56,15], 
     labels=abbreviate(names(corpus.train)[52:56]),
     col="darkgreen", cex=0.9)
# For texts written by Madison
text(freqs[57:70,13], freqs[57:70,15],
     labels=abbreviate(names(corpus.train)[57:70]),
     col="darkorchid", cex=0.9)
