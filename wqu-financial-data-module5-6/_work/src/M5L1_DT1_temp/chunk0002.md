.................................................................
Learning the parts of objects by
non-negative matrix factorization
Daniel D. Lee* & H. Sebastian Seung*†
* Bell Laboratories, Lucent Technologies, Murray Hill, New Jersey 07974, USA
† Department of Brain and Cognitive Sciences, Massachusetts Institute of
Technology, Cambridge, Massachusetts 02139, USA
.......................................... ......................... ......................... ......................... .........................

Is perception of the whole based on perception of its parts? There
is psychological1 and physiological2,3 evidence for parts-based
representations in the brain, and certain computational theories
of object recognition rely on such representations4,5. But little is
known about how brains or computers might learn the parts of
objects. Here we demonstrate an algorithm for non-negative
matrix factorization that is able to learn parts of faces and
semantic features of text. This is in contrast to other methods,
such as principal components analysis and vector quantization,
that learn holistic, not parts-based, representations. Non-negative
matrix factorization is distinguished from the other methods by
its use of non-negativity constraints. These constraints lead to a
parts-based representation because they allow only additive, not
subtractive, combinations. When non-negative matrix factorization is implemented as a neural network, parts-based representations emerge by virtue of two properties: the firing rates of
neurons are never negative and synaptic strengths do not
change sign.
We have applied non-negative matrix factorization (NMF),
together with principal components analysis (PCA) and vector
quantization (VQ), to a database of facial images. As shown in
Fig. 1, all three methods learn to represent a face as a linear
combination of basis images, but with qualitatively different results.
VQ discovers a basis consisting of prototypes, each of which is a
whole face. The basis images for PCA are ‘eigenfaces’, some of which
resemble distorted versions of whole faces6. The NMF basis is
radically different: its images are localized features that correspond
better with intuitive notions of the parts of faces.
How does NMF learn such a representation, so different from the
holistic representations of PCA and VQ? To answer this question, it
is helpful to describe the three methods in a matrix factorization
framework. The image database is regarded as an n 3 m matrix V,
each column of which contains n non-negative pixel values of one of
the m facial images. Then all three methods construct approximate
factorizations of the form V < WH, or
r

V im < ðWHÞim ¼

^W H
ia

am

ð1Þ

a¼1

The r columns of W are called basis images. Each column of H is
called an encoding and is in one-to-one correspondence with a face
in V. An encoding consists of the coefficients by which a face is
represented with a linear combination of basis images. The dimensions of the matrix factors W and H are n 3 r and r 3 m, respectively. The rank r of the factorization is generally chosen so that
ðn þ mÞr , nm, and the product WH can be regarded as a compressed form of the data in V.
The differences between PCA, VQ and NMF arise from different
constraints imposed on the matrix factors W and H. In VQ, each
column of H is constrained to be a unary vector, with one element
equal to unity and the other elements equal to zero. In other words,
every face (column of V) is approximated by a single basis image
(column of W) in the factorization V < WH. Such a unary encoding for a particular face is shown next to the VQ basis in Fig. 1. This
unary representation forces VQ to learn basis images that are
prototypical faces.

© 1999 Macmillan Magazines Ltd

NATURE | VOL 401 | 21 OCTOBER 1999 | www.nature.com

letters to nature
PCA constrains the columns of W to be orthonormal and the
rows of H to be orthogonal to each other. This relaxes the unary
constraint of VQ, allowing a distributed representation in which
each face is approximated by a linear combination of all the basis
images, or eigenfaces6. A distributed encoding of a particular face is
shown next to the eigenfaces in Fig. 1. Although eigenfaces have a
statistical interpretation as the directions of largest variance, many
of them do not have an obvious visual interpretation. This is
because PCA allows the entries of W and H to be of arbitrary sign.
As the eigenfaces are used in linear combinations that generally
involve complex cancellations between positive and negative
numbers, many individual eigenfaces lack intuitive meaning.
NMF does not allow negative entries in the matrix factors W and
H. Unlike the unary constraint of VQ, these non-negativity constraints permit the combination of multiple basis images to represent a face. But only additive combinations are allowed, because the
non-zero elements of W and H are all positive. In contrast to PCA,
no subtractions can occur. For these reasons, the non-negativity
constraints are compatible with the intuitive notion of combining
parts to form a whole, which is how NMF learns a parts-based
representation.
As can be seen from Fig. 1, the NMF basis and encodings contain
a large fraction of vanishing coefficients, so both the basis images
and image encodings are sparse. The basis images are sparse because
they are non-global and contain several versions of mouths, noses
and other facial parts, where the various versions are in different
locations or forms. The variability of a whole face is generated by
combining these different parts. Although all parts are used by at

Original
NMF

×

=

×

=

×

=

least one face, any given face does not use all the available parts. This
results in a sparsely distributed image encoding, in contrast to the
unary encoding of VQ and the fully distributed PCA encoding7–9.
We implemented NMF with the update rules for Wand H given in
Fig. 2. Iteration of these update rules converges to a local maximum
of the objective function
n

F¼

m
