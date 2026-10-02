1. khởi tạo với các giá trị không âm ngẫu nhiên (sau này: với các phương pháp heuristic tốt hơn)
2. tối đa hóa $W$:

$$w_{ik} \leftarrow w_{ik} \frac{(XH^T)_{ik}}{(WHH^T)_{ik}}$$

3. tối đa hóa $H$:

$$h_{kj} \leftarrow h_{kj} \frac{(W^T X)_{kj}}{(W^T WH)_{kj}}$$

4. lặp lại bước 2-3 cho đến khi mức cải thiện của $\|X - WH\|^2$ nhỏ hơn một ngưỡng

Có thể bị kẹt tại một điểm bất động cục bộ hoặc điểm yên ngựa – không đảm bảo tìm được nghiệm tối ưu.
Lưu ý: ta cần $w_{ij} > 0$, $h_{ij} > 0$, vì vậy thường cộng một hằng số nhỏ $\varepsilon = 10^{-16}$ vào mọi giá trị.

## NMF: Cập nhật nhân tính cho KL-Divergence

Phương pháp gradient descent cho KL-Divergence [LeSe00; LeSe99]:

$$L(W, H) = \sum_i \sum_j \left( X_{ij} \log (WH)_{ij} - (WH)_{ij} \right)$$

1. khởi tạo ngẫu nhiên (hoặc với các phương pháp heuristic tốt hơn)
2. tối đa hóa $W$:

$$w_{ik} \leftarrow w_{ik} \frac{\sum_{j=1}^{m} h_{kj} \frac{x_{ij}}{(WH)_{ij}}}{\sum_{j=1}^{m} h_{kj}}$$

3. tối đa hóa $H$:

$$h_{kj} \leftarrow h_{kj} \frac{\sum_{i=1}^{n} w_{ik} \frac{x_{ij}}{(WH)_{ij}}}{\sum_{i=1}^{n} w_{ik}}$$

4. lặp lại bước 2-3 cho đến khi mức cải thiện của $L(W, H)$ nhỏ hơn một ngưỡng

Có thể bị kẹt tại một điểm bất động cục bộ hoặc điểm yên ngựa – không đảm bảo tìm được nghiệm tối ưu.

Lưu ý: ta cần $w_{ij} > 0$, $h_{ij} > 0$, vì vậy thường cộng một hằng số nhỏ $\varepsilon = 10^{-16}$ vào mọi giá trị.

## Các thuật toán khác cho NMF

Khi các thuật toán này được cài đặt theo đúng nguyên văn, chúng chạy chậm:
cần các phép nhân ma trận dày đặc (độ phức tạp $O(n^3)$) trong mỗi vòng lặp

Nhiều biến thể thuật toán đã được phát triển:

- Alternating Least Squares [PaTa94]
- Projected-gradient ALS [Lin07]
- Tối ưu hóa Quasi-Newton [ZdCi06]
- Hierarchical Alternating Least Squares [CiPh09]
- Khởi tạo bằng spherical-$k$-means
- Khởi tạo bằng SVD [BBLP07]
- Khảo sát các phương pháp khởi tạo: [LMAC14]
- Beta divergence [FéId11]
- Phân rã tensor không âm [CiPh09]
- ...

## pLSI [Hofm99] chính là phân rã ma trận không âm [GaGo05]

Probabilistic Latent Semantic Indexing (xem Phần 4) là phiên bản xác suất của LSI/LSA.

PLSI sử dụng một mô hình hỗn hợp dạng đồ thị với (ký hiệu mô hình hỗn hợp; khác với ký hiệu trong Phần 4)

$$P(w_i | d_j) = \sum_t P(t) P(d_j | t) P(w_i | t)$$

- $W$: xác suất của từ trong mỗi chủ đề $P(w_i | t) P(t)$
- $H$: xác suất chủ đề của mỗi tài liệu $P(d_j | t)$
- các xác suất đều không âm

“Mọi nghiệm cực đại hóa hợp lý (cục bộ) của PLSA đều là một nghiệm của NMF với KL divergence.”
[GaGo05]

## Lịch sử của phân rã ma trận không âm

Được phổ biến bởi Daniel D. Lee và H. Sebastian Seung.
Learning the parts of objects by non-negative matrix factorization
In: Nature 401, 4, 1999. DOI: 10.1038/44565.

Các cách tiếp cận tương tự đã xuất hiện trước đó trong:

- “Non-negative Rank Factorization”
  M.W. Jeter, and W.C. Pye. A note on nonnegative rank factorizations
  In: Linear Algebra and its Applications 38, 3, 1981. DOI: 10.1016/0024-3795(81)90018-5
  Ji-Cheng Chen. The nonnegative rank factorizations of nonnegative matrices
  In: Linear Algebra and its Applications 62, 11, 1984. DOI: 10.1016/0024-3795(84)90096-X
- “Positive Matrix Factorization”
  Pentti Paatero, and Unto Tapper. Positive matrix factorization: A non-negative factor
