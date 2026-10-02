• We introduce FinBERT, which is a language model based on
BERT for financial NLP tasks. We evaluate FinBERT on two
financial sentiment analysis datasets.
• We achieve the state-of-the-art on FiQA sentiment scoring
and Financial PhraseBank.
• We implement two other pre-trained language models, ULMFit and ELMo for financial sentiment analysis and compare
these with FinBERT.
• We conduct experiments to investigate several aspects of
the model, including: effects of further pre-training on financial corpus, training strategies to prevent catastrophic
forgetting and fine-tuning only a small subset of model layers for decreasing training time without a significant drop
in performance.
The rest of the thesis is structured as follows: First, relevant literature in both financial polarity analysis and pre-trained language
models are discussed (Section 2). Then, the evaluated models are
described (Section 3). This is followed by the description of the
experimental setup being used (Section 4). In Section 5, we present
1

the experimental results on the financial sentiment datasets. Then
we further analyze FinBERT from different perspectives in Section
6. Finally, we conclude with Section 7.

2

Even when their first (word embedding) layers are initialized with
pre-trained values, the rest of the model still needs to learn complex
relations with relatively small amount of labeled data. A more
promising solution could be initializing almost the entire model
with pre-trained values and fine-tuning those values with respect
to the classification task.

RELATED LITERATURE

This section describes previous research conducted on sentiment
analysis in finance (2.1) and text classification using pre-trained
language models (2.2).

2.2
2.1

Sentiment analysis in finance

Sentiment analysis is the task of extracting sentiments or opinions
of people from written language [10]. We can divide the recent
efforts into two groups: 1) Machine learning methods with features
extracted from text with "word counting" [1, 19, 28, 30], 2) Deep
learning methods, where text is represented by a sequence of embeddings [2, 25, 32]. The former suffers from inability to represent
the semantic information that results from a particular sequence of
words, while the latter is often deemed as too "data-hungry" as it
learns a much higher number of parameters [18].
Financial sentiment analysis differs from general sentiment analysis not only in domain, but also the purpose. The purpose behind
financial sentiment analysis is usually guessing how the markets
will react with the information presented in the text [9]. Loughran
and McDonald (2016) presents a thorough survey of recent works
on financial text analysis utilizing machine learning with "bag-ofwords" approach or lexicon-based methods [12]. For example, in
Loughran and McDonald (2011), they create a dictionary of financial terms with assigned values such as "positive" or "uncertain"
and measure the tone of a documents by counting words with a specific dictionary value [11]. Another example is Pagolu et al. (2016),
where n-grams from tweets with financial information are fed into
supervised machine learning algorithms to detect the sentiment
regarding the financial entity mentioned.
On of the first papers that used deep learning methods for textual financial polarity analysis was Kraus and Feuerriegel (2017) [7].
They apply an LSTM neural network to ad-hoc company announcements to predict stock-market movements and show that method
to be more accurate than traditional machine learning approaches.
They find pre-training their model on a larger corpus to improve
the result, however their pre-training is done on a labeled dataset,
which is a more limiting approach then ours, as we pre-train a
language model as an unsupervised task.
There are several other works that employ various types of
neural architectures for financial sentiment analysis. Sohangir et al.
(2018) [26] apply several generic neural network architectures to
a StockTwits dataset, finding CNN as the best performing neural
network architecture. Lutz et al. 2018 [13] take the approach of using
doc2vec to generate sentence embeddings in a particular company
ad-hoc announcement and utilize multi-instance learning to predict
stock market outcomes. Maia et al. (2018) [14] use a combination of
text simplification and LSTM network to classify a set of sentences
from financial news according to their sentiment and achieve stateof-the-art results for the Financial PhraseBank, which is used in
thesis as well.
Due to lack of large labeled financial datasets, it is difficult to
utilize neural networks to their full potential for sentiment analysis.

Text classification using pre-trained
language models
