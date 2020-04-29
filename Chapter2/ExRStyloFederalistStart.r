#
# Loading the Federalist Papers corpus
#
# Working with Stylo library
library(stylo)
#
# Import all articles from the given folder 
# if the filename finishes with 'txt'
raw.corpus <- load.corpus(files=list.files(path="../Federalist/",
                                          pattern="[.]txt$"),
                          corpus.dir="../Federalist/")

# View the data (a list of all texts included in the loaded files)
summary(raw.corpus)
#
# Apply the tokinizer for the English language,
# and replace uppercase letters by lowercases
tokenized.corpus <- txt.to.words.ext(raw.corpus, language="English", 
                                    preserve.case=FALSE)
#
# Select the training part
corpus.train <- tokenized.corpus[grep("Hamilton|Madison|Jay",
                                      names(tokenized.corpus))]
# This sub-corpus must contains 70 texts
length(corpus.train)
#
# Select the test part
corpus.test <- tokenized.corpus[grep("Test",
                                   names(tokenized.corpus))]
# This sub-corpus must contains 12 texts
length(corpus.test)
#
