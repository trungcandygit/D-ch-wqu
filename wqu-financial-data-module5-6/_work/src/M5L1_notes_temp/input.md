

MODULE 5 \| LESSON 1

------------------------------------------------------------------------

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

## **1. What is Non-Negative Matrix Factorization?**[¶](#1.-What-is-Non-Negative-Matrix-Factorization?){.anchor-link}

Non-negative matrix factorization (NMF) is a dimensionality reduction technique that decomposes a non-negative matrix into two smaller non-negative matrices. It\'s often used in data analysis, machine learning, and recommender systems. Please review the required readings and come back for the remainder of this lesson.

The mathematical definition of non-negative matrix factorization (NMF) is as follows:

Given a non-negative matrix \$V\$ with dimensions \$m \\times n\$, NMF seeks to find two non-negative matrices:

-   \$W\$ with dimensions \$m \\times k\$ (\$m\$ rows, \$k\$ columns, where \$k\$ is the reduced dimensionality);
-   \$H\$ with dimensions \$k \\times n\$;

Such that: \$\$V \\approx W \* H\$\$

Where:

-   \$\*\$ denotes matrix multiplication
-   The approximation \$\\approx\$ is typically measured using a cost function, such as the Frobenius norm: \$\\lVert V - W \* H \\rVert \^2\$

Constraints: All elements of \$W\$ and \$H\$ must be non-negative real numbers, i.e., \$W\$ ≥ 0, \$H\$ ≥ 0

In simpler terms, we want to find two matrices (\$W\$ and \$H\$) that, when multiplied together, closely resemble our original data matrix (\$V\$). The elements of \$W\$ and \$H\$ must be non-negative (greater than or equal to zero).

Factorization rank in NMF, often denoted as \$k\$, represents the number of factors or components we are trying to extract from data. It essentially determines the dimensionality of the reduced representation.

**Iterative Update Rules:** There are several ways in which \$W\$ and \$H\$ may be found. NMF algorithms typically employ iterative update rules to refine the matrices \$W\$ and \$H\$ until convergence. These rules aim to minimize the difference between the original matrix \$V\$ and the product \$W \* H\$. One common update rule is the multiplicative update rule, which is derived from minimizing the Frobenius norm:

\$\$W\_{ia} \\leftarrow W\_{ia} \* \\frac{(V \* H\^T)\_{ia}}{(W \* H \* H\^T)\_{ia}}\$\$

\$\$H\_{aj} \\leftarrow H\_{aj} \* \\frac{(W\^T \* V)\_{aj}}{(W\^T \* W \* H)\_{aj}}\$\$

Where:

-   \$W\_{ia}\$ represents the element in the \$i\$-th row and \$a\$-th column of matrix \$W\$.
-   \$H\_{aj}\$ represents the element in the \$a\$-th row and \$j\$-th column of matrix \$H\$.
-   \$V\$, \$W\$, and \$H\$ are the matrices as defined in the NMF problem.
-   \$H\^T\$ and \$W\^T\$ denote the transpose of matrices \$H\$ and \$W\$, respectively.
-   \$\*\$ and division represent element-wise multiplication and division, respectively.

The iterative process continues until a convergence criterion is met. This can be based on:

-   Difference in cost function: The algorithm stops when the change in the cost function (e.g., Frobenius norm) between consecutive iterations falls below a predefined threshold.
-   Maximum number of iterations: The algorithm terminates after a fixed number of iterations, even if the cost function hasn\'t fully converged.

Mathematically, convergence can be expressed as:

\$\$\\lVert V - W\^{(t+1)} \* H\^{(t+1)} \\rVert \^2 - \\lVert V - W\^{(t)} \* H\^{(t)} \\rVert \^2 \< \\varepsilon\$\$

Where:

-   \$W\^{(t)}\$ and \$H\^{(t)}\$ represent the matrices \$W\$ and \$H\$ at iteration \$t\$.
-   \$\\varepsilon\$ is a small positive value representing the convergence threshold.

In simpler terms, the algorithm stops when the difference in the approximation error between consecutive iterations becomes sufficiently small.

## **2. Applications of Non-negative Matrix Factorization (NMF) in Financial Engineering**[¶](#2.-Applications-of-Non-negative-Matrix-Factorization-(NMF)-in-Financial-Engineering){.anchor-link}

NMF has gained popularity in financial engineering due to its ability to extract meaningful and interpretable features from financial data. Here are some notable applications:

**Portfolio diversification:** NMF can be used to identify groups of assets that exhibit similar behavior, allowing for the construction of diversified portfolios with reduced risk. By decomposing the correlation matrix of asset returns, NMF can reveal underlying factors that drive asset co-movements and help investors allocate their investments across different asset classes.

**Risk management:** NMF can be used to identify and quantify risk factors in financial markets. By decomposing historical market data, NMF can uncover hidden risk factors that may not be apparent using traditional methods. This information can be used to develop risk management strategies and improve portfolio hedging.

**Asset pricing:** NMF can be applied to asset pricing models to identify factors that explain asset returns. By decomposing the cross-section of asset returns, NMF can reveal underlying factors that drive asset prices and help investors understand the determinants of asset performance.

**Sentiment analysis:** NMF can be used to analyze textual data, such as news articles or social media posts, to extract sentiment and gauge market sentiment toward specific assets or the overall market. This information can be used to inform investment decisions and predict market movements.

