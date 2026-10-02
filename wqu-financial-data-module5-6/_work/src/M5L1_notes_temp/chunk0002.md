## **Non-Negative Matrix Factorization**[¶]{.anchor-link}

  ----------------------------------- ------------------------------------------------------------------------------------------------------------------------------
  **Reading Time**                    50 minutes

  **Prior Knowledge**                 Basic understanding of linear algebra and statistics: Matrices and vectors; Eigenvalues and eigenvectors; Basic statistics;\
                                      Familiarity with Python programming: Basic Python syntax, data manipulation and numerical operations;\
                                      Fundamental financial concepts: Asset returns and correlation; Portfolio diversification; Sentiment analysis

  **Keywords**                        Non-negative Matrix Factorization (NMF), Dimensionality Reduction, Feature Extraction, Parts-based Representation,\
                                      Sparsity, Interpretability, Sparse NMF, Constrained NMF, Semi-NMF, Convex NMF, Online NMF, Sentiment Analysis,\
                                      Principal Component Analysis (PCA), Singular Value Decomposition (SVD), Independent Component Analysis (ICA),\
                                      Factor Loadings, Factor Scores
  ----------------------------------- ------------------------------------------------------------------------------------------------------------------------------

------------------------------------------------------------------------

*In this lesson, we explore non-negative matrix factorization (NMF), a technique to decompose a non-negative matrix into two smaller non-negative matrices. It\'s often used for dimensionality reduction, feature extraction, and topic modeling. This lesson offers a comprehensive overview of NMF, its variations, and its applications, with a focus on financial engineering, particularly portfolio diversification.*

In \[1\]:

``` calibre12
# Loading libraries
import pandas as pd
import yfinance as yf

from sklearn.decomposition import NMF
```
