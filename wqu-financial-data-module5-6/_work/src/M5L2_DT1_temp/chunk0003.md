Language modeling is the task of predicting the next word in a given
piece of text. One of the most important recent developments in
natural language processing is the realization that a model trained
for language modeling can be successfully fine-tuned for most
down-stream NLP tasks with small modifications. These models
are usually trained on very large corpora, and then with addition
of suitable task-specific layers fine-tuned on the target dataset [6].
Text classification, which is the focus of this thesis, is one of the
obvious use-cases for this approach.
ELMo (Embeddings from Language Models) [23] was one of the
first successful applications of this approach. With ELMo, a deep
bidirectional language model is pre-trained on a large corpus. For
each word, hidden states of this model is used to compute a contextualized representation. Using the pre-trained weights of ELMo,
contextualized word embeddings can be calculated for any piece
of text. Initializing embeddings for down-stream tasks with those
were shown to improve performance on most tasks compared to
static word embeddings such as word2vec or GloVe. For text classification tasks like SST-5, it achieved state-of-the-art performance
when used together with a bi-attentive classification network [20].
Although ELMo makes use of pre-trained language models for
contextualizing representations, still the information extracted using a language model is present only in the first layer of any model
using it. ULMFit (Universal Language Model Fine-tuning) [5] was
the first paper to achieve true transfer learning for NLP, as using
novel techniques such as discriminative fine-tuning, slanted triangular learning rates and gradual unfreezing. They were able to
efficiently fine-tune a whole pre-trained language model for text
classification. They also introduced further pre-training of the language model on a domain-specific corpus, assuming target task
data comes from a different distribution than the general corpus
the initial model was trained on.
ULMFit’s main idea of efficiently fine-tuning a pre-trained a
language model for down-stream tasks was brought to another level
with Bidirectional Encoder Representations from Transformers
(BERT) [3], which is also the main focus of this paper. BERT has
two important differences from what came before: 1) It defines the
task of language modeling as predicting randomly masked tokens
in a sequence rather than the next token, in addition to a task of
classifying two sentences as following each other or not. 2) It is
a very big network trained on an unprecedentedly large corpus.
These two factors enabled in to achieve state-of-the-art results in
multiple NLP tasks such as, natural language inference or question
answering.
The specifics of fine-tuning BERT for text classification has not
been researched thoroughly. One such recent work is Sun et al.
2

(2019) [27]. They conduct a series of experiments regarding different configurations of BERT for text classification. Some of their
results will be referenced throughout the rest of the thesis, for the
configuration of our model.

3

3.1.4 Transformer. The Transformer is an attention-based architecture for modeling sequential information, that is an alternative
to recurrent neural networks [29]. It was proposed as a sequence-tosequence model, therefore including encoder and decoder mechanisms. Here, we will focus only on the encoder part (though decoder
is quite similar). The encoder consists of multiple identical Transformer layers. Each layer has a multi-headed self-attention layer
and a fully connected feed-forward network. For one self-attention
layer, three mappings from embeddings (key, query and value) are
learned. Using each token’s key and all tokens’ query vectors, a
similarity score is calculated with dot product. These scores are
used to weight the value vectors to arrive at the new representation
of the token. With the multi-headed self-attention, these layers are
concatenated together, so that the sequence can be evaluated from
varying "perspectives". Then the resulted vectors go through fully
connected networks with shared parameters.
As it was argued by Vaswani 2017 [29], Transformer architecture
has several advantages over the RNN-based approaches. Because
of RNNs’ sequential nature, they are much harder to parallelize on
GPUs and too many steps between far away elements in a sequence
make it hard for information to persist.

METHOD

In this section, we will present our BERT implementation for financial domain named as FinBERT, after giving a brief background on
relevant neural architectures.

3.1

Preliminaries

3.1.1 LSTM. Long short-term memory (LSTM) is a type of recurrent neural network that allows long-term dependencies in a
sequence to persist in the network by using "forget" and "update"
gates. It is one of the primary architectures for modeling any sequential data generation process, from stock prices to natural language.
Since a text is a sequence of tokens, the first choice for any LSTM
natural language processing model is determining how to initially
represent a single token. Using pre-trained weights for initial token representation is the common practice. One such pre-training
algorithm is GLoVe (Global Vectors for Word Representation) [22].
GLoVr is a model for calculating word representations with the
unsupervised task of training a log-bilinear regression model on
a word-word co-occurance matrix from a large corpus. It is an effective model for representing words in a vector space, however
it doesn’t contextualize these representations with respect to the
sequence they are actually used in1 .
