where a i k is the value of the lcth parameter at location i. Note that (1)is a special
case of (3) in which all of the functions are conStants across space. As will be
shown below, the point i at which estimates of the parameters are obtained is
completely generalizable and need not only refer to points at which data are collected. It is very easy with GWR to compute parameter estimates, for instance, for
locations that lie between data points, which makes it possible to produce detailed
maps of spatial variations in relationships.
Although the model in equation (3) appears to be a simple extension of that
in equation (I), a problem with calibrating (3) is that the unknown quantities
are in fact functions mapping geographical space onto the real line, rather
than simple scalars as in (1). In a typical data set, samples of the dependent
and independent variables are taken at a set of sample points and it is from

15384632, 1996, 4, Downloaded from https://onlinelibrary.wiley.com/doi/10.1111/j.1538-4632.1996.tb00936.x by candy Trung - Readcube (Labtiva Inc.) , Wiley Online Library on [01/10/2026]. See the Terms and Conditions (https://onlinelibrary.wiley.com/terms-and-conditions) on Wiley Online Library for rules of use; OA articles are governed by the applicable Creative Commons License

284 f

285

these that the parameters must be estimated. In the traditional model, these
estimates are constant for all i but in equation (3) this is clearly not the case.
For model (3),it seems intuitively appealing to base estimates of aik on observations taken at sample points close to i. If some degree of smoothness of the
aiks is assumed, then reasonable approximations may be made by considering
the relationship between the observed variables in a region geographically
close to i.
Using a weighted least squares approach to calibrating regression models,
different emphases can be placed on different observations in generating the
estimated parameters. In ordinary least squares, the sum of the squared differences of predicted and actual yis is minimized by the coefficient estimates. In
weighted least squares a weighting factor w, is applied to each squared difference before minimizing, so that the inaccuracy of some predictions carries
more of a penalty than others. If w is the diagonal matrix of wis. then the estimated coefficients satisfy

In GWR, weighting an observation in accordance with its proximity to i would
allow an estimation of a i k to be made that meets the criterion of “closeness of
calibration points” set out above.
Note that usually in weighted regression models the values of wi are constant,
so that only one calibration has to be carried out to obtain a set of coefficient
estimates, but in this case w varies with i so that a different calibration exists
for every point in the study area. In this case, the parameter estimation formula
could be written more generally as

There are parallels between this method and that of kernel re ression and
kernel density estimation (Parzen 1962; Cleveland 1979; Clevelan and Devlin
1988; Silverman 1986; Brunsdon 1991, 1995; Wand and Jones 1995, pp. 11445). In kernel regression, y is modeled as a nonlinear function of x by weighted
regression, with weights for the ith observation depending on the proximity of x
and x, for each i with the estimator being

f

i(x) = (x~w(x)x)-’xtw(x)y.

(6)

The essential difference between the two methods is that in (6), kernel regression,
the weighting system depends on the location in “attribute space” (Openshaw
1993) of the independent variables, whereas in (5), GWR, it depends on location
in geographical space. The output from (5)is typically a set of localized parameter
estimates in x space so that highly nonlinear and nonmonotonic relationships
between y and x can be modeled. The typical output from (6), however, will be
a set of parameter estimates that can be mapped in geographic space to represent
nonstationarity or parameter “drift.”
3.1 Choice of Spatial Weighting Function

Until this point, it has merely been stated that w(i) is a weighting scheme
based on the proximity of i to the sampling locations around i without an

15384632, 1996, 4, Downloaded from https://onlinelibrary.wiley.com/doi/10.1111/j.1538-4632.1996.tb00936.x by candy Trung - Readcube (Labtiva Inc.) , Wiley Online Library on [01/10/2026]. See the Terms and Conditions (https://onlinelibrary.wiley.com/terms-and-conditions) on Wiley Online Library for rules of use; OA articles are governed by the applicable Creative Commons License

Chris Brunsdon, A. Stewart Fotheringham, and Martin E . Charlton

/ Geographical Analysis

explicit relationship being stated. The choice of such a relationship will be considered here. Firstly, consider the implicit weighting scheme of (2). Here
wij = 1

vi,j

(7)

where j represents a specific point in space at which data are observed and i represents any point in space for which parameters are estimated. That is, in the
global model each observation has a weight of unity. An initial step toward weighting based on locality might be to exclude from the model calibration observations
that are further than some distance d from the locality. This would be equivalent
to setting their weights to zero, giving a weighting function of

< d;

wij = 1

if

wij = 0

otherwise.

dij

(8)
