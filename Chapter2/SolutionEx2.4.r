#
# Solution for Exercise #2.4
#
# START: load the stylo package
library(stylo)
# Load the corpus
raw.corpus <- load.corpus(files=list.files(path="../Federalist/",
                                          pattern="[.]txt$"),
                          corpus.dir="../Federalist/")
length(raw.corpus)
# STEP 2:  Tokenize the corpus
tokenized.corpus <- txt.to.words.ext(raw.corpus, language="English", 
                                    preserve.case=FALSE)
# STEP 3: Subdive the corpus according to the three authors
corpus.hamilton <- tokenized.corpus[grep("Hamilton", names(tokenized.corpus))]
corpus.madison <- tokenized.corpus[grep("Madison", names(tokenized.corpus))]
corpus.jay <- tokenized.corpus[grep("Jay", names(tokenized.corpus))]
# STEP 4: Compute the list of words and thier absolute frequency
frequent.words.hamilton <- make.frequency.list(corpus.hamilton, value=TRUE,
                                      relative=FALSE)
frequent.words.madison <- make.frequency.list(corpus.madison, value=TRUE,
                                          relative=FALSE)
frequent.words.jay <- make.frequency.list(corpus.jay, value=TRUE,
                                               relative=FALSE)
options(digits=4)
#
#
# STEP 5: VOCABULARY RICHNESS measurements
#
# For Hamilton
#
# The vocabulary size used in Hamilton's texts
voc.size.hamilton <- length(frequent.words.hamilton)
# The total number of tokens in Hamilton's texts
token.size.hamilton <- sum(frequent.words.hamilton)
# The number of hapax in Hamilton's writings
hapax.hamilton <- sum(frequent.words.hamilton == 1)
# Number of dis legomena for Hamilton
dis.hamilton <- sum(frequent.words.hamilton == 2)


# TTR for Hamiton
voc.size.hamilton / token.size.hamilton 
# Guiraud's R for Hamiton
voc.size.hamilton / sqrt(token.size.hamilton)
# Herdan's C for Hamiton
log(voc.size.hamilton) / log(token.size.hamilton)
# Hapax density
hapax.hamilton / voc.size.hamilton
# Sichlel'S for Hamiton
dis.hamilton / voc.size.hamilton
#
# For Madison
#
# The vocabulary size used in Madison's texts
voc.size.madison <- length(frequent.words.madison)
token.size.madison <- sum(frequent.words.madison)
hapax.madison <- sum(frequent.words.madison == 1)
dis.madison <- sum(frequent.words.madison == 2)
#
# TTR for Madison
voc.size.madison / token.size.madison 
# Guiraud's R for Madison
voc.size.madison / sqrt(token.size.madison)
# Herdan's C for Madison
log(voc.size.madison) / log(token.size.madison)
# Hapax density
hapax.madison / voc.size.madison
# Sichlel'S for Madison
dis.madison / voc.size.madison
#
# For Jay
#
# The vocabulary size used in Jay's texts
voc.size.jay <- length(frequent.words.jay)
token.size.jay <- sum(frequent.words.jay)
hapax.jay <- sum(frequent.words.jay == 1)
dis.jay <- sum(frequent.words.jay == 2)
#
# TTR for Jay
voc.size.jay / token.size.jay 
# Guiraud's R for Jay
voc.size.jay / sqrt(token.size.jay)
# Herdan's C for Jay
log(voc.size.jay) / log(token.size.jay)
# Hapax density
hapax.jay / voc.size.jay
# Sichlel'S for Jay
dis.jay / voc.size.jay

#
#
#