**Fraud detection:** NMF can be used to detect anomalies and patterns in financial transactions that may indicate fraudulent activity. By decomposing transaction data, NMF can identify unusual patterns and highlight potential areas of concern for further investigation.

**High-frequency trading:** NMF can be used to analyze high-frequency financial data and identify patterns that can be exploited for trading strategies. By decomposing price and volume data, NMF can reveal hidden relationships and predict short-term price movements.

**Algorithmic trading:** NMF can be integrated into algorithmic trading systems to automate trading decisions based on extracted features and patterns in financial data. This can help improve trading efficiency and profitability.

These are just a few examples of how NMF is being applied in financial engineering. Its ability to extract meaningful and interpretable features from complex financial data makes it a valuable tool for various tasks, including portfolio management, risk management, asset pricing, and trading. As financial markets become increasingly complex and data-driven, the applications of NMF in financial engineering are likely to continue to expand.

## **3. Toy Example**[¶]{.anchor-link}

Let\'s illustrate how the NMF procedure functions with this small toy example. Let\'s consider the following 4x5 data matrix \$V\$:

\$\$V = \\begin{pmatrix} 1 & 2 & 3 & 4 & 5 \\\\ 6 & 7 & 8 & 9 & 10 \\\\ 11 & 12 & 13 & 14 & 15 \\\\ 16 & 17 & 18 & 19 & 20 \\\\ \\end{pmatrix}\$\$

We want to decompose this matrix into two smaller matrices, \$W\$ (4x2) and \$H\$ (2x5), such that \$V ≈ W \* H\$. We initialize \$W\^{(0)}\$ (feature matrix at \$t=0\$) and \$H\^{(0)}\$ (coefficient matrix at \$t=0\$) with random non-negative values:

\$\$W\^{(0)} = \\begin{pmatrix} 0.2 & 0.5 \\\\ 0.8 & 0.3 \\\\ 0.6 & 0.9 \\\\ 0.4 & 0.7 \\\\ \\end{pmatrix}, \\quad H\^{(0)} = \\begin{pmatrix} 0.7 & 0.1 & 0.4 & 0.6 & 0.2 \\\\ 0.3 & 0.6 & 0.2 & 0.4 & 0.8 \\\\ \\end{pmatrix}\$\$

Now, we iteratively update \$W\^{(t)}\$ and \$H\^{(t)}\$ using the multiplicative update rules to minimize the difference between \$V\$ and \$W\^{(t)} \* H\^{(t)}\$. After a few iterations, we might obtain the following updated matrices:

\$\$W = \\begin{pmatrix} 0.9618 & 0. \\\\ 1.9262 & 1.0167 \\\\ 2.8902 & 2.0347 \\\\ 3.8542 & 3.0527 \\\\ \\end{pmatrix}, \\quad H = \\begin{pmatrix} 1.0413 & 2.0823 & 3.1232 & 4.1642 & 5.19 \\\\ 3.9269 & 2.9399 & 1.9529 & 0.966 & 0. \\\\ \\end{pmatrix}\$\$

The final values of Feature matrix \$W\$ and Coefficient matrix \$H\$ represent the decomposed factors of the original matrix \$V\$. Please note that the specific values in the matrices may differ slightly depending on the actual calculations. By multiplying \$W\$ and \$H\$, we get an approximation of \$V\$:

\$\$W \* H = \\begin{pmatrix} 1.0015 & 2.0028 & 3.004 & 4.0052 & 4.9919 \\\\ 5.9983 & 6.9999 & 8.0017 & 9.0034 & 9.9972 \\\\ 10.9996 & 12. & 13.0004 & 14.0008 & 15.0002 \\\\ 16.0009 & 17. & 17.9992 & 18.9983 & 20.0032 \\\\ \\end{pmatrix}\$\$

This resulting matrix is an approximation of the original matrix \$V\$. The difference between \$V\$ and \$W \* H\$ represents the reconstruction error.

\$\$V - W \* H = \\begin{pmatrix} -0.0015 & -0.0028 & -0.004 & -0.0052 & 0.0081 \\\\ 0.0017 & 0.0001 & -0.0017 & -0.0034 & 0.0028 \\\\ 0.0004 & 0. & -0.0004 & -0.0008 & -0.0002 \\\\ -0.0009 & -0. & 0.0008 & 0.0017 & -0.0032 \\\\ \\end{pmatrix}\$\$

The goal of NMF is to find \$W\$ and \$H\$ that minimize this reconstruction error while keeping all elements of \$W\$ and \$H\$ non-negative.

This very simple numerical example demonstrates how NMF can decompose a larger data matrix into smaller matrices, capturing its underlying structure and relationships.

## **4. Basics of Non-Negative Matrix Factorization**[¶]{.anchor-link}

In a nutshell, NMF is about finding a simpler representation of data by breaking it down into two parts that capture the essential features and their importance. It has applications in various fields, including image processing, text analysis, and bioinformatics. Implementation involves the following steps:

