#
# Solution for Exercise #2.1
#
# START:  Load the STYLO package
#
library(stylo)

# Be sure that the current directory is '.../Chapter2/
# Verify this with
getwd()
# if not, specify it with setwd('yourPathTo/Chapter2/')
# Or look at this video https://www.youtube.com/watch?v=pWOCfZnitdc
#
#
# STEP 1:  LOAD THE CORPUS: Federalist Papers
#
# Import the articles from the given folder
# One file per article
# And if we assume that this directory contains only the Federalist Papers articles
# we can upload all files present in this directory
raw.corpus <- load.corpus(files = "all",
                          corpus.dir="../Federalist/")
# View the data
summary(raw.corpus)
# Be sure to have loaded 82 texts
length(raw.corpus)
#
# Alternative solution
#
# Import all articles from the specified folder
# if the filename finishes with 'txt'
raw.corpus <- load.corpus(files=list.files(path="../Federalist/",
                                          pattern="[.]txt$"),
                          corpus.dir="../Federalist/")
length(raw.corpus)
# View the data (a list of all texts included in the specified folder)
summary(raw.corpus)
#
# View a given text, as for example the first one.
# It is composed of lines (defined according to the representation present in the file).
raw.corpus[[1]]
# Or only the first three lines of this first paper
raw.corpus[[1]][1:3]
# And to verify the file name of this first article
names(raw.corpus)[1]
#
#
# STEP 2:  TOKENIZE THE CORPUS
#
# A set of lines is not so very useful, we need a list of words.
# Apply the tokenizer for the English language,
#   and replace each uppercase letter by a lowercase one
tokenized.corpus <- txt.to.words.ext(raw.corpus, language="English", 
                                    preserve.case=FALSE)
# The result is a list of words 
# So you can see the list of the words appearing in the first article
tokenized.corpus[[1]]
# ups... too many
#
# Or only the first 15 words of this article
tokenized.corpus[[1]][1:15]
# See the effect of the tokenizer by looking at the first two lines of this article
raw.corpus[[1]][1:2]
# And to verify the corresponding file name
names(tokenized.corpus)[1]
#
#
# STEP 3: SUBDIVIDE the corpus into different parts
#
# Select the training sample
# All articles written by Hamilton, Madison or Jay
# The filename contains the author's name
corpus.train <- tokenized.corpus[grep("Hamilton|Madison|Jay",
                                      names(tokenized.corpus))]
# This sub-corpus must contains 70 texts
length(corpus.train)
#
# Select the test sample composed of 12 articles
corpus.test <- tokenized.corpus[grep("Test",
                                      names(tokenized.corpus))]
length(corpus.test)
#
# You can also select all articles written by Hamilton
# by repeating the grep function
corpus.hamilton <- tokenized.corpus[grep("Hamilton", names(tokenized.corpus))]
# corresponding to 51 articles
length(corpus.hamilton)
#
# Select all articles written by Madison
corpus.madison <- tokenized.corpus[grep("Madison", names(tokenized.corpus))]
# With 14 articles
length(corpus.madison)
#
# Select the part written by Jay
corpus.jay <- tokenized.corpus[grep("Jay", names(tokenized.corpus))]
# This sub-corpus must contains 5 texts
length(corpus.jay)
#
# End of this exercise
#
