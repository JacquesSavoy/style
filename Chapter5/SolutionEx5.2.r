#
# Solution for Exercise #5.2
#
# Step 1: load the stylo package, the corpus + tokenize
library(stylo)
# Load the corpus
raw.corpus <- load.corpus(files=list.files(path="../Federalist/",
                  pattern="[.]txt$"), corpus.dir="../Federalist/")
tokenized.corpus <- txt.to.words.ext(raw.corpus, language="English", 
                                     preserve.case=FALSE)
# Step 2: subdivide according to the two authors + query text
corpus.train <- tokenized.corpus[grep("Hamilton|Madison",
                                      names(tokenized.corpus))]
corpus.test <- tokenized.corpus[grep("Test",
                                    names(tokenized.corpus))]
# Verify the number of articles: training = 51 + 14 = 65
length(corpus.train)
# In the test set 12
length(corpus.test)
#
# Step 3: Generate the letter trigrams based on the training and test sample
corpus.train.char.3.grams <- txt.to.features(corpus.train,
                                       ngram.size=3, features='c')
corpus.test.char.3.grams <- txt.to.features(corpus.test,
                                       ngram.size=3, features='c')
# Select the features:  Here the 500 Most Frequent trigrams
# But only from the training sample
myFrequentFeatures <- make.frequency.list(corpus.train.char.3.grams, 
                                          head=500)
# To see the first ten of these features
myFrequentFeatures[1:10]
# Represent each text in the training set with these 500 features
freqs.train <- make.table.of.frequencies(corpus.train.char.3.grams,
                                         features=myFrequentFeatures)
# Represent each text in the test corpus with the 500 selected features
# If a feature is absent, denote it by 0
freqs.test <- make.table.of.frequencies(corpus.test.char.3.grams,
                                        features = myFrequentFeatures,
                                        absent.sensitive=FALSE)
#
# Verify the number of articles and features in
# both the training and test set
dim(freqs.train)
dim(freqs.test)
#
# Step 4:  Delta
#
# If the two freqs table don't have the same number of features:  Fails!
# Apply the Delta method from 50 to 500 n-grams of letters
# by step = 50 features
classify(training.frequencies = freqs.train,
         test.frequencies = freqs.test,
         mfw.min = 50, mfw.max = 500, mfw.incr=50,
         classification = "delta",
         gui = FALSE)

# The result is stored in file "final_results.txt"
#
#
#