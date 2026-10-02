values. Other recent works in ﬁnance exist on the use of emotions extracted from
social media, ﬁnancial microblogs, and news to improve predictions of the stock
market (e.g. [1,9]). In the macroeconomics literature, [14] has looked at the informational content of the Federal Reserve statements and the guidance that these
statements provide about the future evolution of monetary policy. Other papers
([27,28] and [25] among others) have used Latent Dirichlet allocation (LDA)
to classify articles in topics and to extract a signal with predictive power for
measures of economic activity, such as GDP, unemployment and inﬂation [12].
These results, among others, have shown the high potentials of the information
extracted from news variables on monitoring and improving the forecasts of the
business cycle [9].
Machine learning approaches in the existing literature for controlling ﬁnancial
indexes measuring credit risk, liquidity risk and risk aversion include the works in
[3,5,10,11,20], among others. Several eﬀorts to make machine learning models
accepted within the economic modeling space have increased exponentially in
recent years (see e.g.. [4,6–8,16,18,29] among others).

3

GDELT Data

GDELT analyses over 88 million articles a year and more than 150,000 news
outlets. Its dimension is around 8 TB, growing 2TB each year [17]. For our
study we rely on the “Global Knowledge Graph (GKG)” repository of GDELT,
which captures people, organizations, quotes, locations, themes, and emotions
associated with events happening in print and web news across the world in more
than 65 languages and translated in English. Themes are mapped into commonly
used practitioners’ topical taxonomies, such as the “World Bank (WB) Topical
Ontology”4 . GDELT also measures thousands of emotional dimensions expressed
by means of, e.g., the “Harvard IV-4 Psychosocial Dictionary”5 , the “WordNetAﬀect dictionary”6 , and the “Loughran and McDonald Sentiment Word Lists
dictionary”7 , among others. For our application we use the GDELT GKG ﬁelds
from the World Bank Topical Ontology (i.e. WB themes), all emotional dimensions (GCAM), and the name of the journal outlets.
The huge number of unstructured documents coming from GDELT are reengineered and stored on an ad-hoc Elasticsearch infrastructure [13,24]. Elasticsearch is a popular and eﬃcient document-store built on the Apache Lucene
search library8 and providing real-time search and analytics for diﬀerent types
of complex data structures, like text, numerical data, or geospatial data, that
have been serialized as JSON documents. Elasticsearch can eﬃciently store and
4

https://vocabulary.worldbank.org/taxonomy.html.
Harvard IV-4 Psychosocial Dictionary: http://www.wjh.harvard.edu/∼inquirer/
homecat.htm.
6
WordNet-Aﬀect dictionary: http://wndomains.fbk.eu/wnaﬀect.html.
7
Loughran and McDonald Sentiment Word Lists: https://sraf.nd.edu/textualanalysis/resources/.
8
https://lucene.apache.org/.
5

58

S. Consoli et al.

index data in a way that supports fast searches, allowing data retrieval and
aggregate information functionalities via simple REST APIs to discover trends
and patterns in the stored data.

4

Feature Selection

We use the available World Bank Topical Ontology to understand the primary
focus (theme) of each article and select the relevant news whose main themes are
related to events concerning bond market investors. Hence, we select only articles
such that the topics extracted by GDELT fall into one of the following WB
themes of interest: Macroeconomic Vulnerability and Debt, and Macroeconomic
and Structural Policies. To make sure that the main focus of the article is one of
the selected WB topics, we retain only news that contain in their text at least
three keywords belonging to these themes. The aim is to select news that focus on
topics relevant to the bond market, while excluding news that only brieﬂy report
macroeconomic, debt and structural policies issues. We consider only articles
that are at least 100 words long. From the large amount of information selected,
we construct features counting the total number of words belonging to all WB
themes and GCAMs detected each day. We also create the variables “Number of
mentions“ denoting the word count of each location mentioned in the selected
news. We further ﬁlter the data by using domain knowledge to retain a subset of
GCAM dictionaries that qualitatively may have potentials to our analysis. Then
we retain only the variables having a standard deviation calculated over the full
sample greater than 5 words and allowing a 10% of missing values on the total
number of days. Finally we perform a correlation analysis across the selected
variables, normalized by number of daily articles. If the correlation between any
two features is above 80% we give preference to the variable with less missing
values, while if the number of missing values is identical and the two variables
belong to the same category (i.e. both are themes or GCAMs), we randomly
pick one of them. Finally, if the number of missing values is identical but the
two variables belong to the same category, we consider the following order of
priority: GCAM, WB themes, GDELT themes, locations.

5

Preliminary Results

Here we show some preliminary results on the application of the described
methodology for the use case of Italy. The main objective of this empirical
exercise is to assess the predictive power of GDELT selected features for the
forecasting of the Italian sovereign bond market.
We have extracted data from Bloomberg on the term-structure of government
bond yields for Italy over the period 2 March 2015 to 31 August 2019. We
have calculated the sovereign spread for Italy against Germany as the diﬀerence
between the Italian 10 year maturity bond yield minus the German counterpart.
We have also extracted the standard level, slope and curvature factors of the
term-structure using the Nelson and Siegel [23] procedure and included these

Information Extraction from the GDELT Database

59
