letters to nature
parts are likely to occur together. This results in complex dependencies between the hidden variables that cannot be captured by
algorithms that assume independence in the encodings. An alternative application of ICA is to transform the PCA basis images, to
make the images rather than the encodings as statistically independent as possible18. This results in a basis that is non-global; however,
in this representation all the basis images are used in cancelling
combinations to represent an individual face, and thus the encodings are not sparse. In contrast, the NMF representation contains
both a basis and encoding that are naturally sparse, in that many of
the components are exactly equal to zero. Sparseness in both the
basis and encodings is crucial for a parts-based representation.
The algorithm of Fig. 2 performs both learning and inference
simultaneously. That is, it both learns a set of basis images and
infers values for the hidden variables from the visible variables.
Although the generative model of Fig. 3 is linear, the inference
computation is nonlinear owing to the non-negativity constraints.
The computation is similar to maximum likelihood reconstruction
in emission tomography19, and deconvolution of blurred astronomical images20,21.
According to the generative model of Fig. 3, visible variables are
generated from hidden variables by a network containing excitatory
connections. A neural network that infers the hidden from the
visible variables requires the addition of inhibitory feedback connections. NMF learning is then implemented through plasticity in
the synaptic connections. A full discussion of such a network is
beyond the scope of this letter. Here we only point out the

court
government
council
culture
supreme
constitutional
rights
justice

president
served
governor
secretary
senate
congress
presidential
elected

flowers
leaves
plant
perennial
flower
plants
growing
annual

disease
behaviour
glands
contact
symptoms
skin
pain
infection

Encyclopedia entry:
'Constitution of the
United States'

×

≈

president (148)
congress (124)
power (120)
united (104)
constitution (81)
amendment (71)
government (57)
law (49)

metal process method paper ... glass copper lead steel
person example time people ... rules lead leads law

Figure 4 Non-negative matrix factorization (NMF) discovers semantic features of
m ¼ 30;991 articles from the Grolier encyclopedia. For each word in a vocabulary of size
n ¼ 15;276, the number of occurrences was counted in each article and used to form the
15;276 3 30;991 matrix V. Each column of V contained the word counts for a particular
article, whereas each row of V contained the counts of a particular word in different
articles. The matrix was approximately factorized into the form WH using the algorithm
described in Fig. 2. Upper left, four of the r ¼ 200 semantic features (columns of W). As
they are very high-dimensional vectors, each semantic feature is represented by a list of
the eight words with highest frequency in that feature. The darkness of the text indicates
the relative frequency of each word within a feature. Right, the eight most frequent words
and their counts in the encyclopedia entry on the ‘Constitution of the United States’. This
word count vector was approximated by a superposition that gave high weight to the
upper two semantic features, and none to the lower two, as shown by the four shaded
squares in the middle indicating the activities of H. The bottom of the figure exhibits the
two semantic features containing ‘lead’ with high frequencies. Judging from the other
words in the features, two different meanings of ‘lead’ are differentiated by NMF.
NATURE | VOL 401 | 21 OCTOBER 1999 | www.nature.com

consequence of the non-negativity constraints, which is that
synapses are either excitatory or inhibitory, but do not change
sign. Furthermore, the non-negativity of the hidden and visible
variables corresponds to the physiological fact that the firing rates of
neurons cannot be negative. We propose that the one-sided constraints on neural activity and synaptic strengths in the brain may be
important for developing sparsely distributed, parts-based repreM
sentations for perception.

Methods
The facial images used in Fig. 1 consisted of frontal views hand-aligned in a 19 3 19 grid.
For each image, the greyscale intensities were first linearly scaled so that the pixel mean and
standard deviation were equal to 0.25, and then clipped to the range [0,1]. NMF was
performed with the iterative algorithm described in Fig. 2, starting with random initial
conditions for W and H. The algorithm was mostly converged after less than 50 iterations;
the results shown are after 500 iterations, which took a few hours of computation time on a
Pentium II computer. PCA was done by diagonalizing the matrix VVT. The 49 eigenvectors
with the largest eigenvalues are displayed. VQ was done via the k-means algorithm,
starting from random initial conditions for W and H.
In the semantic analysis application of Fig. 4, the vocabulary was defined as the 15,276
most frequent words in the database of Grolier encyclopedia articles, after removal of the
430 most common words, such as ‘the’ and ‘and’. Because most words appear in relatively
few articles, the word count matrix V is extremely sparse, which speeds up the algorithm.
The results shown are after the update rules of Fig. 2 were iterated 50 times starting from
random initial conditions for W and H.
Received 24 May; accepted 6 August 1999.
1. Palmer, S. E. Hierarchical structure in perceptual representation. Cogn. Psychol. 9, 441–474 (1977).
2. Wachsmuth, E., Oram, M. W. & Perrett, D. I. Recognition of objects and their component parts:
responses of single units in the temporal cortex of the macaque. Cereb. Cortex 4, 509–522 (1994).
3. Logothetis, N. K. & Sheinberg, D. L. Visual object recognition. Annu. Rev. Neurosci. 19, 577–621
(1996).