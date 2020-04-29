#
# Different ways to explore the Federalist Papers corpus
#
# START:  load the STYLO package and be on the correct directory

# Working with Stylo library
library(stylo)

# Be sure that the current directory is in Chapter 2
# Verify this with
getwd()
# if not, specify it with setwd('aDirectoryPath/Chapter2')

#
# STEP 1:  LOAD THE CORPUS
#
# Import the articles from the given folder
# one file per author
raw.corpus <- load.corpus(files = "all",
                          corpus.dir="../Federalist/")
# View the data
summary(raw.corpus)

# Alternative
# Import all articles from the given folder 
# if the filename finishes with 'txt'
raw.corpus <- load.corpus(files=list.files(path="../Federalist/",
                                          pattern="[.]txt$"),
                          corpus.dir="../Federalist/")

# View the data (a list of all texts included in the loaded files)
summary(raw.corpus)

# View a given text, as for example the first one
# Composed of lines (defined according to the representation present in the file)
raw.corpus[[1]]
# And the first three lines of the first paper
raw.corpus[[1]][1:3]
# And to verify the corresponding file name of thsi first article
names(raw.corpus)[1]
#
#
# STEP 2:  TOKENIZE THE CORPUS
# A set of lines is not so useful, we need a list of words
# Apply the tokinizer for the English language,
# and replace uppercase letters by lowercases
tokenized.corpus <- txt.to.words.ext(raw.corpus, language="English", 
                                    preserve.case=FALSE)
# the result is a list of words per text
# So you can see the list of the words appearing in the first articles
tokenized.corpus[[1]]
# Or only the first 12 words of this article
tokenized.corpus[[1]][1:12]
# And to verify the corresponding file name
names(tokenized.corpus)[1]
#
#
# STEP 3: SUBDIVIDE the corpus into differnet parts
#
# Select the training part
corpus.train <- tokenized.corpus[grep("Hamilton|Madison|Jay",
                                      names(tokenized.corpus))]
# This sub-corpus must contains 70 texts
length(corpus.train)
#
# Select the part written by Hamilton
corpus.hamilton <- tokenized.corpus[grep("Hamilton", names(tokenized.corpus))]
# Corresponding to 51 articles
length(corpus.hamilton)
#
# Select the part written by Madison
corpus.madison <- tokenized.corpus[grep("Madison", names(tokenized.corpus))]
# With 14 articles
length(corpus.madison)
#
# Select the part written by Jay
corpus.jay <- tokenized.corpus[grep("Jay", names(tokenized.corpus))]
# This sub-corpus must contains 5 texts
length(corpus.jay)
#
#
# STEP 4: STATISTICS  over the different parts
#
# Generate a list with the top 50 most frequent words (head=50)
# with the absolute frequency (relative=FALSE)
# and keep this value (value=TRUE)
frequent50.words <- make.frequency.list(corpus.train, value=TRUE,
                                      head=50, relative=FALSE)
# Those 50 words are...
show(frequent50.words)
# And if we want to have the most frequent
names(frequent50.words)[1]
# And its absolute frequency
frequent50.words[[1]]
#
#
# To analyze the entire vocabulary used by the three authors
frequent.words <- make.frequency.list(corpus.train, value=TRUE,
                                       relative=FALSE)
# The vocabulary size used in Hamilton's texts
length(frequent.words)
# The total number of tokens in Hamilton's texts
sum(frequent.words)
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
# The top 10 most frequent words used by Hamiton with their frequency
frequent.words.hamilton[1:10]
#
#
# Some statistics about Madison
frequent.words.madison <- make.frequency.list(corpus.madison, value=TRUE,
                                          relative=FALSE)
# The vocabulary size used in Madison's texts
length(frequent.words.madison)
# The total number of tokens in Madison's texts
sum(frequent.words.madison)
# The top 10 most frequent words used by Madison with their frequency
frequent.words.madison[1:10]
#
#
# Some statistics about Jay
frequent.words.jay <- make.frequency.list(corpus.jay, value=TRUE,
                                               relative=FALSE)
# The vocabulary size used in Jay's texts
length(frequent.words.jay)
# The total number of tokens in Jay's texts
sum(frequent.words.jay)
# The top 10 most frequent words used by Jay with their frequency
frequent.words.jay[1:10]
#
# And the Zipf's law

# The vocabulary size used in Hamilton's texts
voc.size.hamilton <- length(frequent.words.hamilton)
# The total number of tokens in Hamilton's texts
token.size.hamilton <- sum(frequent.words.hamilton)
# The number of hapax in Hamilton's writings
sum(frequent.words.hamilton == 1)
# And in proportion or hapax density for Hamilton
sum(frequent.words.hamilton <= 1) / voc.size.hamilton 
# Hapax density for Hamilton
sum(frequent.words.hamilton == 1) / voc.size.hamilton 
# Number of dis legomena for Hamilton
dis.hamilton <- sum(frequent.words.hamilton == 2)
dis.hamilton
# Dis density for Hamilton
dis.hamilton / voc.size.hamilton 
# And the propostion of words appearing once or twice is ...
sum(frequent.words.hamilton <= 2) / voc.size.hamilton 
#
# And analyzing the frequencies of the most frequent words
# Coverage of the most frequent word in Hamilton's texts
sum(frequent.words.hamilton[frequent.words.hamilton > 10185]) / token.size.hamilton 
# Coverage of the top ten most frequent words 
sum(frequent.words.hamilton[frequent.words.hamilton > 1295]) / token.size.hamilton 
#
#
# STEP 5: VOCABULARY RICHNESS measurements
#
# TTR for Hamiton
voc.size.hamilton / token.size.hamilton 

# Guiraud's R for Hamiton
voc.size.hamilton / sqrt(token.size.hamilton)
# Herdan's C for Hamiton
log(voc.size.hamilton) / log(token.size.hamilton)
# Sichlel'S for Hamiton
dis.hamilton / voc.size.hamilton
# And the number of words appearing 5 times or less
sum(frequent.words.hamilton <= 5)
# In proportion is
sum(frequent.words.hamilton <= 5) / voc.size.hamilton 


