332s
302s
291s
272s
250s
240s
220s
205s
188s
172s
158s
144s
133s
119s

al. (2014 )[17], it is indicated that most of the inter-annotator disagreements are between positive and neutral labels (agreement for
separating positive-negative, negative-neutral and positive-neutral
are 98.7%, 94.2% and 75.2% respectively). Authors attribute that
the difficulty of distinguishing "commonly used company glitter
and actual positive statements". We will present the confusion matrix in order to observe whether this is the case for FinBERT as well.

this experiment, we investigate which layer out of 12 Transformer
encoder layers give the best result for classification. We put the classification layer after the CLS] tokens of respective representations.
We also try taking the average of all layers.
As shown in table 6the last layer contributes the most to the
model performance in terms of all the metrics measured. This might
be indicative of two factors: 1) When the higher layers are used the
model that is being trained is larger, hence possibly more powerful,
2) The lower layers capture deeper semantic information, hence
they struggle to fine-tune that information for classification.

6.4

Example 1: Pre-tax loss totaled euro 0.3 million ,
compared to a loss of euro 2.2 million in the first
quarter of 2005 .
True value: Positive Predicted: Negative

Training only a subset of the layers (RQ6)

BERT is a very large model. Even on small datasets, fine-tuning
the whole model requires significant time and computing power.
Therefore if a slightly lower performance can be achieved with
fine-tuning only a subset of all parameters, it might be preferable in
some contexts. Especially if training set is very large, this change
might make BERT more convenient to use. Here we experiment
with fine-tuning only the last k many encoder layers.
The results are presented on table 7. Fine-tuning only the classification layer does not achieve close performance to fine-tuning
other layers. However fine-tuning only the last layer handily outperforms the state-of-the-art machine learning methods like HSC.
After Layer-9, the performance becomes virtually the same, only to
be outperformed by fine-tuning the whole model. This result shows
that in order to utilize BERT, an expensive training of the whole
model is not mandatory. A fair trade-off can be made for much less
training time with a small decrease in model performance.

6.5

Example 2: This implementation is very important to
the operator , since it is about to launch its Fixed
to Mobile convergence service in Brazil
True value: Neutral Predicted: Positive
Example 3: The situation of coated magazine printing
paper will continue to be weak .
True value: Negative Predicted: Neutral
The first example is actually the most common type of failure.
The model fails to do the math in which figure is higher, and in
the absence of words indicative of direction like "increased", might
make the prediction of neutral. However, there are many similar
cases where it does make the true prediction too. Examples 2 and 3
are different versions of the same type of failure. The model fails
to distinguish a neutral statement about a given situation from a
statement that indicated polarity about the company. In the third
example, information about the company’s business would probably
help.
The confusion matrix is presented on figure 4. 73% of the failures
happen between labels positive and negative, while same number
is 5% for negative and positive. That is consistent with both the
inter-annotator agreement numbers and common sense. It is easier

Where does the model fail?

With 97% accuracy on the subset of Financial PhraseBank with
100% annotator agreement, we think it might be an interesting
exercise to examine cases where the model failed to predict the
true label. Therefore in this section we will present several examples where model makes the wrong prediction. Also in Malo et
8

market return data (both in terms of directionality and volatility)
on financial news. FinBERT is good enough for extracting explicit
sentiments, but modeling implicit information that is not necessarily apparent even to those who are writing the text should be a
challenging task. Another possible extension can be using FinBERT
for other natural language processing tasks such as named entity
recognition or question answering in financial domain.

8

I would like to show my gratitude to Pengjie Ren and Zulkuf Genc
for their excellent supervision. They provided me with both independence in setting my own course for the research and valuable
suggestions when I need them. I would also like to thank Naspers AI
team, for entrusting me with this project and always encouraging
me to share my work. I am grateful to NIST, for sharing Reuters
TRC-2 corpus with me and to Malo et al. for making the excellent
Financial PhraseBank publicly available.

Figure 4: Confusion matrix

to differentiate between positive and negative. But it might be more
challenging to decide whether a statement indicates a positive
outlook or merely an objective observation.

7

ACKNOWLEDGEMENTS
