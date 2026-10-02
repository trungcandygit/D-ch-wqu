# M5L1_DT2

› Machine Learning Bits › Phân rã ma trận không âm

# Phân rã ma trận không âm

Các nội dung này được chuyển đổi tự động từ bài giảng dạng slide. Một số nội dung đã bị lược bỏ do bản quyền hoặc hạn chế kỹ thuật. Nội dung chưa được định dạng lại một cách tối ưu cho việc truy cập trực tuyến. Bảo lưu mọi quyền trừ khi có ghi chú khác.

## Phân rã ma trận không âm (Non-negative Matrix Factorization – NMF, NNMF) [LeSe99]

Cho một ma trận dữ liệu $X \in \mathbb{R}^{m \times n}_{\ge 0}$, và tham số $k$ với $1 \le k \le \min\{m, n\}$, hãy tìm hai ma trận

$$W \in \mathbb{R}^{m \times k}_{\ge 0}$$

$$H \in \mathbb{R}^{k \times n}_{\ge 0}$$

sao cho

$$X \approx WH$$

Biến thể 1: Sai số bình phương – cực tiểu hóa

$$\|X - WH\|^2 = \sum_i \sum_j \left( X_{ij} - (WH)_{ij} \right)^2$$

Biến thể 2: Độ phân kỳ (divergence) – cực tiểu hóa log-hợp lý của $X_{ij} \sim \mathrm{Poisson}((WH)_{ij})$

$$L(W, H) = -\sum_i \sum_j \left( X_{ij} \log (WH)_{ij} - (WH)_{ij} \right)$$

## NMF: Cập nhật nhân tính cho sai số bình phương

Phương pháp hạ gradient cho sai số bình phương [LeSe00; LeSe99]:

$$\|X - WH\|^2 = \sum_i \sum_j \left( X_{ij} - (WH)_{ij} \right)^2$$
