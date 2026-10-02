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
