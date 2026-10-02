# M5L2_DT1

FinBERT: Financial Sentiment Analysis with Pre-trained Language Models

arXiv:1908.10063v1 [cs.CL] 27 Aug 2019

submitted in partial fulfillment for the degree of master of science
Dogu Araci
12255068

master information studies
data science
faculty of science
university of amsterdam
2019-06-25

Title, Name
Affiliation
Email

Internal Supervisor
Dr Pengjie Ren
UvA, ILPS
p.ren@uva.nl

External Supervisor
Dr Zulkuf Genc
Naspers Group
zulkuf.genc@naspers.com

FinBERT: Financial Sentiment Analysis with Pre-trained
Language Models
Dogu Tan Araci
dogu.araci@student.uva.nl
University of Amsterdam
Amsterdam, The Netherlands

ABSTRACT

NLP transfer learning methods look like a promising solution
to both of the challenges mentioned above, and are the focus of
this thesis. The core idea behind these models is that by training language models on very large corpora and then initializing
down-stream models with the weights learned from the language
modeling task, a much better performance can be achieved. The
initialized layers can range from the single word embedding layer
[23] to the whole model [5]. This approach should, in theory, be an
answer to the scarcity of labeled data problem. Language models
don’t require any labels, since the task is predicting the next word.
They can learn how to represent the semantic information. That
leaves the fine-tuning on labeled data only the task of learning how
to use this semantic information to predict the labels.
One particular component of the transfer learning methods is the
ability to further pre-train the language models on domain specific
unlabeled corpus. Thus, the model can learn the semantic relations
in the text of the target domain, which is likely to have a different distribution than a general corpus. This approach is especially
promising for a niche domain like finance, since the language and
vocabulary used is dramatically different than a general one.
The goal of this thesis is to test these hypothesized advantages
of using and fine-tuning pre-trained language models for financial
domain. For that, sentiment of a sentence from a financial news
article towards the financial actor depicted in the sentence will be
tried to be predicted, using the Financial PhraseBank created by
Malo et al. (2014) [17] and FiQA Task 1 sentiment scoring dataset
[15].
The main contributions of this thesis are the following:

Financial sentiment analysis is a challenging task due to the specialized language and lack of labeled data in that domain. Generalpurpose models are not effective enough because of specialized
language used in financial context. We hypothesize that pre-trained
language models can help with this problem because they require
fewer labeled examples and they can be further trained on domainspecific corpora. We introduce FinBERT, a language model based
on BERT, to tackle NLP tasks in financial domain. Our results show
improvement in every measured metric on current state-of-theart results for two financial sentiment analysis datasets. We find
that even with a smaller training set and fine-tuning only a part of
the model, FinBERT outperforms state-of-the-art machine learning
methods.

1

INTRODUCTION

Prices in an open market reflects all of the available information
regarding assets exchanged in an economy [16]. When new information becomes available, all actors in the economy update their
positions and prices adjust accordingly, which makes beating the
markets consistently impossible. However, the definition of "new information" might change as new information retrieval technologies
become available and early-adoption of such technologies might
provide an advantage in the short-term.
Analysis of financial texts, be it news, analyst reports or official
company announcements is a possible source of new information.
With unprecedented amount of such text being created every day,
manually analyzing these and deriving actionable insights from
them is too big of a task for any single entity. Hence, automated
sentiment or polarity analysis of texts produced by financial actors using natural language processing (NLP) methods has gained
popularity during the last decade [4].
The principal research interest for this thesis is the polarity
analysis, which is classifying text as positive, negative or neutral,
in a specific domain. It requires to address two challenges: 1) The
most sophisticated classification methods that make use of neural
nets require vast amounts of labeled data and labeling financial
text snippets requires costly expertise. 2) The sentiment analysis
models trained on general corpora are not suited to the task, because
financial texts have a specialized language with unique vocabulary
and have a tendency to use vague expressions instead of easilyidentified negative/positive words.
Using carefully crafted financial sentiment lexicons such as
Loughran and McDonald (2011) [11] may seem a solution because
they incorporate existing financial knowledge into textual analysis.
However, they are based on "word counting" methods, which come
short in analyzing deeper semantic meaning of a given text.
