| Practical Example: Cleaning Customer Survey Responses with Google DataPrep                                                                                                           |
|                                                                                                                                                                                      |
| 1\. Setup and Data Import                                                                                                                                                            |
|                                                                                                                                                                                      |
| Access Google DataPrep                                                                                                                                                               |
|                                                                                                                                                                                      |
| In your Google Cloud Console, navigate to the "Dataprep" section (often listed under "Big Data" or "Data Analytics").                                                                |
|                                                                                                                                                                                      |
| If this is your first time, create a new **DataPrep flow** or project by following the on-screen instructions to connect to your Google Cloud Storage (GCS) bucket.                  |
|                                                                                                                                                                                      |
| Upload or Connect to Your Dataset                                                                                                                                                    |
|                                                                                                                                                                                      |
| Place your raw files (e.g., CSV, Excel, or JSON) into a Google Cloud Storage bucket.                                                                                                 |
|                                                                                                                                                                                      |
| In DataPrep, click **"Import Datasets"**, then select your source. The tool will generate a preview and automatically sample the data.                                               |
|                                                                                                                                                                                      |
| Initial Data Assessment                                                                                                                                                              |
|                                                                                                                                                                                      |
| DataPrep automatically generates a **data quality overview**, highlighting issues like missing values or type mismatches.                                                            |
|                                                                                                                                                                                      |
| Explore each column's **profile** (distribution, min/max values) to spot potential errors[][]{.text_5} (e.g., unexpected symbols, out-of-range values). |
|                                                                                                                                                                                      |
| 2\. Text Standardization                                                                                                                                                             |
|                                                                                                                                                                                      |
| Locate and Select Free-Text Columns                                                                                                                                                  |
|                                                                                                                                                                                      |
| Identify columns like "Customer_Comments" or "Feedback_Text."                                                                                                                        |
|                                                                                                                                                                                      |
| Click on a column header to access transformation options.                                                                                                                           |
|                                                                                                                                                                                      |
| Use Built-In "Text Cleanup" Functions                                                                                                                                                |
|                                                                                                                                                                                      |