## **3.4 How to Enhance Sentiment Analysis**[¶]{.anchor-link}

Besides the `V2Tone` column, there are other columns in the GDELT GKG 2.0 dataset that we could potentially use to enhance sentiment analysis:

**Themes and V2Themes:** These columns contain a list of themes identified in the article. We can use this to identify themes related to positive or negative sentiment (e.g., \"ECON_INFLATION\" might be associated with negative sentiment). We can create a dictionary mapping themes to sentiment scores and use it to analyze the sentiment associated with the themes present in the articles.

We can use these columns to create a sentiment dictionary or lexicon based on the co-occurrence of specific themes with positive or negative keywords. We can then use this lexicon to score the sentiment of articles based on the presence of these themes or names.

**Quotations:** This column contains direct quotations from the article. Analyzing the sentiment of these quotations can provide a more nuanced understanding of the sentiment expressed in the article. We can apply sentiment analysis techniques directly to the text of the quotations to get a more granular understanding of the sentiment expressed.

**GCAM:** GCAM stands for Global Content Analysis Measures. This column in the GKG dataset provides a comprehensive set of content analysis measures derived from applying Google\'s Cloud Vision API to the images and videos associated with a news article. This column contains the output of Google\'s Cloud Vision API, which can include labels and descriptions of images associated with the article. These labels and descriptions can sometimes provide clues about the sentiment of the article. We can apply sentiment analysis to the text extracted from the GCAM data to infer sentiment related to the visual content of the article.

We can extract text from the GCAM data and apply sentiment analysis models to this text to infer the sentiment associated with visual content.

**AllNames:** This column contains a list of all names mentioned in the article. This could be used to identify individuals or entities that are frequently associated with positive or negative sentiment. By analyzing the sentiment associated with the mentioned names, we can potentially identify key influencers or stakeholders driving the overall sentiment.

Important Considerations: These columns might require more pre-processing and analysis compared to the `V2Tone` column. Also, the accuracy of sentiment analysis based on these columns might be lower compared to using `V2Tone`, which is specifically designed for sentiment analysis. Combining the insights from these columns with the `V2Tone` data can provide a more comprehensive understanding of the overall sentiment.
