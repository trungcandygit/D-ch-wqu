certain linguistic tasks15, it generally results in semantic variables
that are difficult to interpret, for much the same reason that the PCA
representation of faces has no obvious visual interpretation. This is
the result of two unrealistic aspects of the model: all semantic
variables are used to represent each document; and negative values
for semantic variables are allowed. Intuitively, it makes more sense
for each document to be associated with some small subset of a large
array of topics, rather than just one topic or all the topics. Because
the sparsely distributed representation of NMF appears ideally
suited for this purpose, we applied NMF to the semantic analysis
of a corpus of encyclopedia articles.
Some of the semantic features (r ¼ 200, columns of W) discovered by NMF are shown in Fig. 4. In each semantic feature, the
algorithm has grouped together semantically related words. Each
article in the encyclopedia is represented by additively combining
several of these features. For example, to represent the article about
the ‘Constitution of the United States’, the semantic feature containing ‘supreme’ and ‘court’ and the one containing ‘president’ and
‘congress’ are coactivated.
In addition to grouping semantically related words together into
semantic features, the algorithm uses context to differentiate
between multiple meanings of the same word. For example, the
word ‘lead’ appears with high frequency in two semantic features
shown in Fig. 4: it occurs with ‘metal’, ‘copper’ and ‘steel’ in one,
whereas it appears with ‘person’, ‘rules’ and ‘law’ in the other. This
demonstrates that NMF can deal with the polysemy of ‘lead’ by
disambiguating two of its meanings in the corpus of documents.
Although NMF is successful in learning facial parts and semantic
topics, this success does not imply that the method can learn parts
from any database, such as images of objects viewed from extremely
different viewpoints, or highly articulated objects. Learning parts
for these complex cases is likely to require fully hierarchical models
with multiple levels of hidden variables, instead of the single level in
NMF. Although non-negativity constraints may help such models
to learn parts-based representations13, we do not claim that they are
sufficient in themselves. Also, NMF does not learn anything about
the ‘syntactic’ relationships between parts. NMF assumes that the
hidden variables are non-negative, but makes no further assumptions
about their statistical dependencies.
This is in contrast to independent components analysis (ICA),
a variant of PCA that assumes that the hidden variables are
statistically independent and non-gaussian16,12. Applying ICA to
the facial images to make the encodings independent results in basis
images that are holistic. The independence assumption of ICA is illsuited for learning parts-based representations because various

...

h1

hr

V

Wia ← Wia ∑ (WHiµ) H aµ
iµ

µ

Wia ←

Wia
∑W ja

W

H aµ ← H aµ ∑
i

V
Wia (WHiµ)
iµ
v1

Figure 2 Iterative algorithm for non-negative matrix factorization. Starting from nonnegative initial conditions for W and H, iteration of these update rules for non-negative V
finds an approximate factorization V < WH by converging to a local maximum of the
objective function given in equation (2). The fidelity of the approximation enters the
updates through the quotient Vim/(WH)im. Monotonic convergence can be proven using
techniques similar to those used in proving the convergence of the EM algorithm22,23. The
update rules preserve the non-negativity of W and H and also constrain the columns of W
to sum to unity. This sum constraint is a convenient way of eliminating the degeneracy
associated with the invariance of WH under the transformation W → W L, H → L 2 1 H ,
where L is a diagonal matrix.
790

...

vn

〈v〉 = Wh

j

Figure 3 Probabilistic hidden variables model underlying non-negative matrix
factorization. The model is diagrammed as a network depicting how the visible variables
v1,…,vn in the bottom layer of nodes are generated from the hidden variables h1,…,hr in
the top layer of nodes. According to the model, the visible variables vi are generated from a
probability distribution with mean SaWiaha. In the network diagram, the influence of ha
on vi is represented by a connection with strength Wia. In the application to facial images,
the visible variables are the image pixels, whereas the hidden variables contain the partsbased encoding. For fixed a, the connection strengths W1a,…,Wna constitute a specific
basis image (right middle) which is combined with other basis images to represent a whole
facial image (right bottom).

© 1999 Macmillan Magazines Ltd

NATURE | VOL 401 | 21 OCTOBER 1999 | www.nature.com
