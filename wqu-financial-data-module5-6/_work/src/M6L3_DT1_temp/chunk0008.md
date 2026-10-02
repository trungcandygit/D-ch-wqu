5.1 Variability of Coefficient Estimates
All types of spatial analysis which produce localized and mappable outputs
are subject to edge effects and GWR is no exception. For instance, consider
the use of the “sudden cut off” kernel such as (8). For points close to the
edge of the study area, the number of sample points in a radius of d around i
will often be relatively small, since part of the sampling circle will lie outside of
the study area. As a result, calibration of the regression model for such points
will be subject to greater sampling error. Although the effect is more subtle,
similar phenomena will occur with other kernels. In these cases, the sum of
the weights will act analogously to n and this sum will vary according to the
location of each point, so that for regions close to only a few sampling points,
greater sampling error will occur. It is possible to compute the standard errors
of the coefficient estimates for the GWR model and by mapping these, some
indication of the reliability of each of the estimates may be obtained. In Figure
10, for example, the standard error is mapped for the Social Class I coefficient
for the example given above. It is interesting to note that this map shows
clearly that the standard errors are not uniform and are larger for wards in the
southern part of the study area.
The challenge for future research is in finding ways of simultaneously visualizing the coefficient estimates and their reliability measured by this standard
error.

15384632, 1996, 4, Downloaded from https://onlinelibrary.wiley.com/doi/10.1111/j.1538-4632.1996.tb00936.x by candy Trung - Readcube (Labtiva Inc.) , Wiley Online Library on [01/10/2026]. See the Terms and Conditions (https://onlinelibrary.wiley.com/terms-and-conditions) on Wiley Online Library for rules of use; OA articles are governed by the applicable Creative Commons License

295

Chris Brunsdon, A. Stewart Fotheringham, and Martin E . Charlton

Geographical Analysis

5.2 Roving Hypothesis Tests
It is clear from the discussion in the previous subsection that, for each point,
a coefficient estimate and a standard error may be computed. Dividing the
former by the latter, a pseudo t statistic may be calculated. In ordinary least
squares regression, this may be used as the basis for a test as to whether the
coefficient differs significantly from zero. This is essentially a test for dependency between one of the independent variables and the dependent variable. In
the case of GWR there would be such a statistic for every point in the study
area. It is appealing to think that the test for dependency could be generalized. This would provide a method of determining in which areas one variable
influenced another-and in which areas it did not.
Clearly, careful thought has to be iven to this problem, particularly the pitfalls of multiple significance testing, ut it would be helpful if some means of
investigating the spatial nature of dependencies could be developed of either a
formal or informal nature.

\

5.3 Spatial Variations in Weighting Functions

In the GWR methods suggested so far, the weighting function, once calibrated, is assumed to be constant throughout the study area. However, there
may be circumstances when this is not a reasonable assumption. For example,
in economic applications, pricing structures may be dependent on local markets,
but the extent of the notion of locality may vary regionally-the geographical
extent of a London market may be spatially broader than that for Newcastle.
In such cases, a more reasonable approach to GWR might be to have a spatially
variable weighting function so that pi is estimated rather than /3. Although this
will be computationally complex, the results should be informative, not only of
the nature of relationships between attributes but also of the nature of how
locations interact with each other.
5.4 Extensions of GWR

The idea of using geographically weighted data to produce localized statistics
need not only apply to regression techniques. There are several other statistical
techniques that allow weights to be attached to each variable, and any one of
these could be modified to become geographically adaptive in the way that
regression has been with GWR. As a simple example, it is possible to calculate
the standard deviation of a set of observations with a weight attached to each
observation. A GWSD (geographically weighted standard deviation) could be
defined for a point i by applying a kernel weighting scheme around i to the
computation of the sample SD. This would give a surface spanning the study
region indicating the local variability of the variable being mapped. It would
also be feasible to produce localized spatial autocorrelation statistics in this
manner from a GWR version of Ord’s model (Ord 1975). Essentially, any
model which can be weighted, can be geographically weighted.
6. CONCLUSIONS

One possible interpretation of GWR is that it is a discrete transform-such as
a Fourier transform. A Fourier transform is often used with time series data to
obtain a view of its frequency content. However, the longer the period over
which the time series is observed, the more lower frequency components of
the time series can be observed. As a result, the number of data items in the
Fourier series grows with the size of the time series. Thus, rather than using

15384632, 1996, 4, Downloaded from https://onlinelibrary.wiley.com/doi/10.1111/j.1538-4632.1996.tb00936.x by candy Trung - Readcube (Labtiva Inc.) , Wiley Online Library on [01/10/2026]. See the Terms and Conditions (https://onlinelibrary.wiley.com/terms-and-conditions) on Wiley Online Library for rules of use; OA articles are governed by the applicable Creative Commons License

296
