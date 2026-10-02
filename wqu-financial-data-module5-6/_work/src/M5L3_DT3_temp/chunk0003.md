Feature Engineering

As GDELT adds news articles every ﬁfteen minutes, each article is concisely
represented as a row of a GDELT table in .csv format. The GKG table contains
around 10 TB of data that need to be integrated and ingested as serialized
JSON documents into our Elasticsearch framework. This involves applying the
three usual steps of Extract, Transform and Load (ETL), that have to identify
and overcome structural, syntactic, and semantic heterogeneity across the data.
For this reason we have used the available World Bank Topical Ontology to
understand the primary focus (theme) of each article and select the relevant
news whose main themes are related to events concerning bond market investors.
Such taxonomy is a classiﬁcation schema for describing the World Bank’s areas
of expertise and knowledge domains representing the language used by domain
experts. GDELT contains all themes discussed in an article as an entry in a
single row. We separate these themes into separate entries.
We have extracted news information from GKG from a set of around 20 newspapers for Italy, published over the period March 2015 until end of August 2019.
We rely on the Geographic Source Lookup ﬁle available on GDELT blog10 in
order to chose both generalist national newspapers with the widest circulation in
that country, as well as specialized ﬁnancial and economic outlets. Once collected
the news data, we have mapped these to the relevant trading day. Speciﬁcally, we
assign to a given trading day all the articles published during the opening hours
of the bond market, namely between 9.00 am and 5.30 pm. Articles that have
been published after the closure of the bond market or overnight are assigned to
the following trading day.11 Following [10], we assign the news published during
weekends to Monday trading days, and omit articles published during holidays
or in weekends preceding holidays.
Hence, we selected only articles such that the topics extracted by GDELT fall
into one of the following WB themes of interest: Macroeconomic Vulnerability
and Debt, and Macroeconomic and Structural Policies. We observe that articles
can mention only brieﬂy one of the selected topics and then focus on a totally
diﬀerent theme. To make sure that the main focus of the article is one of the
selected WB topics, we have retained only news that contain in their text at least
three keywords belonging to these themes. The aim is to select news that focus
on topics relevant to the bond market, while excluding news that only brieﬂy
9

https://www.elastic.co/guide/en/elasticsearch/reference/current/query-dsl.html.
See https://blog.gdeltproject.org/mapping-the-media-a-geographic-lookup-pf-gdel
ts-sources/.
11
Since the GKG operates on the UTC time, https://blog.gdeltproject.org/new-gkg-20-article-metadata-ﬁelds/, we made a one-hour lag adjustment according to Italian
time zone.
10

Using the GDELT Dataset to Analyse the Italian Sovereign Bond Market

195

report macroeconomic, debt and structural policies issues. Finally, to obtain a
pool of news that are not too heterogeneous in length, we have retained only
articles that are at least 100 words long. After this selection procedure we obtain
a total of 18,986 articles. From this large amount of information, we construct
features counting the total number of words belonging to all WB themes and
GCAMs detected each day. We also created the variables “Number of mentions”
denoting the word count of each location mentioned in the selected news. By
doing this we obtain a total of 2,978 GCAM, 1,996 Themes and 155 locations.
Notice that, all of our features are expressed in terms of daily word count with
the exception of the ANEW dictionary (v19) and the Hedenometer measure of
happiness (v21) which are already provided as score values.
Once extracted the data from GKG, we have adopted a ﬁve step procedure to
ﬁlter out features from news stories. In the ﬁrst step we have applied a domain
knowledge criteria and have retained a subset of 413 GCAM dictionaries that are
potentially relevant for our analysis. Speciﬁcally we have extracted 31 dimensions
of the General Inquirer Harvard IV psychosocial Dictionary, 61 dimensions of
Roget’s Thesaurus, 7 dimensions of the Martindale Regressive Imagery and 3
dimensions of the Aﬀective Norms for English Words (ANEW) dictionary. The
second step concerns the variability of the extracted features. In particular, we
have retained variables with a standard deviation calculated over the full sample
that is greater than 5 words and allowed a 10% of missing values on the total
number of days. In addition, features that are missing at the beginning of the
sample (more than 33% of the sample) have been excluded. In the ﬁnal step
we have performed a correlation analysis across the selected variables. We have
normalized at ﬁrst all features by number of daily articles. If the correlation
between any two features is above 80% we give preference to the variable with
less missing values, while if the number of missing values is identical and the
two variables belong to the same category (i.e. both are themes or GCAMs), we
randomly pick one of them. Finally, if the number of missing values is identical
but the two variables belong to the same category, we consider the following order
of priority: GCAM, WB themes, GDELT themes, locations. After this Feature
Engineering procedure, we are left with a total of 45 variables, of which 9 are
themes, 34 are GCAM, 2 are locations. A careful inspection among the selected
topics reveals that WB themes such as Inﬂation, Government, Central Banks,
Taxation and Policy have been selected by our procedure. These are important
topics discussed in the news when considering interest rates issues. Moreover,
features constructed and selected from GCAM dimensions such as optimism,
pessimism or arousal are also inculed and allow us to explore the emotional
state of the market.
4.3

Big Data Analytics
