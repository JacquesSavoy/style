#
# Solution for Exercise #3.1
#
# Step 1: load the stylo package
library(stylo)
# Load the corpus
raw.corpus <- load.corpus(files=list.files(path="../Federalist/",
                                          pattern="[.]txt$"),
                          corpus.dir="../Federalist/")
# Step 2: Tokenize the corpus
tokenized.corpus <- txt.to.words.ext(raw.corpus, language="English", 
                                    preserve.case=FALSE)
# Subdive the corpus according to Hamilton & Madison
corpus.hamilton <- tokenized.corpus[grep("Hamilton",
                                         names(tokenized.corpus))]
# The number of texts must be 51
length(corpus.hamilton)
# For Madison
corpus.madison <- tokenized.corpus[grep("Madison",
                                        names(tokenized.corpus))]
corpus.jay <- tokenized.corpus[grep("Jay",
                                    names(tokenized.corpus))]
# Select the doubtful article #54
corpus.Q54 <- tokenized.corpus[grep("54",
                                    names(tokenized.corpus))]
#
# STEP 3: Selected a few word-types
#
selected.words <- c('the', 'of', 'to', 'in', 'and', 'a')
# Selected four articles written by Hamilton
subcorpus.hamilton <- corpus.hamilton[grep("59|60|61|65",
                                names(corpus.hamilton))]
length(subcorpus.hamilton)
# Check their names
names(subcorpus.hamilton)
#
# Selected four articles written by Madison
subcorpus.madison <- corpus.madison[grep("37|38|47|48",
                                           names(corpus.madison))]
length(subcorpus.madison)
# Check their names
names(subcorpus.madison)
#
# Generate a vector for each text
freqs.hamilton <- make.table.of.frequencies(subcorpus.hamilton,
                                        relative=FALSE,
                                         features=selected.words)
freqs.hamilton
# And the length of the selected articles with the chosen words
apply(freqs.hamilton, 1, sum)
#
# And for Madison
freqs.madison <- make.table.of.frequencies(subcorpus.madison,
                                           relative=FALSE,
                                           features=selected.words)
freqs.madison
# And the length of the selected articles with the chosen words
apply(freqs.madison, 1, sum)
#
# Compute the mean for each word-type over all papers 
options(digits=3)
freqs.hamilton.rel <- freqs.hamilton / apply(freqs.hamilton, 1, sum)
freqs.hamilton.rel
freqs.madison.rel  <- freqs.madison / apply(freqs.madison, 1, sum)
freqs.madison.rel
#
# And for the query article #54
freqs.test <- make.table.of.frequencies(corpus.Q54,
                                           relative=FALSE,
                                           features=selected.words)
freqs.test
# And the length of the selected articles with the chosen words
sum(freqs.test)
# Transform this single query text with relative frequencies
freqs.test.rel <- freqs.test / sum(freqs.test)
freqs.test.rel
