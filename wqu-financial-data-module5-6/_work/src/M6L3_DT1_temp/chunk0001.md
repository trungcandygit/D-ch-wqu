# M6L3_DT1

-~

____

Chris Brunsdon, A. Stewart Fotheringham
and Martin E . Charlton

Geographically Weighted Regression: A Method
for Exploring Spatial Nonstationarity

Spatial nonstationarity is a condition in which a simple ‘global” model cannot
explain the relationships between some sets of variables. The nature of the
model must alter over space to reflect the structure within the data. In this
paper, a technique is developed, termed geogra hically weighted regression,
which attempts t o capture this variation b y Cali rating a multiple regression
model which allows diferent relationships to exist at diferent points in space.
This technique is loosely based on kernel regression. The method itself is introduced and related issues such as the choice of a spatial weighting function are
discussed. Following this, a series of related statistical tests are considered
which can be described generally as tests f o r spatial nonstationarity. Using
Monte Carlo methods, techniques are proposed f o r investigatin the null
hypothesis that the data m y be described by a global model rat er than a
non-stationa y one and also f o r testing whether individual regression coeficients are stable over geographic space. These techniques are demonstrated on a
data set f r o m the 1991 U.K. census relating car ownership rates to social class
and mule unemployment. The paper concludes b y discussing ways in which the
technique can be extended.

E

a

1. INTRODUCTION

One of the main objectives in spatial analysis is to identify the nature of relationships that exist between variables. Typically this is undertaken by calculating
statistics or estimating parameters with observations taken from different spatial
units across a study area. The resulting statistics or parameter estimates are
assumed to be constant across space although this might be a very questionable
assumption to make in many circumstances. It seems reasonable to assume that
there might be intrinsic differences in relationships over space or that there
might be some problem with the specification of the model from which the relationships are being measured and which manifests itself in terms of spatially
Dr. Chris Brunsdon is lecturer in computer-based methods in the Department of Town
and County Planning, A. Stewart Fotheringham is Professor of Quantitative Geography,
and Martin Charlton i s lecturer in GIS in the Department of Geography, all at Newcastle
University.

GeographicalAnalysis, Vol. 28, No. 4 (October 1996) 01996 Ohio State University Press
Submitted 6/7/95. Revised version accepted 2/16/96.

varying parameter estimates. In either case it would be useful to have a means
of describing and map ing such spatial variations as an exploratory tool for
developing a better un C erstanding
f
of the relationships being studied.
Several techniques already exist for this purpose although we argue that the
method we develop in this paper has several important advantages. Perhaps the
most well-known framework in which parameter “drift” has been measured is
that of Casetti’s expansion method (Casetti 1972; Casetti and Jones 1992). In
this framework, parameters in a global model can be made functions of geographic space so that trends in parameter variation over space can be measured
(inter alia, Fotheringham and Pitts 1995; Eldridge and Jones 1991). While this
is an important framework in which improved models can be developed, it is a
trend-fitting exercise which is of limited use in situations where parameters
exhibit complex variation over the space being studied. The method proposed here, that of geographically weighted regression (GWR), allows the
actual parameters for each location in space to be estimated and mapped as
opposed to having a trend surface fitted to them.
The method of spatial adaptive filtering (SAF) has also been proposed to
handle spatially varying relationships (Foster and Gorr 1986; Gorr and Olligschlaeger 1994). However, this approach incorporates spatial relationships in a
rather ad hoc manner and produces parameter estimates that cannot be tested
statistically so that it is of limited applicability.
Two other methods that model spatial variations in parameter estimates are
the random coefficients model (Aitken 1996) and multilevel modeling (Goldstein 1987). In both these ap roaches the parameter estimates in regression
models are assumed to be ran om variables. In multilevel modeling, the distribution of the parameter estimates is assumed to be Gaussian, while in the random coefficients model, the parameters are modeled as finite mixture distributions. In either case, by using Bayes’ theorem it is possible to obtain an estimate
of each parameter although in neither case is any spatial dependency assumed
in the parameter estimates which seems unrealistic in models of spatial phenomena. Although geographical variations of multilevel models have been applied
(Jones 1991), these rely heavily on an assumed hierarchy of spatial units. While
this may be reasonable if the hierarchical nature of the model is reflected well
in the process being modeled, in other circumstances a “distance-decay” model
of spatial association, such as GWR, may be more appropriate.

dp

2. SPATIAL NONSTATIONARI’N IN A REGRESSION CONTEXT

A frequently used model in geographical analysis is that of simple linear
regression (inter aha, Dobson 1990, pp. 68-78). In this technique, a particular variable, the dependent variable, is modeled as a linear function of a set of
independent or predictor Variables;

where y i is the ith observation of the dependent variable, X i k is the ith observation of the lcth independent variable, the ~s are independent normally distributed
error terms with zero means, and each a k must be determined from a sample of n
observations. Usually the least squares method is used to estimate the a k s . Using
matrix notation this may be expressed as
8 = (xtx)-lxty

(2)
