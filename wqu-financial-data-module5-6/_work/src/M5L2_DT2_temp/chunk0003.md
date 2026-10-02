# of tokens
2.5B
1.3B
1.1B

Table 1: Size of pretraining financial corpora.

4 FinBERT Training
Vocabulary We construct FinVocab, a new WordPiece vocabulary on our financial corpora using
the SentencePiece library. We produce both cased
and uncased versions of FinVocab, with sizes of
2

https://seekingalpha.com/

28,573 and 30,873 tokens respectively. This is
very similar to the 28,996 and 30,522 token sizes
of the original BERT cased and uncased BaseVocab. The resulting overlap between between the
original BERT BaseVocab, and FinVocab is 41%
for both the cased and uncased versions.
FinBERT-Variants We use the original BERT
code 3 to train FinBERT on our financial corpora
with the same configuration as BERT-Base. Following the original BERT training, we set a maximum sentence length of 128 tokens, and train the
model until the training loss starts to converge.
We then continue training the model allowing sentence lengths up to 512 tokens. In particular, we
train four different versions of FinBERT: cased or
uncased; BaseVocab or FinVocab.
FinBERT-BaseVocab, uncased/cased: Model
is initialized from the original BERT-Base uncased/cased model, and is further pretrained on the
financial corpora for 250K iterations at a smaller
learning rate of 2e−5 , which is recommended by
BERT code.
FinBERT-FinVocab, uncased/cased: Model
is trained from scratch using a new uncased/cased
financial vocabulary FinVocab for 1M iterations.
Training The entire training is done using a
NVIDIA DGX-1 machine. The server has 4 Tesla
P100 GPUs, providing a total of 128 GB of GPU
memory. This machine enables us to train the
BERT models using a batch size of 128. We utilize Horovord framework (Sergeev and Del Balso,
2018) for multi-GPU training. Overall, the total
time taken to perform pretraining for one model
is approximately 2 days. With the release of
FinBERT, we hope financial practitioners and researchers can benefit from FinBERT model without the necessity of the significant computational
resources required to train the model.

5 Financial Sentiment Experiments
Given the importance of sentiment analysis in financial NLP tasks, we conduct experiments on financial sentiment classification datasets.
5.1

Dataset

Financial Phrase Bank is a public dataset
for financial sentiment classification (Malo et al.,
2014). The dataset contains 4,840 sentences selected from financial news. The dataset is manually labeled by 16 researchers with adequate back3

https://github.com/google-research/bert

ground knowledge on financial markets. The sentiment label is either positive, neutral or negative.
AnalystTone Dataset is a dataset to gauge
the opinions in analyst reports, which is commonly used in Accounting and Finance literature
(Huang et al., 2014). The dataset contains randomly selected 10,000 sentences from analyst reports in the Investext database. Each sentence is
manually annotated into one of three categories:
positive, negative and neutral. This classification
yields a total of 3,580 positive, 1,830 negative, and
4,590 neutral sentences in the dataset.
FiQA Dataset is an open challenge dataset for financial sentiment analysis, containing 1,111 text
sentences 4 . Given an English text sentence in the
financial domain (microblog message, news statement), the task of this challenge is to predict the
associated numeric sentiment score, ranged from 1 to 1. We convert the original regression task into
a binary classification task for consistent comparison with the above two datasets.
We randomly split each dataset into 90% training and 10% testing 10 times and report the average. Since all dataset are used for sentiment classification, we report the accuracy metrics in the
experiments.
5.2 Fine-tune Strategy
We follow the same fine-tune architecture and optimization choices used in (Devlin et al., 2019).
We use a simple linear layer, as our classification
layer, with a softmax activation function. We also
use cross-entropy loss as the loss function. Note
that an alternative is to feed the contextualized
word embeddings of each token into a deep architectures, such as Bi-LSTM, atop frozen BERT
embeddings. We choose not to use this strategy as
it has shown to perform significantly worse than
fine-tune BERT model (Beltagy et al., 2019).
5.3 Experiment Results
We compare FinBERT with original BERT-Base
model (Devlin et al., 2019), and we evaluate both
cased and uncased versions of this model. The
main results of financial sentiment analysis tasks
are present in Table 2.
FinBERT vs. BERT The results show substantial
improvement of FinBERT models over the generic
BERT models. On PhraseBank dataset, the best
model uncased FinBERT-FinVocab achieves the
4

https://sites.google.com/view/fiqa/home

PhraseBank
FiQA
AnalystTone

BERT
cased uncased
0.755
0.835
0.653
0.730
0.840
0.850

FinBERT-BaseVocab
cased
uncased
0.856
0.870
0.767
0.796
0.872
0.880

FinBERT-FinVocab
cased
uncased
0.864
0.872
0.814
0.844
0.876
0.887

Table 2: Performance of different BERT models on three financial sentiment analysis tasks.

BaseVocab
FinVocab

PhraseBank
FiQA
AnalystTone
PhraseBank
FiQA
AnalystTone

10-Ks/10-Qs
0.835
0.707
0.845
0.847
0.766
0.858

Earnings Call
0.843
0.731
0.862
0.860
0.778
0.870

Analyst Reports
0.845
0.744
0.871
0.861
0.796
0.872

All
0.856
0.767
0.872
0.864
0.814
0.876

Table 3: Performance of pretraining on different financial corpus.
