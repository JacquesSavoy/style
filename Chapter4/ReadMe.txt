
Chapter 4 is dealing with statistical analysis and tests.

To help you understand the procedure, we compute the sign and the t-test with a small example.

Let us assume that we need to verify the effectiveness of two authorship attribution systems (denoted A and B)
(or, if your prefer, the two systems are used to identify some author's demographics).

We have collected 10 cases (for which the correct answer is known with an absolute certainty).
In our evaluation, one can see these 10 cases as 10 experiments. For each of them, System A (and B) identifies the possible author by ranking the author names.  Thus one can verify whether or not the correct answer appears in the first rank or not.  

To evaluate the effectiveness achieved for each experiement, we compute the reciprocal rank of the correct answer. If the correct answer appears in the second position, the score is 1/2 = 0.5.  For the ten experiments, we obtained the following results with System A and B.      

    A	   B 
   1	  0.5
   0.5	  0.25
   0.2	  0.33
   0.5	  0.25
   0.1	  0.1
   0.2	  0.16
   0.5	  0.125
   1	  0.2
   0.5	  0.33
   0.33	  0.25

(This data is stored in the file SystemAB.txt).


The roadmap is the following.

Exercise #4.1:  Load the data and compute the sign test.  What is our conclusion?

Exercise #4.2:  Load the data and compute the t-test.  What is our conclusion?
