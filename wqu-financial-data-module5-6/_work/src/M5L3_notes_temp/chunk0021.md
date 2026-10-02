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
