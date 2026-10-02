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
