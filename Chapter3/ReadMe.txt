
Chapter 3 presents the Delta model.

We will investigate all the details underlying this model with the Federalist Papers.

In the file Delta.xls, one can find a version of the Delta model with 8 articles and 8 word-types.  Both the profile and instances-based computations are provided.  



The roadmap is the following.

Exercise #3.1:  Select four papers from two authors and a test articles
                and represent them with a six selected word-types

Exercise #3.2:  Profile-base approach
                From the few articles and word-types used in Exercise #3.1
                Generate the profile of the two authors
                Compute the Delta distance with the disputed article

Exercise #3.3:  Instances-based approach
                Similar as Exercise #3.2 but each selected articles is used
                to compute the Delta score with the disputed articles

Exercise #3.4:  Instances-based approach
                Apply the Delta model to all disputed articles
                Considering all training articles 
                Using the classify() function of the style package

Exercise #3.5:  KLD method
                Define function to compute the KLD value
                Select only six word-types
                Considering four articles written by Hamilton and four by Madison 
                and only the doubtful article Q54

Exercise #3.6:  Different distance measures
                Select the six word-types of previous exercise
                with the eight training articles.
                Define functions to compute different distances
                and similarity functions
                


The code needed to draw the two figures related to PCA are also provided in the file

   doFig3.1.txt
   doFig3.2.txt

with the associated data in the file 'DataTable3.7.txt'.