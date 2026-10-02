# M5L1_DT2

## Phân rã ma trận không âm

Phân rã ma trận không âm

Các nội dung này được chuyển đổi tự động từ slide bài giảng. Một số nội dung bị lược bỏ do giới hạn về bản quyền hoặc kỹ thuật. Các nội dung chưa được định dạng lại một cách tối ưu để truy cập trực tuyến. Bảo lưu mọi quyền, trừ khi có ghi chú khác.

### Phân rã ma trận không âm (NMF, NNMF) [LeSe99]

Cho một ma trận dữ liệu $X \in \mathbb{R}^{m \times n}_{\geq 0}$, và tham số $k$ với $1 \leq k \leq \min\{m, n\}$, hãy tìm hai ma trận

$$W \in \mathbb{R}^{m \times k}_{\geq 0}$$

$$H \in \mathbb{R}^{k \times n}_{\geq 0}$$

sao cho

$$X \approx WH$$

Biến thể 1: Sai số bình phương – cực tiểu hóa

$$\|X - WH\|^2 = \sum_i \sum_j \left(X_{ij} - (WH)_{ij}\right)^2$$

Biến thể 2: Độ phân kỳ (divergence) – cực tiểu hóa log-hợp lý của $X_{ij} \sim \text{Poisson}((WH)_{ij})$

$$L(W, H) = -\sum_i \sum_j X_{ij} \log (WH)_{ij} - (WH)_{ij}$$

### NMF: Cập nhật nhân cho sai số bình phương

Phương pháp giảm gradient cho sai số bình phương [LeSe00; LeSe99]:

$$\|X - WH\|^2 = \sum_i \sum_j \left(X_{ij} - (WH)_{ij}\right)^2$$
