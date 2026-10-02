15384632, 1996, 4, Downloaded from https://onlinelibrary.wiley.com/doi/10.1111/j.1538-4632.1996.tb00936.x by candy Trung - Readcube (Labtiva Inc.) , Wiley Online Library on [01/10/2026]. See the Terms and Conditions (https://onlinelibrary.wiley.com/terms-and-conditions) on Wiley Online Library for rules of use; OA articles are governed by the applicable Creative Commons License

282 / Geographical Analysis

/ 283

where the independent observations are the columns of x and the dependent
observations are the single column vector y.* The column vector ii contains the
coefficient estimates. Each of these estimates can be thought of as a “rate of
change” between one of the independent variables and the dependent variable.
For example, if y were agreed house prices, and x contained several variables
relating to attributes of the house and its surrounding environment, coefficients
could be used to estimate the change in house price for an extra square meter of
garden, an extra bedroom, or the house being located one kilometer closer to the
nearest school.
It is important to note that these rates of change are assumed to be universal. Wherever a house is located, for example, the mar inal price increase associated with an additional bedroom is fixed. However, t is may not be the case.
It might be more reasonable to assume that rates of change are determined by
local culture or local knowledge, rather than a global utility assumed for each
commodity. Returning to the example, the value added for an additional bedroom might be greater in a neighborhood populated by families with children
where extra space is likely to be viewed as highly beneficial than in a neighborhood populated by singles or elderly couples, for whom extra space might be
viewed as a negative feature.
Variations in relationships over space, such as those described above, are referred to as spatial nonstationarity. In a recent paper, Fotheringham, Charlton,
and Brunsdon (1996) provide a demonstration of the extent to which regression
parameter estimates can vary over space. In their example, a 7 x 7 window is
placed over every cell in a 50 x 38 matrix which allows placement of the window in such a way that it is completely within the region. At each placement,
the data within the window are used to calibrate a regression model so that
each cell has a set of parameter estimates associated with it. The parameter
estimates can then be mapped to show the extent of spatial variations in estimated relationships. The results show that (a) relationships can vary significantly over space and that a “global” estimate of the relationships may obscure
interesting geographical relationships and (b) that the variation over space can
be sufficiently complex that it invalidates simple trend-fitting exercises. An example of the type of parameter surface described by Fotheringham, Charlton,
and Brunsdon (1996) is shown in Figure 1 for the relationship between population density and elevation in part of northeast Scotland. The surface shows
localized parameter estimates obtained from the window regression technique
described above in which a multiple linear regression model is calibrated
using, in this case, a 7 x 7 window. The surface shows a complex surface of
parameter values ranging from -1.26 to 0.75. In some parts of the study area,
the relationship between population and density and elevation is significantly
negative and in other parts it is significantly positive. Although there are interesting “valleys” and “hills” in this parameter surface, it is clearly too complex to
be represented by a simple linear or quadratic trend. It does, however, provide
interesting insights into how this particular relationship varies over space which
can be used to explore aspects of the relationship between the two variables
that might not otherwise be investigated.
Although the methodology of Fotheringham, Charlton, and Brunsdon (1996)
which is used to generate Figure 1 serves a useful exploratory purpose, it is ad
hoc. Hence, it is the purpose of this paper to describe a formal statistical technique, which we term geographically weighted regression (GWR), that allows

a

For the

term a column of 1s must be included in x.

15384632, 1996, 4, Downloaded from https://onlinelibrary.wiley.com/doi/10.1111/j.1538-4632.1996.tb00936.x by candy Trung - Readcube (Labtiva Inc.) , Wiley Online Library on [01/10/2026]. See the Terms and Conditions (https://onlinelibrary.wiley.com/terms-and-conditions) on Wiley Online Library for rules of use; OA articles are governed by the applicable Creative Commons License

Chris Brunsdon, A. Stewart Fotheringham, and Martin E . Charlton

Geographical Analysis
Parameter Value

I

0

0 8

t o

0

0

4 1

t o

0 . 7 5

- 1 . 2 6

t o

. 0 . 9 2

t o

- 0 . 5 9

. 0 . 5 9

t o

- 0 . 2 5

- 0 . 2 5 t o

- 0 . 9 2

0 . 0 8

4 1

FIG.1. Elevation Parameter Surface

complex spatial variations in parameter estimates to be identified, mapped and
modeled.
3. GEOGRAPHICALLY WEIGHTED REGRESSION

GWR is a relatively simple technique that extends the traditional regression
framework of equation (1) by allowing local variations in rates of change so
that the coefficients in the model rather than being global estimates are specific to a location i. The regression equation is then
k=l,m