-   **Initialization:** Starting with a non-negative matrix, often denoted as \$V\$, that represents data. This is our matrix that contains information about users, products, or any other kind of data.
-   **Decomposition:** The core of NMF is to find two non-negative matrices, typically called \$W\$ and \$H\$, such that the product of \$W\$ and \$H\$ closely approximates the original matrix \$V\$ i.e. \$V \\approx WH\$. In simpler terms, we\'re trying to break down the original data into two parts that, when combined, resemble the original.
-   **Iteration:** NMF algorithms employ iterative processes to refine \$W\$ and \$H\$, minimizing the difference between the product \$W H\$ and the original matrix \$V\$. These iterations involve updating \$W\$ and \$H\$ repeatedly until a satisfactory level of accuracy is reached. This process is often based on gradient descent or multiplicative updates.
-   **Convergence:** The iteration process continues until a convergence criterion is met. This usually means that the difference between \$W H\$ and \$V\$ is small enough or that the algorithm has run for a predetermined number of steps.
-   **Interpretation:** After convergence, the resulting matrices \$W\$ and \$H\$ provide a lower-dimensional representation of the original data. \$W\$ can be seen as containing the basis vectors or features, while \$H\$ represents the coefficients or weights of these features for each data point. Each column of \$W\$ represents a feature, and the corresponding row of \$H\$ shows how strongly this feature is expressed in each data point.

## **5. Properties of Non-negative Matrix Factorization (NMF)**[¶](#5.-Properties-of-Non-negative-Matrix-Factorization-(NMF)){.anchor-link}

Some of the key properties of non-negative matrix factorization (NMF) are:

**Non-negativity:** The most fundamental property of NMF is that it produces non-negative matrices \$W\$ and \$H\$. This means that all elements of these matrices are greater than or equal to zero. This property is crucial for interpretability, as it allows us to understand the resulting factors as additive combinations of original features.

**Dimensionality Reduction:** NMF reduces the dimensionality of the data by decomposing it into two lower-rank matrices. This can be useful for simplifying the data, removing noise, and identifying latent features.

**Parts-based Representation:** NMF often leads to a parts-based representation of the data. This means that the resulting factors (columns of \$W\$) can be interpreted as representing individual parts or components of the original data. For example, in image analysis, NMF might identify factors corresponding to edges, textures, or objects.

**Sparsity:** NMF often produces sparse matrices, meaning that many elements of \$W\$ and \$H\$ are zero. This can be beneficial for interpretability, as it highlights the most important features and reduces the complexity of the model.

**Interpretability:** Due to its non-negativity and parts-based representation, NMF is often considered more interpretable than other dimensionality reduction techniques like Principal Component Analysis (PCA). The resulting factors can be more easily related to the original features, making it easier to understand the underlying structure of the data.

**Flexibility:** NMF can be applied to a wide variety of data types, including text, images, audio, and biological data. It can also be adapted to different applications by using different cost functions and constraints.

**Computational Efficiency:** NMF algorithms are generally computationally efficient, especially for sparse data. This makes them suitable for large-scale datasets.

**Non-uniqueness:** The NMF decomposition is not unique, meaning that there can be multiple solutions for \$W\$ and \$H\$ that give a good approximation of \$V\$. This can be addressed by using regularization techniques or by imposing additional constraints.

These are some of the key properties of NMF. They contribute to its popularity and effectiveness in various data analysis and machine learning tasks.

## **6. Challenges and limitations of Non-negative Matrix Factorization (NMF)**[¶](#6.-Challenges-and-limitations-of-Non-negative-Matrix-Factorization-(NMF)){.anchor-link}

Non-negative Matrix Factorization (NMF) has some challenges and limitations:

**Non-Uniqueness of Solutions:** The NMF decomposition is inherently non-unique, meaning that there can be multiple pairs of factor matrices (\$W\$ and \$H\$) that, when multiplied together, approximate the original data matrix (\$V\$) equally well. This arises from the fact that there are often many ways to represent the same data using different combinations of non-negative factors.

> -   Implications: This non-uniqueness can make it challenging to interpret the results of NMF, as different solutions may lead to different interpretations of the underlying factors. It can also make it difficult to compare results across different runs of the algorithm or when using different initialization strategies.
> -   Mitigation: Techniques like regularization, which adds constraints or penalties to the objective function, can help reduce the non-uniqueness issue by encouraging solutions with specific properties, such as sparsity or orthogonality.

**Initialization Sensitivity:** The performance of NMF algorithms can be sensitive to the initial values of the factor matrices (\$W\$ and \$H\$). Different initialization strategies can lead to the algorithm converging to different local minima, resulting in different solutions.

> -   Implications: This sensitivity to initialization can make the results of NMF less reproducible and potentially lead to suboptimal solutions.
> -   Mitigation: Exploring different initialization methods, such as random initialization, NNDSVD (Non-negative Double Singular Value Decomposition), or using prior knowledge about the data, can help mitigate this issue and potentially improve the quality of the solutions.

**Determining the Optimal Number of Factors:** Choosing the right number of factors (or components) is a crucial step in NMF. Too few factors may not capture all the important information in the data, leading to a loss of information and reduced accuracy. Too many factors can lead to overfitting, where the model captures noise or irrelevant patterns in the data, reducing its ability to generalize to new data.

> -   Implications: Selecting an inappropriate number of factors can significantly impact the performance and interpretability of the NMF model.
> -   Mitigation: Model selection techniques, such as cross-validation, silhouette analysis, or using domain expertise to assess the interpretability of the factors, can help guide the choice of the optimal number of factors.

**Non-negative Data Requirement:** NMF is fundamentally designed to work with non-negative data. The algorithm assumes that the input data matrix (\$V\$) and the resulting factor matrices (\$W\$ and \$H\$) have only non-negative elements. This is because the non-negativity constraint is essential for ensuring the interpretability of the factors as additive combinations of original features.

> -   Implications: This limitation restricts the applicability of NMF to datasets where negative values are not meaningful or where they can be transformed into a non-negative representation.
> -   Mitigation: For data with negative values, techniques like shifting (adding a constant to all elements), scaling (multiplying by a positive constant), or using alternative matrix factorization methods that can handle mixed-sign data might be considered.

