# M5L3_DT3

Using the GDELT Dataset to Analyse
the Italian Sovereign Bond Market
Sergio Consoli(B) , Luca Tiozzo Pezzoli, and Elisa Tosetti
European Commission, Joint Research Centre, Directorate A-Strategy, Work
Programme and Resources, Scientiﬁc Development Unit, Via E. Fermi 2749,
21027 Ispra, VA, Italy
sergio.consoli@ec.europa.eu

Abstract. The Global Data on Events, Location, and Tone (GDELT) is
a real time large scale database of global human society for open research
which monitors worlds broadcast, print, and web news, creating a free
open platform for computing on the entire world’s media. In this work,
we ﬁrst describe a data crawler, which collects metadata of the GDELT
database in real-time and stores them in a big data management system based on Elasticsearch, a popular and eﬃcient search engine relying
on the Lucene library. Then, by exploiting and engineering the detailed
information of each news encoded in GDELT, we build indicators capturing investor’s emotions which are useful to analyse the sovereign bond
market in Italy. By using regression analysis and by exploiting the power
of Gradient Boosting models from machine learning, we ﬁnd that the features extracted from GDELT improve the forecast of country government
yield spread, relative that of a baseline regression where only conventional regressors are included. The improvement in the ﬁtting is particularly relevant during the period government crisis in May-December
2018.
Keywords: Government yield spread · Machine learning · Big data
management · Quantile regression · Feature Engineering · GDELT

1

Introduction

The explosion in computation and information technology experienced in the
past decade has made available vast amounts of data in various domains, that
has been referred to as Big Data. In Economics and Finance in particular, tapping into these data brings research and business closer together, as data generated in ordinary economic activity can be used towards rapid-learning economic
systems, continuously improving and personalizing models. In this context, the
recent use of Data Science technologies for Economics and Finance is providing
mutual beneﬁts to both scientists and professionals, improving forecasting and
nowcasting for several types of applications.
c The Author(s) 2020

G. Nicosia et al. (Eds.): LOD 2020, LNCS 12565, pp. 190–202, 2020.
https://doi.org/10.1007/978-3-030-64583-0_18

Using the GDELT Dataset to Analyse the Italian Sovereign Bond Market

191

In particular, the recent surge in the government yield spreads in countries
within the Euro area has originated an intense debate about the determinants
and sources of risk of sovereign spreads. Traditionally, factors such as the creditworthiness, the sovereign bond liquidity risk, and global risk aversion have been
identiﬁed as the main factors having an impact on government yield spreads
[2,20]. However, a recent literature has pointed at the important role of ﬁnancial
investor’s sentiment in anticipating interest rates dynamics [17,25].
This paper exploits a novel, open source, news database known as Global
Database of Events, Language and Tone (GDELT) 1 [15] to construct news-based
ﬁnancial indicators related to economic and political events for a set of Euro area
countries. As described in Sect. 3.1, since the dimensions of the GDELT dataset
make unfeasible the use of any relational database to perform an analysis in
reasonable time, in Sect. 4.1 it is discussed the big data management infrastracture that we have used to host and interact with the data. Once GDELT
data are crawled from the Web by the means of custom REST APIs2 , we eﬃciently transform and store them on our big data management system based on
Elasticsearch, a popular and eﬃcient NO-SQL search engine (Sect. 4.1).
Afterwards a feature engineering process is applied on the detailed information encoded in GDELT (Sect. 4.2) to select the most proﬁtable variables which
capture, among others, investor’s emotions and popularity of news thematics,
and that are useful to analyse the Italian sovereign bond market. In Sect. 4.3
we describe the Gradient Boosting machine we have used to analyse the Italian
sovereign bond market. Our experimental analysis reported in Sect. 4.4 shows
that the implemented machine learning model using the constructed GDELT
indicators is useful to predict country government yield spread and ﬁnancial
instability, well aligned with previous studies in the literature.

2

Related Work

News articles represent a recent addition to the standard information used to
model economic and ﬁnancial variables. An early paper is [25] that uses sentiment from a column in the Wall Street Journal to show that high levels of
pessimism are a relevant predictor of convergence of the stock prices towards
their fundamental values. Following this early work, several other papers have
tried to understand the role that news play in predicting, for instance, company
news announcements, stock returns and volatility. For example recent works
in ﬁnance exist on the application of semantic sentiment analysis from social
media, ﬁnancial microblogs, and news to improve predictions of the stock market (e.g. [1,7]). However these approaches generally suﬀer from a limited scope
of the historical ﬁnancial sources available. Recently, news have been also used in
macroeconomics. For example, [13] looks at the informational content of the Federal Reserve statements and the guidance that these statements provide about
the future evolution of monetary policy. Other papers ([26,27] and [23] among
1
2

GDELT website: https://blog.gdeltproject.org/.
See https://blog.gdeltproject.org/gdelt-2-0-our-global-world-in-realtime/.

192

S. Consoli et al.
