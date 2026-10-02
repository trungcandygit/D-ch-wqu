1. Khởi tạo bằng các giá trị ngẫu nhiên không âm (về sau: dùng heuristic tốt hơn).
2. Tối ưu $W$:

$$w_{ik} \leftarrow w_{ik} \frac{(XH^T)_{ik}}{(WHH^T)_{ik}}$$

3. Tối ưu $H$:

$$h_{kj} \leftarrow h_{kj} \frac{(W^T X)_{kj}}{(W^T WH)_{kj}}$$

4. Lặp lại bước 2-3 cho đến khi mức cải thiện của $\|X - WH\|^2$ nhỏ hơn một ngưỡng.

Thuật toán có thể mắc kẹt tại điểm bất động cục bộ hoặc điểm yên ngựa, nên không đảm bảo tìm được nghiệm tối ưu. Lưu ý: cần $w_{ij} > 0$, $h_{ij} > 0$, vì vậy thường cộng một hằng số nhỏ $\varepsilon = 10^{-16}$ vào mọi giá trị.

## NMF: cập nhật nhân tính cho độ phân kỳ KL

Phương pháp gradient descent cho độ phân kỳ KL (KL-Divergence) [LeSe00; LeSe99]:

$$L(W, H) = \sum_i \sum_j \left( X_{ij} \log (WH)_{ij} - (WH)_{ij} \right)$$

1. Khởi tạo ngẫu nhiên (hoặc bằng heuristic tốt hơn).
2. Tối ưu $W$:

$$w_{ik} \leftarrow w_{ik} \frac{\sum_{j=1}^{m} h_{kj} \frac{x_{ij}}{(WH)_{ij}}}{\sum_{j=1}^{m} h_{kj}}$$

3. Tối ưu $H$:

$$h_{kj} \leftarrow h_{kj} \frac{\sum_{i=1}^{n} w_{ik} \frac{x_{ij}}{(WH)_{ij}}}{\sum_{i=1}^{n} w_{ik}}$$

4. Lặp lại bước 2-3 cho đến khi mức cải thiện của $L(W, H)$ nhỏ hơn một ngưỡng.

Thuật toán có thể mắc kẹt tại điểm bất động cục bộ hoặc điểm yên ngựa, nên không đảm bảo tìm được nghiệm tối ưu. Lưu ý: cần $w_{ij} > 0$, $h_{ij} > 0$, vì vậy thường cộng một hằng số nhỏ $\varepsilon = 10^{-16}$ vào mọi giá trị.

## Các thuật toán khác cho NMF

Khi cài đặt nguyên văn, các thuật toán trên chạy chậm: mỗi vòng lặp phải nhân các ma trận đặc (dense) với độ phức tạp $O(n^3)$.

Nhiều biến thể thuật toán đã được phát triển:

- Bình phương tối thiểu luân phiên (Alternating Least Squares) [PaTa94]
- ALS gradient chiếu (Projected-gradient ALS) [Lin07]
- Tối ưu hóa tựa Newton (Quasi-Newton) [ZdCi06]
- Bình phương tối thiểu luân phiên phân cấp (Hierarchical ALS) [CiPh09]
- Khởi tạo bằng spherical-$k$-means
- Khởi tạo bằng SVD [BBLP07]
- Khảo sát các phương pháp khởi tạo: [LMAC14]
- Độ phân kỳ beta (Beta divergence) [FéId11]
- Phân rã tensor không âm [CiPh09]
- ...

## pLSI [Hofm99] chính là phân rã ma trận không âm [GaGo05]

Lập chỉ mục ngữ nghĩa ẩn xác suất (Probabilistic Latent Semantic Indexing, xem Phần 4) là phiên bản xác suất của LSI/LSA.

PLSI dùng một mô hình hỗn hợp đồ thị (ký hiệu mô hình hỗn hợp, khác với Phần 4):

$$P(w_i | d_j) = \sum_t P(t) P(d_j | t) P(w_i | t)$$

- $W$: xác suất từ theo mỗi chủ đề, $P(w_i | t) P(t)$.
- $H$: xác suất chủ đề theo mỗi tài liệu, $P(d_j | t)$.
- Các xác suất đều không âm.

"Mọi nghiệm cực đại hợp lý (cục bộ) của PLSA đều là một nghiệm của NMF với độ phân kỳ KL." [GaGo05]

## Lịch sử của phân rã ma trận không âm

Được phổ biến bởi Daniel D. Lee và H. Sebastian Seung.
Learning the parts of objects by non-negative matrix factorization
In: Nature 401, 4, 1999. DOI: 10.1038/44565.

Các cách tiếp cận tương tự đã xuất hiện trước đó:

- "Phân rã hạng không âm" (Non-negative Rank Factorization)
  M.W. Jeter, and W.C. Pye. A note on nonnegative rank factorizations
  In: Linear Algebra and its Applications 38, 3, 1981. DOI: 10.1016/0024-3795(81)90018-5
  Ji-Cheng Chen. The nonnegative rank factorizations of nonnegative matrices
  In: Linear Algebra and its Applications 62, 11, 1984. DOI: 10.1016/0024-3795(84)90096-X
- "Phân rã ma trận dương" (Positive Matrix Factorization)
  Pentti Paatero, and Unto Tapper. Positive matrix factorization: A non-negative factor
