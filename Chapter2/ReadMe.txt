
Chapter 2 presents the Federalist Papers corpus composed of 82 newspapers articles written by Alexander Hamilton, James Madison, and John Jay.

Hamilton wrote 51 articles, Madison 14, and Jay 5.  In addition, three articles have been jointly written by Hamilton and Madison (Article #18, #19, and #20).  Theses three papers are not included in our corpus.

Thus it remains 12 papers with a doubtful authorship forming the test set. The rest (70 texts) corresponds to the training set. In total, the corpus contains 82 articles.

For all articles, we removed the first phrase (always the same, namely 'To the People of the State of New York') as well as the signature ('PUBLIUS').



As practical exercises related to Chapter 2, we explore this corpus and extract some general overall measurements.


We will start by loading the STYLO package and specifying the correct directory for the dataset.

As additional introduction to the STYLO package, you can look at this video

    https://www.youtube.com/watch?v=pWOCfZnitdc




The roadmap is the following.

Exercise #2.1:  Load the corpus, split it into different sub-corpora (training & test).

Exercise #2.2:  Compute some general statistics about the corpus (the Zipf's Law).

Exercise #2.3:  Explore the lower tail of the Zipf's Law.

Exercise #2.4:  Vocabulary richness measures:  TTR, hapax density, Sichel's S.
