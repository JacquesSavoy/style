#
# Solution for Exercise #3.6
#
# Step 1: load the stylo package, the corpus + tokenize
library(stylo)
# Load the corpus
raw.corpus <- load.corpus(files=list.files(path="../Federalist/",
                                           pattern="[.]txt$"),
                          corpus.dir="../Federalist/")
tokenized.corpus <- txt.to.words.ext(raw.corpus, language="English", 
                                     preserve.case=FALSE)
# Step 2: subdivide according to the two authors + query text
# Only eight articles in the training sample
corpus.train <- tokenized.corpus[grep("59|60|61|65|37|38|47|48",
                                         names(tokenized.corpus))]
corpus.Q54 <- tokenized.corpus[grep("54",
                                    names(tokenized.corpus))]
# Step 3: Selected a few word-types/ articles
selected.words <- c('the', 'of', 'to', 'in', 'and', 'a')
# Generate a vector for each text for Hamilton
freqs.train <- make.table.of.frequencies(corpus.train,
                                            relative=FALSE,
                                            features=selected.words)
# And for the query article #54
freqs.test <- make.table.of.frequencies(corpus.Q54, relative=FALSE,
                                        features=selected.words)
# Compute the mean for each word-type over all papers 
options(digits=3)
freqs.train.rel <- freqs.train / apply(freqs.train, 1, sum)
# Transform this single query text with relative frequencies
freqs.test.rel <- freqs.test / sum(freqs.test)
#
# STEP 4: Define the distance functions
#
# Define the Manhattan function
#
manhattan <- function(aVector1, aVector2) {
  return(sum(abs (aVector1 - aVector2)) )
}
# Define the Euclidian function
# Usually function name in R starts with a lowercase letter!
euclidian <- function(aVector1, aVector2) {
  return(sqrt ( sum((aVector1 - aVector2) * (aVector1 - aVector2)) ))
}
# Define the inner product function
innerProduct <- function(aVector1, aVector2) {
  return( sum(aVector1 *  aVector2) )
  }
# Define the similarity by the cosine
simCosine <- function(aVector1, aVector2) {
  norm1 <- sqrt(innerProduct(aVector1, aVector1))
  norm2 <- sqrt(innerProduct(aVector2, aVector2)) 
  return( innerProduct(aVector1,aVector2) / (norm1*norm2) )
}
# Define the distance by the cosine
distCosine <- function(aVector1, aVector2) {
  return( 1.0 - simCosine(aVector1,aVector2))
  }

#
# STEP 5: Compute the distance function to all papers
# 
# Show the training sample and the test article
show(freqs.train.rel)
show(freqs.test.rel)
# The Manhattan distance
for (anIndex in 1:(dim(freqs.train.rel))[1]) {
  cat (anIndex, rownames(freqs.train.rel)[anIndex], " ")
  cat (manhattan(freqs.test.rel, as.vector(freqs.train.rel[anIndex,])))
  cat("\n")
  }
# The smallest value:  FederalistHamilton65.txt  0.0974
#
# The Euclidian distance
for (anIndex in 1:(dim(freqs.train.rel))[1]) {
  cat (anIndex, rownames(freqs.train.rel)[anIndex], " ")
  cat (euclidian(freqs.test.rel, as.vector(freqs.train.rel[anIndex,])))
  cat("\n")
  }
# The smallest value:  FederalistHamilton60.txt  0.0484
#
# The similarity cosine
for (anIndex in 1:(dim(freqs.train.rel))[1]) {
  cat (anIndex, rownames(freqs.train.rel)[anIndex], " ")
  cat (simCosine(freqs.test.rel, as.vector(freqs.train.rel[anIndex,])))
  cat("\n")
  }
# The largest value:  FederalistHamilton60.txt  0.996
#