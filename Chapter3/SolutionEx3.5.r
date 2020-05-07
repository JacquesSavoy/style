#
# Solution for Exercise #3.5
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
# Define the KLD function
#

kld <- function(aQuery, aVector){
  if (abs(sum(aQuery)-1.0) > 0.00001) {
    stop("The first vector is not a probability distribuition") }
  if (abs(sum(aVector)-1.0) > 0.00001) {
    stop("The second vector is not a probability distribuition") }
  return(sum(aQuery * log(aQuery/aVector, 2)))
  }

#
# STEP 5: Compute the KLD score for all papers written by Hamilton
# 
for (anIndex in 1:(dim(freqs.hamilton.rel))[1]) {
  cat (anIndex, rownames(freqs.hamilton.rel)[anIndex], " ")
  cat (kld(freqs.test.rel, as.vector(freqs.hamilton.rel[anIndex,])))
  cat("\n")
}
# Compute the KLD score for all papers written by Madison
# 
for (anIndex in 1:(dim(freqs.madison.rel))[1]) {
  cat (anIndex, rownames(freqs.madison.rel)[anIndex], " ")
  cat (kld(freqs.test.rel, as.vector(freqs.madison.rel[anIndex,])))
  cat("\n")
}
#
# The smallest value: 
# 2 FederalistHamilton60.txt  0.011
# Hamilton is the possible author of Q54
#
