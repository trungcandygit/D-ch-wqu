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

               1. initialize with random non-negative values (later: with better heuristics)
               2. maximize 𝑊 :

                                                                                                  𝑋𝐻𝑇 )𝑖𝑘
                                                                                                   (
                                                                               𝑤𝑖𝑘 ← 𝑤𝑖𝑘
                                                                                                (𝑊𝐻𝐻 𝑇 ) 𝑖𝑘

               3. maximize 𝐻:

                                                                                          𝑊 𝑇 𝑋)𝑘𝑗 (
                                                                               ℎ𝑘𝑗 ← ℎ𝑘𝑗 𝑇
                                                                                        (𝑊 𝑊𝐻) 𝑘𝑗

               4. repeat 2-3 until the improvement of ‖𝑋 −𝑊𝐻‖ 2 is below a threshold

            May get stuck in a local fixpoint or saddlepoint – does not guarantee to find the optimum.
            Note: we need 𝑤 𝑖𝑗 > 0, ℎ 𝑖𝑗 > 0, so it is common to add a small constant 𝜀=10 −16 to all values.

            NMF: Multiplicative Update for KL-Divergence
            Gradient descent method for KL-Divergence [LeSe00; LeSe99]:

                                                            𝐿(𝑊, 𝐻) =       ∑∑𝑋    𝑖    𝑗 𝑖𝑗
                                                                                             log (𝑊𝐻) 𝑖𝑗 − (𝑊𝐻) 𝑖𝑗

               1. initialize randomly (or with better heuristics)
               2. maximize 𝑊 :
                                                                                                      𝑥𝑖𝑗
                                                                                             ∑𝑚
                                                                                              𝑗 ℎ 𝑘𝑗 𝑊𝐻 𝑖𝑗
                                                                            𝑤𝑖𝑘 ← 𝑤𝑖𝑘
                                                                                                   =1        (   )

                                                                                             ∑𝑚
                                                                                              𝑗=1 ℎ 𝑘𝑗

               3. maximize 𝐻:
                                                                                                      𝑥𝑖𝑗
                                                                                             ∑𝑛𝑖 𝑤𝑖𝑘 𝑊𝐻
                                                                                               =1         𝑖𝑗 (   )
                                                                             ℎ𝑘𝑗 ← ℎ𝑘𝑗 𝑛
                                                                                      ∑𝑖 𝑤𝑖𝑘   =1

               4. repeat 2-3 until the improvement of 𝐿(𝑊 , 𝐻) is below a threshold

            May get stuck in a local fixpoint or saddlepoint – does not guarantee to find the optimum.

            Note: we need 𝑤 𝑖𝑗 > 0, ℎ 𝑖𝑗 > 0, so it is common to add a small constant 𝜀=10 −16 to all values.

            Other Algorithms for NMF
            When these algorithms are implemented literally, they are slow:
            dense matrix multiplications (in 𝑂(𝑛 3 )) per iteration
https://dm.cs.tu-dortmund.de/en/mlbits/matrix-factorization-non-negative/                                                         2/5

10/2/26, 9:51 AM                                                            Non-negative Matrix Factorization – Lecture Notes

            Many algorithm variants have been developed:
               ▶ Alternating Least Squares [PaTa94]
               ▶ Projected-gradient ALS [Lin07]
               ▶ Quasi-Newton optimization [ZdCi06]
               ▶ Hierarchical Alternating Least Squares [CiPh09]
               ▶ Initialize with spherical-𝑘-means
               ▶ Initialize with SVD [BBLP07]
               ▶ Initialization survey: [LMAC14]
               ▶ Beta divergence [FéId11]
               ▶ Non-negative tensor factorization [CiPh09]
               ▶…

            pLSI [Hofm99] is Non-Negative Matrix Factorization [GaGo05]
            Probabilistic Latent Semantic Indexing (c.f. Part 4) is a probabilistic version of LSI/LSA.

            PLSI used a graphical mixture model with (mixture model notation; different than in Part 4)

                                                                 𝑃(𝑤𝑖 |𝑑𝑗 ) =      ∑ 𝑃𝑡𝑃𝑑 𝑡𝑃𝑤 𝑡
                                                                                        𝑡
                                                                                            ( ) (    𝑗| ) ( 𝑖| )

               ▶ 𝑊: word probability for each topic 𝑃(𝑤𝑖 |𝑡)𝑃(𝑡)
               ▶ 𝐻: topic probability for each document 𝑃(𝑑𝑗 |𝑡)
               ▶ probabilities are non-negative
            “Any (local) maximum likelihood solution of PLSA is a solution of NMF with KL divergence.”
            [GaGo05]

            History of Non-negative Matrix Factorization
            Popularized by Daniel D. Lee, and H. Sebastian Seung.
            Learning the parts of objects by non-negative matrix factorization
            In: Nature 401, 4, 1999. DOI: 10.1038/44565.

            Similar approaches already found in:

               ▶ “Non-negative Rank Factorization”
                     M.W. Jeter, and W.C. Pye. A note on nonnegative rank factorizations
                     In: Linear Algebra and its Applications 38, 3, 1981. DOI: 10.1016/0024-3795(81)90018-5
                     Ji-Cheng Chen. The nonnegative rank factorizations of nonnegative matrices
                 In: Linear Algebra and its Applications 62, 11, 1984. DOI: 10.1016/0024-3795(84)90096-X
               ▶ “Positive Matrix Factorization”
                     Pentti Paatero, and Unto Tapper. Positive matrix factorization: A non-negative factor

https://dm.cs.tu-dortmund.de/en/mlbits/matrix-factorization-non-negative/                                                       3/5

10/2/26, 9:51 AM                                                            Non-negative Matrix Factorization – Lecture Notes

                     model with optimal utilization of error estimates of data values
                     In: Environmetrics 5, 16, 1994. DOI: 10.1002/env.3170050203

            Problems of NMF
            Interesting theoretical analysis:

            David L. Donoho, and Victoria Stodden.
            When Does Non-Negative Matrix Factorization Give a Correct Decomposition into Parts?
            In: NIPS, 8, 2003

            Observations:
               ▶ decomposition is not orthogonal (in contrast to SVD, PCA)
               ▶ decomposition is not unique (not even when 𝑋 = 𝑊𝐻 is achieved;
                 not only permutations and scaling of components)
               ▶ in particular, invariant regions are decomposed arbitrarily
                 (stop words ≈ invariants of the data)
               ▶ 0 values are problematic with multiplicative update strategy
            Need additional constraints, such as sparsity regularization [EgKo04; Hoye04].

            References
            [BBLP07]          Berry, M.W., Browne, M., Langville, A.N., Pauca, V.P. and Plemmons, R.J. 2007. Algorithms and
                              applications for approximate nonnegative matrix factorization. Comput. Stat. Data Anal. 52, 1 (2007),
                              155–173. DOI:10.1016/j.csda.2006.11.006
            [CiPh09]          Cichocki, A. and Phan, A.H. 2009. Fast local algorithms for large scale nonnegative matrix and tensor
                              factorizations. IEICE Trans. Fundam. Electron. Commun. Comput. Sci. 92-A, 3 (2009), 708–721.
                              DOI:10.1587/transfun.E92.A.708
            [EgKo04]          Eggert, J. and Korner, E. 2004. Sparse coding and NMF. IJCNN (2004), 2529–2533.
            [FéId11]          Févotte, C. and Idier, J. 2011. Algorithms for nonnegative matrix factorization with the 𝛽-divergence.
                              Neural Computation. 23, 9 (2011), 2421–2456. DOI:10.1162/NECO\_a\_00168
            [GaGo05]          Gaussier, É. and Goutte, C. 2005. Relation between PLSA and NMF and implications. SIGIR (2005),
                              601–602.
            [Hofm99]          Hofmann, T. 1999. Learning the similarity of documents: An information-geometric approach to document
                              retrieval and categorization. Neural information processing systems, NIPS (1999), 914–920.
            [Hoye04]          Hoyer, P.O. 2004. Non-negative matrix factorization with sparseness constraints. Journal of Machine
                              Learning Research. 5, (2004), 1457–1469.
            [LeSe00]          Lee, D.D. and Seung, H.S. 2000. Algorithms for non-negative matrix factorization. NIPS (2000), 556–562.
            [LeSe99]          Lee, D.D. and Seung, H.S. 1999. Learning the parts of objects by non-negative matrix factorization.
                              Nature. 401, 6755 (1999), 788–791. DOI:10.1038/44565
            [Lin07]           Lin, C.-J. 2007. Projected gradient methods for nonnegative matrix factorization. Neural Computation. 19,
                              10 (2007), 2756–2779. DOI:10.1162/neco.2007.19.10.2756
            [LMAC14]          Langville, A.N., Meyer, C.D., Albright, R., Cox, J. and Duling, D. 2014. Algorithms, initializations, and
                              convergence for the nonnegative matrix factorization. CoRR. abs/1407.7299, (2014).

https://dm.cs.tu-dortmund.de/en/mlbits/matrix-factorization-non-negative/                                                                 4/5

10/2/26, 9:51 AM                                                            Non-negative Matrix Factorization – Lecture Notes
            [PaTa94]          Paatero, P. and Tapper, U. 1994. Positive matrix factorization: A non-negative factor model with optimal
                              utilization of error estimates of data values. Environmetrics. 5, 2 (1994), 111–126.
                              DOI:10.1002/env.3170050203
            [ZdCi06]          Zdunek, R. and Cichocki, A. 2006. Non-negative matrix factorization with quasi-newton optimization.
                              Artificial intelligence and soft computing (ICAISC) (2006), 870–879.

            « k-Means as Matrix Factorization                                                 Examples for Nonnegative Matrix Factorization
                                                                                                                                          »

                              Technische Universität Dortmund                                    Telefon: (+49) 231 755-2777
                              Informatik VIII                                                    Send Email
                              AG Data Mining

                              Otto-Hahn-Straße 12
                              44227 Dortmund

                                                                    Our Research

                                      Imprint           Privacy              Accessibility Statement                     Sitemap

https://dm.cs.tu-dortmund.de/en/mlbits/matrix-factorization-non-negative/                                                                 5/5

