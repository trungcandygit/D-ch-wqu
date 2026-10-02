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