**Interpretability Challenges:** While NMF is often considered more interpretable than other dimensionality reduction techniques like PCA, interpreting the resulting factors can still be subjective and require domain expertise. The factors represent latent features or patterns in the data, and their meaning may not always be immediately obvious.

> -   Implications: The interpretation of NMF factors requires careful analysis and consideration of the context of the data and the specific application.
> -   Mitigation: Techniques like visualizing the factor loadings, examining the top contributing features for each factor, and using domain knowledge to relate the factors to real-world concepts can aid in interpretation.

**Computational Cost:** NMF algorithms can be computationally expensive, especially for large datasets or a high number of factors. The iterative nature of the algorithm and the need to update the factor matrices repeatedly can lead to significant computation time.

> -   Implications: The computational cost of NMF can be a limiting factor for large-scale applications or when real-time analysis is required.
> -   Mitigation: Using efficient algorithms, such as those based on sparse matrix operations, can help reduce the computational burden. Additionally, techniques like online NMF, which updates the factorization incrementally as new data arrives, can be more computationally tractable for streaming data.

## **7. Comparing NMF with Other Matrix Decomposition Techniques**[¶]{.anchor-link}

**Principal component analysis (PCA)** is a dimensionality reduction technique that transforms high-dimensional data into a lower-dimensional space by identifying the directions (principal components) along which the data varies the most. These principal components are orthogonal and capture the maximum variance in the data, allowing for data simplification, noise reduction, and feature extraction. PCA is often used for data visualization, noise reduction, and as a preprocessing step for machine learning. It\'s a versatile technique applicable to various data types, but the resulting components can be less interpretable. In summary, PCA finds the most important patterns in the data and represents them using a smaller number of variables (principal components) that are orthogonal. This simplifies the data while preserving its essential information.

**Singular value decomposition (SVD)** is a more general-purpose matrix factorization technique that decomposes data into three matrices, capturing latent factors and their relationships. SVD is a matrix factorization technique that decomposes a matrix into three constituent matrices: \$U\$, \$\\Sigma\$ and \$V\^T\$. These matrices capture the latent factors and relationships within the data, allowing for dimensionality reduction, noise reduction, and data compression. It\'s widely used in various applications, including recommendation systems, image compression, and noise reduction. However, like PCA, SVD components can be less interpretable. In summary, SVD breaks down a matrix into simpler components that reveal its underlying structure and relationships.

**Independent component analysis (ICA)** is a computational technique that aims to separate a multivariate signal into additive subcomponents that are statistically independent and non-Gaussian. In summary, ICA aims to uncover the hidden sources or factors that contribute to a mixed signal. It\'s like \"unmixing\" a cocktail to identify its individual ingredients.

**Non-negative matrix factorization (NMF)** specializes in decomposing non-negative data into two non-negative matrices, resulting in a parts-based representation. NMF decomposes non-negative data into two non-negative matrices, \$W\$ and \$H\$. This decomposition results in a parts-based representation, where the components (columns of \$W\$) represent individual parts or features of the original data, and their weights (rows of \$H\$) indicate their importance in each data point. This makes NMF particularly useful for tasks where interpretability and a parts-based decomposition are desired, such as image processing, text analysis, and topic modeling. NMF often produces sparse results, further enhancing interpretability. In essence, NMF breaks down data into additive, non-negative components that represent its essential parts or features.

PCA, SVD, ICA, and NMF are all techniques used for dimensionality reduction and feature extraction, but they differ in their approaches and properties. Key differences are:

-   **Constraints:** PCA and SVD enforce orthogonality on their components, ICA enforces independence, and NMF enforces non-negativity.
-   **Interpretation:** PCA and SVD components can be difficult to interpret while ICA components represent underlying sources and NMF components are often more easily related to the original features.
-   **Sparsity:** PCA and SVD typically produce dense results while ICA can be sparse or dense and NMF often leads to sparse representations.
-   **Data types:** PCA, SVD, and ICA can be applied to any type of data, while NMF is limited to non-negative data.

The choice between PCA, SVD, ICA, and NMF depends on the specific application and the desired properties. If capturing the maximum variance is the primary goal, PCA might be more appropriate. If a more general-purpose decomposition is needed, SVD might be more suitable. If blind source separation is desired, ICA would be the preferred technique. If interpretability and a parts-based representation are crucial, NMF is a good choice.

In some cases, it can be beneficial to use these techniques in combination. For example, PCA or SVD could be used for initial dimensionality reduction, and then ICA or NMF could be applied to extract interpretable features from the reduced data.

## **8. Extensions of Non-negative Matrix Factorization (NMF)**[¶](#8.-Extensions-of-Non-negative-Matrix-Factorization-(NMF)){.anchor-link}

While the standard NMF algorithm is widely used, various extensions and variations have been developed to address specific needs and improve performance. Here are a few notable ones:

### **8.1 Sparse NMF**[¶]{.anchor-link}

Sparse non-negative matrix factorization (NMF) is a variation of the standard NMF algorithm that enforces sparsity on the factor matrices \$W\$ and \$H\$. This means that it encourages many elements of these matrices to be zero.

**Reasoning:** Sparsity is often desirable in NMF for several reasons:

