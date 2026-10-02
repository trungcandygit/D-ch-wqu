# M5L2_DT2

FinBERT: A Pretrained Language Model for Financial Communications

Yi Yang
Mark Christopher Siy UY
Allen Huang
School of Business and Management, Hong Kong University of Science and Technology
{imyiyang,acahuang}@ust.hk, mcsuy@connect.ust.hk

arXiv:2006.08097v2 [cs.CL] 9 Jul 2020

Abstract
Contextual pretrained language models, such
as BERT (Devlin et al., 2019), have made
significant breakthrough in various NLP tasks
by training on large scale of unlabeled text
resources. Financial sector also accumulates
large amount of financial communication
text. However, there is no pretrained finance
specific language models available. In this
work, we address the need by pretraining
a financial domain specific BERT models,
FinBERT, using a large scale of financial
communication corpora.
Experiments on
three financial sentiment classification
tasks confirm the advantage of FinBERT
over generic domain BERT model. The
code and pretrained models are available at
https://github.com/yya518/FinBERT.
We hope this will be useful for practitioners
and researchers working on financial NLP
tasks.

1 Introduction
The growing maturity of NLP techniques and resources is drastically changing the landscape of finanical domain. Capital market practitioners and
researchers have keen interests in using NLP techniques to monitor market sentiment in real time
from online news articles or social media posts,
since sentiment can be used as a directional signal for trading purposes. Intuitively, if there is
positive information about a particular company,
we expect that company’s stock price to increase,
and vice versa. For example, Bloomberg, the financial media company, reports that trading sentiment portfolios outperform the benchmark index significantly (Cui et al., 2016). Prior financial
economics research also reports that news article
and social media sentiment could be used to predict market return and firm performance (Tetlock,
2007; Tetlock et al., 2008).

Recently, unsupervised pre-training of language
models on large corpora has significantly improved the performance of many NLP tasks. The
language models are pretained on generic corpora
such as Wikipedia. However, sentiment analysis
is a strongly domain dependent task. Financial
sector has accumulated large scale of text of financial and business communications. Therefore,
leveraging the success of unsupervised pretraining and large amount of financial text could potentially benefit wide range of financial applications.
To fill the gap, we pretrain FinBERT, a finance
domain specific BERT model on a large financial
communication corpora of 4.9 billion tokens, including corporate reports, earnings conference call
transcripts and analyst reports. We document the
financial corpora and the FinBERT pretraining details. Experiments on three financial sentiment
classification tasks shows that FinBERT outperforms the generic BERT models. Our contribution is straightforward: we compile a large scale
of text corpora that are the most representative in
financial and business communications. We pretrain and release FinBERT, a new resource demonstrated to improve performance on financial sentiment analysis.

2 Related Work
Recently, unsupervised pre-training of language models on large corpora, such as BERT
(Devlin et al., 2019), ELMo (Peters et al., 2018),
ULM-Fit (Howard and Ruder, 2018), XLNet,
and GPT (Radford et al., 2019) has significantly
improved performance on many natural language
processing tasks, from sentence classification to
question answering. Unlike traditional word embedding (Mikolov et al., 2013; Pennington et al.,
2014) where word is represented as a single vector
representation, these language model returns

contextualized embeddings for each word token
which can be fed into downstream tasks.
The released language models are trained on
general domain corpora such as news articles and
Wikipedia. Even though it is easy to fine tune
the language model using downstream task, it has
been shown that pre-training a language model
using large-scale domain corpora can further improve the task performance than fine-tuning the
generic language model. To this end, several
domain-specific BERT models are trained and released. BioBERT (Lee et al., 2019) pretrains a
biomedical domain-specific language representation model using large-scale biomedical corpora.
Similarly, ClinicalBERT (Huang et al., 2019) applies BERT model to clinical notes for hospital
readmission prediction task, and (Alsentzer et al.,
2019) applies BERT on clinical notes and discharge summaries.
SciBERT (Beltagy et al.,
2019) trains a scientific domain-specific BERT
model using a large multi-domain corpus of scientific publications to improve performance on
downstream scientific NLP tasks. We are the first
to pre-train and release a finance domain specific
BERT model.

3 Financial Corpora
We compile a large financial domain corpora that
are most representative in finance and business
communications.
Corporate Reports 10-K & 10-Q The most important text data in finance and business communication is corporate report. In the United States,
the Securities Exchange Commission (SEC) mandates all publicly traded companies to file annual
reports, known as Form 10-K, and quarterly reports, known as Form 10-Q. This document provides a comprehensive overview of the company’s
business and financial condition. Laws and regulations prohibit companies from making materially
false or misleading statements in the 10-Ks. The
Form 10-Ks and 10-Qs are publicly available and
can be accesses from SEC website.1
We obtain 60,490 Form 10-Ks and 142,622
Form 10-Qs of Russell 3000 firms during 1994 and
2019 from SEC website. We only include sections
that are textual components, such as Item 1 (Business) in 10-Ks, Item 1A (Risk Factors) in both 10Ks and 10-Qs and Item 7 (Managements Discussion and Analysis) in 10-Ks.
1

http://www.sec.gov/edgar.shtml
