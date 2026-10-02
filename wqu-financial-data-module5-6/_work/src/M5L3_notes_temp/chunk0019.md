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
