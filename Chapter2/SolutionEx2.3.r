#
# Solution of Exercise #2.3
#
# START: load the stylo package
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
corpus.test <- tokenized.corpus[grep("Test",
                                      names(tokenized.corpus))]
length(corpus.test)
#
# Or according to each author
corpus.hamilton <- tokenized.corpus[grep("Hamilton", names(tokenized.corpus))]
corpus.madison <- tokenized.corpus[grep("Madison", names(tokenized.corpus))]
corpus.jay <- tokenized.corpus[grep("Jay", names(tokenized.corpus))]
#
# Compute all words and their absolute frequency used per each author
frequent.words.hamilton <- make.frequency.list(corpus.hamilton, value=TRUE,
                                      relative=FALSE)
frequent.words.madison <- make.frequency.list(corpus.madison, value=TRUE,
                                          relative=FALSE)
frequent.words.jay <- make.frequency.list(corpus.jay, value=TRUE,
                                          relative=FALSE)
#
# All words used in the training corpus
frequent.words <- make.frequency.list(corpus.train, value=TRUE,
                                      relative=FALSE)
#
#
# Expore the Zipf's Law
#
options(digits=3)
#
# With Hamilton
#
# The vocabulary size used in Hamilton's texts
voc.size.hamilton <- length(frequent.words.hamilton)
# The total number of tokens in Hamilton's texts
token.size.hamilton <- sum(frequent.words.hamilton)
# The number of hapax in Hamilton's writings
# (hapax = word appearing only once)
hapax.hamilton <- sum(frequent.words.hamilton == 1)
hapax.hamilton
#
# Hapax density for Hamilton
sum(frequent.words.hamilton == 1) / voc.size.hamilton 
# Number of dis legomena for Hamilton
# (dis = word appearing exactly twice)
dis.hamilton <- sum(frequent.words.hamilton == 2)
dis.hamilton
# Dis density for Hamilton
dis.hamilton / voc.size.hamilton 
#
# And the proportion of words appearing once or twice is ...
sum(frequent.words.hamilton <= 2) / voc.size.hamilton 
# Number and proportion of words appearing three times
sum(frequent.words.hamilton == 3)
sum(frequent.words.hamilton == 3) / voc.size.hamilton 
# Number and proportion of words appearing five times of less
sum(frequent.words.hamilton <= 5)
sum(frequent.words.hamilton <= 5) / voc.size.hamilton 
#
# With Madison
#
# The vocabulary size used in Madison's texts
voc.size.madison <- length(frequent.words.madison)
# The total number of tokens in Madison's texts
token.size.madison <- sum(frequent.words.madison)
# The number of hapax in Madison's writings
hapax.madison <- sum(frequent.words.madison == 1)
hapax.madison
# Hapax density for Madison
sum(frequent.words.madison == 1) / voc.size.madison 
# Number of dis legomena for Madison
dis.madison <- sum(frequent.words.madison == 2)
dis.madison
# Dis density for Madison
dis.madison / voc.size.madison 
# Number and proportion of words appearing three times
sum(frequent.words.madison == 3)
sum(frequent.words.madison == 3) / voc.size.madison 
# Number and proportion of words appearing five times of less
sum(frequent.words.madison <= 5)
sum(frequent.words.madison <= 5) / voc.size.madison 
#
# With Jay
#
# The vocabulary size used in Jay's texts
voc.size.jay <- length(frequent.words.jay)
# The total number of tokens in Jay's texts
token.size.jay <- sum(frequent.words.jay)
# The number of hapax in Jay's writings
hapax.jay <- sum(frequent.words.jay == 1)
hapax.jay
# Hapax density for Jay
sum(frequent.words.jay == 1) / voc.size.jay 
# Number of dis legomena for Jay
dis.jay <- sum(frequent.words.jay == 2)
dis.jay
# Dis density for Jay
dis.jay / voc.size.jay 
# Number and proportion of words appearing three times
sum(frequent.words.jay == 3)
sum(frequent.words.jay == 3) / voc.size.jay 
# Number and proportion of words appearing five times of less
sum(frequent.words.jay <= 5)
sum(frequent.words.jay <= 5) / voc.size.jay

#
# End of Exercise 2.3
#
