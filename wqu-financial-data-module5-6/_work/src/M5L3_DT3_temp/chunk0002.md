others) use Latent Dirichlet allocation (LDA) to classify articles in topics and
calculate simple measures of sentiment based on the topic classiﬁcation. The goal
of these papers is to extract a signal that could have some predictive content for
measures of economic activity, such as GDP, unemployment and inﬂation [11].
Their results show that economic sentiment is a useful addition to the predictors
that are commonly used to monitor and forecast the business cycle [7].
Machine learning approaches in the existing literature for controlling ﬁnancial indexes measuring credit risk, liquidity risk and risk aversion include the
works in [2,4,8,9,18], among others. Eﬀorts to make machine learning models accepted within the economic modeling space have increased exponentially
in recent years [19,24]. Among popular machine learning approaches, Gradient Boosting machines have been shown to be successful in various forecasting
problems in Economics and Finance (see e.g. [5,6,16,28] among others).

3

Data

3.1

About GDELT

GDELT is the global database of events, location and tone that is maintained by
Google [15]. It is an open Big Data platform on news collected at worldwide level,
containing structured data mined from broadcast, print and web news sources
in more than 65 languages. It connects people, organizations, quotes, locations,
themes, and emotions associated with events happening across the world. It
describes societal behavior through eye of the media, making it an ideal data
source for measuring social factors and for testing our hypotheses. In terms of
volume, GDELT analyses over 88 million articles a year and more than 150,000
news outlets. Its dimension is around 8 TB, growing 2TB each year. GDELT
consists of two main datasets, the “Global Knowledge Graph (GKG)” and the
“Events Table”. For our study we have relied on the ﬁrst dataset. GDELT’s
GKG captures what’s happening around the world, what its context is, who’s
involved, and how the world is feeling about it; every single day. It provides
English translation from the supported languages of the encoded information.
In addition, the included themes are mapped into commonly used practitioners’ topical taxonomies, such as the “World Bank (WB) Topical Ontology”3 , or
into the GDELT built-in topical taxonomy. GDELT also measures thousands of
emotional dimensions expressed by means of popular dictionaries in the literature, such as the “Harvard IV-4 Psychosocial Dictionary”4 , the “WordNet-Aﬀect
dictionary”5 , and the “Loughran and McDonald Sentiment Word Lists dictionary”6 , among others. For this application we use the GDELT GKG ﬁelds from
3

https://vocabulary.worldbank.org/taxonomy.html.
Harvard IV-4 Psychosocial Dictionary: http://www.wjh.harvard.edu/∼inquirer/
homecat.htm.
5
WordNet-Aﬀect dictionary: http://wndomains.fbk.eu/wnaﬀect.html.
6
Loughran and McDonald Sentiment Word Lists: https://sraf.nd.edu/textualanalysis/resources/.
4

Using the GDELT Dataset to Analyse the Italian Sovereign Bond Market

193

the World Bank Topical Ontology (i.e. WB themes), all emotional dimensions
(GCAM), and the name of the journal outlet.
3.2

Yield Spread

We have extracted data from Bloomberg on the term-structure of government
bond yields for Italy over the period 2 March 2015 to 31 August 2019. We calculate the sovereign spread for Italy against Germany as the diﬀerence between
the Italian 10 year maturity bond yield minus the German counterpart. We also
extract the standard level, slope and curvature factors of the term-structure
using the Nelson and Siegel [21] procedure.
We estimate a model of credit spread forecast using convetional yield curve
factors and the GDELT selected features, and compare with a classical model of
credit spread forecast using only the level, slope and curvature as regressors.

4

Methods

4.1

Big Data Management

Massive unstructured datasets like GDELT require to be stored in specialized
distributed ﬁle systems (DFS), joining together many computational nodes over
a network, that are essential for building the data pipes that slice and aggregate
this large amount of information. Among the most popular DFS platforms today,
considering the huge number of unstructered documents coming from GDELT,
we have used Elasticsearch [12,22] to store the data and interact with them.
Elasticsearch is a popular and eﬃcient eﬃcient document-store which, instead of
storing information as rows of columnar data like in classical relational databases,
stores complex data structures that have been serialized as JSON documents.
Being built on the Apache Lucene search library7 , it then provides real-time
search and analytics for diﬀerent types of structured or unstructured data.
Elasticsearch is built upon a distributed setting, allowing connecting multiple
Elasticsearch nodes in a unique cluster. At the moment a document is stored,
it is indexed and fully searchable in near real-time. An Elasticsearch index can
be thought of as an optimized collection of documents and each document is a
collection of ﬁelds, which are the key-value pairs that contain the stored data.
An index is really just a logical grouping of one or more physical shards, where
each shard is actually a self-contained index.
Elasticsearch is also schema-less, which means that documents can be indexed
without explicitly specifying how to handle each of the diﬀerent ﬁelds that might
occur in a document. Elasticsearch provides a simple REST API for managing
the created cluster and interacting with the stored documents. It is possible to
submit API requests directly from the command line or through the Developer
Console within the user web interface, referred to as Kibana 8 . The Elasticsearch
7
8

https://lucene.apache.org/.
Kibana, version 7.4: https://www.elastic.co/guide/en/kibana/7.4/.

194

S. Consoli et al.

REST APIs support structured queries, full text queries, and complex queries
that combine the two, using Elasticsearch’s JSON-style query language, referred
to as Query DSL9 .
4.2
