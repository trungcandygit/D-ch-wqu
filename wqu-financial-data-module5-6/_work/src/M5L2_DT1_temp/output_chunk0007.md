Kết quả trên bộ dữ liệu cảm xúc FiQA được trình bày ở bảng 3. Mô hình của chúng tôi vượt các mô hình hiện đại nhất (state-of-the-art) cả về MSE lẫn R². Cần lưu ý rằng hai công trình [31] [24] dùng tập kiểm tra chính thức của FiQA Task 1; do không có quyền truy cập tập này, chúng tôi báo cáo kết quả theo kiểm định chéo 10 lần (10-fold cross validation). Theo [15], không có dấu hiệu cho thấy tập huấn luyện và tập kiểm tra được công bố đến từ các phân phối khác nhau, và mô hình của chúng tôi có thể được xem là bất lợi hơn vì phải tách một phần tập huấn luyện làm tập kiểm tra, trong khi các công trình hiện đại nhất được dùng toàn bộ tập huấn luyện.

**Bảng 3: Kết quả thực nghiệm trên bộ dữ liệu cảm xúc FiQA**

| Mô hình | MSE | R² |
|---|---|---|
| Yang et. al. (2018) | 0.08 | 0.40 |
| Piao and Breslin (2018) | 0.09 | 0.41 |
| FinBERT | 0.07 | 0.55 |

Chữ in đậm biểu thị kết quả tốt nhất theo chỉ số tương ứng. Yang et. al. (2018) [31] và Piao and Breslin (2018) [24] báo cáo kết quả trên tập kiểm tra chính thức. Vì không có tập này, MSE và R² của chúng tôi được tính bằng kiểm định chéo 10 lần.

## 6 PHÂN TÍCH THỰC NGHIỆM

### 6.1 Tác động của tiền huấn luyện bổ sung (RQ3)

Trước hết chúng tôi đo tác động của tiền huấn luyện bổ sung (further pre-training) lên hiệu năng của bộ phân loại, so sánh ba mô hình: 1) không tiền huấn luyện bổ sung (Vanilla BERT); 2) tiền huấn luyện bổ sung trên tập huấn luyện phân loại (FinBERT-task); 3) tiền huấn luyện bổ sung trên kho ngữ liệu miền, TRC2-financial (FinBERT-domain). Các mô hình được đánh giá bằng hàm mất mát, độ chính xác và điểm F1 trung bình macro trên tập kiểm tra. Kết quả ở bảng 4.

**Bảng 4: Hiệu năng với các chiến lược tiền huấn luyện khác nhau**

| Mô hình | Loss | Accuracy | F1 Score |
|---|---|---|---|
| Vanilla BERT | 0.38 | 0.85 | 0.84 |
| FinBERT-task | 0.39 | 0.86 | 0.85 |
| FinBERT-domain | 0.37 | 0.86 | 0.84 |

Bộ phân loại được tiền huấn luyện bổ sung trên kho ngữ liệu miền tài chính cho kết quả tốt nhất trong ba mô hình, dù chênh lệch không lớn. Có thể có bốn lý do: 1) kho ngữ liệu có thể có phân phối khác với tập tác vụ; 2) bộ phân loại BERT có thể không cải thiện đáng kể nhờ tiền huấn luyện bổ sung; 3) phân loại câu ngắn có thể không hưởng lợi nhiều từ tiền huấn luyện bổ sung; 4) hiệu năng vốn đã rất tốt nên còn ít dư địa cải thiện. Chúng tôi cho rằng lý do cuối là khả dĩ nhất, vì với tập con của Financial Phrasebank mà mọi người gán nhãn đều đồng thuận, độ chính xác của Vanilla BERT đã là 0.96. Hiệu năng ở các mức đồng thuận thấp hơn hẳn phải thấp hơn, vì ngay cả con người cũng không hoàn toàn nhất trí. Cần thêm thực nghiệm với một bộ dữ liệu tài chính có gán nhãn khác để kết luận rằng tác động của tiền huấn luyện bổ sung trên kho ngữ liệu miền là không đáng kể.

### 6.2 Quên thảm khốc (RQ4)

Để đo hiệu quả của các kỹ thuật chống quên thảm khốc (catastrophic forgetting), chúng tôi thử bốn thiết lập: không điều chỉnh (NA), chỉ dùng tốc độ học tam giác nghiêng (STL), tốc độ học tam giác nghiêng kèm giải băng dần (STL+GU), và các kỹ thuật ở thiết lập trước cùng với tinh chỉnh phân biệt (discriminative fine-tuning). Chúng tôi báo cáo hiệu năng của bốn thiết lập theo hàm mất mát trên tập kiểm tra và quỹ đạo hàm mất mát trên tập xác thực qua các epoch huấn luyện. Kết quả ở bảng 5 và hình 3.

