| Run the "Data Health" Scan                                                                                                                                                           |
|                                                                                                                                                                                      |
| This scan identifies anomalies such as out-of-range rating scores (e.g., "12" in a 1--10 rating) or invalid email formats.                                                           |
|                                                                                                                                                                                      |
| You'll see flagged issues in a sidebar or error summary.                                                                                                                             |
|                                                                                                                                                                                      |
| Review and Apply Suggested Fixes                                                                                                                                                     |
|                                                                                                                                                                                      |
| **Standardize Rating Scores**: If a rating is "12," you might choose to set it to "10" or mark it as invalid.                                                                        |
|                                                                                                                                                                                      |
| **Correct Date Formats**: DataPrep can parse mixed date formats (e.g., "MM/DD/YYYY" vs. "DD/MM/YYYY") and convert them into a single standardized pattern.                           |
|                                                                                                                                                                                      |
| **Repair Invalid Emails**: The tool can remove or fix domain typos like "@gamil.com."                                                                                                |
|                                                                                                                                                                                      |
| Mark Persistent Issues as Exceptions                                                                                                                                                 |
|                                                                                                                                                                                      |
| If some flagged entries are actually valid edge cases, mark them as acceptable rather than errors[][]{.text_5}.                                         |
|                                                                                                                                                                                      |
| 5\. Data Enrichment and Validation                                                                                                                                                   |
|                                                                                                                                                                                      |
| Derived Columns                                                                                                                                                                      |
|                                                                                                                                                                                      |
| Create new columns using existing fields (e.g., calculating an "Age Group" based on date of birth).                                                                                  |
|                                                                                                                                                                                      |
| Add rules to handle borderline cases (e.g., if the date of birth is before 1900, mark as "Potential Error").                                                                         |
|                                                                                                                                                                                      |
| Postal Code Validation                                                                                                                                                               |
|                                                                                                                                                                                      |
| For demographic data, enable region-specific checks (e.g., US ZIP codes vs. Canadian postal codes).                                                                                  |
|                                                                                                                                                                                      |
| DataPrep can highlight mismatches, prompting you to fix or remove invalid records.                                                                                                   |
|                                                                                                                                                                                      |