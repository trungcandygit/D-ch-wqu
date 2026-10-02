3.2.3 FinBERT for regression. While the focus of this paper is classification, we also implement regression with almost the same
architecture on a different dataset with continuous targets. The
only difference is that the loss function being used is mean squared
error instead of the cross entropy loss.
3.2.4 Training strategies to prevent catastrophic forgetting. As it
was pointed out by Howard and Ruder (2018) [5], catastrophic
forgetting is a significant danger with this fine-tuning approach.
Because the fine-tuning procedure can quickly cause model to
"forget" the information from language modeling task as it tries to
adapt to the new task. In order to deal with this phenomenon, we
apply three techniques as it was proposed by Howard and Ruder
(2018): slanted triangular learning rates, discriminative fine-tuning
and gradual unfreezing.
Slanted triangular learning rate applies a learning rate schedule
in the shape of a slanted triangular, that is, learning rate first linearly
increases up to some point and after that point linearly decreases.
Discriminative fine-tuning is using lower learning rates for lower
layers on the network. Assume our learning rate at layer l is α. Then
for discrimination rate of θ we calculate the learning rate for layer
l − 1 as αl −1 = θαl . The assumption behind this method is that the
lower layers represent the deep-level language information, while
the upper ones include information for actual classification task.
Therefore we fine-tune them differently.
With gradual freezing, we start training with all layers but the
classifier layer as frozen. During training we gradually unfreeze all
of the layers starting from the highest one, so that the lower level
features become the least fine-tuned ones. Hence, during the initial
stages of training it is prevented for model to "forget" low-level
language information that it learned from pre-training.

4.2

Datasets

4.2.1 TRC2-financial. In order to further pre-train BERT, we use
a financial corpus we call TRC2-financial. It is a subset of Reuters’
TRC24 , which consists of 1.8M news articles that were published
by Reuters between 2008 and 2010. We filter for some financial
keywords in order to make corpus more relevant and in limits with
the compute power available. The resulting corpus, TRC2-financial,
includes 46,143 documents with more than 29M words and nearly
400K sentences.
4.2.2 Financial PhraseBank. The main sentiment analysis dataset
used in this paper is Financial PhraseBank5 from Malo et al. 2014
[17]. Financial Phrasebank consists of 4845 english sentences selected randomly from financial news found on LexisNexis database.
These sentences then were annotated by 16 people with background
in finance and business. The annotators were asked to give labels
according to how they think the information in the sentence might
affect the mentioned company stock price. The dataset also includes
information regarding the agreement levels on sentences among
annotators. The distribution of agreement levels and sentiment
labels can be seen on table 1. We set aside 20% of all sentences as
test and 20% of the remaining as validation set. In the end, our train
set includes 3101 examples. For some of the experiments, we also
make use of 10-fold cross validation.

4 EXPERIMENTAL SETUP
4.1 Research Questions
We aim to answer the following research questions:

4 The

corpus can be obtained for research purposes by applying here:
https://trec.nist.gov/data/reuters/reuters.html
5 The dataset can be found here: https://www.researchgate.net/publication/251231364
_FinancialPhraseBank-v10

(RQ1) What is the performance of FinBERT in short sentence classification compared with the other transfer learning methods
like ELMo and ULMFit?
4

[is next sentence] prediction

Masked LM prediction

Dense

Dense

[is next sentence] prediction

Masked LM prediction

Dense

Sentiment prediction

Dense

Dense

Encoder 12

[CLS]

Token 1

Token 2

[MASK]

[SEP]

[CLS]

Token 1

Token 2

[MASK]

[SEP]

[CLS]

Token 1

Token 2

Token k

[SEP]

Encoder 2

[CLS]

Token 1

Token 2

[MASK]

[SEP]

[CLS]

Token 1

Token 2

[MASK]

[SEP]

[CLS]

Token 1

Token 2

Token k

[SEP]

Encoder 1

[CLS]

Token 1

Token 2

[MASK]

[SEP]

[CLS]

Token 1

Token 2

[MASK]

[SEP]

[CLS]

Token 1

Token 2

Token k

[SEP]

Embeddings

[CLS]

Token 1

Token 2

[MASK]

[SEP]

[CLS]

Token 1

Token 2

[MASK]

[SEP]

[CLS]

Token 1

Token 2

Token k

[SEP]

BookCorpus +
Wikipedia

Reuters TRC2ﬁnancial

Financial
Phrasebank

Language model on general corpus

Language model on ﬁnancial corpus

Classiﬁcation model on ﬁnancial sentiment dataset

Figure 1: Overview of pre-training, further pre-training and classification fine-tuning
4.2.3 FiQA Sentiment. FiQA [15] is a dataset that was created for
WWW ’18 conference financial opinion mining and question answering challenge6 . We use the data for Task 1, which includes
1,174 financial news headlines and tweets with their corresponding
sentiment score. Unlike Financial Phrasebank, the targets for this
datasets are continuous ranging between [−1, 1] with 1 being the
most positive. Each example also has information regarding which
financial entity is targeted in the sentence. We do 10-fold cross
validation for evaluation of the model for this dataset.

4.3

PhraseBank dataset, by adding a fully-connected layer to the output
of pre-trained language model.

4.4

Evaluation Metrics

For evaluation of classification models, we use three metrics: Accuracy, cross entropy loss and macro F1 average. We weight cross
entropy loss with square root of inverse frequency rate. For example if a label constitutes 25% of the all examples, we weight the loss
attributed to that label by 2. Macro F1 average calculates F1 scores
for each of the classes and then takes the average of them. Since our
data, Financial PhraseBank suffers from label imbalance (almost
60% of all sentences are neutral), this gives another good measure of
the classification performance. For evaluation of regression model,
we report mean squared error and R 2 , as these are both standard
and also reported by the state-of-the-art papers for FiQA dataset.
