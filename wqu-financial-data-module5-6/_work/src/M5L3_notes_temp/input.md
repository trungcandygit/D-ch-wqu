

MODULE 5 \| LESSON 3

------------------------------------------------------------------------

# **Large-Scale News Data Collections**[¶]{.anchor-link}

  ----------------------------------- -------------------------------------------------------------------------------------------------------------------------------------------
  **Reading Time**                    60 minutes

  **Prior Knowledge**                 Fundamental Python Programming: Data Structures, Control Flow, Functions, File Handling, Regular Expressions, HTML Basics;\
                                      Financial Engineering: A basic understanding of financial engineering concepts and applications for contextualizing the use of news data.

  **Keywords**                        WARC (Web ARChive), GDELT (Global Database of Events, Language, and Tone), GKG (Global Knowledge Graph), CSV, Warcio,\
                                      Newspaper3k, Tqdm, Regular Expressions (Regex), Natural Language Processing (NLP), Large-Scale Data, Big Data
  ----------------------------------- -------------------------------------------------------------------------------------------------------------------------------------------

------------------------------------------------------------------------

*In this lesson, we learn how to leverage two large-scale news datasets, Common Crawl News Crawl and GDELT, for financial engineering applications. We learn how to access and process raw news articles from Common Crawl\'s WARC files, extracting key information like titles and content, and filtering by language and keywords. Additionally, we learn how to work with GDELT\'s GKG data to analyze news events, entities, and sentiment, including downloading, filtering, and analyzing GDELT\'s Tone scores for nuanced sentiment insights. We explore the code and techniques necessary to harness the power of these datasets for financial research and analysis.*

In \[14\]:

``` calibre12
# Loading libraries
import gc
import gzip
import io
import nltk
import pandas as pd
import plotly.graph_objects as go
import re
import requests
import time
import tqdm
import warcio
import yfinance as yf
import zipfile

from datetime import datetime, timedelta
from newspaper import Article
from nltk.corpus import stopwords
from sklearn.decomposition import NMF
from sklearn.feature_extraction.text import TfidfVectorizer
```

Large-scale data collection refers to the process of gathering and storing massive amounts of data from various sources. In this lesson, we consider two: Common Crawl and GDELT. Both initiatives involve large-scale data collection from a vast number of online news sources. They utilize web crawling techniques and other methods to gather news articles from diverse websites and publications worldwide. This extensive data collection allows for comprehensive analysis and insights into global news coverage. While there are challenges associated with large-scale data collection, the benefits in terms of comprehensive analysis, improved accuracy, and the discovery of new knowledge make it a valuable approach for news analysis and research, including applications in financial engineering.

# **1. Common Crawl**[¶]{.anchor-link}

Common Crawl is a non-profit organization that crawls the web and provides an open-source dataset of web pages. Common Crawl uses web crawlers to collect web pages and store them in a publicly accessible repository called the Common Crawl corpus.

They also have a separate dataset called News Crawl, which uses RSS feeds and sitemaps to collect news articles specifically. This dataset has around 600,000 news articles a day in multiple languages, going back a few years, and includes the full HTML of the pages.

Common Crawl use different techniques like following links, using sitemaps, and respecting robots.txt rules to find new pages and update existing ones. The data is stored in a format called WARC (Web ARChive) files. These files contain not only the HTML content of web pages but also metadata like timestamps, URLs, and content type. This data can be accessed and analyzed by anyone using various tools and techniques.

The Common Crawl corpus is estimated to be over 250 TiB of raw data, compressed. This data includes petabytes of text data, images, and metadata. Based on its massive volume, high velocity, variety of formats, and potential value, the Common Crawl data is unequivocally considered big data. It requires specialized tools and infrastructure, such as distributed computing frameworks and cloud-based storage, to handle the data effectively and extract meaningful insights. While challenges related to veracity and data quality need to be addressed, the scale and scope of the Common Crawl dataset firmly place it within the realm of big data for news and information analysis.

