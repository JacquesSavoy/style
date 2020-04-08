#
# Exemple #1 with the Federalist Papers
#
# Working with Stylo library
library(stylo)

# Import the articles from the current folder
raw.corpus <- load.corpus(files = c("./Federalist/FederalistHamilton01.txt",
                                    "./Federalist/FederalistHamilton06.txt",
                                    "./Federalist/FederalistHamilton07.txt",
                                    "./Federalist/FederalistHamilton08.txt",
                                    "./Federalist/FederalistHamilton09.txt",
                                    "./Federalist/FederalistHamilton11.txt",
                                    "./Federalist/FederalistHamilton12.txt",
                                    "./Federalist/FederalistHamilton13.txt",
                                    "./Federalist/FederalistHamilton15.txt",
                                    "./Federalist/FederalistHamilton16.txt",
                                    "./Federalist/FederalistHamilton17.txt",
                                    "./Federalist/FederalistHamilton21.txt",
                                    "./Federalist/FederalistHamilton22.txt",
                                    "./Federalist/FederalistHamilton23.txt",
                                    "./Federalist/FederalistHamilton24.txt",
                                    "./Federalist/FederalistHamilton25.txt",
                                    "./Federalist/FederalistHamilton26.txt",
                                    "./Federalist/FederalistHamilton27.txt",
                                    "./Federalist/FederalistHamilton28.txt",
                                    "./Federalist/FederalistHamilton29.txt",
                                    "./Federalist/FederalistHamilton30.txt",
                                    "./Federalist/FederalistHamilton31.txt",
                                    "./Federalist/FederalistHamilton32.txt",
                                    "./Federalist/FederalistHamilton33.txt",
                                    "./Federalist/FederalistHamilton34.txt",
                                    "./Federalist/FederalistHamilton35.txt",
                                    "./Federalist/FederalistHamilton36.txt",
                                    "./Federalist/FederalistHamilton59.txt",
                                    "./Federalist/FederalistHamilton60.txt",
                                    "./Federalist/FederalistHamilton61.txt",
                                    "./Federalist/FederalistHamilton65.txt",
                                    "./Federalist/FederalistHamilton66.txt",
                                    "./Federalist/FederalistHamilton67.txt",
                                    "./Federalist/FederalistHamilton68.txt",
                                    "./Federalist/FederalistHamilton69.txt",
                                    "./Federalist/FederalistHamilton70.txt",
                                    "./Federalist/FederalistHamilton71.txt",
                                    "./Federalist/FederalistHamilton72.txt",
                                    "./Federalist/FederalistHamilton73.txt",
                                    "./Federalist/FederalistHamilton74.txt",
                                    "./Federalist/FederalistHamilton75.txt",
                                    "./Federalist/FederalistHamilton76.txt",
                                    "./Federalist/FederalistHamilton77.txt",
                                    "./Federalist/FederalistHamilton78.txt",
                                    "./Federalist/FederalistHamilton79.txt",
                                    "./Federalist/FederalistHamilton80.txt",
                                    "./Federalist/FederalistHamilton81.txt",
                                    "./Federalist/FederalistHamilton82.txt",
                                    "./Federalist/FederalistHamilton83.txt",
                                    "./Federalist/FederalistHamilton84.txt",
                                    "./Federalist/FederalistHamilton85.txt",
                                    "./Federalist/FederalistMadison10.txt",
                                    "./Federalist/FederalistMadison14.txt",
                                    "./Federalist/FederalistMadison37.txt",
                                    "./Federalist/FederalistMadison38.txt",
                                    "./Federalist/FederalistMadison39.txt",
                                    "./Federalist/FederalistMadison40.txt",
                                    "./Federalist/FederalistMadison40.txt",
                                    "./Federalist/FederalistMadison41.txt",
                                    "./Federalist/FederalistMadison42.txt",
                                    "./Federalist/FederalistMadison43.txt",
                                    "./Federalist/FederalistMadison44.txt",
                                    "./Federalist/FederalistMadison45.txt",
                                    "./Federalist/FederalistMadison46.txt",
                                    "./Federalist/FederalistMadison47.txt",
                                    "./Federalist/FederalistMadison48.txt",
                                    "./Federalist/FederalistJay02.txt",
                                    "./Federalist/FederalistJay03.txt",
                                    "./Federalist/FederalistJay04.txt",
                                    "./Federalist/FederalistJay05.txt",
                                    "./Federalist/FederalistJay64.txt",
                                    "./Federalist/FederalistTest49.txt",
                                    "./Federalist/FederalistTest50.txt",
                                    "./Federalist/FederalistTest51.txt",
                                    "./Federalist/FederalistTest52.txt",
                                    "./Federalist/FederalistTest53.txt",
                                    "./Federalist/FederalistTest54.txt",
                                    "./Federalist/FederalistTest55.txt",
                                    "./Federalist/FederalistTest56.txt",
                                    "./Federalist/FederalistTest57.txt",
                                    "./Federalist/FederalistTest58.txt",
                                    "./Federalist/FederalistTest62.txt",
                                    "./Federalist/FederalistTest63.txt") )

#      and you can see why
raw.corpus <- load.corpus(files = "all",
                          corpus.dir="./Federalist/") 
#      is simpler (if the directory contains only those files)

# View the data
summary (raw.corpus)

# Tokenize the corpus
tokenized.corpus <- txt.to.words.ext(raw.corpus, language="English", 
                                    preserve.case=FALSE)

# Select the sub-corpus written by Hamilton
corpus.hamilton <- tokenized.corpus[grep("Hamilton", names(tokenized.corpus))]
# Select the articles written by Madison
corpus.madison <- tokenized.corpus[grep("Madison", names(tokenized.corpus))]
# Select the texts written by Jay
corpus.jay <- tokenized.corpus[grep("Jay", names(tokenized.corpus))]

# Select the test part
corpus.test  <- tokenized.corpus[grep("Test", names(tokenized.corpus))]
summary(corpus.test)

# Select the training part
corpus.train <- tokenized.corpus[grep("Hamilton|Madison|Jay", 
                                      names(tokenized.corpus))]
summary(corpus.train)

# Select the feature:  Here the 50 Most Frequent Word-types
myFrequentFeatures <- make.frequency.list(tokenized.corpus, head=50)

# Represent each text with these 50 MFWs
freqs <- make.table.of.frequencies(tokenized.corpus,
                                   features = myFrequentFeatures)

# the size of the variable
dim(freqs)

# And some examples
freqs[c(4, 28, 52, 56, 60, 62),c(1, 13, 15, 26, 50)]

# We select 'the' and 'would' as predictors
plot(freqs[1:51,1], freqs[1:51,15], xlim=c(6,9), ylim=c(0.2, 1.2),
     xlab="Relative frequencies of 'the'",
     ylab="Relative frequencies of 'would'",
     pch=18, col="red")

# The articles writtenby Jay in darkgreen
points(freqs[52:56,1], freqs[52:56,15], pch=15,col="darkgreen")
# The articles written by Madison in darkorchid
points(freqs[57:70,1], freqs[57:70,15], pch=20,col="darkorchid")
# The doubtful articles in blue
points(freqs[71:82,1], freqs[71:82,15], pch=20,col="blue")




