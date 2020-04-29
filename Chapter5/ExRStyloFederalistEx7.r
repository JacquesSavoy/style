#
# Exemple with trigrams of letters 
# Using the corpus the Federalist Papers
#
# Working with Stylo library
library(stylo)

# Import the articles from the given folder
# one file per author
raw.corpus <- load.corpus(files = "all",
                          corpus.dir="../Stylo-Federalist/Federalist/")
# View the data
summary(raw.corpus)

# Tokenize the corpus
tokenized.corpus <- txt.to.words.ext(raw.corpus, language="English", 
                                    preserve.case=FALSE)
# Select the training part
corpus.train <- tokenized.corpus[grep("Hamilton|Madison|Jay",
                                      names(tokenized.corpus))]
summary(corpus.train)# Select the training part
corpus.test <- tokenized.corpus[grep("Test",
                                      names(tokenized.corpus))]
summary(corpus.train)

# Generate the letter trigrams based on the training sample
corpus.char.3.grams <- txt.to.features(corpus.train,
                                       ngram.size = 3, features='c')

# Select the features:  Here the 100 Most Frequent Words
myFrequentFeatures <- make.frequency.list(corpus.char.3.grams, head=100)
myFrequentFeatures

# Represent each text with these three word-types
freqs.train <- make.table.of.frequencies(corpus.char.3.grams, features=myFrequentFeatures)


# Represent each text in the test corpus with the selected features
# If a feature is absent, denote it by 0
freqs.test <- make.table.of.frequencies(corpus.test,
                                        features = myFrequentFeatures,
                                        absent.sensitive=FALSE)

# Verify the number of articles and features in both the training ansd test set
dim(freqs.train)
dim(freqs.test)

# If the two freqs table don't have the same number of features:  Fails!
# Apply the Delta method with 35 selected words
classify(training.frequencies = freqs.train,
         test.frequencies = freqs.test,
         mfw.min = 100, mfw.max = 100, classification = "delta",
         gui = FALSE)

# The result is stored in file "final_results.txt"
