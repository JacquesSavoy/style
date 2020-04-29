#
# Exemple with words and their frequencies
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

# Generate the the top 50 most frequent words / keep the absolute frequency
frequent.words <- make.frequency.list(corpus.train, value=TRUE,
                                      head=50, relative=FALSE)
# What are the most frequent words
show(frequent.words)   

# Generate the the top 50 most frequent words, ignore the frequecies in the output
frequent.words <- make.frequency.list(corpus.train, value=FALSE,
                                      head=50, relative=TRUE)

# Generate a vector for each text
freqs.train <- make.table.of.frequencies(corpus.train,
                                            features=frequent.words)

# Represent each text in the test corpus with the selected features
# If a feature is absent, denote it by 0
freqs.test <- make.table.of.frequencies(corpus.test,
                                        features = frequent.words,
                                        absent.sensitive=FALSE)

# Verify the number of articles and features in both the training ansd test set
dim(freqs.train)
dim(freqs.test)

# If the two freqs table don't have the same number of features:  Fails!
# Apply the Delta method with 35 selected words
classify(training.frequencies = freqs.train,
         test.frequencies = freqs.test,
         classification = "knn", k.value=1,
         gui = FALSE)

a <- perform.knn(freqs.train, freqs.test, k.value = 1) 
show(a)



# The result is stored in file "final_results.txt"
