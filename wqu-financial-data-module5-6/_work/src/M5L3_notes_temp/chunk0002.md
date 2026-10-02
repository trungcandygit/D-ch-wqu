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
