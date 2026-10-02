model with optimal utilization of error estimates of data values
In: Environmetrics 5, 16, 1994. DOI: 10.1002/env.3170050203

## Các vấn đề của NMF

Một phân tích lý thuyết đáng chú ý:

David L. Donoho, and Victoria Stodden.
When Does Non-Negative Matrix Factorization Give a Correct Decomposition into Parts?
In: NIPS, 8, 2003

Các quan sát:

- Phép phân rã không trực giao (khác với SVD, PCA).
- Phép phân rã không duy nhất (kể cả khi đạt được $X = WH$; không chỉ do hoán vị và đổi tỷ lệ các thành phần).
- Đặc biệt, các vùng bất biến bị phân rã một cách tùy ý (từ dừng ≈ các thành phần bất biến của dữ liệu).
- Các giá trị 0 gây khó khăn cho chiến lược cập nhật nhân tính (multiplicative update).

Cần thêm các ràng buộc bổ sung, chẳng hạn điều chuẩn thưa (sparsity regularization) [EgKo04; Hoye04].

## Tài liệu tham khảo

[BBLP07] Berry, M.W., Browne, M., Langville, A.N., Pauca, V.P. and Plemmons, R.J. 2007. Algorithms and applications for approximate nonnegative matrix factorization. Comput. Stat. Data Anal. 52, 1 (2007), 155–173. DOI:10.1016/j.csda.2006.11.006

[CiPh09] Cichocki, A. and Phan, A.H. 2009. Fast local algorithms for large scale nonnegative matrix and tensor factorizations. IEICE Trans. Fundam. Electron. Commun. Comput. Sci. 92-A, 3 (2009), 708–721. DOI:10.1587/transfun.E92.A.708

[EgKo04] Eggert, J. and Korner, E. 2004. Sparse coding and NMF. IJCNN (2004), 2529–2533.

[FéId11] Févotte, C. and Idier, J. 2011. Algorithms for nonnegative matrix factorization with the 𝛽-divergence. Neural Computation. 23, 9 (2011), 2421–2456. DOI:10.1162/NECO_a_00168

[GaGo05] Gaussier, É. and Goutte, C. 2005. Relation between PLSA and NMF and implications. SIGIR (2005), 601–602.

[Hofm99] Hofmann, T. 1999. Learning the similarity of documents: An information-geometric approach to document retrieval and categorization. Neural information processing systems, NIPS (1999), 914–920.

[Hoye04] Hoyer, P.O. 2004. Non-negative matrix factorization with sparseness constraints. Journal of Machine Learning Research. 5, (2004), 1457–1469.

[LeSe00] Lee, D.D. and Seung, H.S. 2000. Algorithms for non-negative matrix factorization. NIPS (2000), 556–562.

[LeSe99] Lee, D.D. and Seung, H.S. 1999. Learning the parts of objects by non-negative matrix factorization. Nature. 401, 6755 (1999), 788–791. DOI:10.1038/44565

[Lin07] Lin, C.-J. 2007. Projected gradient methods for nonnegative matrix factorization. Neural Computation. 19, 10 (2007), 2756–2779. DOI:10.1162/neco.2007.19.10.2756

[LMAC14] Langville, A.N., Meyer, C.D., Albright, R., Cox, J. and Duling, D. 2014. Algorithms, initializations, and convergence for the nonnegative matrix factorization. CoRR. abs/1407.7299, (2014).

[PaTa94] Paatero, P. and Tapper, U. 1994. Positive matrix factorization: A non-negative factor model with optimal utilization of error estimates of data values. Environmetrics. 5, 2 (1994), 111–126. DOI:10.1002/env.3170050203

[ZdCi06] Zdunek, R. and Cichocki, A. 2006. Non-negative matrix factorization with quasi-newton optimization. Artificial intelligence and soft computing (ICAISC) (2006), 870–879.
