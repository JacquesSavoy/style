#
# Solution for Exercise #2.2
#
# START: load the STYLO package
#
library(stylo)
#
# Load the corpus
raw.corpus <- load.corpus(files=list.files(path="../Federalist/",
                  pattern="[.]txt$"), corpus.dir="../Federalist/")
length(raw.corpus)
#
# STEP 2:  Tokenize the corpus
tokenized.corpus <- txt.to.words.ext(raw.corpus, language="English", 
                                    preserve.case=FALSE)
#
# STEP 3: Subdive the corpus into different parts
corpus.train <- tokenized.corpus[grep("Hamilton|Madison|Jay",
                                      names(tokenized.corpus))]
length(corpus.train)
#
corpus.test <- tokenized.corpus[grep("Test",
                                      names(tokenized.corpus))]
length(corpus.test)
#
# Or according to each author
corpus.hamilton <- tokenized.corpus[grep("Hamilton", names(tokenized.corpus))]
corpus.madison  <- tokenized.corpus[grep("Madison", names(tokenized.corpus))]
corpus.jay      <- tokenized.corpus[grep("Jay", names(tokenized.corpus))]
#
# STEP 4: STATISTICS over the different parts
#
# Generate a list with the top 50 most frequent words (head=50)
#    with the absolute frequency (relative=FALSE)
#    and keep this value (value=TRUE)
frequent50.words <- make.frequency.list(corpus.train, value=TRUE,
                                      head=50, relative=FALSE)
# Those 50 words are...
show(frequent50.words)
# And if we want only the most frequent
names(frequent50.words)[1]
# And with its absolute frequency
frequent50.words[[1]]
#
#
# To analyze the entire vocabulary used by the three authors
frequent.words <- make.frequency.list(corpus.train, value=TRUE,
                                       relative=FALSE)
# The vocabulary size used in training set
length(frequent.words)
# The total number of tokens in training set
sum(frequent.words)
# The vocabulary size used in test sample
frequent.words.test <- make.frequency.list(corpus.test, value=TRUE,
                                      relative=FALSE)
length(frequent.words.test)
# The total number of tokens in test sample
sum(frequent.words.test)
#
#
# And some statistics for each author
#
#
# Some statistics about Hamilton
frequent.words.hamilton <- make.frequency.list(corpus.hamilton, value=TRUE,
                                      relative=FALSE)
# The vocabulary size used in Hamilton's texts
length(frequent.words.hamilton)
# The total number of tokens in Hamilton's texts
sum(frequent.words.hamilton)
# The top 10 most frequent words used by Hamiton
#    with their absolute frequency
frequent.words.hamilton[1:10]
#   or their relative frequency
frequent.words.hamilton[1:10] / sum(frequent.words.hamilton)
#
# Maybe the number of digits is to high
# You can reduce this with
# options(digits=3)
# 
# The Zipf's Law
# The top ten most frequent words cover a large percentage of all tokens
# Example with Hamilton's writings
sum(frequent.words.hamilton[1:10] / sum(frequent.words.hamilton))
#
#
# Some statistics about Madison
frequent.words.madison <- make.frequency.list(corpus.madison, value=TRUE,
                                          relative=FALSE)
# The vocabulary size used in Madison's texts
length(frequent.words.madison)
# The total number of tokens in Madison's texts
sum(frequent.words.madison)
# The top 10 most frequent words used by Madison
#    with their absolute frequency
frequent.words.madison[1:10]
#    or their relative frequency
frequent.words.madison[1:10] / sum(frequent.words.madison)
#
# The Zipf's Law
# The top ten most frequent words cover a large percentage of all tokens
sum(frequent.words.madison[1:10] / sum(frequent.words.madison))

#
#
# Some statistics about Jay
frequent.words.jay <- make.frequency.list(corpus.jay, value=TRUE,
                                               relative=FALSE)
# The vocabulary size used in Jay's texts
length(frequent.words.jay)
# The total number of tokens in Jay's texts
sum(frequent.words.jay)
# The top 10 most frequent words used by Jay
# with their absolute frequency
frequent.words.jay[1:10]
# or their relative frequency
frequent.words.jay[1:10] / sum(frequent.words.jay)
#
# The Zipf's Law
# The top ten most frequent words cover a large percentage of all tokens
sum(frequent.words.jay[1:10] / sum(frequent.words.jay))

#
# End of Exercise 2.2
#
