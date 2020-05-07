#
# Solution for Exercise #3.4
#
# Step 1: load the stylo package, the corpus + tokenize
library(stylo)
#
# Import the articles from the given folder (one file per text)
raw.corpus <- load.corpus(files = "all",
                          corpus.dir="../Federalist/")
# View the data
summary(raw.corpus)
# Tokenize the corpus
tokenized.corpus <- txt.to.words.ext(raw.corpus, language="English", 
                                    preserve.case=FALSE)
#
# Step 2: subdivide according to the two authors + query text
# Select the training part
corpus.train <- tokenized.corpus[grep("Hamilton|Madison|Jay",
                                      names(tokenized.corpus))]
length(corpus.train)
# Select the test sample
corpus.test <- tokenized.corpus[grep("Test",
                                      names(tokenized.corpus))]
length(corpus.test)
#
# STEP 3: Select the the top 50 most frequent words
#
frequent.words <- make.frequency.list(corpus.train, head=50)
# What are the most frequent words
show(frequent.words)
#
# Generate a vector for each training  instance
freqs.train <- make.table.of.frequencies(corpus.train,
                                        features=frequent.words)
#
# Represent each text in the test corpus with the selected features
# If a feature is absent, denote it by 0
freqs.test <- make.table.of.frequencies(corpus.test,
                                        features = frequent.words,
                                        absent.sensitive=FALSE)
#
# Verify the number of articles and features in both
# the training sample (70) and in the test set (12)
dim(freqs.train)
dim(freqs.test)

# If the two freqs table don't have the same number of features:  Fails!
# Apply the Delta method with 50 selected words
classify(training.frequencies = freqs.train,
         test.frequencies = freqs.test,
         classification = "delta", gui = FALSE)


# The result is stored in file "final_results.txt"
#
# FederalistTest49.txt     -->     FederalistHamilton35.txt
# FederalistTest50.txt     -->     FederalistMadison37.txt
# FederalistTest51.txt     -->     FederalistMadison43.txt
# FederalistTest52.txt     -->     FederalistMadison41.txt
# FederalistTest53.txt     -->     FederalistMadison43.txt
# FederalistTest54.txt     -->     FederalistMadison39.txt
# FederalistTest55.txt     -->     FederalistHamilton72.txt
# FederalistTest56.txt     -->     FederalistMadison46.txt
# FederalistTest57.txt     -->     FederalistMadison10.txt
# FederalistTest58.txt     -->     FederalistMadison41.txt
# FederalistTest62.txt     -->     FederalistMadison38.txt
# FederalistTest63.txt     -->     FederalistMadison41.txt
#
