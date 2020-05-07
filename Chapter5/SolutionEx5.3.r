#
# Solution for Exercise #5.3
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
corpus.train <- tokenized.corpus[grep("Hamilton|Madison",
                                      names(tokenized.corpus))]
corpus.test <- tokenized.corpus[grep("54|55",
                                    names(tokenized.corpus))]
# Verify the number of articles: training = 51 + 14 = 65
length(corpus.train)
# The test set is limited to two articles
length(corpus.test)
#
# STEP 3: Generate the letter trigrams
#         for the training and test sample
#
corpus.train.words.2.grams <- txt.to.features(corpus.train,
                                       ngram.size=2, features='w')
corpus.test.words.2.grams <- txt.to.features(corpus.test,
                                       ngram.size=2, features='w')
#
# Select the features:  Here the 200 Most Frequent bigrams
# But only from the training sample
#
myFrequentFeatures <- make.frequency.list(corpus.train.words.2.grams, 
                                          head=200)
# To see the first ten of these features
myFrequentFeatures[1:10]

# Represent each text in the training set with these 200 features
freqs.train <- make.table.of.frequencies(corpus.train.words.2.grams,
                                         features=myFrequentFeatures)

# Represent each text in the test corpus with the 200 selected features
# If a feature is absent, denote it by 0
freqs.test <- make.table.of.frequencies(corpus.test.words.2.grams,
                                        features = myFrequentFeatures,
                                        absent.sensitive=FALSE)
#
# Verify the number of articles and features in
# both the training and test set
dim(freqs.train)
dim(freqs.test)
#
# STEP 4: Define the Manhattan and Euclidian distances
#
# Define the Manhattan function
manhattan <- function(aVector1, aVector2) {
  return( sum(abs(aVector1 - aVector2)) )
  }
# Define the Euclidian function
euclidian <- function(aVector1, aVector2) {
  return( sqrt( sum((aVector1 - aVector2)**2)) )
  }
#
# STEP 5: Apply the two functions to the training and test sets
#
# And need to consider all query articles
#
for (aQueryIndex in 1:(dim(freqs.test)[1])) {
   cat("Closest Manhattan distance with", rownames(freqs.test)[aQueryIndex])
   distance <- numeric(n)
   for (anIndex in 1:n) {
     distance[anIndex] <- manhattan(freqs.test[aQueryIndex,],
                                 (freqs.train[anIndex,]))
     }
   closest <- order(distance)[1]
   cat(" is",rownames(freqs.train)[closest], sort(distance)[1],"\n")
}
#
#
#
#
