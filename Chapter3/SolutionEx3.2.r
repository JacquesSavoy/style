#
# Solution for Exercise #3.2
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
corpus.hamilton <- tokenized.corpus[grep("Hamilton",
                                         names(tokenized.corpus))]
corpus.madison <- tokenized.corpus[grep("Madison",
                                        names(tokenized.corpus))]
corpus.Q54 <- tokenized.corpus[grep("54",
                                    names(tokenized.corpus))]
# Step 3: Selected a few word-types/ articles
selected.words <- c('the', 'of', 'to', 'in', 'and', 'a')
# Selected four articles written by Hamilton
subcorpus.hamilton <- corpus.hamilton[grep("59|60|61|65",
                                           names(corpus.hamilton))]
# Selected four articles written by Madison
subcorpus.madison <- corpus.madison[grep("37|38|47|48",
                                         names(corpus.madison))]
# Generate a vector for each text for Hamilton
freqs.hamilton <- make.table.of.frequencies(subcorpus.hamilton,
                                            relative=FALSE,
                                            features=selected.words)
# And for Madison
freqs.madison <- make.table.of.frequencies(subcorpus.madison,
                                           relative=FALSE,
                                           features=selected.words)
# Compute the mean for each word-type over all papers 
options(digits=3)
freqs.hamilton.rel <- freqs.hamilton / apply(freqs.hamilton, 1, sum)
freqs.madison.rel  <- freqs.madison / apply(freqs.madison, 1, sum)
# And for the query article #54
freqs.test <- make.table.of.frequencies(corpus.Q54,
                                        relative=FALSE,
                                        features=selected.words)
# Transform this single query text with relative frequencies
freqs.test.rel <- freqs.test / sum(freqs.test)
#
# STEP 4: Selected a few word-types/ articles
#
# Form a unique variable with the training articles
freqs.train.rel <- rbind(freqs.hamilton.rel, freqs.madison.rel)
#
# Profile-based evaluation
#
# Generate the two author's profile
# by averaging the relative frequencies of all papers written by that author
# 
profile.hamilton <- apply(freqs.hamilton.rel, 2, mean)
profile.hamilton
profile.madison  <- apply(freqs.madison.rel, 2, mean)
profile.madison
#
#
# Transform into Z scores
#
# The mean over all selected word-types
freqs.train.mean <- apply(freqs.train.rel, 2, mean)
freqs.train.mean
# The standard deviation over all word-types
freqs.train.sd <- apply(freqs.train.rel, 2, sd)
freqs.train.sd
#
# The Z score for Hamilton's profile
profile.hamilton.Z <- (profile.hamilton - freqs.train.mean) / freqs.train.sd
profile.hamilton.Z
# The Z score for Madison's profile
profile.madison.Z <- (profile.madison - freqs.train.mean) / freqs.train.sd
profile.madison.Z
# The Z score for the test set
freqs.test.Z <- (freqs.test.rel - freqs.train.mean) / freqs.train.sd
freqs.test.Z
#
# STEP 5: Compute the Delta score for both authors
# 
hamilton.Delta <- mean(abs(profile.hamilton.Z - freqs.test.Z))
hamilton.Delta
madison.Delta <- mean(abs(profile.madison.Z - freqs.test.Z))
madison.Delta
# 
# Hamilton presents the closest profile for Article T54





