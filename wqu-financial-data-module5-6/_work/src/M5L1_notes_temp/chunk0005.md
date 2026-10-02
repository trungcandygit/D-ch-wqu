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
