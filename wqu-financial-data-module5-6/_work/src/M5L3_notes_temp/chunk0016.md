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