-   Interpretability: Sparse factor matrices are easier to interpret because they highlight the most important features and reduce the complexity of the model.
-   Feature Selection: Sparsity can act as a form of feature selection, identifying the most relevant features for representing the data.
-   Noise Reduction: By focusing on a smaller set of features, sparse NMF can help reduce the influence of noise in the data.

**Methods:** Sparsity in NMF is typically achieved by adding sparsity-inducing regularization terms to the NMF objective function. These terms penalize non-zero elements in the factor matrices, encouraging them to become zero. Common regularization techniques include:

-   L1 regularization: Adds a penalty proportional to the sum of the absolute values of the elements in the factor matrices.
-   L2 regularization: Adds a penalty proportional to the sum of the squared values of the elements in the factor matrices.
-   Other sparsity constraints: Various other constraints can be used to enforce sparsity, such as limiting the number of non-zero elements in each row or column of the factor matrices.

**Benefits:** Sparse NMF offers several benefits compared to standard NMF:

-   Improved interpretability: Sparse factor matrices are easier to understand and relate to the original features.
-   Better feature selection: Sparsity helps identify the most relevant features for representing the data.
-   Reduced noise: By focusing on a smaller set of features, sparse NMF can help reduce the influence of noise.
-   Enhanced generalization: Sparse models often generalize better to new data because they are less prone to overfitting.

### **8.2 Constrained NMF**[¶]{.anchor-link}

Constrained non-negative matrix factorization (NMF) is a variation of standard NMF where additional constraints are imposed on the factor matrices (\$W\$ and \$H\$) during the factorization process. These constraints are often based on prior knowledge about the data or specific properties desired in the resulting factors.

**Reasoning:** Incorporating constraints allows for tailoring NMF to specific applications and data characteristics. This can improve the quality of the factorization, enhance interpretability, and ensure the results are more meaningful in the context of the problem.

**Examples of Constraints:**

-   Sum-to-one Constraint: This constraint enforces that the elements in each row of \$H\$ (or each column of \$W\$) sum to one. It\'s commonly used in topic modeling, where each row of \$H\$ represents a document and the elements indicate the proportion of each topic in that document.
-   Orthogonality Constraint: This constraint requires that the columns of \$W\$ (or rows of \$H\$) be orthogonal to each other. It encourages the factors to be independent and represent distinct aspects of the data.
-   Sparsity Constraint: Similar to sparse NMF, this constraint promotes sparsity in the factor matrices, leading to more interpretable and noise-resistant results.
-   Domain-Specific Constraints: Constraints based on domain knowledge can be incorporated to guide the factorization. For example, in image processing, constraints could be used to ensure that the factors represent specific image features like edges or textures.

**Benefits:** Constrained NMF offers several advantages:

-   Improved Factorization: Constraints can guide the factorization process toward more meaningful and relevant solutions.
-   Enhanced Interpretability: Constraints can make the resulting factors easier to interpret and relate to the original data.
-   Tailored Solutions: Constraints allow for adapting NMF to specific applications and data characteristics.
-   Control over Factor Properties: Constraints can be used to enforce desired properties in the factors, such as sparsity, orthogonality, or specific patterns.

In essence, constrained NMF allows you to customize the NMF algorithm to your specific needs by incorporating prior knowledge or desired properties into the factorization process. This can lead to more insightful and relevant results compared to standard NMF.

### **8.3 Semi-NMF**[¶]{.anchor-link}

Semi-NMF, or semi non-negative matrix factorization, is a variation of NMF where the non-negativity constraint is relaxed on one of the factor matrices (either \$W\$ or \$H\$). This means that one of the matrices can contain both positive and negative values while the other remains non-negative.

**Reasoning:** The standard NMF algorithm requires all elements of the factor matrices to be non-negative. However, in some applications, negative values can be meaningful and provide valuable insights. For instance, in financial data analysis, negative returns are possible and should be considered in the factorization. Semi-NMF allows for the decomposition of such mixed-sign data while still preserving the interpretability and parts-based representation benefits of NMF.

**How it Works:** Semi-NMF modifies the standard NMF objective function and update rules to accommodate the relaxation of the non-negativity constraint. The algorithm still aims to find two matrices (\$W\$ and \$H\$) whose product approximates the original data matrix (\$V\$), but one of the matrices can now have negative elements.

**Benefits:**

-   Handling Mixed-Sign Data: Semi-NMF enables the decomposition of data with both positive and negative values, which is crucial for applications where negative values are meaningful.
-   Preserving Interpretability: While allowing negative values, semi-NMF still retains the interpretability and parts-based representation benefits of NMF.
-   Flexibility: It offers more flexibility compared to standard NMF by accommodating a wider range of data types.

**Considerations:**

-   When using semi-NMF, it\'s crucial to choose which factor matrix (\$W\$ or \$H\$) should be allowed to have negative values based on the specific application and the interpretation of the factors.
-   The interpretation of the factors may differ slightly from standard NMF due to the presence of negative values. Careful consideration should be given to the meaning of negative values in the context of the problem.

In summary, semi-NMF is a valuable extension of NMF that allows for the decomposition of mixed-sign data while still retaining many of the benefits of standard NMF. It offers more flexibility and can provide insights into data where negative values are meaningful.

### **8.4 Convex NMF**[¶]{.anchor-link}

Convex non-negative matrix factorization (convex NMF) is a variant of NMF where convexity constraints are imposed on the factorization. This means that the factor matrices (\$W\$ and \$H\$) are restricted to lie within a convex set.

**Reasoning:** Incorporating convexity constraints in NMF can lead to several benefits:

