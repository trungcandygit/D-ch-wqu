# **4. Scenario: Topic Modeling of Financial News**

We will now use the News API data to discover underlying topics in financial news articles related to Microsoft and analyze sentiment associated with each topic.

**Topic modeling** is an unsupervised machine learning technique used to discover hidden thematic structures or topics within a collection of documents (also known as a **corpus**). It aims to automatically identify groups of words that frequently co-occur in documents, representing underlying themes or subjects. Topic modeling algorithms typically work by assuming that each document is a mixture of a small number of topics, and each topic is characterized by a distribution of words. The goal is to learn these topic distributions and the document-topic assignments.

Key terminology:

 - **Document:** A single unit of text, such as an article, blog post, or tweet.
 - **Corpus:** A collection of documents.
 - **Topic:** A hidden thematic structure or theme within the corpus, represented by a distribution of words.
 - **Document-Topic Distribution:** The probability or weight of each topic within each document.
 - **Topic-Word Distribution:** The probability or weight of each word within each topic.

Non-negative matrix factorization (NMF) is a powerful technique for discovering hidden topics in text data. By applying it to financial news, we can uncover the main themes being discussed about Microsoft. Combining topic modeling with sentiment analysis provides a deeper understanding of the sentiment associated with different topics. This can help identify areas of positive or negative perception toward the company. The insights gained from this analysis can inform investment decisions, risk management, and public relations strategies.

**Implementation steps:**

 - **Data Preparation:** We will use the existing `df` DataFrame containing News API data selecting the 'Description' column as the text data for analysis. We will preprocess the text data (remove stop words, punctuation, stemming/lemmatization).

 - **Document-Term Matrix (TDM) Creation:** Then we will create a document-term matrix using TF-IDF (Term Frequency-Inverse Document Frequency). This matrix represents the frequency or importance of each word in each document.

 - **NMF Application:** We apply NMF to the document-term matrix to decompose it into two matrices: $W$ matrix representing the importance of each topic in each document and $H$ matrix representing the importance of each word in each topic.

 - **Topic Extraction and Interpretation:** Access the topic-word matrix ($H$) in order to examine the top words for each topic. Identify the words with the highest weights in each row of $H$ to understand the theme of each topic. Based on the top words, we give meaningful names to the topics to make them interpretable.

 - **Document-Topic Assignment:** Obtain the document-topic matrix ($W$) in order to assign dominant topics to documents. For each document, we find the topic with the highest weight in the corresponding row of $W$. This assigns the most prominent topic to each document.





