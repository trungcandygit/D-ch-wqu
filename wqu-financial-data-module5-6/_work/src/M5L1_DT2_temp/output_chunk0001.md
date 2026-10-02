# M5L1_DT2

› Machine Learning Bits › Phân rã ma trận không âm

## Phân rã ma trận không âm

Nội dung này được chuyển đổi tự động từ slide bài giảng; một số phần bị lược bỏ do bản quyền hoặc hạn chế kỹ thuật, và chưa được định dạng lại tối ưu cho truy cập trực tuyến. Bảo lưu mọi quyền, trừ khi có ghi chú khác.

## Phân rã ma trận không âm (NMF, NNMF) [LeSe99]

Cho ma trận dữ liệu $X \in \mathbb{R}^{m \times n}_{\ge 0}$ và tham số $k$ với $1 \le k \le \min\{m, n\}$, hãy tìm hai ma trận

$$W \in \mathbb{R}^{m \times k}_{\ge 0}, \qquad H \in \mathbb{R}^{k \times n}_{\ge 0}$$

sao cho

$$X \approx WH$$

Biến thể 1: Sai số bình phương, cực tiểu hóa

$$\|X - WH\|^2 = \sum_i \sum_j \left( X_{ij} - (WH)_{ij} \right)^2$$

Biến thể 2: Độ phân kỳ (divergence), cực tiểu hóa log-hợp lý (log-likelihood) của $X_{ij} \sim \text{Poisson}((WH)_{ij})$

$$L(W, H) = -\sum_i \sum_j X_{ij} \log (WH)_{ij} - (WH)_{ij}$$

## NMF: Cập nhật nhân tính cho sai số bình phương

Phương pháp hạ gradient (gradient descent) cho sai số bình phương [LeSe00; LeSe99]:

$$\|X - WH\|^2 = \sum_i \sum_j \left( X_{ij} - (WH)_{ij} \right)^2$$
