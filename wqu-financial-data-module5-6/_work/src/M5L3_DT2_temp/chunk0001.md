# M5L3_DT2

Information Extraction From the GDELT
Database to Analyse EU Sovereign Bond
Markets
Sergio Consoli1(B) , Luca Tiozzo Pezzoli1 , and Elisa Tosetti1,2
1

Joint Research Centre, Directorate A-Strategy, Work Programme and Resources,
Scientiﬁc Development Unit, European Commission,
Via E. Fermi 2749, 21027 Ispra, VA, Italy
{sergio.consoli,luca.tiozzo-pezzoli}@ec.europa.eu
2
Department of Management, Universitá Ca’ Foscari Venezia,
Cannaregio 873, 30121 Fondamenta San Giobbe, Venice, Italy
elisa.tosetti@unive.it

Abstract. In this contribution we provide an overview of a currently
on-going project related to the development of a methodology for building economic and ﬁnancial indicators capturing investor’s emotions and
topics popularity which are useful to analyse the sovereign bond markets
of countries in the EU.These alternative indicators are obtained from the
Global Data on Events, Location, and Tone (GDELT) database, which
is a real-time, open-source, large-scale repository of global human society for open research which monitors worlds broadcast, print, and web
news, creating a free open platform for computing on the entire world’s
media. After providing an overview of the method under development,
some preliminary ﬁndings related to the use case of Italy are also given.
The use case reveals initial good performance of our methodology for the
forecasting of the Italian sovereign bond market using the information
extracted from GDELT and a deep Long Short-Term Memory Network
opportunely trained and validated with a rolling window approach to
best accounting for non-linearities in the data.
Keywords: Big data · Government yield spread · GDELT · Machine
learning · Features engineering

1

Introduction and Preliminaries

Economic and ﬁscal policies conceived by international organizations, governments, and central banks heavily depend on economic forecasts, in particular
during times of economic turmoil like the one we have recently experienced
with the COVID-19 virus spreading world-wide [30]. The accuracy of economic
forecasting and nowcasting models is however still problematic since modern
economies are subject to numerous shocks that make the forecasting and nowcasting tasks extremely hard, both in the short and in the medium-long run.
c The Author(s) 2021

V. Bitetta et al. (Eds.): MIDAS 2020, LNAI 12591, pp. 55–67, 2021.
https://doi.org/10.1007/978-3-030-66981-2_5

56

S. Consoli et al.

In this context, the use of recent Big Data technologies for improving forecasting and nowcasting for several types of economic and ﬁnancial applications has
high potentials. In a currently on-going project we are designing a methodology to extract alternative economic and ﬁnancial indicators capturing investor’s
emotions, topics popularity, and economic and political events, from the Global
Database of Events, Language and Tone (GDELT) 1 [17], a novel big database of
news information. GDELT is a real-time, open-source, large-scale repository of
global human society for open research which monitors worlds broadcast, print,
and web news. The news-based economic and ﬁnancial indicators extracted from
GDELT can be used as alternative features to enrich forecasting and nowcasting
models for the analysis of the sovereign bond markets of countries in the EU.
The very large dimensions of GDELT make unfeasible the use of any relational database and require ad-hoc big data management solutions to perform
any kind of analysis in reasonable time. In our case, after GDELT data are
crawled from the Web by means of custom REST APIs2 , we use Elasticsearch
[13,24] to host and interact with the data. Elasticsearch is a popular and eﬃcient
NO-SQL big data management system whose search engine relies on the Lucene
library3 to eﬃciently transform, store, and query the data.
After GDELT data are stored into our Elasticsearch infrastructure, a feature
selection procedure selects the variables having higher forecasting potentials to
analyse the sovereign bond market of the EU country under study. The selected
variables capture, among others, investor’s emotions, economic and political
events, and popularity of news thematics for that country. These additional variables are included into economic forecasting and nowcasting models with the goal
of improving their performance. In current research we are experimenting diﬀerent models, ranging from traditional economic models to novel machine learning
approaches, like Gradient Boosting Machines and Recurrent Neural Networks
(RNNs), which have been shown to be successful in various forecasting problems
in Economics and Finance (see e.g. [4,6–8,16,18,29] among others).

2

Related Work

The recent surge in the government yield spreads in countries within the Euro
area has originated an intense debate about the determinants and sources of
risk of sovereign spreads. Traditionally, factors such as the creditworthiness, the
sovereign bond liquidity risk, and global risk aversion have been identiﬁed as
the main factors having an impact on government yield spreads [3,22]. However, a recent literature has pointed at the important role of ﬁnancial investor’s
sentiment in anticipating interest rates dynamics [19,26]. An early paper that
has used a sentiment variable calculated on news articles from the Wall Street
Journal is [26]. In this work it is showed that high levels of pessimism are a
relevant predictor of convergence of the stock prices towards their fundamental
1

GDELT website: https://blog.gdeltproject.org/.
See https://blog.gdeltproject.org/gdelt-2-0-our-global-world-in-realtime/.
3
https://lucene.apache.org/.
2

Information Extraction from the GDELT Database

57
