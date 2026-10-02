Baseline Methods

For contrastive experiments, we consider baselines with three different methods: LSTM classifier with GLoVe embeddings, LSTM
classifier with ELMo embeddings and ULMFit classifier. It should
be noted that these baseline methods are not experimented with as
thoroughly as we did with BERT. Therefore the results should not
be interpreted as definitive conclusions of one method being better.

4.5

4.3.1 LSTM classifiers. We implement two classifiers using bidirectional LSTM models. In both of them, a hidden size of 128 is used,
with the last hidden state size being 256 due to bidirectionality.
A fully connected feed-forward layer maps the last hidden state
to a vector of three, representing likelihood of three labels. The
difference between two models is that one uses GLoVe embeddings,
while the other uses ELMo embeddings. A dropout probability of
0.3 and a learning rate of 3e-5 is used in both models. We train them
until there is no improvement in validation loss for 10 epochs.

Implementation Details

For our implementation BERT, we use a dropout probability of
p = 0.1, warm-up proportion of 0.2, maximum sequence length
of 64 tokens, a learning rate of 2e − 5 and a mini-batch size of
64. We train the model for 6 epochs, evaluate on the validation
set and choose the best one. For discriminative fine-tuning we set
the discrimination rate as 0.85. We start training with only the
classification layer unfrozen, after each third of a training epoch we
unfreeze the next layer. An Amazon p2.xlarge EC2 instance with
one NVIDIA K80 GPU, 4 vCPUs and 64 GiB of host memory is used
to train the models.

4.3.2 ULMFit. As it was explained in section 3.1.3, classification
with ULMFit consists of three steps. The first step of pre-training
a language model is already done and the pre-trained weights are
released by Howard and Ruder (2018). We first further pre-train
AWD-LSTM language model on TRC2-financial corpus for 3 epochs.
After that, we fine-tune the model for classification on Financial

5

EXPERIMENTAL RESULTS (RQ1 & RQ2)

The results of FinBERT, the baseline methods and state-of-the-art
on Financial PhraseBank dataset classification task can be seen on
table 2. We present the result on both the whole dataset and subset
with 100% annotator agreement.

6 Data can be found here: https://sites.google.com/view/fiqa/home

5

Table 2: Experimental Results on the Financial PhraseBank dataset
All data

Data with 100% agreement

Model

Loss

Accuracy

F1 Score

Loss

Accuracy

F1 Score

LSTM
LSTM with ELMo
ULMFit

0.81
0.72
0.41

0.71
0.75
0.83

0.64
0.7
0.79

0.57
0.50
0.20

0.81
0.84
0.93

0.74
0.77
0.91

LPS
HSC
FinSSLX

-

0.71
0.71
-

0.71
0.76
-

-

0.79
0.83
0.91

0.80
0.86
0.88

FinBERT

0.37

0.86

0.84

0.13

0.97

0.95

Bold face indicates best result in the corresponding metric. LPS [17], HSC [8] and FinSSLX
[15] results are taken from their respective papers. For LPS and HSC, overall accuracy is not
reported on the papers. We calculated them using recall scores reported for different classes.
For the models implemented by us, we report 10-fold cross validation results.

For all of the measured metrics, FinBERT performs clearly the
best among both the methods we implemented ourselves (LSTM and
ULMFit) and the models reported by other papers (LPS [17], HSC [8],
FinSSLX [14]). LSTM classifier with no language model information
performs the worst. In terms of accuracy, it is close to LPS and HSC,
(even better than LPS for examples with full agreement), however
it produces a low F1-score. That is due to it performing much better
in neutral class. LSTM classifier with ELMo embeddings improves
upon LSTM with static embeddings in all of the measured metrics.
It still suffers from low average F1-score due to poor performance
in less represented labels. But it’s performance is comparable with
LPS and HSC, besting them in accuracy. So contextualized word
embeddings produce close performance to machine learning based
methods for dataset of this size.
ULMFit significantly improves on all of the metrics and it doesn’t
suffer from model performing much better in some classes than
the others. It also handily beats the machine learning based models
LPS and HSC. This shows the effectiveness of language model pretraining. AWD-LSTM is a very large model and it would be expected
to suffer from over-fitting with this small of a dataset. But due to
language model pre-training and effective training strategies, it
is able to overcome small data problem. ULMFit also outperforms
FinSSLX, which has a text simplification step as well as pre-training
of word embeddings on a large financial corpus with sentiment
labels.
FinBERT outperforms ULMFit, and consequently all of the other
methods in all metrics. In order to measure the performance of the
models on different sizes of labeled training datasets, we ran LSTM
classifiers, ULMFit and FinBERT on 5 different configurations. The
result can be seen on figure 2, where the cross entropy losses on
test set for each model are drawn. 100 training examples is too low
for all of the models. However, once the training size becomes 250,
ULMFit and FinBERT starts to successfully differentiate between
labels, with an accuracy as high as 80% for FinBERT. All of the
methods consistently get better with more data, but ULMFit and
FinBERT does better with 250 examples than LSTM classifiers do
with the whole dataset. This shows the effectiveness of language
model pre-training.

Figure 2: Test loss different training set sizes
