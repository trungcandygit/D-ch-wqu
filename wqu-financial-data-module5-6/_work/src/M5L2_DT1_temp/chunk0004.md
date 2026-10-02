3.1.5 BERT. BERT [3] is in essence a language model that consists
of a set of Transformer encoders stacked on top of each other.
However it defines the language modeling task differently from
ELMo and AWD-LSTM. Instead of predicting the next word given
previous ones, BERT "masks" a randomly selected 15% of all tokens.
With a softmax layer over vocabulary on top of the last encoder
layer the masked tokens are predicted. A second task BERT is
trained on is "next sentence prediction". Given two sentences, the
model predicts whether or not these two actually follow each other.
The input sequence is represented with token and position embeddings. Two tokens denoted by [CLS] and [SEP] are added to the
beginning and end of the sequence respectively. For all classification tasks, including the next sentence prediction, [CLS] token is
used.
BERT has two versions: BERT-base, with 12 encoder layers, hidden size of 768, 12 multi-head attention heads and 110M parameters
in total and BERT-large, with 24 encoder layers, hidden size of
1024, 16 multi-head attention heads and 340M parameters. Both of
these models have been trained on BookCorpus [33] and English
Wikipedia, which have in total more than 3,500M words 3 .

3.1.2 ELMo. ELMo embeddings [23] are contextualized word representations in the sense that the surrounding words influence
the representation of the word. In the center of ELMo, there is
a bidirectional language model with multiple LSTM layers. The
goal of a language model is to learn the probability distribution
over sequences of tokens in a given vocabulary. ELMo models the
probability of a token given the previous (and separately following)
tokens in the sequence. Then the model also learns how to weight
different representations from different LSTM layers in order to
calculate one contextualized vector per token. Once the contextualized representations are extracted, these can be used to initialize
any down-stream NLP task2 .
3.1.3 ULMFit. ULMFit is a transfer learning model for down-stream
NLP tasks, that make use of language model pre-training [5]. Unlike ELMo, with ULMFit, the whole language model is fine-tuned
together with the task-specific layers. The underlying language
model used in ULMFit is AWD-LSTM, which uses sophisticated
dropout tuning strategies to better regularize its LSTM model [21].
For classification using ULMFit two linear layers are added to the
pre-trained AWD-LSTM, first of which takes the pooled last hidden
states as input.
ULMFit comes with novel training strategies for further pretraining the language model on domain-specific corpus and finetuning on the down-stream task. We implement these strategies
with FinBERT as explained in section 3.2.
1 The

pre-trained
weights
for
GLoVE
can
be
found
https://nlp.stanford.edu/projects/glove/
2 The pre-trained ELMo models can be found here: https://allennlp.org/elmo

3.2

BERT for financial domain: FinBERT

In this subsection we will describe our implementation of BERT: 1)
how further pre-training on domain corpus is done, 2-3) how we
implemented BERT for classification and regression tasks, 4) training strategies we used during fine-tuning to prevent catastrophic
forgetting.
3.2.1 Further pre-training. Howard and Ruder (2018) [5] shows
that futher pre-training a language model on a target domain corpus
improves the eventual classification performance. For BERT, there
is not decisive research showing that would be the case as well.

here:
3 The pre-trained weights are made public by creators of BERT. The code and weights

can be found here: https://github.com/google-research/bert
3

Table 1: Distribtution of sentiment labels and agreement levels in Financial PhraseBank

Regardless, we implement further pre-training in order to observe
if such adaptation is going to be beneficial for financial domain.
For further pre-training, we experiment with two approaches.
The first is pre-training the model on a relatively large corpus from
the target domain. For that, we further pre-train a BERT language
model on a financial corpus (details of the corpus can be found on
section 4.2.1). The second approach is pre-training the model only
on the sentences from the training classification dataset. Although
the second corpus is much smaller, using data from the direct target
might provide better target domain adaptation.
3.2.2 FinBERT for text classification. Sentiment classification is
conducted by adding a dense layer after the last hidden state of the
[CLS] token. This is the recommended practice for using BERT for
any classification task [3]. Then, the classifier network is trained on
the labeled sentiment dataset. An overview of all the steps involved
in the procedure is presented on figure 1.

Agreement level

Positive

Negative

Neutral

Count

100%
75% - 99%
66% - 74%
50% - 65%

%25.2
%26.6
%36.7
%31.1

%13.4
%9.8
%12.3
%14.4

%61.4
%63.6
%50.9
%54.5

2262
1191
765
627

All

%28.1

%12.4

%59.4

4845

(RQ2) How does FinBERT compare to the state-of-the-art in financial sentiment analysis with targets discrete or continuous?
(RQ3) How does futher pre-training BERT on financial domain, or
target corpus, affect the classification performance?
(RQ4) What are the effects of training strategies like slanted triangular learning rates, discriminative fine-tuning and gradual
unfreezing on classification performance? Do they prevent
catastrophic forgetting?
(RQ5) Which encoder layer performs best (or worse) for sentence
classification?
(RQ6) How much fine-tuning is enough? That is, after pre-training,
how many layers should be fine-tuned to achieve comparable
performance to fine-tuning the whole model?
