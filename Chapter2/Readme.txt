
Chapter 2 presents the Federalist Papers corpus composed of 82 newspapers articles written by Alexander Hamilton, James Madison, and John Jay.

Hamilton wrote 51 articles, Madison 14, and Jay 5.  In addition, three have been jointly written by Hamilton and Madison (Article #18, #19, and #20).  Theses three papers are not included in our corpus.

12 papers with a doubtful authorship form the test set.
The rest (70 texts) forms the training set.
In total, the corpus contains 82 articles.

For all articles, we removed the first phrase ('To the People of the State of New York') and the final signature (PUBLIUS).

In Chapter 2, we explore this corpus and extract some general overall measurements.

We will start by loading the STYLO package and specifying the correct directory.

The roadmap is the following.

Step 1:  Load the corpus form the specified data directory

Step 2:  Tokenize the corpus

Step 3:  Subdivide the corpus according to the three authors

Step 4:  Generate the overall statistics: number of tokens, vocabulary size

Step 5:  Vocabulary richness measure:  TTR, hapax number