Interestingly, Common Crawl is a crucial resource for building large language models. This allows the models to benefit from the vast and diverse information available on the web, improving their ability to generate human-like text and understand a wide range of topics. The Common Crawl corpus, or a filtered version of it, played a role in training GPT models. The GPT-3, or third-generation Generative Pre-trained Transformer, a neural network machine learning model developed by OpenAI, was trained on a mixture of filtered Common Crawl (60% of GPT-3\'s data) and other corpuses such as WEBTEXT2, BOOKS1 and BOOKS2, and English-language Wikipedia (Brown et al.).

## **1.1 Getting News Crawl Data**[¶]{.anchor-link}

It is essential to understand the structure of News Crawl data and how to access it. Common Crawl data files are primarily stored in the **WARC (Web ARChive) format**. WARC is a widely used standard for archiving web content, and it\'s well suited for storing large amounts of data, including web pages, metadata, and associated assets. These files contain the raw crawled web pages, along with metadata such as the URL, timestamp, content type, and HTTP headers. They are the primary source of data in Common Crawl.

The Common Crawl also provides its main datasets in **WAT files (Web Annotation Text)**, where it stores important metadata about the records providing additional context and information, and in **WET files (Web Extracted Text)** with the extracted plain text content of the web pages, making it easier to search and analyze the text without parsing HTML. You can see examples of each file format on Common Crawl\'s website here: <https://commoncrawl.org/get-started>.

Unlike Common Crawl\'s main datasets, News Crawl datasets are provided only in WARC format. Common Crawl\'s News datasets are organized into monthly segments, **WARC File Path Listings**, and the data within each segment is stored in WARC files. These files are further grouped into daily crawls. WARC File Path Listings are available on AWS (Amazon Web Services) and can be accessed via the following pattern `s3://commoncrawl/CC-NEWS/yyyy/mm/warc.paths.gz` (access to AWS cloud can be subject to an inter-region data transfer fee depending on your location). Alternatively, data is also accessible via the URL scheme at `https://data.commoncrawl.org/CC-NEWS/yyyy/mm/warc.paths.gz`. We just need to replace `yyyy` and `mm` with the numerical year and month values, respectively.

Inside each WARC paths listing, there is a list of all crawls that were saved in this segment\'s WARC files during the month. The WARC files are released on a daily basis, and WARC file names follow the pattern: `crawl-data/CC-NEWS/yyyy/mm/CC-NEWS-yyyymmddHHMMSS-nnnnn.warc.gz`. The timestamp (yyyymmddHHMMSS) indicates the time the first record in the WARC file was created with:

  ----------------------------------- -----------------------------------
  yyyy                                year

  mm                                  month (01..12)

  dd                                  day of month (01, etc.)

  HH                                  hour (00..23)

  MM                                  minute (00..59)

  SS                                  second (00..59)

  nnnnn                               serial WARC file number.\
                                      The serial number is reset when\
                                      the crawl process is resumed.
  ----------------------------------- -----------------------------------

Now let\'s try to get News Crawl data using the Common Crawl\'s WARC File Path Listings. The following code snippet aims to download and display the list of WARC file paths for the Common Crawl News dataset for September 2024. This code downloads a compressed file containing a list of WARC file paths for the Common Crawl News dataset, decompresses it, and then prints each path to the console:

In \[15\]:

``` calibre12
# Get September 2024 WARC paths list
url = "https://data.commoncrawl.org/crawl-data/CC-NEWS/2024/09/warc.paths.gz"

# Fetch the file
response = requests.get(url, stream=True)
response.raise_for_status()  # Raise an exception for bad responses (4xx or 5xx)

# Decompress and print content
with gzip.GzipFile(fileobj=io.BytesIO(response.content)) as gz:
    for line in gz:
        print(line.decode('utf-8').strip()) # Print each line, removing leading/trailing spaces
```

``` calibre12
crawl-data/CC-NEWS/2024/09/CC-NEWS-20240901011006-05863.warc.gz
crawl-data/CC-NEWS/2024/09/CC-NEWS-20240901040313-05864.warc.gz
crawl-data/CC-NEWS/2024/09/CC-NEWS-20240901061815-05865.warc.gz
crawl-data/CC-NEWS/2024/09/CC-NEWS-20240901082058-05866.warc.gz
crawl-data/CC-NEWS/2024/09/CC-NEWS-20240901100849-05867.warc.gz
crawl-data/CC-NEWS/2024/09/CC-NEWS-20240901115147-05868.warc.gz
crawl-data/CC-NEWS/2024/09/CC-NEWS-20240901132402-05869.warc.gz
crawl-data/CC-NEWS/2024/09/CC-NEWS-20240901145127-05870.warc.gz
crawl-data/CC-NEWS/2024/09/CC-NEWS-20240901161309-05871.warc.gz
crawl-data/CC-NEWS/2024/09/CC-NEWS-20240901174029-05872.warc.gz
crawl-data/CC-NEWS/2024/09/CC-NEWS-20240901191613-05873.warc.gz
crawl-data/CC-NEWS/2024/09/CC-NEWS-20240901210159-05874.warc.gz
crawl-data/CC-NEWS/2024/09/CC-NEWS-20240901230057-05875.warc.gz
crawl-data/CC-NEWS/2024/09/CC-NEWS-20240902013240-05876.warc.gz
crawl-data/CC-NEWS/2024/09/CC-NEWS-20240902035909-05877.warc.gz
crawl-data/CC-NEWS/2024/09/CC-NEWS-20240902060627-05878.warc.gz
crawl-data/CC-NEWS/2024/09/CC-NEWS-20240902073934-05879.warc.gz
crawl-data/CC-NEWS/2024/09/CC-NEWS-20240902090600-05880.warc.gz
crawl-data/CC-NEWS/2024/09/CC-NEWS-20240902102119-05881.warc.gz
crawl-data/CC-NEWS/2024/09/CC-NEWS-20240902113551-05882.warc.gz
crawl-data/CC-NEWS/2024/09/CC-NEWS-20240902124845-05883.warc.gz
crawl-data/CC-NEWS/2024/09/CC-NEWS-20240902140154-05884.warc.gz
crawl-data/CC-NEWS/2024/09/CC-NEWS-20240902151007-05885.warc.gz
crawl-data/CC-NEWS/2024/09/CC-NEWS-20240902161834-05886.warc.gz
crawl-data/CC-NEWS/2024/09/CC-NEWS-20240902172503-05887.warc.gz
crawl-data/CC-NEWS/2024/09/CC-NEWS-20240902184143-05888.warc.gz
crawl-data/CC-NEWS/2024/09/CC-NEWS-20240902200726-05889.warc.gz
crawl-data/CC-NEWS/2024/09/CC-NEWS-20240902214146-05890.warc.gz
crawl-data/CC-NEWS/2024/09/CC-NEWS-20240902231517-05891.warc.gz
crawl-data/CC-NEWS/2024/09/CC-NEWS-20240903010221-05892.warc.gz
crawl-data/CC-NEWS/2024/09/CC-NEWS-20240903031847-05893.warc.gz
crawl-data/CC-NEWS/2024/09/CC-NEWS-20240903052128-05894.warc.gz
crawl-data/CC-NEWS/2024/09/CC-NEWS-20240903065755-05895.warc.gz
crawl-data/CC-NEWS/2024/09/CC-NEWS-20240903082335-05896.warc.gz
crawl-data/CC-NEWS/2024/09/CC-NEWS-20240903093529-05897.warc.gz
crawl-data/CC-NEWS/2024/09/CC-NEWS-20240903104052-05898.warc.gz
crawl-data/CC-NEWS/2024/09/CC-NEWS-20240903114456-05899.warc.gz
crawl-data/CC-NEWS/2024/09/CC-NEWS-20240903125242-05900.warc.gz
crawl-data/CC-NEWS/2024/09/CC-NEWS-20240903135605-05901.warc.gz
crawl-data/CC-NEWS/2024/09/CC-NEWS-20240903145856-05902.warc.gz
crawl-data/CC-NEWS/2024/09/CC-NEWS-20240903155837-05903.warc.gz
crawl-data/CC-NEWS/2024/09/CC-NEWS-20240903170339-05904.warc.gz
crawl-data/CC-NEWS/2024/09/CC-NEWS-20240903180601-05905.warc.gz
crawl-data/CC-NEWS/2024/09/CC-NEWS-20240903191349-05906.warc.gz
crawl-data/CC-NEWS/2024/09/CC-NEWS-20240903203539-05907.warc.gz
crawl-data/CC-NEWS/2024/09/CC-NEWS-20240903215955-05908.warc.gz
crawl-data/CC-NEWS/2024/09/CC-NEWS-20240903233704-05909.warc.gz
crawl-data/CC-NEWS/2024/09/CC-NEWS-20240904013100-05910.warc.gz
crawl-data/CC-NEWS/2024/09/CC-NEWS-20240904032710-05911.warc.gz
crawl-data/CC-NEWS/2024/09/CC-NEWS-20240904051857-05912.warc.gz
crawl-data/CC-NEWS/2024/09/CC-NEWS-20240904065038-05913.warc.gz
crawl-data/CC-NEWS/2024/09/CC-NEWS-20240904081044-05914.warc.gz
crawl-data/CC-NEWS/2024/09/CC-NEWS-20240904092642-05915.warc.gz
crawl-data/CC-NEWS/2024/09/CC-NEWS-20240904103523-05916.warc.gz
crawl-data/CC-NEWS/2024/09/CC-NEWS-20240904113931-05917.warc.gz
crawl-data/CC-NEWS/2024/09/CC-NEWS-20240904123755-05918.warc.gz
crawl-data/CC-NEWS/2024/09/CC-NEWS-20240904133441-05919.warc.gz
crawl-data/CC-NEWS/2024/09/CC-NEWS-20240904143625-05920.warc.gz
crawl-data/CC-NEWS/2024/09/CC-NEWS-20240904153623-05921.warc.gz
crawl-data/CC-NEWS/2024/09/CC-NEWS-20240904163717-05922.warc.gz
crawl-data/CC-NEWS/2024/09/CC-NEWS-20240904174006-05923.warc.gz
crawl-data/CC-NEWS/2024/09/CC-NEWS-20240904184511-05924.warc.gz
crawl-data/CC-NEWS/2024/09/CC-NEWS-20240904195249-05925.warc.gz
crawl-data/CC-NEWS/2024/09/CC-NEWS-20240904210940-05926.warc.gz
crawl-data/CC-NEWS/2024/09/CC-NEWS-20240904223752-05927.warc.gz
crawl-data/CC-NEWS/2024/09/CC-NEWS-20240905002041-05928.warc.gz
crawl-data/CC-NEWS/2024/09/CC-NEWS-20240905022237-05929.warc.gz
crawl-data/CC-NEWS/2024/09/CC-NEWS-20240905042413-05930.warc.gz
crawl-data/CC-NEWS/2024/09/CC-NEWS-20240905060522-05931.warc.gz
crawl-data/CC-NEWS/2024/09/CC-NEWS-20240905073724-05932.warc.gz
crawl-data/CC-NEWS/2024/09/CC-NEWS-20240905085710-05933.warc.gz
crawl-data/CC-NEWS/2024/09/CC-NEWS-20240905101445-05934.warc.gz
crawl-data/CC-NEWS/2024/09/CC-NEWS-20240905112031-05935.warc.gz
crawl-data/CC-NEWS/2024/09/CC-NEWS-20240905122602-05936.warc.gz
crawl-data/CC-NEWS/2024/09/CC-NEWS-20240905133109-05937.warc.gz
crawl-data/CC-NEWS/2024/09/CC-NEWS-20240905143153-05938.warc.gz
crawl-data/CC-NEWS/2024/09/CC-NEWS-20240905153656-05939.warc.gz
crawl-data/CC-NEWS/2024/09/CC-NEWS-20240905164601-05940.warc.gz
crawl-data/CC-NEWS/2024/09/CC-NEWS-20240905175318-05941.warc.gz
crawl-data/CC-NEWS/2024/09/CC-NEWS-20240905190722-05942.warc.gz
crawl-data/CC-NEWS/2024/09/CC-NEWS-20240905202310-05943.warc.gz
crawl-data/CC-NEWS/2024/09/CC-NEWS-20240905214353-05944.warc.gz
crawl-data/CC-NEWS/2024/09/CC-NEWS-20240905231222-05945.warc.gz
crawl-data/CC-NEWS/2024/09/CC-NEWS-20240906010900-05946.warc.gz
crawl-data/CC-NEWS/2024/09/CC-NEWS-20240906030941-05947.warc.gz
crawl-data/CC-NEWS/2024/09/CC-NEWS-20240906050807-05948.warc.gz
crawl-data/CC-NEWS/2024/09/CC-NEWS-20240906065107-05949.warc.gz
crawl-data/CC-NEWS/2024/09/CC-NEWS-20240906082009-05950.warc.gz
crawl-data/CC-NEWS/2024/09/CC-NEWS-20240906094326-05951.warc.gz
crawl-data/CC-NEWS/2024/09/CC-NEWS-20240906105841-05952.warc.gz
crawl-data/CC-NEWS/2024/09/CC-NEWS-20240906120732-05953.warc.gz
crawl-data/CC-NEWS/2024/09/CC-NEWS-20240906131638-05954.warc.gz
crawl-data/CC-NEWS/2024/09/CC-NEWS-20240906142320-05955.warc.gz
crawl-data/CC-NEWS/2024/09/CC-NEWS-20240906152619-05956.warc.gz
crawl-data/CC-NEWS/2024/09/CC-NEWS-20240906163110-05957.warc.gz
crawl-data/CC-NEWS/2024/09/CC-NEWS-20240906173354-05958.warc.gz
crawl-data/CC-NEWS/2024/09/CC-NEWS-20240906184712-05959.warc.gz
crawl-data/CC-NEWS/2024/09/CC-NEWS-20240906200553-05960.warc.gz
crawl-data/CC-NEWS/2024/09/CC-NEWS-20240906213748-05961.warc.gz
crawl-data/CC-NEWS/2024/09/CC-NEWS-20240906233021-05962.warc.gz
crawl-data/CC-NEWS/2024/09/CC-NEWS-20240907013152-05963.warc.gz
crawl-data/CC-NEWS/2024/09/CC-NEWS-20240907035007-05964.warc.gz
crawl-data/CC-NEWS/2024/09/CC-NEWS-20240907054419-05965.warc.gz
crawl-data/CC-NEWS/2024/09/CC-NEWS-20240907074026-05966.warc.gz
crawl-data/CC-NEWS/2024/09/CC-NEWS-20240907092730-05967.warc.gz
crawl-data/CC-NEWS/2024/09/CC-NEWS-20240907110444-05968.warc.gz
crawl-data/CC-NEWS/2024/09/CC-NEWS-20240907124603-05969.warc.gz
crawl-data/CC-NEWS/2024/09/CC-NEWS-20240907142103-05970.warc.gz
crawl-data/CC-NEWS/2024/09/CC-NEWS-20240907155542-05971.warc.gz
crawl-data/CC-NEWS/2024/09/CC-NEWS-20240907173455-05972.warc.gz
crawl-data/CC-NEWS/2024/09/CC-NEWS-20240907191153-05973.warc.gz
crawl-data/CC-NEWS/2024/09/CC-NEWS-20240907205831-05974.warc.gz
crawl-data/CC-NEWS/2024/09/CC-NEWS-20240907231853-05975.warc.gz
crawl-data/CC-NEWS/2024/09/CC-NEWS-20240908015357-05976.warc.gz
crawl-data/CC-NEWS/2024/09/CC-NEWS-20240908040656-05977.warc.gz
crawl-data/CC-NEWS/2024/09/CC-NEWS-20240908060718-05978.warc.gz
crawl-data/CC-NEWS/2024/09/CC-NEWS-20240908081344-05979.warc.gz
crawl-data/CC-NEWS/2024/09/CC-NEWS-20240908101336-05980.warc.gz
crawl-data/CC-NEWS/2024/09/CC-NEWS-20240908120649-05981.warc.gz
crawl-data/CC-NEWS/2024/09/CC-NEWS-20240908134929-05982.warc.gz
crawl-data/CC-NEWS/2024/09/CC-NEWS-20240908153540-05983.warc.gz
crawl-data/CC-NEWS/2024/09/CC-NEWS-20240908171204-05984.warc.gz
crawl-data/CC-NEWS/2024/09/CC-NEWS-20240908190054-05985.warc.gz
crawl-data/CC-NEWS/2024/09/CC-NEWS-20240908205832-05986.warc.gz
crawl-data/CC-NEWS/2024/09/CC-NEWS-20240908230926-05987.warc.gz
crawl-data/CC-NEWS/2024/09/CC-NEWS-20240909014132-05988.warc.gz
crawl-data/CC-NEWS/2024/09/CC-NEWS-20240909041252-05989.warc.gz
crawl-data/CC-NEWS/2024/09/CC-NEWS-20240909061255-05990.warc.gz
crawl-data/CC-NEWS/2024/09/CC-NEWS-20240909074938-05991.warc.gz
crawl-data/CC-NEWS/2024/09/CC-NEWS-20240909090924-05992.warc.gz
crawl-data/CC-NEWS/2024/09/CC-NEWS-20240909102430-05993.warc.gz
crawl-data/CC-NEWS/2024/09/CC-NEWS-20240909114056-05994.warc.gz
crawl-data/CC-NEWS/2024/09/CC-NEWS-20240909124837-05995.warc.gz
crawl-data/CC-NEWS/2024/09/CC-NEWS-20240909135659-05996.warc.gz
crawl-data/CC-NEWS/2024/09/CC-NEWS-20240909150113-05997.warc.gz
crawl-data/CC-NEWS/2024/09/CC-NEWS-20240909160420-05998.warc.gz
crawl-data/CC-NEWS/2024/09/CC-NEWS-20240909171132-05999.warc.gz
crawl-data/CC-NEWS/2024/09/CC-NEWS-20240909182110-06000.warc.gz
crawl-data/CC-NEWS/2024/09/CC-NEWS-20240909194226-06001.warc.gz
crawl-data/CC-NEWS/2024/09/CC-NEWS-20240909210954-06002.warc.gz
crawl-data/CC-NEWS/2024/09/CC-NEWS-20240909223948-06003.warc.gz
crawl-data/CC-NEWS/2024/09/CC-NEWS-20240910000938-06004.warc.gz
crawl-data/CC-NEWS/2024/09/CC-NEWS-20240910015530-06005.warc.gz
crawl-data/CC-NEWS/2024/09/CC-NEWS-20240910035916-06006.warc.gz
crawl-data/CC-NEWS/2024/09/CC-NEWS-20240910054350-06007.warc.gz
crawl-data/CC-NEWS/2024/09/CC-NEWS-20240910071415-06008.warc.gz
crawl-data/CC-NEWS/2024/09/CC-NEWS-20240910083555-06009.warc.gz
crawl-data/CC-NEWS/2024/09/CC-NEWS-20240910095403-06010.warc.gz
crawl-data/CC-NEWS/2024/09/CC-NEWS-20240910110544-06011.warc.gz
crawl-data/CC-NEWS/2024/09/CC-NEWS-20240910120950-06012.warc.gz
crawl-data/CC-NEWS/2024/09/CC-NEWS-20240910131713-06013.warc.gz
crawl-data/CC-NEWS/2024/09/CC-NEWS-20240910142142-06014.warc.gz
crawl-data/CC-NEWS/2024/09/CC-NEWS-20240910152401-06015.warc.gz
crawl-data/CC-NEWS/2024/09/CC-NEWS-20240910162737-06016.warc.gz
crawl-data/CC-NEWS/2024/09/CC-NEWS-20240910173605-06017.warc.gz
crawl-data/CC-NEWS/2024/09/CC-NEWS-20240910184728-06018.warc.gz
crawl-data/CC-NEWS/2024/09/CC-NEWS-20240910200614-06019.warc.gz
crawl-data/CC-NEWS/2024/09/CC-NEWS-20240910212959-06020.warc.gz
crawl-data/CC-NEWS/2024/09/CC-NEWS-20240910230702-06021.warc.gz
crawl-data/CC-NEWS/2024/09/CC-NEWS-20240911004909-06022.warc.gz
crawl-data/CC-NEWS/2024/09/CC-NEWS-20240911025351-06023.warc.gz
crawl-data/CC-NEWS/2024/09/CC-NEWS-20240911044419-06024.warc.gz
crawl-data/CC-NEWS/2024/09/CC-NEWS-20240911061740-06025.warc.gz
crawl-data/CC-NEWS/2024/09/CC-NEWS-20240911074400-06026.warc.gz
crawl-data/CC-NEWS/2024/09/CC-NEWS-20240911090014-06027.warc.gz
crawl-data/CC-NEWS/2024/09/CC-NEWS-20240911101042-06028.warc.gz
crawl-data/CC-NEWS/2024/09/CC-NEWS-20240911111607-06029.warc.gz
crawl-data/CC-NEWS/2024/09/CC-NEWS-20240911122232-06030.warc.gz
crawl-data/CC-NEWS/2024/09/CC-NEWS-20240911132256-06031.warc.gz
crawl-data/CC-NEWS/2024/09/CC-NEWS-20240911142629-06032.warc.gz
crawl-data/CC-NEWS/2024/09/CC-NEWS-20240911153142-06033.warc.gz
crawl-data/CC-NEWS/2024/09/CC-NEWS-20240911163901-06034.warc.gz
crawl-data/CC-NEWS/2024/09/CC-NEWS-20240911174737-06035.warc.gz
crawl-data/CC-NEWS/2024/09/CC-NEWS-20240911190449-06036.warc.gz
crawl-data/CC-NEWS/2024/09/CC-NEWS-20240911202531-06037.warc.gz
crawl-data/CC-NEWS/2024/09/CC-NEWS-20240911214957-06038.warc.gz
crawl-data/CC-NEWS/2024/09/CC-NEWS-20240911233233-06039.warc.gz
crawl-data/CC-NEWS/2024/09/CC-NEWS-20240912012239-06040.warc.gz
crawl-data/CC-NEWS/2024/09/CC-NEWS-20240912031012-06041.warc.gz
crawl-data/CC-NEWS/2024/09/CC-NEWS-20240912044405-06042.warc.gz
crawl-data/CC-NEWS/2024/09/CC-NEWS-20240912062239-06043.warc.gz
crawl-data/CC-NEWS/2024/09/CC-NEWS-20240912075437-06044.warc.gz
crawl-data/CC-NEWS/2024/09/CC-NEWS-20240912091943-06045.warc.gz
crawl-data/CC-NEWS/2024/09/CC-NEWS-20240912103138-06046.warc.gz
crawl-data/CC-NEWS/2024/09/CC-NEWS-20240912113652-06047.warc.gz
crawl-data/CC-NEWS/2024/09/CC-NEWS-20240912123923-06048.warc.gz
crawl-data/CC-NEWS/2024/09/CC-NEWS-20240912134337-06049.warc.gz
crawl-data/CC-NEWS/2024/09/CC-NEWS-20240912144443-06050.warc.gz
crawl-data/CC-NEWS/2024/09/CC-NEWS-20240912154503-06051.warc.gz
crawl-data/CC-NEWS/2024/09/CC-NEWS-20240912164409-06052.warc.gz
crawl-data/CC-NEWS/2024/09/CC-NEWS-20240912174934-06053.warc.gz
crawl-data/CC-NEWS/2024/09/CC-NEWS-20240912185646-06054.warc.gz
crawl-data/CC-NEWS/2024/09/CC-NEWS-20240912200556-06055.warc.gz
crawl-data/CC-NEWS/2024/09/CC-NEWS-20240912213446-06056.warc.gz
crawl-data/CC-NEWS/2024/09/CC-NEWS-20240912231854-06057.warc.gz
crawl-data/CC-NEWS/2024/09/CC-NEWS-20240913011714-06058.warc.gz
crawl-data/CC-NEWS/2024/09/CC-NEWS-20240913032512-06059.warc.gz
crawl-data/CC-NEWS/2024/09/CC-NEWS-20240913052116-06060.warc.gz
crawl-data/CC-NEWS/2024/09/CC-NEWS-20240913065603-06061.warc.gz
crawl-data/CC-NEWS/2024/09/CC-NEWS-20240913082219-06062.warc.gz
crawl-data/CC-NEWS/2024/09/CC-NEWS-20240913094238-06063.warc.gz
crawl-data/CC-NEWS/2024/09/CC-NEWS-20240913105733-06064.warc.gz
crawl-data/CC-NEWS/2024/09/CC-NEWS-20240913120238-06065.warc.gz
crawl-data/CC-NEWS/2024/09/CC-NEWS-20240913130937-06066.warc.gz
crawl-data/CC-NEWS/2024/09/CC-NEWS-20240913141442-06067.warc.gz
crawl-data/CC-NEWS/2024/09/CC-NEWS-20240913152009-06068.warc.gz
crawl-data/CC-NEWS/2024/09/CC-NEWS-20240913162723-06069.warc.gz
crawl-data/CC-NEWS/2024/09/CC-NEWS-20240913174056-06070.warc.gz
crawl-data/CC-NEWS/2024/09/CC-NEWS-20240913185347-06071.warc.gz
crawl-data/CC-NEWS/2024/09/CC-NEWS-20240913201437-06072.warc.gz
crawl-data/CC-NEWS/2024/09/CC-NEWS-20240913214808-06073.warc.gz
crawl-data/CC-NEWS/2024/09/CC-NEWS-20240913233605-06074.warc.gz
crawl-data/CC-NEWS/2024/09/CC-NEWS-20240914013311-06075.warc.gz
crawl-data/CC-NEWS/2024/09/CC-NEWS-20240914040042-06076.warc.gz
crawl-data/CC-NEWS/2024/09/CC-NEWS-20240914060224-06077.warc.gz
crawl-data/CC-NEWS/2024/09/CC-NEWS-20240914074631-06078.warc.gz
crawl-data/CC-NEWS/2024/09/CC-NEWS-20240914091726-06079.warc.gz
crawl-data/CC-NEWS/2024/09/CC-NEWS-20240914103658-06080.warc.gz
crawl-data/CC-NEWS/2024/09/CC-NEWS-20240914115721-06081.warc.gz
crawl-data/CC-NEWS/2024/09/CC-NEWS-20240914132005-06082.warc.gz
crawl-data/CC-NEWS/2024/09/CC-NEWS-20240914144751-06083.warc.gz
crawl-data/CC-NEWS/2024/09/CC-NEWS-20240914161308-06084.warc.gz
crawl-data/CC-NEWS/2024/09/CC-NEWS-20240914174100-06085.warc.gz
crawl-data/CC-NEWS/2024/09/CC-NEWS-20240914191457-06086.warc.gz
crawl-data/CC-NEWS/2024/09/CC-NEWS-20240914205527-06087.warc.gz
crawl-data/CC-NEWS/2024/09/CC-NEWS-20240914224724-06088.warc.gz
crawl-data/CC-NEWS/2024/09/CC-NEWS-20240915004740-06089.warc.gz
crawl-data/CC-NEWS/2024/09/CC-NEWS-20240915031133-06090.warc.gz
crawl-data/CC-NEWS/2024/09/CC-NEWS-20240915051611-06091.warc.gz
crawl-data/CC-NEWS/2024/09/CC-NEWS-20240915072156-06092.warc.gz
crawl-data/CC-NEWS/2024/09/CC-NEWS-20240915092328-06093.warc.gz
crawl-data/CC-NEWS/2024/09/CC-NEWS-20240915111559-06094.warc.gz
crawl-data/CC-NEWS/2024/09/CC-NEWS-20240915124839-06095.warc.gz
crawl-data/CC-NEWS/2024/09/CC-NEWS-20240915142355-06096.warc.gz
crawl-data/CC-NEWS/2024/09/CC-NEWS-20240915160017-06097.warc.gz
crawl-data/CC-NEWS/2024/09/CC-NEWS-20240915174929-06098.warc.gz
crawl-data/CC-NEWS/2024/09/CC-NEWS-20240915193916-06099.warc.gz
crawl-data/CC-NEWS/2024/09/CC-NEWS-20240915212838-06100.warc.gz
crawl-data/CC-NEWS/2024/09/CC-NEWS-20240915233029-06101.warc.gz
crawl-data/CC-NEWS/2024/09/CC-NEWS-20240916014123-06102.warc.gz
crawl-data/CC-NEWS/2024/09/CC-NEWS-20240916040938-06103.warc.gz
crawl-data/CC-NEWS/2024/09/CC-NEWS-20240916061055-06104.warc.gz
crawl-data/CC-NEWS/2024/09/CC-NEWS-20240916074937-06105.warc.gz
crawl-data/CC-NEWS/2024/09/CC-NEWS-20240916091433-06106.warc.gz
crawl-data/CC-NEWS/2024/09/CC-NEWS-20240916103506-06107.warc.gz
crawl-data/CC-NEWS/2024/09/CC-NEWS-20240916114119-06108.warc.gz
crawl-data/CC-NEWS/2024/09/CC-NEWS-20240916125644-06109.warc.gz
crawl-data/CC-NEWS/2024/09/CC-NEWS-20240916140523-06110.warc.gz
crawl-data/CC-NEWS/2024/09/CC-NEWS-20240916150937-06111.warc.gz
crawl-data/CC-NEWS/2024/09/CC-NEWS-20240916161444-06112.warc.gz
crawl-data/CC-NEWS/2024/09/CC-NEWS-20240916172802-06113.warc.gz
crawl-data/CC-NEWS/2024/09/CC-NEWS-20240916183845-06114.warc.gz
crawl-data/CC-NEWS/2024/09/CC-NEWS-20240916200049-06115.warc.gz
crawl-data/CC-NEWS/2024/09/CC-NEWS-20240916212716-06116.warc.gz
crawl-data/CC-NEWS/2024/09/CC-NEWS-20240916230457-06117.warc.gz
crawl-data/CC-NEWS/2024/09/CC-NEWS-20240917005553-06118.warc.gz
crawl-data/CC-NEWS/2024/09/CC-NEWS-20240917031218-06119.warc.gz
crawl-data/CC-NEWS/2024/09/CC-NEWS-20240917051457-06120.warc.gz
crawl-data/CC-NEWS/2024/09/CC-NEWS-20240917065017-06121.warc.gz
crawl-data/CC-NEWS/2024/09/CC-NEWS-20240917082326-06122.warc.gz
crawl-data/CC-NEWS/2024/09/CC-NEWS-20240917094327-06123.warc.gz
crawl-data/CC-NEWS/2024/09/CC-NEWS-20240917105219-06124.warc.gz
crawl-data/CC-NEWS/2024/09/CC-NEWS-20240917115844-06125.warc.gz
crawl-data/CC-NEWS/2024/09/CC-NEWS-20240917130526-06126.warc.gz
crawl-data/CC-NEWS/2024/09/CC-NEWS-20240917140709-06127.warc.gz
crawl-data/CC-NEWS/2024/09/CC-NEWS-20240917150805-06128.warc.gz
crawl-data/CC-NEWS/2024/09/CC-NEWS-20240917160524-06129.warc.gz
crawl-data/CC-NEWS/2024/09/CC-NEWS-20240917170833-06130.warc.gz
crawl-data/CC-NEWS/2024/09/CC-NEWS-20240917181932-06131.warc.gz
crawl-data/CC-NEWS/2024/09/CC-NEWS-20240917192405-06132.warc.gz
crawl-data/CC-NEWS/2024/09/CC-NEWS-20240917203807-06133.warc.gz
crawl-data/CC-NEWS/2024/09/CC-NEWS-20240917220124-06134.warc.gz
crawl-data/CC-NEWS/2024/09/CC-NEWS-20240917233423-06135.warc.gz
crawl-data/CC-NEWS/2024/09/CC-NEWS-20240918011508-06136.warc.gz
crawl-data/CC-NEWS/2024/09/CC-NEWS-20240918031201-06137.warc.gz
crawl-data/CC-NEWS/2024/09/CC-NEWS-20240918045945-06138.warc.gz
crawl-data/CC-NEWS/2024/09/CC-NEWS-20240918063321-06139.warc.gz
crawl-data/CC-NEWS/2024/09/CC-NEWS-20240918075834-06140.warc.gz
crawl-data/CC-NEWS/2024/09/CC-NEWS-20240918091314-06141.warc.gz
crawl-data/CC-NEWS/2024/09/CC-NEWS-20240918102024-06142.warc.gz
crawl-data/CC-NEWS/2024/09/CC-NEWS-20240918112351-06143.warc.gz
crawl-data/CC-NEWS/2024/09/CC-NEWS-20240918122715-06144.warc.gz
crawl-data/CC-NEWS/2024/09/CC-NEWS-20240918133029-06145.warc.gz
crawl-data/CC-NEWS/2024/09/CC-NEWS-20240918143146-06146.warc.gz
crawl-data/CC-NEWS/2024/09/CC-NEWS-20240918153745-06147.warc.gz
crawl-data/CC-NEWS/2024/09/CC-NEWS-20240918164120-06148.warc.gz
crawl-data/CC-NEWS/2024/09/CC-NEWS-20240918174658-06149.warc.gz
crawl-data/CC-NEWS/2024/09/CC-NEWS-20240918185703-06150.warc.gz
crawl-data/CC-NEWS/2024/09/CC-NEWS-20240918200612-06151.warc.gz
crawl-data/CC-NEWS/2024/09/CC-NEWS-20240918212045-06152.warc.gz
crawl-data/CC-NEWS/2024/09/CC-NEWS-20240918224056-06153.warc.gz
crawl-data/CC-NEWS/2024/09/CC-NEWS-20240919002201-06154.warc.gz
crawl-data/CC-NEWS/2024/09/CC-NEWS-20240919021231-06155.warc.gz
crawl-data/CC-NEWS/2024/09/CC-NEWS-20240919042052-06156.warc.gz
crawl-data/CC-NEWS/2024/09/CC-NEWS-20240919055224-06157.warc.gz
crawl-data/CC-NEWS/2024/09/CC-NEWS-20240919072441-06158.warc.gz
crawl-data/CC-NEWS/2024/09/CC-NEWS-20240919084249-06159.warc.gz
crawl-data/CC-NEWS/2024/09/CC-NEWS-20240919100223-06160.warc.gz
crawl-data/CC-NEWS/2024/09/CC-NEWS-20240919110946-06161.warc.gz
crawl-data/CC-NEWS/2024/09/CC-NEWS-20240919121417-06162.warc.gz
crawl-data/CC-NEWS/2024/09/CC-NEWS-20240919131839-06163.warc.gz
crawl-data/CC-NEWS/2024/09/CC-NEWS-20240919142514-06164.warc.gz
crawl-data/CC-NEWS/2024/09/CC-NEWS-20240919153241-06165.warc.gz
crawl-data/CC-NEWS/2024/09/CC-NEWS-20240919163900-06166.warc.gz
crawl-data/CC-NEWS/2024/09/CC-NEWS-20240919174744-06167.warc.gz
crawl-data/CC-NEWS/2024/09/CC-NEWS-20240919190057-06168.warc.gz
crawl-data/CC-NEWS/2024/09/CC-NEWS-20240919201919-06169.warc.gz
crawl-data/CC-NEWS/2024/09/CC-NEWS-20240919214621-06170.warc.gz
crawl-data/CC-NEWS/2024/09/CC-NEWS-20240919232308-06171.warc.gz
crawl-data/CC-NEWS/2024/09/CC-NEWS-20240920011440-06172.warc.gz
crawl-data/CC-NEWS/2024/09/CC-NEWS-20240920033848-06173.warc.gz
crawl-data/CC-NEWS/2024/09/CC-NEWS-20240920054029-06174.warc.gz
crawl-data/CC-NEWS/2024/09/CC-NEWS-20240920072903-06175.warc.gz
crawl-data/CC-NEWS/2024/09/CC-NEWS-20240920085438-06176.warc.gz
crawl-data/CC-NEWS/2024/09/CC-NEWS-20240920101150-06177.warc.gz
crawl-data/CC-NEWS/2024/09/CC-NEWS-20240920112400-06178.warc.gz
crawl-data/CC-NEWS/2024/09/CC-NEWS-20240920122830-06179.warc.gz
crawl-data/CC-NEWS/2024/09/CC-NEWS-20240920133425-06180.warc.gz
crawl-data/CC-NEWS/2024/09/CC-NEWS-20240920144308-06181.warc.gz
crawl-data/CC-NEWS/2024/09/CC-NEWS-20240920154658-06182.warc.gz
crawl-data/CC-NEWS/2024/09/CC-NEWS-20240920165443-06183.warc.gz
crawl-data/CC-NEWS/2024/09/CC-NEWS-20240920181129-06184.warc.gz
crawl-data/CC-NEWS/2024/09/CC-NEWS-20240920193432-06185.warc.gz
crawl-data/CC-NEWS/2024/09/CC-NEWS-20240920210356-06186.warc.gz
crawl-data/CC-NEWS/2024/09/CC-NEWS-20240920224850-06187.warc.gz
crawl-data/CC-NEWS/2024/09/CC-NEWS-20240921010627-06188.warc.gz
crawl-data/CC-NEWS/2024/09/CC-NEWS-20240921034714-06189.warc.gz
crawl-data/CC-NEWS/2024/09/CC-NEWS-20240921055059-06190.warc.gz
crawl-data/CC-NEWS/2024/09/CC-NEWS-20240921075106-06191.warc.gz
crawl-data/CC-NEWS/2024/09/CC-NEWS-20240921094007-06192.warc.gz
crawl-data/CC-NEWS/2024/09/CC-NEWS-20240921111859-06193.warc.gz
crawl-data/CC-NEWS/2024/09/CC-NEWS-20240921125154-06194.warc.gz
crawl-data/CC-NEWS/2024/09/CC-NEWS-20240921142152-06195.warc.gz
crawl-data/CC-NEWS/2024/09/CC-NEWS-20240921155205-06196.warc.gz
crawl-data/CC-NEWS/2024/09/CC-NEWS-20240921173232-06197.warc.gz
crawl-data/CC-NEWS/2024/09/CC-NEWS-20240921192053-06198.warc.gz
crawl-data/CC-NEWS/2024/09/CC-NEWS-20240921211915-06199.warc.gz
crawl-data/CC-NEWS/2024/09/CC-NEWS-20240921234040-06200.warc.gz
crawl-data/CC-NEWS/2024/09/CC-NEWS-20240922022211-06201.warc.gz
crawl-data/CC-NEWS/2024/09/CC-NEWS-20240922045224-06202.warc.gz
crawl-data/CC-NEWS/2024/09/CC-NEWS-20240922063525-06203.warc.gz
crawl-data/CC-NEWS/2024/09/CC-NEWS-20240922083214-06204.warc.gz
crawl-data/CC-NEWS/2024/09/CC-NEWS-20240922102909-06205.warc.gz
crawl-data/CC-NEWS/2024/09/CC-NEWS-20240922121527-06206.warc.gz
crawl-data/CC-NEWS/2024/09/CC-NEWS-20240922135525-06207.warc.gz
crawl-data/CC-NEWS/2024/09/CC-NEWS-20240922152907-06208.warc.gz
crawl-data/CC-NEWS/2024/09/CC-NEWS-20240922170439-06209.warc.gz
crawl-data/CC-NEWS/2024/09/CC-NEWS-20240922184410-06210.warc.gz
crawl-data/CC-NEWS/2024/09/CC-NEWS-20240922202709-06211.warc.gz
crawl-data/CC-NEWS/2024/09/CC-NEWS-20240922222303-06212.warc.gz
crawl-data/CC-NEWS/2024/09/CC-NEWS-20240923005822-06213.warc.gz
crawl-data/CC-NEWS/2024/09/CC-NEWS-20240923035139-06214.warc.gz
crawl-data/CC-NEWS/2024/09/CC-NEWS-20240923060350-06215.warc.gz
crawl-data/CC-NEWS/2024/09/CC-NEWS-20240923074837-06216.warc.gz
crawl-data/CC-NEWS/2024/09/CC-NEWS-20240923091340-06217.warc.gz
crawl-data/CC-NEWS/2024/09/CC-NEWS-20240923102329-06218.warc.gz
crawl-data/CC-NEWS/2024/09/CC-NEWS-20240923112657-06219.warc.gz
crawl-data/CC-NEWS/2024/09/CC-NEWS-20240923123101-06220.warc.gz
crawl-data/CC-NEWS/2024/09/CC-NEWS-20240923133940-06221.warc.gz
crawl-data/CC-NEWS/2024/09/CC-NEWS-20240923143733-06222.warc.gz
crawl-data/CC-NEWS/2024/09/CC-NEWS-20240923154058-06223.warc.gz
crawl-data/CC-NEWS/2024/09/CC-NEWS-20240923164018-06224.warc.gz
crawl-data/CC-NEWS/2024/09/CC-NEWS-20240923174201-06225.warc.gz
crawl-data/CC-NEWS/2024/09/CC-NEWS-20240923190106-06226.warc.gz
crawl-data/CC-NEWS/2024/09/CC-NEWS-20240923202615-06227.warc.gz
crawl-data/CC-NEWS/2024/09/CC-NEWS-20240923220036-06228.warc.gz
crawl-data/CC-NEWS/2024/09/CC-NEWS-20240923235105-06229.warc.gz
crawl-data/CC-NEWS/2024/09/CC-NEWS-20240924015653-06230.warc.gz
crawl-data/CC-NEWS/2024/09/CC-NEWS-20240924041710-06231.warc.gz
crawl-data/CC-NEWS/2024/09/CC-NEWS-20240924055946-06232.warc.gz
crawl-data/CC-NEWS/2024/09/CC-NEWS-20240924073735-06233.warc.gz
crawl-data/CC-NEWS/2024/09/CC-NEWS-20240924090019-06234.warc.gz
crawl-data/CC-NEWS/2024/09/CC-NEWS-20240924101831-06235.warc.gz
crawl-data/CC-NEWS/2024/09/CC-NEWS-20240924112743-06236.warc.gz
crawl-data/CC-NEWS/2024/09/CC-NEWS-20240924123324-06237.warc.gz
crawl-data/CC-NEWS/2024/09/CC-NEWS-20240924134506-06238.warc.gz
crawl-data/CC-NEWS/2024/09/CC-NEWS-20240924144607-06239.warc.gz
crawl-data/CC-NEWS/2024/09/CC-NEWS-20240924154631-06240.warc.gz
crawl-data/CC-NEWS/2024/09/CC-NEWS-20240924164911-06241.warc.gz
crawl-data/CC-NEWS/2024/09/CC-NEWS-20240924180107-06242.warc.gz
crawl-data/CC-NEWS/2024/09/CC-NEWS-20240924191818-06243.warc.gz
crawl-data/CC-NEWS/2024/09/CC-NEWS-20240924204810-06244.warc.gz
crawl-data/CC-NEWS/2024/09/CC-NEWS-20240924222818-06245.warc.gz
crawl-data/CC-NEWS/2024/09/CC-NEWS-20240925001051-06246.warc.gz
crawl-data/CC-NEWS/2024/09/CC-NEWS-20240925020605-06247.warc.gz
crawl-data/CC-NEWS/2024/09/CC-NEWS-20240925041112-06248.warc.gz
crawl-data/CC-NEWS/2024/09/CC-NEWS-20240925054624-06249.warc.gz
crawl-data/CC-NEWS/2024/09/CC-NEWS-20240925071505-06250.warc.gz
crawl-data/CC-NEWS/2024/09/CC-NEWS-20240925083918-06251.warc.gz
crawl-data/CC-NEWS/2024/09/CC-NEWS-20240925095325-06252.warc.gz
crawl-data/CC-NEWS/2024/09/CC-NEWS-20240925110445-06253.warc.gz
crawl-data/CC-NEWS/2024/09/CC-NEWS-20240925121530-06254.warc.gz
crawl-data/CC-NEWS/2024/09/CC-NEWS-20240925132202-06255.warc.gz
crawl-data/CC-NEWS/2024/09/CC-NEWS-20240925142612-06256.warc.gz
crawl-data/CC-NEWS/2024/09/CC-NEWS-20240925153828-06257.warc.gz
crawl-data/CC-NEWS/2024/09/CC-NEWS-20240925164632-06258.warc.gz
crawl-data/CC-NEWS/2024/09/CC-NEWS-20240925175152-06259.warc.gz
crawl-data/CC-NEWS/2024/09/CC-NEWS-20240925190432-06260.warc.gz
crawl-data/CC-NEWS/2024/09/CC-NEWS-20240925203004-06261.warc.gz
crawl-data/CC-NEWS/2024/09/CC-NEWS-20240925220746-06262.warc.gz
crawl-data/CC-NEWS/2024/09/CC-NEWS-20240926000455-06263.warc.gz
crawl-data/CC-NEWS/2024/09/CC-NEWS-20240926021249-06264.warc.gz
crawl-data/CC-NEWS/2024/09/CC-NEWS-20240926042219-06265.warc.gz
crawl-data/CC-NEWS/2024/09/CC-NEWS-20240926060949-06266.warc.gz
crawl-data/CC-NEWS/2024/09/CC-NEWS-20240926074542-06267.warc.gz
crawl-data/CC-NEWS/2024/09/CC-NEWS-20240926091134-06268.warc.gz
crawl-data/CC-NEWS/2024/09/CC-NEWS-20240926102611-06269.warc.gz
crawl-data/CC-NEWS/2024/09/CC-NEWS-20240926113551-06270.warc.gz
crawl-data/CC-NEWS/2024/09/CC-NEWS-20240926124341-06271.warc.gz
crawl-data/CC-NEWS/2024/09/CC-NEWS-20240926135053-06272.warc.gz
crawl-data/CC-NEWS/2024/09/CC-NEWS-20240926144744-06273.warc.gz
crawl-data/CC-NEWS/2024/09/CC-NEWS-20240926155114-06274.warc.gz
crawl-data/CC-NEWS/2024/09/CC-NEWS-20240926164717-06275.warc.gz
crawl-data/CC-NEWS/2024/09/CC-NEWS-20240926174829-06276.warc.gz
crawl-data/CC-NEWS/2024/09/CC-NEWS-20240926190018-06277.warc.gz
crawl-data/CC-NEWS/2024/09/CC-NEWS-20240926201130-06278.warc.gz
crawl-data/CC-NEWS/2024/09/CC-NEWS-20240926212823-06279.warc.gz
crawl-data/CC-NEWS/2024/09/CC-NEWS-20240926225648-06280.warc.gz
crawl-data/CC-NEWS/2024/09/CC-NEWS-20240927004505-06281.warc.gz
crawl-data/CC-NEWS/2024/09/CC-NEWS-20240927024051-06282.warc.gz
crawl-data/CC-NEWS/2024/09/CC-NEWS-20240927044057-06283.warc.gz
crawl-data/CC-NEWS/2024/09/CC-NEWS-20240927063703-06284.warc.gz
crawl-data/CC-NEWS/2024/09/CC-NEWS-20240927081602-06285.warc.gz
crawl-data/CC-NEWS/2024/09/CC-NEWS-20240927093514-06286.warc.gz
crawl-data/CC-NEWS/2024/09/CC-NEWS-20240927105445-06287.warc.gz
crawl-data/CC-NEWS/2024/09/CC-NEWS-20240927120902-06288.warc.gz
crawl-data/CC-NEWS/2024/09/CC-NEWS-20240927132212-06289.warc.gz
crawl-data/CC-NEWS/2024/09/CC-NEWS-20240927143355-06290.warc.gz
crawl-data/CC-NEWS/2024/09/CC-NEWS-20240927154732-06291.warc.gz
crawl-data/CC-NEWS/2024/09/CC-NEWS-20240927165808-06292.warc.gz
crawl-data/CC-NEWS/2024/09/CC-NEWS-20240927181445-06293.warc.gz
crawl-data/CC-NEWS/2024/09/CC-NEWS-20240927193612-06294.warc.gz
crawl-data/CC-NEWS/2024/09/CC-NEWS-20240927211106-06295.warc.gz
crawl-data/CC-NEWS/2024/09/CC-NEWS-20240927225219-06296.warc.gz
crawl-data/CC-NEWS/2024/09/CC-NEWS-20240928011132-06297.warc.gz
crawl-data/CC-NEWS/2024/09/CC-NEWS-20240928040334-06298.warc.gz
crawl-data/CC-NEWS/2024/09/CC-NEWS-20240928061306-06299.warc.gz
crawl-data/CC-NEWS/2024/09/CC-NEWS-20240928081118-06300.warc.gz
crawl-data/CC-NEWS/2024/09/CC-NEWS-20240928100319-06301.warc.gz
crawl-data/CC-NEWS/2024/09/CC-NEWS-20240928115144-06302.warc.gz
crawl-data/CC-NEWS/2024/09/CC-NEWS-20240928133641-06303.warc.gz
crawl-data/CC-NEWS/2024/09/CC-NEWS-20240928152459-06304.warc.gz
crawl-data/CC-NEWS/2024/09/CC-NEWS-20240928170532-06305.warc.gz
crawl-data/CC-NEWS/2024/09/CC-NEWS-20240928184547-06306.warc.gz
crawl-data/CC-NEWS/2024/09/CC-NEWS-20240928203900-06307.warc.gz
crawl-data/CC-NEWS/2024/09/CC-NEWS-20240928225518-06308.warc.gz
crawl-data/CC-NEWS/2024/09/CC-NEWS-20240929011801-06309.warc.gz
crawl-data/CC-NEWS/2024/09/CC-NEWS-20240929035219-06310.warc.gz
crawl-data/CC-NEWS/2024/09/CC-NEWS-20240929061044-06311.warc.gz
crawl-data/CC-NEWS/2024/09/CC-NEWS-20240929082310-06312.warc.gz
crawl-data/CC-NEWS/2024/09/CC-NEWS-20240929102111-06313.warc.gz
crawl-data/CC-NEWS/2024/09/CC-NEWS-20240929120854-06314.warc.gz
crawl-data/CC-NEWS/2024/09/CC-NEWS-20240929135520-06315.warc.gz
crawl-data/CC-NEWS/2024/09/CC-NEWS-20240929154117-06316.warc.gz
crawl-data/CC-NEWS/2024/09/CC-NEWS-20240929171839-06317.warc.gz
crawl-data/CC-NEWS/2024/09/CC-NEWS-20240929190454-06318.warc.gz
crawl-data/CC-NEWS/2024/09/CC-NEWS-20240929204551-06319.warc.gz
crawl-data/CC-NEWS/2024/09/CC-NEWS-20240929225111-06320.warc.gz
crawl-data/CC-NEWS/2024/09/CC-NEWS-20240930012849-06321.warc.gz
crawl-data/CC-NEWS/2024/09/CC-NEWS-20240930041208-06322.warc.gz
crawl-data/CC-NEWS/2024/09/CC-NEWS-20240930061854-06323.warc.gz
crawl-data/CC-NEWS/2024/09/CC-NEWS-20240930074933-06324.warc.gz
crawl-data/CC-NEWS/2024/09/CC-NEWS-20240930091334-06325.warc.gz
crawl-data/CC-NEWS/2024/09/CC-NEWS-20240930103308-06326.warc.gz
crawl-data/CC-NEWS/2024/09/CC-NEWS-20240930114624-06327.warc.gz
crawl-data/CC-NEWS/2024/09/CC-NEWS-20240930125257-06328.warc.gz
crawl-data/CC-NEWS/2024/09/CC-NEWS-20240930135959-06329.warc.gz
crawl-data/CC-NEWS/2024/09/CC-NEWS-20240930151334-06330.warc.gz
crawl-data/CC-NEWS/2024/09/CC-NEWS-20240930162313-06331.warc.gz
crawl-data/CC-NEWS/2024/09/CC-NEWS-20240930173229-06332.warc.gz
crawl-data/CC-NEWS/2024/09/CC-NEWS-20240930183901-06333.warc.gz
crawl-data/CC-NEWS/2024/09/CC-NEWS-20240930195256-06334.warc.gz
crawl-data/CC-NEWS/2024/09/CC-NEWS-20240930212123-06335.warc.gz
crawl-data/CC-NEWS/2024/09/CC-NEWS-20240930230449-06336.warc.gz
```

Each line represents the path to a single WARC file. These files are compressed archives containing web pages and their associated metadata, specifically news articles in this case. These paths are essential for accessing the actual news data within the Common Crawl dataset. We would typically use these paths in conjunction with tools or libraries that can read and process WARC files.

Let\'s now determine the size of a specific WARC file within the Common Crawl News dataset. Let\'s choose the `crawl-data/CC-NEWS/2024/09/CC-NEWS-20240923074837-06216.warc.gz` file corresponding to data crawled on 23 September 2024 at about 7:48 AM:

In \[16\]:

``` calibre12
# Specify WARC file path
warc_file_url = "https://data.commoncrawl.org/crawl-data/CC-NEWS/2024/09/CC-NEWS-20240923074837-06216.warc.gz"

# Use HEAD request to get headers only
response = requests.get(warc_file_url, stream=True)
response.raise_for_status()

# Get file size from headers and print
file_size = int(response.headers.get('content-length', 0))
print(f"File size: {file_size} bytes")
print(f"File size: {file_size / (1024 * 1024):.2f} MB")  # Convert to MB
```

``` calibre12
File size: 1072759398 bytes
File size: 1023.06 MB
```

This code efficiently retrieves the size of a specific WARC file from the Common Crawl News dataset without downloading the entire file. As we see this specific WARC file has a size of approximately 1.02 GB (1023.06 MB). By understanding the size of the WARC files, we can better plan data acquisition and processing workflows. In our case, we should note that a 1 GB file can take a significant amount of time to download, especially on slower internet connections.

## **1.2 Processing WARC file records**[¶]{.anchor-link}

For large WARC files like this, we can process them in smaller chunks to avoid memory issues. The `requests.get(..., stream=True)` line in the above code snippet initiates a streaming download, meaning it doesn\'t load the entire WARC file into memory at once. Instead, it downloads chunks of data as needed. This helps to minimize memory usage, especially for large WARC files. The `requests.get()` function returns a Response object, which is assigned to the variable `response`. This object contains information about the server\'s response, including the status code, headers, and the content of the response (in this case, the WARC file data). However, it is important to understand that the `response` object does not hold an entire WARC file. Think of `response` as a container with multiple compartments. One compartment holds information about the response (headers, status code), and another compartment is a pipeline connected to the server where the WARC file data is flowing through in chunks. As an analogy think of it like a water pipe connected to a reservoir. The pipe (the `response` object) exists, but the entire reservoir (the WARC file data) is not flowing through the pipe at once. Instead, water flows through in controlled amounts as needed.

Later, we can use this streaming feature efficiently to keep the memory footprint relatively low. Luckily for us, libraries like `warcio,` a Python library for reading and writing WARC files, allow us to iterate through records in a WARC file without loading the entire file into memory. When we access the content using `response.raw`, we\'re not getting a complete file in memory; we\'re accessing the pipeline through which the data is streaming. `warcio.ArchiveIterator` is designed to work with this pipeline. It reads chunks of data as they come through the pipeline and processes them one by one. For example, the following code snippet iterates over all records and creates a DataFrame with URL, date, and content length for each record in our chosen WARC file. It focuses only on `"response"` records, which typically contain the actual web page content:

In \[ \]:

``` calibre12
# Function to process the WARC file and extract data
def process_warc_file(warc_file_url):
    data = []
    with requests.get(warc_file_url, stream=True) as response:
        response.raise_for_status()

        # Process WARC records
        for record in warcio.ArchiveIterator(response.raw):
            if record.rec_type == 'response':

                # Extract URL, date and content length
                url = record.rec_headers.get_header('WARC-Target-URI')
                date = record.rec_headers.get_header('WARC-Date')
                content_length = record.rec_headers.get_header('Content-Length')

                # Store extracted info in 'data' list
                data.append([url, date, content_length])

    # Create DataFrame
    df = pd.DataFrame(data, columns=['URL', 'Date', 'Content-Length'])
    return df

# Process the WARC file and get the DataFrame
df = process_warc_file(warc_file_url)
df
```

Here, we see that there are 25,498 news records in this chosen WARC file that was crawled at about 7:48AM on September 23, 2024. This amount is large, but the code took less than a minute to iterate over all records. Processing of the above code was also relatively fast because all the record attributes (URL, crawling date, and content length) are saved in record headers.

However, we do not yet have any information about the contents of the news articles. To work with the news article content, we need to access the HTML content from the body of the news record and then use an HTML parsing library to extract specific elements from the HTML, such as the article title, body text, author, and/or publication date. Processing HTML, especially large HTML files or a large number of HTML files, can be time-consuming depending on the complexity of the HTML and the operations being performed. There are advanced techniques like parallel processing or distributed computing to further optimize the processing time. However, for simplicity, we\'ll just limit the number of articles to process to just the first couple thousand records. This should suffice to understand how extraction of news record attributes from News Crawl WARC files is done.

Let\'s now add more functionality to the `process_warc_file()` function in the above code snippet. This time, we will implement the reusable function that is designed to extract news articles related to Netflix from a WARC file. This function handles language filtering, keyword filtering, data extraction, error handling, and data organization, providing a streamlined way to process WARC files for specific information retrieval:

In \[ \]:

``` calibre12
# Helper function to process WARC file
def process_warc_file(warc_file_url, limit=1000):
    data = []
    count = 0

    with requests.get(warc_file_url, stream=True) as response:
        response.raise_for_status()

        # Wrap the iterator with tqdm to process records with a progress bar up to the limit
        for record in tqdm.tqdm(warcio.ArchiveIterator(response.raw), total=limit, desc="Processing records"):
            if record.rec_type == 'response':

                # Proceed with data extraction and filtering
                url = record.rec_headers.get_header('WARC-Target-URI')
                date = record.rec_headers.get_header('WARC-Date')
                content_length = record.rec_headers.get_header('Content-Length')

                try:
                    html_content = record.content_stream().read().decode('utf-8', 'ignore')

                    # Check for lang="en" before <head> (handling line breaks)
                    if re.search(r'lang\s*=\s*[\'"]?en[\'"]?[\s\S]*?<head>', html_content, re.IGNORECASE):

                        # Extract title and article content using newspaper3k
                        article = Article(url, language='en')
                        article.download(input_html=html_content)
                        article.parse()
                        title = article.title
                        news_article = article.text

                        # Filter news article texts containing "netflix" (case-insensitive)
                        if news_article and re.search(r'netflix', news_article, re.IGNORECASE):
                            data.append([url, date, content_length, title, news_article])

                # Error handling
                except UnicodeDecodeError as e:
                    print(f"Error decoding HTML content from {url}: {e}")
                except Exception as e:
                    print(f"Error extracting article from {url}: {e}")

            # Increment count and check limit after processing each record
            count += 1
            if count > limit:
                break # Exit the loop if the limit is reached

    # Create DataFrame
    df = pd.DataFrame(data, columns=['URL', 'Date', 'Content-Length', 'Title', 'News_Article'])
    return df
```

Here we use `lang\s*=\s*[\'"]?en[\'"]?[\s\S]*?<head>` regex (regular expression). This regex is looking for the `lang` attribute in the HTML content, specifically checking if it\'s set to `"en"`, and then it captures everything from that point up to the `<head>` tag, even if there are line breaks in between. This expression allows for flexibility in how the attribute is written, e.g. `lang="en"`, `lang = 'en'`, `lang=en`.

Then, we proceed with extracting news article details. The code does this with `newspaper3k` library to extract the title and main body text of news article from its HTML content. `newspaper3k` is a Python library used for extracting and analyzing articles from news websites and blogs. It is designed to make web scraping of news articles easier and more efficient. Then, the code filters news article texts containing \"netflix\" and appends extracted information to a `data` list, which is used to create the final `df` pandas DataFrame returned from function.

Please also note that, this time around, `warcio.ArchiveIterator` is wrapped within `tqdm.tqdm(...)` to create a progress bar that updates as the loop iterates through the WARC records. The progress bar will indicate the current record number, percentage of completion, and estimated remaining time, giving you a clear visual representation of the processing progress.

Now that we have a more functional `process_warc_file()` function, let\'s call it:

In \[ \]:

``` calibre12
# Record the start time
start_time = time.time()

# Process the first 5000 English records with "netflix" in the title
df = process_warc_file(warc_file_url, limit=5000)

# Calculate and print total processing time
end_time = time.time()
processing_time = end_time - start_time
print(f"\nTotal processing time: {processing_time:.2f} seconds")

# Display DataFrame
df
```

This was just a simplified example to demonstrate how to get a news dataset from a News Crawl WARC file. As a result, we now have filtered news data in `df` DataFrame, which in our case has only a handful of articles concerning Netflix. We can use this DataFrame in a similar manner as we could with other news datasets obtained by other means to process it further.

# **2. GDELT (Global Database of Events, Language, and Tone)**[¶](#2.-GDELT-(Global-Database-of-Events,-Language,-and-Tone)){.anchor-link}

## **2.1 Introduction to GDELT**[¶]{.anchor-link}

**GDELT** (Global Database of Events, Language, and Tone) is another massive, open-source database that monitors the world\'s news media in over 65 languages. It uses sophisticated techniques to identify and categorize events, analyze the tone and sentiment of news coverage, and provide insights into global trends and patterns. GDELT\'s data is freely available to researchers, journalists, and the public, enabling a deeper understanding of human society and global events.

GDELT data is available in various formats including CSV, JSON, and a specialized format called GKG (Global Knowledge Graph). The database is updated in real time or near real time, with new data being added continuously. The GDELT Project claims to have \"the largest, most comprehensive, and highest resolution open database of human society ever created.\" They process 100 million news articles and social media posts daily with about 65 languages represented in their dataset. Data is available from 1979 to present.

While not all aspects of big data might be equally pronounced in GDELT, the combination of its volume, velocity, variety, and potential value places it firmly within the realm of big data. The sheer scale and complexity of GDELT data necessitate specialized tools and techniques for efficient processing, analysis, and storage. This often involves using cloud-based platforms, distributed computing frameworks, and in-memory processing methods to handle the data effectively. However, it\'s worth noting that the \"big data\" definition can be subjective and context dependent. While GDELT undoubtedly presents challenges associated with big data, the dataset might be considered relatively small compared to datasets from social media platforms or web-scale applications. Nonetheless, the volume, velocity, and variety of GDELT data are significant enough to warrant considering it as big data in the context of global event and news analysis.

## **2.2 GDELT vs. News Crawl**[¶]{.anchor-link}

Both GDELT and News Crawl are open-source datasets focused on news analysis. Both provide a large amount of news data from various sources. Both allow for analysis of news trends and patterns. Both are publicly accessible and can be used for research and analysis. But they have some key differences:

  ------------------------------------------------------------------------------------------------------------------------------------------------
  Feature                 News Crawl                                                 GDELT
  ----------------------- ---------------------------------------------------------- -------------------------------------------------------------
  Data Source             Primarily news articles collected through\                 News articles, social media posts,\
                          RSS feeds and sitemaps.                                    and other online media.

  Data Format             Raw HTML of web pages (WARC files)                         CSV, JSON, GKG (Global Knowledge Graph)

  Focus                   Provides the full content of news articles for analysis.   Extracts events, entities, and sentiment from news data.

  Analysis Supported      Text mining, natural language processing (NLP),\           Event detection, sentiment analysis,\
                          topic modeling.                                            geospatial analysis, and network analysis.

  Update Frequency        Updated multiple times per day.                            Updated in real-time or near real-time\
                                                                                     (every 15 minutes for GKG).

  Data Size               Large (around 600,000 articles per day).                   Massive (processes 100 million articles and posts daily).

  Timeframe               Data available from the past few years.                    Data available from 1979 to present.

  Languages               Multiple languages supported.                              Over 65 languages supported.

  Strengths               Access to full article content,\                           Pre-processed data, efficient for specific analysis tasks,\
                          flexible for custom analysis.                              comprehensive analysis of events and sentiment.

  Weaknesses              Requires more preprocessing,\                              Limited access to raw article content,\
                          less structured data.                                      potential biases in data collection.
  ------------------------------------------------------------------------------------------------------------------------------------------------

Key differences between News Crawl and GDELT data can be summarized as:

-   Data Format: News Crawl primarily provides the full HTML content of news articles. This means you get the complete webpage as it appears online. GDELT provides data in various formats like CSV, JSON, and GKG. The choice of format depends on specific needs and the tools to use for analysis. GDELT\'s multiple formats provide flexibility for different types of analysis, while News Crawl\'s raw HTML requires more processing but gives access to the complete web page content.
-   Analysis: GDELT provides analysis of events, tone, and sentiment. News Crawl provides the raw data for you to perform your own analysis.
-   Update Frequency: GDELT is updated in real time or near real time. News Crawl updates less frequently, just multiple times a day.

GDELT datasets are publicly available and primarily stored on Google Cloud Storage. The specific location and access methods might vary depending on the dataset and format. GDELT offers different datasets. Global Knowledge Graph (GKG), Events, and Mentions are the main datasets of GDELT. The additional datasets and tools can be used in conjunction with the main datasets to provide a more comprehensive understanding of global events, news coverage, and public discourse. It\'s worth exploring the full range of GDELT\'s offerings on their website to see which datasets and tools are most relevant to our needs <https://www.gdeltproject.org/data.html#rawdatafiles>. GDELT\'s website provides detailed instructions and documentation on accessing their data.

## **2.3 Datasets Available from GDELT**[¶]{.anchor-link}

Here\'s a summary of some of the GDELT datasets and their potential use in financial engineering:

-   **GKG 2.0:** The Global Knowledge Graph, which extracts a wide range of information from online news articles and other online media sources globally including entities, themes, events, locations, sentiment, and more.

    -   Financial Engineering Use:

        -   Sentiment Analysis: Analyze the tone and sentiment of news articles related to specific companies, industries, or economic indicators to gauge market sentiment and predict potential price movements.
        -   Event Detection: Identify relevant events that could impact financial markets, such as company mergers, regulatory changes, or geopolitical developments.
        -   Theme Extraction: Extract key themes and topics from news articles to understand emerging trends and their potential influence on investment decisions.

    -   Granularity: Hourly updates, providing a near real-time view of global news and information. Data is available from February 2015 to the present.

-   **Events 2.0:** Focuses on events and their relationships, providing details like actor roles, event codes, and geographic locations.

    -   Financial Engineering Use:

        -   Risk Assessment: Assess potential risks associated with specific investments by analyzing events related to companies, countries, or industries.
        -   Portfolio Optimization: Use event data to optimize investment portfolios by identifying potential opportunities or threats based on global events and their potential impact.
        -   Quantitative Trading: Develop quantitative trading strategies based on signals extracted from event data, such as changes in relationships between companies or countries.

    -   Granularity: Event-level data, capturing individual occurrences with specific details. Data is available from January 1, 1979, to the present.

-   **Mentions 2.0:** Tracks mentions of people, organizations, and locations across the GDELT dataset.

    -   Financial Engineering Use:
        -   Track news coverage and identify related entities for specific companies.
        -   Gauge public sentiment and perception toward companies.
    -   Granularity: Mention-level data, providing insights into the frequency and context of entity mentions. Data is available from February 2015 to the present.

-   **Global Frontpage Graph (GFG):** Captures the top headlines from news websites around the world, providing insights into the most prominent news stories.

    -   Financial Engineering Use: Identify breaking news and potential market-moving events quickly.
    -   Granularity: Hourly snapshots of the most prominent news stories. Data is available from April 2017 to the present.

-   **Television Explorer:** Analyzes television news broadcasts and extracts information about the topics covered, people mentioned, and visual content.

    -   Financial Engineering Use: Track sentiment and narratives on financial news programs.
    -   Granularity: Data linked to specific television broadcasts and segments. Data availability depends on the specific television news channels and programs analyzed. Check the GDELT Television Explorer documentation for details.

-   **Geo 2.0:** A geospatial dataset that links GDELT events and mentions to specific geographic locations and administrative regions.

    -   Financial Engineering Use: Analyze the geographical impact of events on investments and markets.
    -   Granularity: Location-specific data associated with events and mentions. Data is available from January 1, 1979, to the present (aligned with Events 2.0).

-   **WEB NGrams 3.0:** Tracks the frequency of phrases and terms across a massive collection of online news articles and web pages.

    -   Financial Engineering Use: Identify emerging trends and topics in financial discourse.
    -   Granularity: Data on the frequency of word and phrase usage over time. Data is available from January 1, 2010, to the present.

By understanding the strengths and granularity of each dataset, financial engineers can leverage GDELT\'s vast information to gain a competitive edge in their analyses and decision-making.

# **3. GDELT Data**[¶]{.anchor-link}

## **3.1 Importing GDELT GKG Data**[¶]{.anchor-link}

In this lesson, we focus on using GDELT to analyze data. Before running the code, we need to understand a few important details:

-   Naming Convention: GKG data is updated every 15 minutes and data is stored in separate compressed files. The file names follow a specific pattern: `YYYYMMDDHHMMSS.gkg.csv.zip`, where:

    -   YYYY: Year
    -   MM: Month
    -   DD: Day
    -   HH: Hour
    -   MM: Minute
    -   SS: Second

-   No Header Row: GKG files typically do not have a header row with column names. You need to refer to the GDELT GKG Codebook to identify the meaning of each column. GKG has 27 columns representing different aspects of news articles. Please refer to the [GDELT 2.0 Global Knowledge Graph Codebook (V2.1)](http://data.gdeltproject.org/documentation/GDELT-Global_Knowledge_Graph_Codebook-V2.1.pdf) for full guidance.

-   Complex Data: The data within each column can be complex, with multiple values separated by delimiters (e.g., semicolons, commas) or encoded information.

By understanding the organization of GDELT GKG data, we can effectively access, process, and analyze the information to gain insights from global news and events. Remember to refer to the GDELT GKG Codebook for detailed information on the data format and column descriptions.

Let\'s now run the code. The following code downloads the specified GDELT GKG data - `20240930081500.gkg.csv.zip` - corresponding to the GDELT data captured at 8:15 AM on September 30, 2024. We will then unzip it, read it into a pandas DataFrame, add column names, and filter the DataFrame to only include rows where the \"Organizations\" column contains the word \"netflix\":

In \[ \]:

``` calibre12
# URL for GDELT GKG data
url = "http://data.gdeltproject.org/gdeltv2/20240930081500.gkg.csv.zip"

# Download and save the zipped file
response = requests.get(url, stream=True)
with open("gdelt_data.csv.zip", "wb") as file:
  for chunk in response.iter_content(chunk_size=1024):
    if chunk:
      file.write(chunk)

# Unzip the file
!unzip gdelt_data.csv.zip -d gdelt_data

# Read the CSV file into a pandas DataFrame
file_path = "gdelt_data/20240930081500.gkg.csv"
df = pd.read_csv(file_path, sep='\t', header=None)

# Add column names (replace with actual column names from GDELT documentation)
gkg_columns = [
    "GKGRECORDID", "DATE", "SourceCollectionIdentifier", "SourceCommonName",
    "DocumentIdentifier", "Counts", "V2Counts", "Themes", "V2Themes",
    "Locations", "V2Locations", "Persons", "V2Persons", "Organizations",
    "V2Organizations", "V2Tone", "Dates", "GCAM", "SharingImage",
    "RelatedImages", "SocialImageEmbeds", "SocialVideoEmbeds", "Quotations",
    "AllNames", "Amounts", "TranslationInfo", "Extras"
]
df.columns = gkg_columns

# Filter for news related to netflix (adjust column and keyword as needed)
netflix_news = df[df['Organizations'].str.contains("netflix", na=False)].copy()
netflix_news
```

First, please note that GDELT GKG 2.0 (Global Knowledge Graph) files are typically in the range of 15-25 MB. This means that we do not really need to worry about how to plan data acquisition and analysis workflows as this is relatively small size that won\'t pose a major memory concern.

GDELT GKG 2.0 data has 27 columns. The columns contain information about:

-   Article Metadata: Unique ID, date/time, source, URL.
-   Entities: Mentions of themes, locations, people, and organizations with counts and relevance.
-   Sentiment: Overall tone, positive/negative scores, polarity, etc.
-   Events & Context: Dates mentioned, content analysis, related images/videos, quotes.
-   Additional: All names, amounts, translation info, and extra metadata.

Essentially, these columns provide a comprehensive view of a news article\'s content, context, and sentiment.

Please note that we only filtered a small GDELT dataset since its GKG data is updated every 15 minutes. Such small timeframe datasets or a sequence of consecutive datasets could potentially be useful in some financial engineering scenarios such as market microstructure analysis, real-time risk management, algorithmic execution, and news sentiment analysis.

Important Considerations: While small timeframe datasets can be useful in these scenarios, it\'s important to be aware of their limitations. The results obtained from small timeframe datasets might not be as robust or statistically significant as those obtained from larger timeframe datasets. It\'s essential to carefully validate the results and ensure that the chosen time window is appropriate for the specific application. Combining data from multiple sources and using robust statistical techniques can help improve the reliability of analysis based on small timeframe datasets.

## **3.2 Tone in GDELT Data**[¶]{.anchor-link}

GDELT employs a sophisticated process to determine the emotional tone and sentiment expressed in news articles and online media. GDELT uses a mix of linguistic analysis (looking at words and grammar) and contextual information (events, entities, location, time) to score the tone of news articles. GDELT leverages a sophisticated blend of NLP, machine learning, statistical methods, contextual analysis, and rule-based systems to calculate its Tone scores. GDELT combines a deep understanding of language with a broad awareness of context to derive nuanced sentiment scores for news articles. This provides valuable insights into the emotional landscape of global events and online discourse.

**Advantages** of GDELT\'s Tone score are:

-   **Vast Scale and Scope:** GDELT processes massive amounts of global news data in multiple languages, providing a broad perspective on sentiment and tone across diverse sources. This scale is unmatched by most other sentiment analysis tools.
-   **Real-time and Historical Analysis:** GDELT provides both real-time updates and a historical archive, allowing you to analyze sentiment trends over time and identify emerging patterns. This historical context is invaluable for understanding the evolution of sentiment toward specific topics or entities.
-   **Granular Sentiment Breakdown:** The `V2Tone` column offers a detailed breakdown of sentiment components, including Tone, Positive Score, Negative Score, Polarity, Activity, Self Direction, and Word Count. This granularity allows for a more nuanced understanding of sentiment beyond simple positive/negative classifications.
-   **Open and Accessible:** GDELT is a free and open-source resource, making it readily available for researchers, analysts, and developers. This accessibility removes barriers to entry and promotes wider use of sentiment analysis for various applications.
-   **Integration with Other GDELT Data:** GDELT\'s Tone score can be combined with other GDELT datasets, such as event data or geographic information, to gain a more holistic understanding of events and their emotional context. This integrated analysis can provide deeper insights into global trends and patterns.

**Limitations:** While sophisticated, the accuracy of GDELT\'s Tone scoring can be influenced by different factors like language ambiguity, cultural nuances, and the complexity of news content. It\'s also important to understand the limitations of automated sentiment analysis:

-   **Accuracy Challenges:** Automated sentiment analysis is inherently complex, and GDELT\'s Tone score is not immune to errors. Language ambiguity, cultural nuances, and sarcasm can sometimes lead to misinterpretations of sentiment.
-   **Contextual Dependence:** Sentiment can be highly context dependent, and GDELT\'s analysis might not always capture the full nuances of the text\'s meaning. It\'s crucial to consider the surrounding context and potential biases when interpreting Tone scores.
-   **Limited to News and Online Media:** GDELT primarily focuses on news articles and online media sources. Sentiment expressed in other forms of communication, such as social media posts or personal conversations, might not be accurately reflected in the Tone score.
-   **Potential for Bias:** The sources and content included in GDELT\'s dataset can introduce biases into the Tone score. It\'s essential to be aware of these potential biases and consider their implications when interpreting results.

Overall, GDELT\'s Tone score is a valuable tool for understanding sentiment and tone in global news and online media. It offers vast scale, historical context, and granular analysis. However, it\'s crucial to be aware of its limitations, particularly regarding accuracy and contextual dependence. By carefully considering the advantages and limitations, we can effectively leverage GDELT\'s Tone score to gain valuable insights into global events and online discourse.

## **3.3 Getting Tone Components in GDELT data**[¶]{.anchor-link}

We can use the `V2Tone` column to filter articles based on their sentiment, identify trends in news tone over time, or analyze the emotional context surrounding specific events or entities. This column contains a set of values that represent the sentiment and emotional tone of the associated news article or online media source. The values within the `V2Tone` column are typically separated by commas and include:

-   Tone: Represents the overall tone, with higher values indicating positivity. Represented as a floating-point number. This is calculated as Positive Score minus Negative Score.
-   Positive Score: This provides more granular sentiment details. Can be used to identify articles with strong positive sentiment. A measure of the positive sentiment expressed by a floating-point number ranging from 0 to 100. A score of 0 indicates the absence of positive sentiment. Higher values indicate stronger positive sentiment with 100 indicating the strongest possible positive sentiment in the article.
-   Negative Score: This provides more granular sentiment details. Can be used to identify articles with strong negative sentiment. A measure of the negative sentiment expressed by a floating-point number ranging from 0 to 100. A score of 0 indicates the absence of negative sentiment in the article. Higher values indicate stronger negative sentiment with 100 indicating the strongest negative sentiment in the article.
-   Polarity: An indicator of how emotionally polarized or charged the text is. Derived from a complex algorithm that considers various linguistic features and contextual factors.
-   Activity Reference Density: A measure of the density of words related to activity or action in the text.
-   Self Direction: A measure of the degree to which the text focuses on the author or the subject.
-   WordCount: The number of words analyzed for tone in the article (integer value).

The following code snippet transforms the GDELT data into a more usable format for sentiment analysis. We take the `V2Tone` column and then separate and convert the relevant sentiment components from it. This allows you to easily work with and analyze the Tone data in subsequent steps.

In \[ \]:

``` calibre12
# Split V2Tone into separate columns
netflix_news[['Tone', 'Positive Score', 'Negative Score', 'Polarity', 'Activity', 'Self Direction', 'WordCount']] = netflix_news['V2Tone'].str.split(',', expand=True)

# Convert numeric columns to appropriate data types
numeric_columns = ['Tone', 'Positive Score', 'Negative Score', 'Polarity', 'Activity', 'Self Direction']
netflix_news[numeric_columns] = netflix_news[numeric_columns].astype(float).round(3)
netflix_news[['Tone', 'Positive Score', 'Negative Score', 'Polarity', 'Activity', 'Self Direction', 'WordCount']]
```

From this code output we can draw the following observations:

-   Negative Tone Prevails: More articles have a negative \"Tone\" value, suggesting a generally negative or critical slant in the text.
-   Subtle Sentiment: The \"Positive Score\" and \"Negative Score\" values remain relatively low, indicating that the sentiment expressed might be nuanced or indirect rather than strongly positive or negative.
-   Relationship Between Polarity and Tone: It seems that in this particular dataset, even articles with a negative Tone can still have an overall positive sentiment direction as captured by Polarity. This highlights the importance of considering both Tone and Polarity together to get a complete picture of the sentiment expressed in the text. While Tone might indicate a generally negative or critical tone, the positive Polarity suggests that there might be underlying positive elements or a more nuanced sentiment conveyed within those articles.
-   Higher Activity in Shorter Articles: There seems to be a trend of higher \"Activity Reference Density\" in articles with a small \"WordCount\". This could indicate that shorter articles tend to have more action-oriented language or describe more events.
-   Varied Self Direction: The \"Self Direction\" values vary, suggesting that some articles focus more on the author\'s perspective while others are more objective or focused on external events.

**How this information could help:** By carefully analyzing this output in conjunction with other information and domain expertise, financial engineers can gain insights into market sentiment toward Netflix and develop strategies for investment and risk management. Possible interpretations of the above results are:

-   Active Change and Adaptation: The results might reflect a period of significant change or transition for Netflix. News coverage could be critical of specific decisions or challenges (negative Tone) but also acknowledge the company\'s active efforts to adapt, innovate, or respond to market dynamics (positive Polarity and Activity).
-   Competitive Landscape: The mixed sentiment might reflect the competitive landscape of the streaming industry. Articles could be discussing Netflix in relation to its competitors, highlighting both challenges and opportunities.
-   Investor Caution: The negative Tone might indicate a degree of caution or skepticism among investors, even amidst positive developments. This could suggest a need for Netflix to address concerns or improve transparency to maintain investor confidence.

Focusing on the Tone and Polarity aspects, here are some potential conclusions from a financial engineering perspective:

-   Sentiment-Based Trading Strategies: The Tone and Polarity data can be used to develop trading strategies that capitalize on shifts in market sentiment toward Netflix. For example, a strategy might involve buying Netflix stock when Polarity is strongly positive, even if Tone is slightly negative, indicating potential undervaluation.
-   Risk Management: The Tone data can be used to assess potential risks associated with investing in Netflix. Negative Tone might indicate increased uncertainty or negative news coverage, prompting further investigation or risk mitigation strategies.
-   Predictive Modeling: The Tone and Polarity data can be incorporated into predictive models for Netflix\'s stock price or other financial metrics. The combination of Tone and Polarity might provide valuable insights into market sentiment that can improve the accuracy of these models.

Overall, the data suggests a dynamic and potentially volatile period for Netflix, with news coverage reflecting both challenges and opportunities. By carefully considering all the V2Tone components and combining them with other GDELT data and fundamental analysis, financial engineers can gain a more comprehensive understanding of market sentiment and its potential impact on Netflix\'s financial performance.

However, we also need to note the important considerations:

-   Limited Data: This analysis is based on a small subset of data. A larger dataset and more comprehensive analysis are needed for more robust conclusions.
-   External Factors: Consider other factors that might be influencing market sentiment toward Netflix, such as industry trends, competitor actions, or overall economic conditions.
-   News Content: Analyze the actual content of the news articles to understand the specific factors driving the Tone and Polarity scores. This qualitative analysis can provide valuable context for the numerical data.

## **3.4 How to Enhance Sentiment Analysis**[¶]{.anchor-link}

Besides the `V2Tone` column, there are other columns in the GDELT GKG 2.0 dataset that we could potentially use to enhance sentiment analysis:

**Themes and V2Themes:** These columns contain a list of themes identified in the article. We can use this to identify themes related to positive or negative sentiment (e.g., \"ECON_INFLATION\" might be associated with negative sentiment). We can create a dictionary mapping themes to sentiment scores and use it to analyze the sentiment associated with the themes present in the articles.

We can use these columns to create a sentiment dictionary or lexicon based on the co-occurrence of specific themes with positive or negative keywords. We can then use this lexicon to score the sentiment of articles based on the presence of these themes or names.

**Quotations:** This column contains direct quotations from the article. Analyzing the sentiment of these quotations can provide a more nuanced understanding of the sentiment expressed in the article. We can apply sentiment analysis techniques directly to the text of the quotations to get a more granular understanding of the sentiment expressed.

**GCAM:** GCAM stands for Global Content Analysis Measures. This column in the GKG dataset provides a comprehensive set of content analysis measures derived from applying Google\'s Cloud Vision API to the images and videos associated with a news article. This column contains the output of Google\'s Cloud Vision API, which can include labels and descriptions of images associated with the article. These labels and descriptions can sometimes provide clues about the sentiment of the article. We can apply sentiment analysis to the text extracted from the GCAM data to infer sentiment related to the visual content of the article.

We can extract text from the GCAM data and apply sentiment analysis models to this text to infer the sentiment associated with visual content.

**AllNames:** This column contains a list of all names mentioned in the article. This could be used to identify individuals or entities that are frequently associated with positive or negative sentiment. By analyzing the sentiment associated with the mentioned names, we can potentially identify key influencers or stakeholders driving the overall sentiment.

Important Considerations: These columns might require more pre-processing and analysis compared to the `V2Tone` column. Also, the accuracy of sentiment analysis based on these columns might be lower compared to using `V2Tone`, which is specifically designed for sentiment analysis. Combining the insights from these columns with the `V2Tone` data can provide a more comprehensive understanding of the overall sentiment.

# **4. Dynamics of Change in Tone**[¶]{.anchor-link}

## **4.1. Considering Two Methods**[¶]{.anchor-link}

Let\'s now consider methods for observing the dynamics of change in tone toward Netflix. There could be many approaches to this, but let\'s delve deeper into the two very basic simple methods for observing the dynamics of change in tone:

**Method 1: Averaging Tone for Each 15-Minute File and Comparing Average Scores**

This method prioritizes observing the overall sentiment trend towards Netflix over time by analyzing the average Tone score within consecutive 15-minute intervals. Here\'s a detailed breakdown of the process:

-   Data Acquisition and Filtering: The process begins by acquiring the relevant GDELT GKG data files for the desired time period, typically encompassing a series of 15-minute intervals. Each file contains information about various news articles and events captured during that specific 15-minute window. The next step is to filter these files to isolate news articles specifically related to Netflix, using keywords, entity mentions, or other relevant criteria.

-   Tone Extraction and Aggregation: Once the Netflix-related articles are identified within each file, the \"V2Tone\" column is extracted. This column contains a comma-separated string of values representing different sentiment components, including the overall Tone score. The \"V2Tone\" string is then parsed to isolate the Tone value, which is typically a numerical score indicating the sentiment expressed in the article. Tone scores are often normalized to a specific range, such as -100 to +100, with higher values indicating more positive sentiment. For each 15-minute file, the Tone scores of all the Netflix-related articles are aggregated by calculating their average. This average Tone score represents the overall sentiment toward Netflix during that specific 15-minute interval.

-   Time Series Construction and Analysis: The average Tone scores, along with their corresponding timestamps (usually the start time of each 15-minute interval), are then used to construct a time series. This time series provides a chronological view of how sentiment toward Netflix has evolved over the extended period. The time series can be visually inspected for patterns, trends, and significant shifts in sentiment. Additionally, various analytical techniques can be applied, including: moving averages, to smooth out short-term fluctuations and identify longer-term trends; volatility analysis, to quantify the variability of sentiment over time; and correlation with other data, such as stock prices or news events, to explore potential relationships.

-   Advantages: This method\'s primary advantage lies in its clear focus on observing the overall change in sentiment and its relative simplicity for implementation and interpretation. It\'s also computationally efficient, making it suitable for real-time applications or large datasets. However, it\'s worth noting that this method sacrifices some granularity by averaging individual article sentiments, and it might be sensitive to outliers. Additionally, it provides limited insight into the specific news stories or events that drive sentiment changes.

**Method 2: Combining All Samples and Analyzing Tone Elements for Individual Articles**

This method focuses on analyzing the sentiment expressed in individual news articles and its potential relationship to specific events or news stories. It provides a more granular and event-centric perspective compared to Method 1. Here\'s a detailed description:

-   Data Consolidation and Tone Extraction: All the GDELT GKG data files for the desired time period are merged into a single dataset. This consolidated dataset includes all Netflix-related articles and their associated information, including timestamps, Tone scores, and other relevant features. The \"V2Tone\" column is extracted for each article, and the Tone score is parsed and isolated, similar to Method 1.

-   Article-Level Sentiment Analysis: The Tone scores of individual articles are then analyzed, considering their timestamps and other relevant features such as themes, entities mentioned, or quotations. This analysis aims to understand the detailed sentiment expressed within specific news stories and how it might relate to the context or content of the article.

-   Event Detection and Correlation: This method allows for identifying specific events or news stories that coincide with significant changes in sentiment for individual articles. By examining the timestamps of articles with notable Tone scores, researchers can pinpoint potential triggers for sentiment shifts. Furthermore, the Tone scores can be correlated with other data sources, such as stock prices or news event databases, to explore relationships and understand the impact of specific events on sentiment toward Netflix.

-   Advantage: The advantage of this method lies in its detailed sentiment information and the potential for deeper analysis, including exploring the relationship between Tone and other article features. It also allows for understanding the impact of specific events on sentiment. However, this approach can be more computationally demanding and complex, potentially losing clear temporal information as it focuses on individual articles rather than aggregated trends. The interpretation of results might also require more effort due to the large volume of individual article sentiments.

## **4.2. Application of Method 1: Averaging Tone for Each 15-Minute File and Comparing Average Scores**[¶](#4.2.-Application-of-Method-1:-Averaging-Tone-for-Each-15-Minute-File-and-Comparing-Average-Scores){.anchor-link}

In this section, we will utilize Method 1. The below code downloads GDELT data for specific 15-minute intervals from 8 AM to 11:45 PM on September 23, 2024, filters for news related to Netflix, extracts sentiment information (Tone scores), and calculates the average sentiment for each interval. It does this efficiently by processing each data file in memory without saving it to disk, making it suitable for analyzing larger datasets:

In \[ \]:

``` calibre12
# Generate timestamps from 8 AM to 11:45 PM on September 23, 2024
start_time = datetime(2024, 9, 23, 8, 0, 0)
end_time = datetime(2024, 9, 23, 23, 45, 0)
timestamps = []
current_time = start_time
while current_time <= end_time:
    timestamps.append(current_time.strftime("%Y%m%d%H%M%S"))
    current_time += timedelta(minutes=15)

# Create a dictionary to store average Tone for each timestamp
avg_tones = {}

# Loop through timestamps, download, process, and discard each file
for timestamp in timestamps:
    url = f"http://data.gdeltproject.org/gdeltv2/{timestamp}.gkg.csv.zip"
    response = requests.get(url, stream=True)

    # Process the zip file in memory without extracting to disk
    with zipfile.ZipFile(io.BytesIO(response.content)) as zip_ref:
        for file_name in zip_ref.namelist():
            if file_name.endswith(".gkg.csv"):
                with zip_ref.open(file_name) as file:
                    # Specify the encoding as 'latin-1' to handle potential encoding issues
                    df = pd.read_csv(file, sep='\t', header=None,
                                     on_bad_lines='skip', # Skip lines with errors
                                     engine='python', # Use Python engine to handle large files
                                     encoding='latin-1') # Explicitly set encoding to 'latin-1'

                # Add column names (refer to GDELT documentation)
                gkg_columns = [
                    "GKGRECORDID", "DATE", "SourceCollectionIdentifier", "SourceCommonName",
                    "DocumentIdentifier", "Counts", "V2Counts", "Themes", "V2Themes",
                    "Locations", "V2Locations", "Persons", "V2Persons", "Organizations",
                    "V2Organizations", "V2Tone", "Dates", "GCAM", "SharingImage",
                    "RelatedImages", "SocialImageEmbeds", "SocialVideoEmbeds", "Quotations",
                    "AllNames", "Amounts", "TranslationInfo", "Extras"
                ]
                df.columns = gkg_columns

                # Filter for news related to Netflix
                netflix_news = df[df['Organizations'].str.contains("netflix", na=False)].copy()

                # Extract Tone components (similar to previous code)
                netflix_news[['Tone', 'Positive Score', 'Negative Score', 'Polarity', 'Activity', 'Self Direction', 'WordCount']] = netflix_news['V2Tone'].str.split(',', expand=True)
                numeric_columns = ['Tone', 'Positive Score', 'Negative Score', 'Polarity', 'Activity', 'Self Direction']
                netflix_news[numeric_columns] = netflix_news[numeric_columns].astype(float, errors='ignore').round(3) #ignore errors

                # Calculate and store average Tone
                avg_tone = netflix_news['Tone'].mean()
                avg_tones[timestamp] = avg_tone

    # File is automatically discarded when exiting the 'with' block

# Create a DataFrame from the avg_tones dictionary converting 'Timestamp' column to datetime objects
tone_df = pd.DataFrame(list(avg_tones.items()), columns=['Timestamp', 'AvgTone'])
tone_df['Timestamp'] = pd.to_datetime(tone_df['Timestamp'], format='%Y%m%d%H%M%S')
tone_df
```

Here, we first create a list of timestamps (timestamps) representing 15-minute intervals between 4 AM and 8 PM on September 23, 2024. These timestamps will be used to access the GDELT data files.

Then, we iterate through each timestamp to download GDELT Data, process Data, calculate Average Tone, and discard File. This code utilizes in-memory processing. In-memory processing is essential for GDELT data analysis due to its ability to handle large data volumes efficiently, enhance speed and responsiveness, improve scalability, optimize resource usage, and provide greater flexibility for analysis. By processing each file individually and discarding it before moving to the next, in-memory approaches enable researchers to extract meaningful insights from GDELT data without being constrained by storage limitations or performance bottlenecks.

Finally, we create a pandas DataFrame named the `avg_tones`, which contains timestamps and their corresponding average Tone scores for Netflix. This allows us to further analyze and visualize the sentiment dynamics over time.

### **4.2.1 Get Netflix Intraday Data**[¶]{.anchor-link}

Let\'s now get intraday stock price data for Netflix (NFLX) for September 23, 2024, using the `yfinance` library. The following code snippet downloads Netflix\'s 15-minute interval intraday stock data for September 23, 2024 (including pre- and post-market), saves it to a CSV file, and then displays it:

In \[ \]:

``` calibre12
# Download the intraday data using yfinance
nflx_intraday = yf.download(
    tickers='NFLX',
    start='2024-09-23',
    end='2024-09-24',
    interval='15m',
    prepost=True, auto_adjust = False)

# Save the data to a CSV file
nflx_intraday.to_csv("netflix_intraday_20240923.csv")

# Display DataFrame
nflx_intraday
```

**Important consideration for data availability:** Intraday data is typically available from Yahoo Finance for the past 60 days. As of this writing, available data was also downloaded and saved as \'WQUnetflix_intraday_20240923.csv\' for later retrieval. In case you run this notebook when intraday data is no longer available, please load data from the locally saved \'WQUnetflix_intraday_20240923.csv\' file for the remainder of this lesson.

In \[ \]:

``` calibre12
# Open saved DataFrame - OPTIONAL
nflx_intraday = pd.read_csv('WQU netflix_intraday_20240923.csv')
nflx_intraday.set_index('Datetime', inplace=True)
nflx_intraday
```

### **4.2.2 Netflix Intraday Data in Conjunction with Average Tone in News**[¶]{.anchor-link}

In previous code, we get intraday data for stock price data for Netflix. Please note the `prepost=True` parameter, which indicates whether to include pre-market and post-market data. In our case, we include pre- and post-market data. As you can see, the Volume column displays zeros before 9:30 AM (market open) and after 4:00 PM (market close). Yahoo uses the exchange\'s native time zone. For Netflix, it is NASDAQ located in New York City. On September 23 in New York, we observe Eastern Daylight Time (EDT), which is 4 hours behind the UTC timezone. Let\'s convert Datetime column values in the `nflx_intraday` DataFrame to UTC timezone:

In \[ \]:

``` calibre12
# Convert Datetime to UTC timezone
nflx_intraday.index = pd.to_datetime(nflx_intraday.index).tz_localize('America/New_York').tz_convert('UTC')
nflx_intraday
```

Let\'s now plot a candlestick chart. The candlestick charts are considered a valuable tool in financial technical analysis for several reasons. Their visual clarity in illustrating price action, ability to signal reversals, and widespread acceptance make them a valuable tool for financial technical analysis and informed trading decisions. The following code generates both the candlestick chart for `nflx_intraday` and the `tone_df` data on the same interactive plot. The code uses Plotly\'s graphing library, which enables us to interactively explore the visualization. We can zoom into a section of the visualization or hover over individual candlesticks/bars to glean precise values of stock price/volume at a specific time:

In \[ \]:

``` calibre12
# Create candlestick trace
candlestick_trace = go.Candlestick(x=nflx_intraday.index,
                                 open=nflx_intraday['Open'],
                                 high=nflx_intraday['High'],
                                 low=nflx_intraday['Low'],
                                 close=nflx_intraday['Close'],
                                 name='Netflix Price')

# Create tone trace
tone_trace = go.Scatter(x=tone_df['Timestamp'],
                        y=tone_df['AvgTone'],
                        mode='lines',
                        name='Average Tone',
                        line=dict(color='blue', width=1),
                        yaxis='y2')  # Assign to secondary y-axis

# Create figure with both traces
fig = go.Figure(data=[candlestick_trace, tone_trace])

# Update layout with secondary y-axis
fig.update_layout(title_text='Netflix Price and Average Tone',
                  yaxis_title='Price (USD)',
                  yaxis2=dict(title='Average Tone',
                              overlaying='y',
                              side='right'))
fig.show()
```

This code generates a chart with both the Netflix intraday candlestick chart and the average tone data plotted together, allowing us to visually analyze the relationship between price movements and sentiment changes.

Each candlestick represents the price movement of Netflix stock during a specific time interval. The green candlestick indicates a price increase during that interval. The bottom of the green candlestick represents the opening price, the top represents the closing price, and the lines (wicks) extending from the body represent the high and low prices during that interval. The red candlestick indicates a price decrease during that interval. The top of the red candlestick represents the opening price, the bottom represents the closing price, and the wicks represent the high and low prices.

The layout is updated to include a secondary y-axis on the right side (`yaxis2`) and set titles for both y-axes. The primary y-axis on the left represents the price (USD) of Netflix stock, and the secondary y-axis represents average tone values. Using separate y-axes allows for a clear and meaningful representation of both datasets without distorting their respective values. Now we can visually compare the price movements of Netflix stock with the changes in average sentiment over time. This can help to identify potential relationships or correlations between price and sentiment.

By observing the patterns and trends in the candlestick prices and the tone line, we can explore potential correlations and insights:

-   Positive Tone and Price: When the Tone line is high (positive sentiment) and the candlesticks are green (price increase), it could suggest that positive news coverage is having a favorable impact on Netflix\'s stock price. We can observe an abundance of news that is mostly positive in tone a few hours prior to market opening from about 10 AM. This could potentially explain green candlesticks at the opening time at 13:30.
-   Negative Tone and Price: Conversely, a low Tone line (negative sentiment) coinciding with red candlesticks (price decrease) could indicate that negative news is influencing the stock negatively.
-   Divergence: We can also observe that there are instances where the Tone line and candlestick patterns diverge. This might warrant further investigation. For example, positive news sentiment (high Tone) but a declining stock price (red candlesticks) could raise questions about other market factors at play.

Overall, the chart provides a visual tool to explore the potential link between sentiment (Tone) derived from GDELT data and Netflix\'s stock price movement. It enables analysts and traders to observe correlations, spot potential trends, and make more informed decisions. Remember that this is just one aspect of analysis, and many other factors influence stock prices. The chart shows potential correlations, but further investigation is needed to establish any causal relationships between sentiment and price movement. Numerous other factors, such as market trends, economic news, and company-specific developments, can impact stock prices. We should also consider that the Tone score is just one measure of sentiment and may not capture all nuances of news coverage.

## **4.3. Possible Financial Engineering Scenarios**[¶]{.anchor-link}

We explored an application of Method 1 in the previous example. By strategically selecting and applying these methods, financial engineers can leverage sentiment analysis to gain valuable insights, inform decision-making, and enhance their strategies across various applications. Here are some potential financial engineering scenarios where observing the dynamics of change in tone toward Netflix can be applied:

**Method 1: Averaging Tone for Each 15-Minute File and Comparing Average Scores**

This method, focusing on overall sentiment trends, is particularly useful for scenarios demanding real-time or near real-time analysis and decision-making due to its efficiency in capturing broad sentiment shifts. Here\'s a closer look at some key applications:

-   **Real-Time Sentiment-Based Trading:** This scenario involves leveraging real-time sentiment data to inform trading decisions. By tracking the average Tone score for Netflix across consecutive 15-minute intervals, traders can identify emerging trends in market sentiment. For instance, if the average Tone score consistently exceeds a predefined positive threshold, it might signal an increasing positive sentiment toward Netflix, potentially leading to a price increase. This could trigger a buy signal for automated trading systems or inform a trader\'s decision to enter a long position. Conversely, a sustained drop in the average Tone score below a negative threshold could indicate growing negative sentiment and a potential price decline, prompting a sell signal or a short position.

-   **Risk Management and Portfolio Allocation:** Risk management is crucial in financial engineering, and sentiment analysis can play a significant role in assessing and mitigating risk associated with investments. By monitoring the average Tone scores for Netflix, portfolio managers can gain insights into the level of uncertainty or negativity surrounding the company. A significant and sustained drop in sentiment could indicate heightened risk, prompting a reassessment of portfolio exposure. In such cases, risk managers might consider reducing their allocation to Netflix or implementing hedging strategies to protect against potential losses. Conversely, a period of consistently positive sentiment could signal lower risk and potentially justify increasing exposure to Netflix within the portfolio.

-   **Market Microstructure Analysis:** This scenario delves into the intricate dynamics of how news and sentiment impact short-term price movements of Netflix stock. By correlating the average Tone scores with high-frequency price data, researchers can identify patterns and relationships between sentiment changes and price fluctuations. For example, a sudden spike in positive sentiment might be followed by a rapid increase in Netflix\'s stock price, indicating a strong correlation between sentiment and market reaction. Understanding these relationships can help traders anticipate price movements and potentially identify arbitrage opportunities.

-   **Sentiment-Driven Event Detection:** This scenario involves using sentiment analysis to detect significant events or news stories that trigger notable shifts in sentiment toward Netflix. By analyzing the time series of average Tone scores for sudden spikes or drops, researchers can pinpoint potential triggers for sentiment change. For instance, a sudden drop in sentiment might coincide with a negative news report or a regulatory announcement affecting Netflix. Identifying these events in real time enables proactive responses and informed decision-making, helping traders and investors adjust their strategies accordingly.

**Method 2: Combining All Samples and Analyzing Tone Elements for Individual Articles**

This method, providing granular sentiment information for individual articles, is more suitable for scenarios requiring in-depth analysis and understanding the context behind sentiment changes. Here\'s a closer look at some key applications:

-   **Event-Driven Trading Strategies:** This scenario involves developing trading strategies based on the sentiment expressed in specific news articles or events related to Netflix. By analyzing the Tone scores of individual articles, traders can identify those with strong positive or negative sentiment. For instance, a highly positive article discussing a successful new Netflix original series might trigger a buy signal, while a negative article highlighting subscriber churn could prompt a sell signal. This approach allows traders to capitalize on market reactions to specific information and events.

-   **Fundamental Analysis:** Fundamental analysis plays a crucial role in investment decision-making, and incorporating sentiment analysis can provide valuable insights. By analyzing the Tone scores of articles related to Netflix\'s earnings reports, product launches, or other significant events, analysts can gauge market perception and assess the potential impact on financial performance. For example, if articles discussing Netflix\'s latest earnings report express overwhelmingly positive sentiment, it might reinforce a positive outlook for the company\'s future prospects. Conversely, negative sentiment surrounding a new product launch could raise concerns about market acceptance and potential impact on revenue.

-   **Competitive Analysis:** Understanding the competitive landscape is essential for strategic decision-making in financial engineering. Sentiment analysis can help track sentiment toward Netflix and its competitors, providing insights into market dynamics and potential opportunities or threats. By analyzing the Tone scores of articles mentioning Netflix and its competitors, analysts can identify shifts in competitive positioning and market perception. For example, a surge in positive sentiment toward a competitor\'s new streaming service might signal a potential threat to Netflix\'s market share, while a decline in negative sentiment toward Netflix could indicate an improving competitive outlook.

In essence, while both methods provide valuable insights for financial engineering applications, they cater to different needs and scenarios:

-   Method 1 (averaging Tone scores) is ideal for real-time or near real-time analysis of overall sentiment trends, enabling rapid decision-making in trading, risk management, and market microstructure analysis. Its focus on aggregated sentiment makes it well-suited for capturing broad market sentiment shifts.

-   Method 2 (analyzing individual Tone elements) is more appropriate for in-depth analysis of individual articles and their impact on sentiment, providing a more nuanced understanding of specific events and their potential consequences. This method is often used for fundamental analysis and competitive intelligence, where understanding the context behind sentiment changes is crucial.

## **5. Conclusion**[¶]{.anchor-link}

In this lesson, we embarked on a practical exploration of two large-scale news datasets, Common Crawl News Crawl and GDELT, with a focus on their applications in financial engineering. We delved into accessing and processing raw news articles from Common Crawl\'s WARC files, learning how to extract key information, filter by language and keywords, and utilize the Python libraries for efficient article content extraction. Furthermore, we explored GDELT\'s GKG data, discovering techniques to analyze news events, entities, and sentiment. We learned how to download, filter, and analyze GDELT\'s Tone scores to gain valuable sentiment insights. Through this lesson, we learned how to leverage these datasets for financial research and analysis.

**References**

-   Brown, Tom B., et al. \"Language Models are Few-Shot Learners.\" *Proceedings of the 34th International Conference on Neural Information Processing Systems*, no. 159, 2020, pp. 1877-1901. <https://dl.acm.org/doi/abs/10.5555/3495724.3495883>.

-   THE GDELT Project. *The GDELT Global Knowledge Graph (GKG) Data Format Codebook*. v2.1, 2015. <http://data.gdeltproject.org/documentation/GDELT-Global_Knowledge_Graph_Codebook-V2.1.pdf>.

------------------------------------------------------------------------

Copyright 2024 WorldQuant University. This content is licensed solely for personal use. Redistribution or publication of this material is strictly prohibited.

In \[ \]:

``` calibre12
 
```
