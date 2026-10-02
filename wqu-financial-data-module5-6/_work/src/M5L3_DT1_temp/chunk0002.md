II. The Gdelt Project
The GDELT Project, supported by Google Ideas, share real-time
information and metadata with the world. This codified metadata (but
not the text of the articles) is then released as an open data stream,
updated every 15 minutes, providing a multilingual annotated index of
the information. It includes broadcast, print, and online news sources.
The project shares a database with trillions data points. Although, data
is available as downloadable CSV files, few users have the storing
capacity and processing power to download terabytes of data, and
effectively query and analyze it. Google’s BigQuery platform provides
a way to interact with this huge information source. GDELT is a clear
example of Big Data, while Google’s BigQuery is an example of
Infrastructure As a Service (IaaS) technology.
According to [4], Big Data is data that exceeds the processing
capacity of conventional database systems. The data is too big, moves

- 38 -

DOI: 10.9781/ijimai.2016.366

Special Issue on Big Data & AI
too fast, or doesn’t fit the structures of our database architectures.
To gain value from this data, one must choose an alternative way
to process it. Big Data technologies have huge variety of sources,
huge volume of information – so much less time is needed to
process information thanks to parallel processing and clustering
infrastructure.
GDELT maintains the GDELT Event Database, and the GDELT
Global Knowledge Graph (GKG). The GKG begins April 1, 2013 and
“… attempts to connect every person, organization, location, count,
theme, news source, and event across the planet into a single massive
network that captures what’s happening around the world, what its
context is and who’s involved, and how the world is feeling about
it, every single day” [3]. The data files use Conflict and Mediation
Event Observations (CAMEO) [5] coding for recording events.
GKG also provides event identification (EventIDs) of each event
found in the same article as the extracted information, allowing rich
contextualization of events.

III. Methodology
In this work, we have used GKG table on Google’s BigQuery
platform. GKG table provides the “Themes” attribute, the list of all
themes found in the document. We want to filter documents related
to, at least, one of these two themes: “ENV_SOLAR” (which refers to
solar power in general), and “FUELPRICES” (which refers to cost of
fuel, energy and heating). The theme attribute is not available for the
Event table. At the same time, we have looked for events that refer to
Spain at some point using the “Locations” attribute (which contains a
list of all locations found in the text). In summary, we are using GKG
table to filter information about solar power or cost of fuel, energy
and heating and related (in some way) with Spain. Attribute “V2Tone”
allows us to analyze the average “tone” of the document as a whole.
The score ranges from -100 (extremely negative) to +100 (extremely
positive). Common values range between -10 and +10, with 0
indicating neutral. This is calculated as Positive Score minus Negative
Score. Positive Score is the percentage of all words in the article that
were found to have a positive emotional connotation. Negative Score
is the percentage of all words in the article that were found to have
a negative emotional connotation. Big Query allows interaction with
the whole GDELT dataset using Structure Query Language (SQL). An
account in Google Cloud Services and activate Google’s Cloud Storage
to export and download data is required.
R [6] has been used to analyze and process data. Downloaded data
from Google’s Cloud Storage have been imported into R. After that,
we have done a basic and exploratory analysis of the downloaded
data. The analysis shows that there are some references, documents
or URL’s that are not related to energy policy. For example, some
entries refer to scientific news from Canary Institute of Astrophysics
(“ENV_SOLAR” theme). For this reason and for a more efficient
measurement, we feel that it is necessary to analyze the text of the
news and look for references to Spanish Government, council, ministry
or ministers. This is a computation intensive task because it requires
to deal with HTML tags and extract the text of the document. In the
next section, we detail this process and explain different alternatives to
improve execution time.
Next and for each theme, we have grouped by day all mentions
and calculated the mean tone and typical deviation in tone per day.
At this stage, we only have evaluated documents written in Spanish
or English because we need to find mentions to Spanish Government
(Spanish and English have been the chosen languages to process, other
languages will be included in future versions). The results have been
placed into context with the policies that the government of Spain has
implemented.
