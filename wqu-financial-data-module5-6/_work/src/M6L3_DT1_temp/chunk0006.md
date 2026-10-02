In this section, the GWR technique will be applied to ward-level 1991 Census
data for the county of Tyne and Wear in the United Kingdom. The county is centered on the city of Newcastle and the River Tyne in northeast England. The relationships to be investigated are those between the rate of car ownership (as the
dependent variable) and two socioeconomic independent variables, the proportion of male unemployment and the proportion of households in social class I (a
U.K. census variable measuring the proportion of households headed by someone
in professional or managerial occupation and often used as a surrogate for highincome households). More detail on these variables is given in Table 1 and their
spatial distributions are mapped in Figures 2-4. The spatial distribution of the
cars per houszhold data indicate that the wards along the river Tyne, toward the
center of the region, generally have lower numbers of car per household than do
the suburban areas towards the periphery. High levels of male unemployment are
found in the central wards of Newcastle (located towards the centre of the region)
and Sunderland (located in the southeast). The distribution of the social class variable exhibits a less obvious pattern but reflects the wealthier areas to the north of
Newcastle and some of the coastal areas in the east of the region.
It is hypothesized that as the pro ortion of male unemployment in a ward
increases, car ownership rates will ecrease, ceteris paribus, and that as the
proportion of households in social class I increases, car ownership rates will
increase, ceteris paribus. These hypotheses are strongly supported by the
global OLS regression results given in Table 2 where both parameter estimates
are significantly different from zero at the 99 percent level and both have the
expected signs. The r-squared value for the model is 0.83 indicating a high
degree of fit to the data. However, what the results do not indicate is the stabil-

1

15384632, 1996, 4, Downloaded from https://onlinelibrary.wiley.com/doi/10.1111/j.1538-4632.1996.tb00936.x by candy Trung - Readcube (Labtiva Inc.) , Wiley Online Library on [01/10/2026]. See the Terms and Conditions (https://onlinelibrary.wiley.com/terms-and-conditions) on Wiley Online Library for rules of use; OA articles are governed by the applicable Creative Commons License

Chris Brunsdon, A. Stewart Fotheringham, and Martin E . Charlton

/

Geographical Analysis

-

Cars per 100 Households
0Under 40
40 - 55

55 - 65
65 75
Over 75

-

N

FIG.2. Ward-based Map of Cars per Hundred Households

Male Unemployment
0Under 10%
10% 15%

-

15% - 20%
20%
25%
Over 25%

-

N

7.5

0

7.5

15 Miles

S

FIG.3. Ward-based Map of Male Unemployment

ity of the relationships across the study region and for this we need to apply
GWR.
4.1 Application of GWR
As GWR is a sample-point-based technique, the variables associated with
each ward are assumed to be samples taken at the centroid of that ward so
that the point i is defined as the centroid of ward i. In this way, distance decay

15384632, 1996, 4, Downloaded from https://onlinelibrary.wiley.com/doi/10.1111/j.1538-4632.1996.tb00936.x by candy Trung - Readcube (Labtiva Inc.) , Wiley Online Library on [01/10/2026]. See the Terms and Conditions (https://onlinelibrary.wiley.com/terms-and-conditions) on Wiley Online Library for rules of use; OA articles are governed by the applicable Creative Commons License

290

Head 01 Household in Social Class I
Under 1%

2% - 3%
3% - 4%

Over 4%

N

7.5

0

7.5

lilc

E
*
w

s

FIG.4. Ward-based Map of Heads of Households in Social Class I

TABLE 2
Global OLS Regression Results
Parameter

Estimated Value

Standard Error

t value

Intercept
Social Class
Unemployment
R2= .83

88.5
1.88
-1.83

2.89
0.33
0.11

30.6

5.7
16.6

effects will still apply, with the influence of each ward on the estimate of aik
being reduced as the distance of the ward centroid from i increases. This also
provides a useful means of mapping the results of the analysis: if aik is estimated for each ward centroid, and that value is assigned to the relevant ward,
then a choropleth map of the variation in the coefficients may be drawn. These
coefficient values may then also be used as a basis for the significance tests
described above.
GWR models with the spatial weighting function described in (9) with various
values of B were .applied to the data described in Table 1 and in Figures 2-4.
The value of the cross-validation sum of squared errors CVSS is graphed as
a function of B in Figure 5. From this it may be seen that there is a globally
optimal value of /3 at around 0.303 which was confirmed by a Golden Section
optimization routine. At this value the CV score is roughly half that for the
global regression case of /? = 0. The weighting scheme around one of the city
center wards for the optimal /3 is illustrated in Figure 6. This pattern shows
how the data are weighted spatially for the estimation of the parameters for
that one ward. The weighting scheme is centered on each ward to estimate the
spatially varying parameter estimates.
The main output from GWR, that of the spatial variation in parameter estimates, is shown in Figures 7-9 for the intercept, social class, and unemployment parameters, respectively. The spatial variations in relationships revealed

15384632, 1996, 4, Downloaded from https://onlinelibrary.wiley.com/doi/10.1111/j.1538-4632.1996.tb00936.x by candy Trung - Readcube (Labtiva Inc.) , Wiley Online Library on [01/10/2026]. See the Terms and Conditions (https://onlinelibrary.wiley.com/terms-and-conditions) on Wiley Online Library for rules of use; OA articles are governed by the applicable Creative Commons License

291

Chris Brunsdon, A. Stewart Fotheringharn, and Martin E . Charlton

/ Geographical Analysis

T

0.28

0.20

0.30

0.31

0.32

0.33

0.34

BUa

FIG.5. Calibrating the Spatial Weighting Function

m

Weighting Value
nUnder 0.01

0.01-0.03
0.03-0.06
0.06-0.30
m 0.30-1.00

7.5

0

7.5

15 Miles

S

FIG.6. Ward-based Map of the Weighting Function
