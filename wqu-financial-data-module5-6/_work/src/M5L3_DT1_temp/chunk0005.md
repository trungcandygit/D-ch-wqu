For “ENV_SOLAR” and text written in Spanish, Group 1 is similar
to the last case. Group 5, 12 and 15 refer to words like “solar”, “system”,
“electricity”, “law”, “change”, “tax”, and months (written in Spanish).

We can obtain historical data about electricity prices and demand
from OMIE [15]. OMIE manages the electrical market for Spain and
Portugal (MIBEL Market). We have used data from February 18th,
2015 to October 28th, 2015 (similar to GDELT data). Our aim is to
evaluate whether there is any type of correlation between prices or
demand in the MIBEL market and the mean tone of public opinion
evaluated thanks to GKG data. For prices and demand, we have taken
natural logs. Variables in Fig. 13 must be interpreted in the following
way: MeanALLSolar (ENV_SOLAR theme for Spain) does not include
references to Spanish Government, MeanGovSolar does include it.
Interpretation is similar for MeanALLFuel and MeanGovFuel (for
FUELPRICES theme in this case). LogPrices and LogDemand refer to
logarithm mean and daily values for prices and demand (respectively)
from MIBEL historical data and the same period.

Fig. 15. Using “topicmodels” R package. “ENV_SOLAR” theme, text written
in Spanish.

Fig. 13. Correlations results.

The CTM model allows to classify documents or news in media.
We also think that we will be able to use it in the future to do further
correlation analysis. Of course our final aim will be to use this
technique in future research to do causal analysis from the information
collected (the indexes built on it) and the movement of key variables
in energy markets.

There is some week evidence of correlation between LogPrices
and mean tone collected by MeanALLFuel. A test of the null that the
coefficient (-0.0708) is equal to zero gives a normal value of -1.65,
which is significantly different from zero at 9.9 percent of significance.
The negative coefficient of correlation between LogPrices and mean
tone collected by MeanGovSolar has a p-value of 0.32 for testing the
same assumption. Finally, the correlation between LogPrices and mean

D. Speedup and Efficiency analysis (getting the text)
As we have explained in the methodology section, getting the text
from URLs is a compute-intensive phase. We present two figures for
analyzing sequential and parallel execution modes. They summarize
the performance in terms of Speedup and Efficiency according to
equations (1) and (2). Fig. 16 shows that speedup improves when using

- 42 -

Special Issue on Big Data & AI
a network of workstations. Although efficiency (in terms of reducing
execution time) increases with multicore execution a network of
workstations is still preferred:

measure the potential of these variables to explain the evolution of key
energy market variables.

Acknowledgment
We acknowledge very useful comment from an editor of the journal.

References
[1]

[2]

Fig. 16. Speedup comparison.

Our code does not require the dispatch of regular data between
processes. Therefore, when we are using a network of workstations, the
communication cost is not excessive and efficiency can be maintained
at a constant level. However, in the multicore case the computer
memory has to be shared and this issue impacts in the efficiency values.

[3]
[4]
[5]

[6]
[7]
[8]
[9]
[10]
[11]
[12]

Fig. 17. Efficiency analysis

A multicore execution can be used to reduce execution time.
Nevertheless, a network of workstations is preferred.

[13]
[14]
[15]

V. Conclusions And Future Work
In this paper we have used extensive data from several sources to
analyze two issues related to energy markets. First, we analyze the
public opinion about energy policy of the Spanish government using
GDELT. Second, we conduct a correlation analysis between sentiment
variables about the public policy and real prices and demand taken
from the MIBEL energy market for the same period. Two results are
worth emphasizing. On one hand, we detect negative feelings about the
solar energy policy introduced by the Spanish government in 2015. On
the other, hand, we find weak correlation between the indexes (tone) in
mentions from GKG database and average daily log prices of energy.
We do not find any correlation to average daily energy demand.
There are many extensions using extensive databases like the one
in this paper or similar to follow different research lines in the future.
We only quote two possibilities closely related to this exercise. First,
we have only taken into account Spanish or English while alternative
languages could be important to build sentiment indexes. Second,
we have only presented correlation analysis between the indexes and
average prices and demand but some formal demand model where to
include these indexes as explanatory variables is necessary to accurately
