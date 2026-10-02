15384632, 1996, 4, Downloaded from https://onlinelibrary.wiley.com/doi/10.1111/j.1538-4632.1996.tb00936.x by candy Trung - Readcube (Labtiva Inc.) , Wiley Online Library on [01/10/2026]. See the Terms and Conditions (https://onlinelibrary.wiley.com/terms-and-conditions) on Wiley Online Library for rules of use; OA articles are governed by the applicable Creative Commons License

Chris Brunsdon, A. Stewart Fotheringham, and Martin E . Charlton f

/ Geographical Analysis

x

Plotting the CV score against the required arameter of whatever weighting
function is selected will therefore provide gui ance on selecting an appropriate
value of that parameter. If it is desired to automate this process, then the CV
score could be maximized using an optimization technique such as a Golden
Section search (Greig 1980).
3.3 Testing For Spatial Nonstationarity
Until this point, the techniques associated with GWR have been predominantly descriptive. However, two useful questions may be examined:
Does the GWR model describe the data significantly better than a global
regression model?
Does the set of aik parameters exhibit significant spatial variation?
In the first case, the geographically varying regression model as a whole is
being tested. In the second case, it is possible to test whether the rate of
change for any specific variable alters significantly across the study re on. In
order to answer either of these two questions, descriptive statistics for t e sample must be defined. In the first instance this statistic will describe the level of
globality in the model. One possible choice here is the weighting arameter
obtained by the CV procedure which can be used to assess the di erence of
the GWR model from a global model. As described above, the value of B in
the exponential function tend to zero for the global model and deviations of
the estimate of /Ifrom zero indicate the degree of difference between the local
and global models.
For the second hypothesis, it is the variability of Gk that can be used to
describe the plausibility of a constant coefficient. In general terms, this could be
is the GWR estithought of as a variance measure. For a given k suppose
mate of Uik. Then a possible estimate of variability would be the “roughness”
of a:k, defined as

f?

f

where

and G is the study area. This could be estimated if a gridwise approximation to ai;,
were constructed. However, this statistic would be relatively cumbersome to compute, so an alternative is proposed here. Suppose for each of the n sample points
i the parameter estimate a; is computed. This would give n estimates of the
coefficient under study. One way to proceed would then be to compute the standard deviation of these values. This gives a sampled estimate of (13).This statistic
will be referred to as si.
There are now two types of statistic defined, one relating to each of the questions posed above. The next stage is to determine their sampling distributions
under the null hypothesis that model (1)holds. Although it is proposed to consider theoretical properties of these distributions in the future, for the time
being a Monte Carlo approach will be adopted. Under the null hypothesis, any
permutation of (.i,yi) pairs among the geographical sampling points i are
equally likely to occur. Thus, the observed values of /3 or si could be compared

15384632, 1996, 4, Downloaded from https://onlinelibrary.wiley.com/doi/10.1111/j.1538-4632.1996.tb00936.x by candy Trung - Readcube (Labtiva Inc.) , Wiley Online Library on [01/10/2026]. See the Terms and Conditions (https://onlinelibrary.wiley.com/terms-and-conditions) on Wiley Online Library for rules of use; OA articles are governed by the applicable Creative Commons License

288

1 289

TABLE 1
Variables Used in GWR Example
Dependent or
Independent

Variable

Numerator

Denominator

Male Unemployment

Male Population
Seeking Work

I

Social Class I

Households with
Head in Social
Class I
Number of Cars

Population
Economically
Active
Total Households
Number of
Households (100s)

D

Cars per Households

I

to these randomization distributions in order to perform a significance test.
Making use of the Monte Carlo approach, it is also the case that selecting N
random permutations of (.i,yi) pairs amongst the i and computing either j?or
si will also give a significance test when compared with the observed statistics.
When carrying out the test for j?, note that computational overheads may
be considerable. For each permutation, a CV-optimal must be found using a
golden section search. Although this method is time consuming, it is a relatively
simple task to compute each of the si statistics for each permutation once B has
been calibrated. One possible time-saving step, if it is not desired to test the
significance of p, is to optimize j? from the observed data, and using this value
carry out the remaining permutation-based estimates of si.
4. A CASE STUDY: CAR OWNERSHIP IN TYNE AND WEAR
