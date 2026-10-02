# M5L1_DT2

› Machine Learning Bits › Phân rã ma trận không âm

## Phân rã ma trận không âm

*Nội dung này được chuyển đổi tự động từ slide bài giảng. Một số phần đã bị lược bỏ vì lý do bản quyền hoặc hạn chế kỹ thuật, và nội dung chưa được định dạng lại tối ưu cho truy cập trực tuyến. Bảo lưu mọi quyền, trừ khi có ghi chú khác.*

### Phân rã ma trận không âm (NMF, NNMF) [LeSe99]

Cho ma trận dữ liệu $X \in \mathbb{R}_{\ge 0}^{m \times n}$ và tham số $k$ với $1 \le k \le \min\{m, n\}$, hãy tìm hai ma trận

$$W \in \mathbb{R}_{\ge 0}^{m \times k}, \qquad H \in \mathbb{R}_{\ge 0}^{k \times n}$$

sao cho

$$X \approx WH$$

**Biến thể 1: Sai số bình phương** – cực tiểu hóa

$$\|X - WH\|^2 = \sum_i \sum_j \left( X_{ij} - (WH)_{ij} \right)^2$$

**Biến thể 2: Độ phân kỳ (divergence)** – cực tiểu hóa log-hợp lý (log-likelihood) của $X_{ij} \sim \mathrm{Poisson}\big((WH)_{ij}\big)$

$$L(W, H) = -\sum_i \sum_j \left( X_{ij} \log (WH)_{ij} - (WH)_{ij} \right)$$

### NMF: Cập nhật nhân tính cho sai số bình phương

Phương pháp hạ gradient (gradient descent) cho sai số bình phương [LeSe00; LeSe99]:

$$\|X - WH\|^2 = \sum_i \sum_j \left( X_{ij} - (WH)_{ij} \right)^2$$
