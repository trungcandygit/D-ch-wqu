## **4.3 NMF Application**

After creating the `dtm`, we can now apply NMF to this matrix to discover underlying topics in the financial news articles. We are going to do this with `n_components=5` parameter that specifies the number of topics (or components) we want to extract from the data. In this case, we're aiming for five topics.
`random_state=42` sets a random seed for reproducibility. Using the same seed ensures that we get the same results each time we run the code:



```python
# NMF
nmf_model = NMF(n_components=5, random_state=42) # 5 topics
W = nmf_model.fit_transform(dtm)
H = nmf_model.components_

```

NMF is used to discover underlying topics in text data. It decomposes the document-term matrix into two lower-dimensional matrices that represent the relationships between words and topics and between topics and documents. Now we have obtained:

 - $W$ (Document-Topic Matrix) represents the distribution of topics within each document. Each row in $W$ corresponds to a document in corpus, and each column corresponds to a topic discovered by NMF. The values in $W$ indicate the weight or probability of each topic being present in each document.
 - $H$ (Topic-Word Matrix) represents the distribution of words within each topic. Each row in $H$ corresponds to a topic, and each column corresponds to a word in vocabulary. The values in $H$ indicate the weight or importance of each word within each topic.

The `n_components=5` parameter determines the number of topics (or components) we want to extract from data. In our case, we're aiming to discover five distinct topics within the financial news articles related to Microsoft. A smaller number of topics (like five) often leads to more interpretable results. It's easier to understand and assign meaningful labels to five topics compared to, say, 20 or 50 topics. When starting with topic modeling, it's often a good practice to begin with a smaller number of topics and then gradually increase it if needed. This makes it possible to get a general understanding of the main themes in the data before diving into more granular analysis. A smaller number of topics also reduces the computational cost of NMF, making the process faster, especially for larger datasets.

