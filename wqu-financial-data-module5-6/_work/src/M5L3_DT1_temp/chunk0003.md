Finally, we have applied a Correlated Topics Models (CTM)
algorithm [7], based on Latent Dirichlet Allocation (LDA) algorithm
[8], on the words contained in the mentions, news or documents written
in Spanish. The rest of the dataset has not been included in this part of
the study. We have not mixed languages, words with similar meaning
but from different languages can be placed on different topics because
writing is different. We leave the evaluation of other languages for
future research. The “topicmodels” R package [9] allows us to execute
LDA and CTM algorithms.
LDA allows to discover topics in large data collections described
via topics. It does not require labeled data (unsupervised learning)
and uses a stochastic procedure to generate the topic weight vector.
LDA represents documents as mixtures of topics that spit out words
with certain probabilities. It is a bag-of-words model. For this reason,
LDA can be used for document modelling and classification. LDA
fails to directly model correlation between the occurrence of topic
and, sometimes, the presence of one topic may be correlated with
the presence of another (for example: “economic” and “business”).
CTM is very similar to LDA except that topic proportions are drawn
from a logistic normal distribution rather than a Dirichlet distribution.
Applying the “topicmodels” R package to our dataset, we can obtain
a list of words for every topic and, also, check the correlation between
the topics obtained.

A. Getting the text of the documents
As we have mentioned before, getting the text of the documents is
a compute-intensive phase because it requires to deal with HTML tags
and extract the text of the document. This task is done in the following
steps:
1. First, documents are accessed through its URL.
2. We detect the text language using “textcat” R package [10]. If
the document is written in Spanish or English we download
the text and confirm that the text contains one of the following
words: “gobierno”, “government”, “council”, “ministers”,
“ministry”, “ministro”, “ministerio”. In other case, we consider
that the text does not mention Spanish Government. One should
note that Spain location is referenced in the text according to
GKG metadata.
3. For all downloaded texts, we clean the text removing HTML
tags and stop-words (Spanish and English) in order to improve
accuracy and performance. This task reduces the text size.
Stop-words refer to the most common words in a language but
given our aims they do not add value to the analysis of the
topic.
Sequential and parallel execution modes have been tested here. A
parallel algorithm, as opposed to a traditional sequential algorithm,
is one which can be executed a piece at a time on many different
processing p devices or processors, and then put back together again at
the end to get the correct result.
The usefulness of this type of parallelization is that once the
program structure is known, a few changes must be made to
the program to be executed by several processors, and not as a
distributed algorithm in which, first, we must establish the optimal
communication structure. This usually involves making substantial
changes to the program.
Two parallelization schemes have been evaluated. In the first one,
we take advantage of multiple cores in one computer. The second
parallelization method employs a master-slave architecture [11]. This
architecture features a single processor running the main algorithm
(master) which delegates the mission of getting the text among a group
of processors (slaves). Slaves are responsible for processing URLs
and getting the text and communicating results to the central process.

- 39 -

International Journal of Interactive Multimedia and Artificial Intelligence, Vol. 3, Nº6
In any case, if we have p processors, the original dataset is divided
into p chunks, one processor processes only one of these chunks. In
all cases, we have used a computer with Pentium V quad core and
8 GB RAM, managed by Operating System Centos 6.4. The Internet
broadband speed is, roughly, 20 Mbps (download speed). Performance
are usually measured in terms Speedup (Sp) and Efficiency (Ep):

Sp = T1 /Tp

(1)

Ep= Sp/p

(2)

where p is the number of processors, T1 is the execution time of
sequential algorithm and Tp is the execution time of the parallel
implementation on p processors.
The Simple Network of Workstations (snow) package [12] allows
executing parallel code in R. It requires loading the code, loading the
snow library, create a snow cluster (or execute in local mode using
multicore CPU) and running the code, maintaining this order. Snow
library can be used to start new R processes (workers) in our machine.
The snow package is a scatter/gather paradigm, which works as
follows:

negative indicating that the sentiment of news related to the solar
energy policies is negative through this period. We must remember
that the government introduced in October 2015 what was named
as solar tax (“impuesto al sol”) regulating consumption made by
consumers who produce their own energy through photovoltaic
systems. The discussions at the media did not began at the time of
publishing the Royal Decree on October the 9th, 2015 but several
months before as soon as the agents knew government’s intention.
It is not strange that the sentiment of the agents producing news is
negative.
On the other hand, when we include the word government as a
control to build the sentiment index, the average as presented in figures
2 and 4 is still more negative. So, the agents (producers, consumers,
etc.) clearly express a negative reaction towards the fuel and energy
prices and we associate it to the regulations in the energy market
referred to these variables. The opinion expressed in other surrounding
countries of Europe and also by the authorities of the UE was also
negative towards the regulation.

1. The manager partitions the data into chunks and parcels them
out to the workers (scatter phase).