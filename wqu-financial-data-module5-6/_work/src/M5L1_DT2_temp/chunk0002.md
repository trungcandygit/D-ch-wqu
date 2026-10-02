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