**Hình 3: Quỹ đạo hàm mất mát trên tập xác thực với các chiến lược huấn luyện khác nhau**

**Bảng 5: Hiệu năng với các chiến lược tinh chỉnh khác nhau**

| Chiến lược | Loss | Accuracy | F1 Score |
|---|---|---|---|
| None | 0.48 | 0.83 | 0.83 |
| STL | 0.40 | 0.81 | 0.82 |
| STL + GU | 0.40 | 0.86 | 0.86 |
| STL + DFT | 0.42 | 0.79 | 0.79 |
| All three | 0.37 | 0.86 | 0.84 |

Chữ in đậm biểu thị kết quả tốt nhất theo chỉ số tương ứng. Kết quả theo kiểm định chéo 10 lần. STL: tốc độ học tam giác nghiêng; GU: giải băng dần (gradual unfreezing); DFT: tinh chỉnh phân biệt (discriminative fine-tuning).

Áp dụng cả ba chiến lược cho hiệu năng tốt nhất xét theo hàm mất mát trên tập kiểm tra và độ chính xác. Giải băng dần và tinh chỉnh phân biệt có cùng nguyên lý: các đặc trưng ở tầng cao cần được tinh chỉnh nhiều hơn các tầng thấp, vì thông tin học được từ mô hình hóa ngôn ngữ chủ yếu nằm ở các tầng thấp. Bảng 5 cho thấy chỉ dùng tinh chỉnh phân biệt với tốc độ học tam giác nghiêng kém hơn chỉ dùng tốc độ học tam giác nghiêng, nghĩa là giải băng dần là kỹ thuật quan trọng nhất trong trường hợp này.

Quên thảm khốc có thể biểu hiện qua việc hàm mất mát trên tập xác thực tăng đột ngột sau vài epoch. Khi huấn luyện mà không có biện pháp phù hợp, mô hình nhanh chóng quá khớp (overfit). Như hình 3, đó là trường hợp khi không áp dụng kỹ thuật nào: mô hình đạt hiệu năng tốt nhất trên tập xác thực sau epoch đầu rồi bắt đầu quá khớp. Ngược lại, khi áp dụng cả ba kỹ thuật, mô hình ổn định hơn nhiều; các tổ hợp còn lại nằm giữa hai trường hợp này.

### 6.3 Chọn tầng tốt nhất để phân loại (RQ5)

BERT có 12 tầng bộ mã hóa Transformer. Không nhất thiết tầng cuối nắm bắt thông tin liên quan nhất đến tác vụ phân loại trong quá trình huấn luyện mô hình ngôn ngữ. Để kiểm tra, chúng tôi so sánh việc dùng từng tầng cho phân loại (bảng 6) và việc bắt đầu huấn luyện từ các tầng khác nhau (bảng 7).

**Bảng 6: Hiệu năng khi dùng các tầng bộ mã hóa khác nhau để phân loại**

| Tầng dùng để phân loại | Loss | Accuracy | F1 Score |
|---|---|---|---|
| Layer-1 | 0.65 | 0.76 | 0.77 |
| Layer-2 | 0.54 | 0.78 | 0.78 |
| Layer-3 | 0.52 | 0.76 | 0.77 |
| Layer-4 | 0.48 | 0.80 | 0.77 |
| Layer-5 | 0.52 | 0.80 | 0.80 |
| Layer-6 | 0.45 | 0.82 | 0.82 |
| Layer-7 | 0.43 | 0.82 | 0.83 |
| Layer-8 | 0.44 | 0.83 | 0.81 |
| Layer-9 | 0.41 | 0.84 | 0.82 |
| Layer-10 | 0.42 | 0.83 | 0.82 |
| Layer-11 | 0.38 | 0.84 | 0.83 |
| Layer-12 | 0.37 | 0.86 | 0.84 |
| All layers - mean | 0.41 | 0.84 | 0.84 |

**Bảng 7: Hiệu năng khi bắt đầu huấn luyện từ các tầng khác nhau**

| Tầng đầu tiên được giải băng | Loss | Accuracy |
|---|---|---|
| Embeddings layer | 0.37 | 0.86 |
| Layer-1 | 0.39 | 0.83 |
| Layer-2 | 0.39 | 0.83 |
| Layer-3 | 0.38 | 0.83 |
| Layer-4 | 0.38 | 0.82 |
| Layer-5 | 0.40 | 0.83 |
| Layer-6 | 0.40 | 0.81 |
| Layer-7 | 0.39 | 0.82 |
| Layer-8 | 0.39 | 0.84 |
| Layer-9 | 0.39 | 0.84 |
| Layer-10 | 0.41 | 0.84 |
| Layer-11 | 0.45 | 0.82 |
| Layer-12 | 0.47 | 0.81 |
| Classification layer | 1.04 | 0.52 |
