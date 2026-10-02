# M5L1_DT2

# Phân rã ma trận không âm (Non-negative Matrix Factorization)

› Machine Learning Bits › Phân rã ma trận không âm

## Phân rã ma trận không âm (NMF, NNMF) [LeSe99]

Cho ma trận dữ liệu $X \in \mathbb{R}^{m \times n}_{\ge 0}$ và tham số $k$ với $1 \le k \le \min\{m, n\}$, hãy tìm hai ma trận

$$W \in \mathbb{R}^{m \times k}_{\ge 0}, \qquad H \in \mathbb{R}^{k \times n}_{\ge 0}$$

sao cho

$$X \approx WH$$

**Biến thể 1: Sai số bình phương** – cực tiểu hóa

$$\|X - WH\|^2 = \sum_i \sum_j \big(X_{ij} - (WH)_{ij}\big)^2$$

**Biến thể 2: Độ phân kỳ (divergence)** – cực tiểu hóa log-hợp lý của $X_{ij} \sim \text{Poisson}\big((WH)_{ij}\big)$

$$L(W, H) = -\sum_i \sum_j \Big( X_{ij} \log (WH)_{ij} - (WH)_{ij} \Big)$$

## NMF: Cập nhật nhân tính cho sai số bình phương

Phương pháp hạ gradient cho sai số bình phương [LeSe00; LeSe99], với hàm mục tiêu:

$$\|X - WH\|^2 = \sum_i \sum_j \big(X_{ij} - (WH)_{ij}\big)^2$$