-   Uniqueness: Convex NMF can help address the non-uniqueness issue inherent in standard NMF. By restricting the solution space to a convex set, it can reduce the number of possible solutions and potentially lead to a unique or more stable solution.
-   Improved Convergence: Convexity constraints can improve the convergence properties of the NMF algorithm, making it more likely to find a good solution efficiently.
-   Better Interpretability: In some cases, convexity constraints can lead to more interpretable factors by encouraging them to represent specific features or patterns in the data.

**Methods:** Convexity constraints in NMF are typically enforced by restricting the factor matrices to lie within a convex set. This can be achieved through various methods, such as:

-   Convex Hull: The factor matrices are constrained to lie within the convex hull of a set of data points or features.
-   Polytope Constraints: The factor matrices are restricted to lie within a specific polytope defined by a set of linear inequalities.
-   Other Convex Constraints: Various other convex constraints can be used, such as restricting the factor matrices to be positive semidefinite or to have specific sparsity patterns.

**Benefits:** Convex NMF offers several advantages compared to standard NMF:

-   Potential Uniqueness: It can help address the non-uniqueness issue of standard NMF, leading to more stable and reliable solutions.
-   Improved Convergence: Convexity constraints can improve the convergence properties of the NMF algorithm.
-   Enhanced Interpretability: In some cases, convexity constraints can lead to more interpretable factors.

**Considerations:**

-   Choosing appropriate convex constraints is crucial for the success of convex NMF. The constraints should be relevant to the specific application and data characteristics.
-   Enforcing convexity constraints can increase the computational complexity of the NMF algorithm. However, efficient algorithms have been developed to address this challenge.

In summary, convex NMF is a valuable variant of NMF that incorporates convexity constraints to improve the uniqueness, convergence, and interpretability of the factorization. It offers a powerful tool for various data analysis and machine learning tasks.

### **8.5 Online-NMF:**[¶](#8.5-Online-NMF:){.anchor-link}

Online non-negative matrix factorization (Online NMF) is a variant of NMF designed to handle streaming data, where new data points arrive continuously over time.

**Reasoning:** Standard NMF assumes that the entire data matrix is available at once. However, in many real-world scenarios, data arrives in a streaming fashion, and it\'s not feasible to store and process the entire dataset at once. Online NMF addresses this challenge by updating the factorization incrementally as new data points become available.

**How it Works:** Online NMF algorithms typically employ incremental update rules to incorporate new data points without recomputing the entire factorization. These update rules adjust the factor matrices (\$W\$ and \$H\$) based on the new data, gradually refining the factorization over time.

**Benefits:**

-   Handling Streaming Data: Online NMF is well-suited for analyzing streaming data, where new data points arrive continuously.
-   Adaptability: It can adapt to changes in the data distribution over time, making it suitable for dynamic environments.
-   Efficiency: It avoids the need to store and process the entire dataset, making it more memory-efficient and computationally tractable for large datasets.
-   Real-time Analysis: Online NMF enables real-time analysis of streaming data, providing timely insights as new data becomes available.

**Key Considerations:**

-   Choosing an appropriate update rule is crucial for the performance of online NMF. Different update rules have different properties and may be more suitable for specific types of data or applications.
-   The learning rate, which controls the step size of the updates, needs to be carefully tuned to balance stability and adaptability.
-   Online NMF may require more iterations or data points to converge compared to standard NMF, as the factorization is updated incrementally.

In summary, online NMF is a valuable variant of NMF designed for handling streaming data. It offers adaptability, efficiency, and real-time analysis capabilities, making it suitable for various dynamic data environments.

## **9. Application of NMF for Portfolio Diversification**[¶]{.anchor-link}

In this section, we will explore a simplified example of portfolio diversification using the NMF technique. We will approach this by leveraging NMF\'s ability to extract meaningful features from financial data and providing a systematic way to diversify a portfolio based on underlying factors. This can be done with the following steps:

-   **Correlation Matrix:** We start with the correlation matrix of asset returns, which captures the relationships between different assets.
-   **NMF Decomposition:** NMF decomposes the correlation matrix into factor loadings (\$W\$) and factor scores (\$H\$). The factor loadings represent the contribution of each asset to each factor, while the factor scores represent the importance of each factor over time.
-   **Factor Interpretation:** By analyzing the factor loadings, we can identify groups of assets that exhibit similar behavior and understand the underlying factors that drive asset co-movements.
-   **Diversification:** We can diversify our portfolio by selecting assets that load highly on different factors. This reduces the overall portfolio risk by spreading investments across different sources of risk.
-   **Portfolio Construction:** Based on the factor analysis, we can determine the weights for each asset in our portfolio, ensuring non-negativity and summing to 1.

In the following code snippet, we construct a simplified portfolio of data for five stocks: AAPL, MSFT, GOOG, AMZN, and TSLA. Then, we construct a `returns_df` DataFrame, containing daily returns for the selected assets.

In \[2\]:

``` calibre12
# Download historical data for the tickers
tickers = ['AAPL', 'MSFT', 'GOOG', 'AMZN', 'TSLA', 'NVDA', 'META', 'JPM']
data = yf.download(tickers, start='2022-01-01', end='2023-01-01')['Close']

# 1. Load asset returns data
returns_df = data.pct_change().dropna()
returns_df
```

``` calibre12
YF.download() has changed argument auto_adjust default to True
```

