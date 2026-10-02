## **4.2 Feature Extraction - Document-Term Matrix (TDM)**

In the following code snippet, we fit the `TfidfVectorizer` vectorizer to our data in the 'Processed_Description' column. We apply the `TfidfVectorizer` vectorizer with the `max_features=250` parameter that limits the vocabulary size to the 250 most frequent words. This helps reduce the dimensionality of the document-term matrix (DTM) and can improve performance. We also use a `stop_words='english'` parameter that removes common English words (like "the," "a," "is") from the vocabulary, as they often don't carry much meaningful information. This will convert the text data in 'Processed_Description' into a document-term matrix (DTM) represented by the variable `dtm`:


```python
# TF-IDF Vectorization
vectorizer = TfidfVectorizer(max_features=250, stop_words='english')
dtm = vectorizer.fit_transform(df['Processed_Description'])
dtm.shape
```

The `dtm` variable now holds a sparse matrix where:
- Each row represents a document (a news article in our case).
- Each column represents a word (or feature) from the vocabulary.
- The values in the matrix represent the TF-IDF score of each word in each document.  
- The `dtm` is typically stored as a sparse matrix to save memory because it often contains many zero values.

The typical range for `max_features` is usually between 1000 and 5000, but it can vary widely depending on the dataset and task depending on such factors as dataset size, task complexity, computation resources, experimentation, etc. For a dataset such as ours with only about 90 rows, a `max_features` value between 100 and 500 would likely be a good starting point for keeping balance between dimensionality and information.


