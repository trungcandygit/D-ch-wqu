The results for FiQA sentiment dataset, are presented on table 3.
Our model outperforms state-of-the-art models for both MSE and
R 2 . It should be noted that the test set these two papers [31] [24]
use is the official FiQA Task 1 test set. Since we don’t have access
to that we report the results on 10-Fold cross validation. There is
no indication on [15] that the train and test sets they publish come
from different distributions and our model can be interpreted to
be at disadvantage since we need to set aside a subset of training
set as test set, while state-of-the-art papers can use the complete
training set.

6 EXPERIMENTAL ANALYSIS
6.1 Effects of further pre-training (RQ3)
We first measure the effect of further pre-training on the performance of the classifier. We compare three models: 1) No further
pre-training (denoted by Vanilla BERT), 2) Further pre-training
on classification training set (denoted by FinBERT-task), 3) Further pre-training on domain corpus, TRC2-financial (denoted by
FinBERT-domain). Models are evaluated with loss, accuracy and
6

Table 3: Experimental Results on FiQA Sentiment Dataset
Model

MSE

R2

Yang et. al. (2018)
Piao and Breslin (2018)

0.08
0.09

0.40
0.41

FinBERT

0.07

0.55

Bold face indicated best result in corresponding metric.
Yang et. al. (2018) [31] and Piao and Breslin (2018) [24]
report results on the official test set. Since we don’t have
access to that set our MSE, and R 2 are calculated with 10Fold cross validation.

Table 4: Performance with different pretraining strategies
Model

Loss

Accuracy

F1 Score

Vanilla BERT
FinBERT-task
FinBERT-domain

0.38
0.39
0.37

0.85
0.86
0.86

0.84
0.85
0.84

Figure 3: Validation loss trajectories with different training
strategies
Table 5: Performance with different finetuning strategies

Bold face indicates best result in the corresponding metric. Results are reported on 10-fold cross validation.

macro average F1 scores on the test dataset. The results can be seen
on table 4.
The classifier that were further pre-trained on financial domain
corpus performs best among the three, though the difference is not
very high. There might be four reasons behind this result: 1) The
corpus might have a different distribution than the task set, 2) BERT
classifiers might not improve significantly with further pre-training,
3) Short sentence classification might not benefit significantly from
further pre-training, 4) Performance is already so good, that there is
not much room for improvement. We think that the last explanation
is the likeliest, because for the subset of Financial Phrasebank that
all of the annotators agree on the result, accuracy of Vanilla BERT
is already 0.96. The performance on the other agreement levels
should be lower, as even the humans can’t agree fully on them. More
experiments with another financial labeled dataset is necessary to
conclude that effect of further pre-training on domain corpus is not
significant.

6.2

Strategy

Loss

Accuracy

F1 Score

None
STL
STL + GU
STL + DFT
All three

0.48
0.40
0.40
0.42
0.37

0.83
0.81
0.86
0.79
0.86

0.83
0.82
0.86
0.79
0.84

Bold face indicates best result in the corresponding metric. Results are reported on 10-fold cross
validation. STL: slanted triangular learning rates,
GU: gradual unfreezing, DFT: discriminative finetuning.

ones, since information learned from language modeling are mostly
present in the lower levels. We see from table 5 that using only
discriminative fine-tuning with slanted triangular learning rates
performs worse than using the slanted triangular learning rates
alone. This shows that gradual unfreezing is the most important
technique for our case.
One way that catastrophic forgetting can show itself is the sudden increase in validation loss after several epochs. As model is
trained, it quickly starts to overfit when no measure is taken accordingly. As it can be seen on the figure 3, that is the case when none of
the aforementioned techniques are applied. The model achieves the
best performance on validation set after the first epoch and then
starts to overfit. While with all three techniques applied, model is
much more stable. The other combinations lie between these two
cases.

Catastrophic forgetting (RQ4)

For measuring the performance of the techniques against catastrophic forgetting, we try four different settings: No adjustment
(NA), only with slanted triangular learning rate (STL), slanted triangular learning rate and gradual unfreezing (STL+GU) and the
techniques in the previous one, together with discriminative finetuning. We report the performance of these four settings with loss
on test function and trajectory of validation loss over training
epochs. The results can be seen on table 5 and figure 3.
Applying all three of the strategies produce the best performance in terms of test loss and accuracy. Gradual unfreezing and
discriminative fine-tuning have the same reasoning behind them:
higher level features should be fine-tuned more than the lower level

6.3

Choosing the best layer for classification
(RQ5)

BERT has 12 Transformer encoder layers. It is not necessarily a
given that the last layer captures the most relevant information
regarding classification task during language model training. For
7

Table 6: Performance on different encoder layers used for
classification

Table 7: Performance on starting training from different layers

Layer for classification

Loss

Accuracy

F1 Score

First layer unfreezed

Loss

Accuracy

Training time

Layer-1
Layer-2
Layer-3
Layer-4
Layer-5
Layer-6
Layer-7
Layer-8
Layer-9
Layer-10
Layer-11
Layer-12

0.65
0.54
0.52
0.48
0.52
0.45
0.43
0.44
0.41
0.42
0.38
0.37

0.76
0.78
0.76
0.80
0.80
0.82
0.82
0.83
0.84
0.83
0.84
0.86

0.77
0.78
0.77
0.77
0.80
0.82
0.83
0.81
0.82
0.82
0.83
0.84

All layers - mean

0.41

0.84

0.84

Embeddings layer
Layer-1
Layer-2
Layer-3
Layer-4
Layer-5
Layer-6
Layer-7
Layer-8
Layer-9
Layer-10
Layer-11
Layer-12
Classification layer

0.37
0.39
0.39
0.38
0.38
0.40
0.40
0.39
0.39
0.39
0.41
0.45
0.47
1.04

0.86
0.83
0.83
0.83
0.82
0.83
0.81
0.82
0.84
0.84
0.84
0.82
0.81
0.52