Out\[2\]:

  Ticker       AAPL        AMZN        GOOG        JPM         META        MSFT        NVDA        TSLA
  ------------ ----------- ----------- ----------- ----------- ----------- ----------- ----------- -----------
  Date                                                                                             
  2022-01-04   -0.012691   -0.016916   -0.004535   0.037910    -0.005937   -0.017147   -0.027589   -0.041833
  2022-01-05   -0.026600   -0.018893   -0.046830   -0.018282   -0.036728   -0.038388   -0.057562   -0.053471
  2022-01-06   -0.016693   -0.006711   -0.000744   0.010624    0.025573    -0.007902   0.020794    -0.021523
  2022-01-07   0.000988    -0.004288   -0.003973   0.009908    -0.002015   0.000510    -0.033040   -0.035447
  2022-01-10   0.000116    -0.006570   0.011456    0.000957    -0.011212   0.000732    0.005615    0.030342
  \...         \...        \...        \...        \...        \...        \...        \...        \...
  2022-12-23   -0.002799   0.017425    0.017562    0.004745    0.007855    0.002267    -0.008671   -0.017551
  2022-12-27   -0.013878   -0.025924   -0.020933   0.003504    -0.009827   -0.007414   -0.071354   -0.114089
  2022-12-28   -0.030685   -0.014692   -0.016718   0.005465    -0.010780   -0.010255   -0.006019   0.033089
  2022-12-29   0.028324    0.028844    0.028800    0.005738    0.040132    0.027630    0.040396    0.080827
  2022-12-30   0.002469    -0.002138   -0.002473   0.006606    0.000665    -0.004938   0.000753    0.011164

250 rows × 8 columns

Now that we have the `returns_df` DataFrame, containing daily returns for the selected assets, we can use it in the NMF portfolio diversification code:

In \[3\]:

``` calibre12
# 2. Calculate the correlation matrix
correlation_matrix = returns_df.corr()
correlation_matrix
```

Out\[3\]:

  Ticker   AAPL       AMZN       GOOG       JPM        META       MSFT       NVDA       TSLA
  -------- ---------- ---------- ---------- ---------- ---------- ---------- ---------- ----------
  Ticker                                                                                
  AAPL     1.000000   0.695905   0.790573   0.547907   0.592901   0.824902   0.763022   0.637218
  AMZN     0.695905   1.000000   0.724022   0.501689   0.605782   0.741197   0.709077   0.591533
  GOOG     0.790573   0.724022   1.000000   0.511192   0.681990   0.845283   0.767571   0.556652
  JPM      0.547907   0.501689   0.511192   1.000000   0.393247   0.532507   0.528095   0.364935
  META     0.592901   0.605782   0.681990   0.393247   1.000000   0.625860   0.607685   0.398646
  MSFT     0.824902   0.741197   0.845283   0.532507   0.625860   1.000000   0.787883   0.563946
  NVDA     0.763022   0.709077   0.767571   0.528095   0.607685   0.787883   1.000000   0.680243
  TSLA     0.637218   0.591533   0.556652   0.364935   0.398646   0.563946   0.680243   1.000000

Non-negative matrix factorization (NMF) is fundamentally designed to work with non-negative matrices. This means that the input matrix (\$V\$) and the resulting factor matrices (\$W\$ and \$H\$) are expected to have only non-negative elements. However, in the specific context of portfolio diversification using NMF, the input matrix is often the correlation matrix of asset returns, which can contain negative values representing inverse relationships between assets.

In our example, the correlation matrix has only positive values. But if required, we would consider the following adjustments in certain cases:

-   **Shifting:** we can shift the correlation matrix by adding 1 to all elements, ensuring all values are between 0 and 2. This might slightly alter the interpretation of the factor loadings but won\'t significantly affect the overall diversification strategy.
-   **Absolute Values:** Another option is to use the absolute values of the correlation coefficients, focusing on the strength of the relationships rather than their direction. This might be useful when we want to identify groups of assets with strong co-movements regardless of whether they are positive or negative.

Next, we apply NMF to break down the correlation matrix into two smaller matrices:

In \[4\]:

``` calibre12
# 3. Apply NMF
n_components = 5  # Number of factors to extract
model = NMF(n_components=n_components, init='random', random_state=0)
W = model.fit_transform(correlation_matrix)  # Factor loadings
H = model.components_  # Factor scores
```

Here, we use the `NMF()` function from the `sklearn.decomposition` module in the scikit-learn library.

-   `n_components` specifies the number of (or components) to extract from the data. In the context of portfolio diversification, these factors represent underlying drivers of asset co-movements. In this specific case, setting n_components = 5 assumes that there are likely around 5 major underlying factors driving the co-movements of the assets in the portfolio. This is a reasonable starting point, but we should experiment with different values to find the optimal number for our specific data and investment goals. Choosing the right number of components is often an iterative process involving domain expertise, experimentation, and model evaluation.
-   `init='random'` specifies the initialization method for the factor matrices (\$W\$ and \$H\$). `'random'` initializes them with random non-negative values.
-   `random_state=0` sets a random seed for reproducibility.

The next step involves analyzing the factor loadings (\$W\$) obtained from the NMF decomposition to understand the underlying factors driving asset co-movements and using this information to diversify the portfolio. We can access the factor loadings (\$W\$) using the variable `W` obtained in this step:

In \[5\]:

``` calibre12
# Convert W to a pandas DataFrame for easier analysis
W_df = pd.DataFrame(W, index=returns_df.columns)
W_df
```

