# M5L1_DT2

10/2/26, 9:51 AM                                                            Non-negative Matrix Factorization – Lecture Notes

              › Machine Learning Bits › Non-negative Matrix Factorization

            Non-negative Matrix Factorization
            These contents were automatically converted from lecture slides. Some contents have been withheld for copyright or
            technical limitations. The contents have not been optimally reformatted for online access. All rights reserved unless
            otherwise noted.

            Non-negative Matrix Factorization (NMF, NNMF) [LeSe99]
            Given a data matrix 𝑋 ∈ ℝ 𝑚×𝑛 ≥ 0, and
            the parameter 𝑘 with 1 ≤ 𝑘 ≤ min{𝑚, 𝑛},
            find two matrixes

                                               𝑊 ∈ ℝ𝑚 𝑘 ≥ 0 ×

                                               𝐻 ∈ ℝ𝑘 𝑛 ≥ 0×

            such that

                                                     𝑋 ≈ 𝑊𝐻
            Variant 1: Squared error – minimize

                                                                ‖ 𝑋−𝑊𝐻‖ =      2
                                                                                       ∑ ∑ 𝑋 − 𝑊𝐻
                                                                                         𝑖     𝑗
                                                                                                   (   𝑖𝑗   (   ) 𝑖𝑗 )
                                                                                                                         2

            Variant 2: Divergence – minimize the log-likelihood of 𝑋 𝑖𝑗 ∼ Poisson(𝑊𝐻) 𝑖𝑗

                                                           𝐿(𝑊, 𝐻) = −       ∑∑𝑋   𝑖    𝑗 𝑖𝑗
                                                                                             log (𝑊𝐻) 𝑖𝑗 − (𝑊𝐻) 𝑖𝑗

            NMF: Multiplicative Update for Squared Error
            Gradient descent method for squared error [LeSe00; LeSe99]:

https://dm.cs.tu-dortmund.de/en/mlbits/matrix-factorization-non-negative/                                                           1/5

10/2/26, 9:51 AM                                                            Non-negative Matrix Factorization – Lecture Notes

                                                                ‖ 𝑋−𝑊𝐻‖ =      2
                                                                                       ∑ ∑ 𝑋 − 𝑊𝐻
                                                                                         𝑖     𝑗
                                                                                                   (    𝑖𝑗   (       ) 𝑖𝑗 )
                                                                                                                              2
