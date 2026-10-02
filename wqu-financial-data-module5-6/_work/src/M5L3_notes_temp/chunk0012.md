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
