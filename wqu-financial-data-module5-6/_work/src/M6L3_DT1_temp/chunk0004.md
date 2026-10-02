The use of (8) allows for efficient computation, since for every point for
which coefficients are to be computed, only a subset (often quite small) of the
sample points need to be included in the regression model. However, the spatial weighting function in (8) suffers the problem of discontinuity. As i vanes
around the study area, the regression coefficients could change drastically as
one sample point moves into or out of the circular buffer around i and which
defines the data to be included in the calibration for location i. Although sudden changes in the parameters over space might genuinely occur, in this case
changes in their estimates would be artifacts of the arrangement of sample
points, rather than any underlying process in the phenomena under investigation. One way to combat this is to specify wij as a continuous function of &j,
the distance between i and j. In this case, it can be seen from ( 5 ) that the coefficient estimates would then vary continuously with i. One obvious choice
might be

so that if i is a point in space at which data are observed, the weighting of that
data will be unity and the weighting of other data will decrease according to a
Gaussian curve as the distance between i and j increases. In the latter case the
inclusion of data in the calibration procedure becomes “fractional.” For example,
in the calibration of a model for point i, if wij = 0.5, then data at point j contribute only half the weight in the calibration procedure as data at point i itself. For
data a long way from i the weighting w
ill fall to virtually zero, effectively excluding
these observations from the estimation of parameters for location i.
Compromises between (8) and (9) may be reached, having the computationally desirable property of excluding all data points greater than some distance
from i and also the analytically desirable property of continuity. One such example is the bisquare function defined by
wij = [l - d;/d2I2
wij = 0

otherwise.

if

dij

< d;
(10)

This excludes points outside radius d but tapers the weighting of points inside the
radius, so that wij is a continuous and once differentiable function for all points
less than d units from i.

15384632, 1996, 4, Downloaded from https://onlinelibrary.wiley.com/doi/10.1111/j.1538-4632.1996.tb00936.x by candy Trung - Readcube (Labtiva Inc.) , Wiley Online Library on [01/10/2026]. See the Terms and Conditions (https://onlinelibrary.wiley.com/terms-and-conditions) on Wiley Online Library for rules of use; OA articles are governed by the applicable Creative Commons License

286

287

Whatever the specific weighting function employed, the essential idea of
GWR is that for each point i there is a “bump of influence” around i corresponding to the weighting function in such a way that sampled observations
near to i have more influence in the estimation of i’s parameters than do
sampled observations farther away. The moving window methodology used to
create Figure 1 and described more fully elsewhere (Fotheringham, Charlton,
and Brunsdon 1996) employs a weighting function defined by unity if the points
i and j lie within the square whose vertices are (-d/2,-d/2), (-d/2,d/2),
(d/2,d/2) and ( 4 2 , -d/2), and zero otherwise. This is essentially a “sudden
cut-off’ kernel like ( 8 ) , but square rather than circular in shape. In hindsight
this appears a to be rather eccentric choice of kernel, although clearly in computational terms this fits the raster framework well.
3.2 Calibrating the Weighting Function

One difficulty with GWR is that the estimated parameters are, in part, functions of the weighting function or kernel selected in the method. In (8), for
example, as d becomes larger, the closer will be the model solution to that of
OLS and when d is equal to the maximum distance between points in the system, the two models will be equal. Equivalently, in (9) as B tends to zero, the
weights tend to one for all pairs of points so that the estimated parameters
become uniform and GWR becomes equivalent to OLS. Conversely, as the distance-decay becomes greater, the parameter estimates will increasingly depend
on observations in close proximity to i and hence will have increased variance.
The problem is therefore how to select an appropriate decay function in GWR.
Consider the selection of /? in (9). One possibility is to choose /3 on a least
squares criteria. If the error terms in (3) are assumed to be Gaussian, then
this also fulfills a maximum likelihood criterion. Clearly, the way to proceed
would be to minimize the quantity
i=l,n

where $(/I)
is the fitted value of yi using a distance-decay of B. In order to find
the fitted value of yi it is necessary to estimate the a i k S at each of the sample
points and then combine these with the z-values at these points. However, when
minimizing the sum of squared errors suggested above, a problem is encountered.
Suppose is made very large so that the weighting of all points except for i itself
become negligible. Then the fitted values at the sampled points will tend to the
actual values, so that the value of (11) becomes zero. This suggests that under
such an optimizing criterion the value of B tends to infinity but clearly this degenerate case is not helpful. First, the parameters of such a model are not defined in
this limiting case and second, the estimates will fluctuate wildly throughout space
in order to give locally good fitted values at each i.
A solution to this problem is a cross-validation (CV) approach suggested
for local regression by Cleveland (1979) and for kernel density estimation by
Bowman (1984). Here, a score of the form

is used where y+f(B) is the fitted value of yi with the observations for point i
omitted from the calibration process. This approach has the desirable property of
countering the wrap-around effect, since when becomes very large, the model is
calibrated only on samples near to i and not at i itself.