Out\[5\]:

           0          1          2              3          4
  -------- ---------- ---------- -------------- ---------- ----------
  Ticker                                                   
  AAPL     0.464388   0.268745   2.308214e-01   0.780431   0.083933
  AMZN     0.667705   0.000000   1.201896e-01   0.276369   0.499711
  GOOG     0.458127   0.178795   1.562598e-01   0.803559   0.246556
  JPM      0.251893   0.864869   1.182338e-07   0.396028   0.208776
  META     0.003509   0.265379   2.902255e-01   0.680854   0.639626
  MSFT     0.550908   0.165173   1.144742e-01   0.780761   0.174299
  NVDA     0.406847   0.266952   3.439407e-01   0.672617   0.173926
  TSLA     0.310220   0.169135   6.282613e-01   0.296556   0.046811

The factor loadings matrix (\$W\$) provides insights into how much each asset contributes to each factor.

-   Rows: Represent the assets in your portfolio.
-   Columns: Represent the extracted factors.
-   Values: Indicate the strength of the relationship between an asset and a factor. Higher values suggest a stronger contribution of the asset to that factor.

To interpret the factors, we need to examine the assets that load highly on each factor. For each factor, we need to identify the assets with the highest loadings. These assets are most strongly associated with that factor.

In \[6\]:

``` calibre12
# Identify top contributing assets for each factor
n_top_assets = 3
for factor_num in range(W_df.shape[1]):
    print(f"\nFactor {factor_num + 1}:")
    top_assets = W_df.iloc[:, factor_num].nlargest(n_top_assets)
    print(top_assets)
```

``` calibre12
Factor 1:
Ticker
AMZN    0.667705
MSFT    0.550908
AAPL    0.464388
Name: 0, dtype: float64

Factor 2:
Ticker
JPM     0.864869
AAPL    0.268745
NVDA    0.266952
Name: 1, dtype: float64

Factor 3:
Ticker
TSLA    0.628261
NVDA    0.343941
META    0.290226
Name: 2, dtype: float64

Factor 4:
Ticker
GOOG    0.803559
MSFT    0.780761
AAPL    0.780431
Name: 3, dtype: float64

Factor 5:
Ticker
META    0.639626
AMZN    0.499711
GOOG    0.246556
Name: 4, dtype: float64
```

This output shows the top 3 contributing assets for each factor and their loadings. Remember that we can adjust `n_top_assets` and the interpretation of factors based on our specific data and investment goals. For now, we keep the top 3 contributing assets. We can now use this information to interpret the factors and develop a diversification strategy. Based on the top contributing assets for each factor, we can attempt to interpret their economic or financial meaning:

-   **Factor 1:** Dominated by AMZN, MSFT, and AAPL. This factor could be interpreted as representing **Large-Cap Tech or Growth Stocks**. These companies are often associated with innovation, technological advancements, and high growth potential.
-   **Factor 2:** Primarily driven by JPM, with moderate contributions from AAPL and NVDA. This factor might represent **Financials or Value Stocks**. JPM is a major financial institution, and this factor could reflect the performance of the financial sector or companies with more established value characteristics.
-   **Factor 3:** Led by TSLA and NVDA, with some influence from META. This factor could be interpreted as **Electric Vehicles or Disruptive Technology**. TSLA is a leading electric vehicle manufacturer, and NVDA is a major semiconductor company, both associated with disruptive technologies.
-   **Factor 4:** Strongly influenced by GOOG, MSFT, and AAPL. This factor seems to represent **Big Tech or Market Leaders**. These companies are dominant players in the technology sector and have a significant impact on the overall market. It might overlap somewhat with Factor 1, but with a broader focus on market leadership.
-   **Factor 5:** Predominantly driven by META, AMZN, and GOOG. This factor could be interpreted as **Social Media and E-commerce**. META is a major social media company, AMZN is a dominant e-commerce player, and GOOG has a strong presence in both areas. Diversification Strategy

Based on this factor interpretation, a diversified portfolio could be constructed by selecting assets that load highly on different factors. For example, we could consider:

-   **Large-Cap Tech/Growth:** AMZN or MSFT (Factor 1)
-   **Financials/Value:** JPM (Factor 2)
-   **Electric Vehicles/Disruptive Tech:** TSLA or NVDA (Factor 3)
-   **Big Tech/Market Leaders:** GOOG or AAPL (Factor 4)
-   **Social Media/E-commerce:** META (Factor 5)

By diversifying across these factors, we would be spreading investments across different sectors and risk profiles, potentially reducing overall portfolio risk and enhancing returns.

This was just a simplified interpretation for this demonstration. Further analysis might be needed to refine the factor definitions. And we also need to remember that the optimal diversification strategy depends on individual investment goals, risk tolerance, and time horizon.

## **10. Conclusion**[¶]{.anchor-link}

In this lesson, we learned about Non-negative Matrix Factorization (NMF), a dimensionality reduction technique with applications in financial engineering. We discussed the definition, properties, and variations of NMF, comparing it to other methods like PCA, SVD, and ICA. The lesson then focused on NMF\'s applications in finance, including portfolio diversification, risk management, and sentiment analysis. It demonstrated a simplified but practical example of using NMF for portfolio diversification with stock market data, showing how to extract and interpret factors to build a diversified portfolio. Overall, the lesson highlighted NMF as a powerful and interpretable tool for analyzing financial data and making informed investment decisions.

------------------------------------------------------------------------

Copyright 2024 WorldQuant University. This content is licensed solely for personal use. Redistribution or publication of this material is strictly prohibited.
