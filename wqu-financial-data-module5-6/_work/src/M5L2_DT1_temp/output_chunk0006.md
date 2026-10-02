## Các phương pháp cơ sở (Baseline)

Để so sánh đối chứng, nghiên cứu xét ba phương pháp cơ sở: bộ phân loại LSTM với embedding GLoVe, bộ phân loại LSTM với embedding ELMo và bộ phân loại ULMFit. Lưu ý các phương pháp này không được thử nghiệm kỹ như BERT, nên kết quả không nên được diễn giải như kết luận dứt khoát rằng phương pháp nào tốt hơn.

### 4.3.1 Bộ phân loại LSTM

Hai bộ phân loại dùng LSTM hai chiều, kích thước ẩn 128 (trạng thái ẩn cuối có kích thước 256 do tính hai chiều). Một lớp truyền thẳng kết nối đầy đủ ánh xạ trạng thái ẩn cuối thành vector ba chiều, biểu diễn khả năng của ba nhãn. Hai mô hình khác nhau ở chỗ một dùng embedding GLoVe, một dùng embedding ELMo. Cả hai dùng xác suất dropout 0,3 và tốc độ học 3e-5; huấn luyện đến khi hàm mất mát trên tập xác thực không cải thiện trong 10 epoch.

### 4.4 Chi tiết triển khai

Với BERT: dropout p = 0,1, tỉ lệ warm-up 0,2, độ dài chuỗi tối đa 64 token, tốc độ học 2e-5, mini-batch 64. Huấn luyện 6 epoch, đánh giá trên tập xác thực và chọn mô hình tốt nhất. Với tinh chỉnh phân biệt (discriminative fine-tuning), tỉ lệ phân biệt đặt là 0,85. Quá trình bắt đầu chỉ với lớp phân loại được mở khóa; sau mỗi một phần ba epoch thì mở khóa lớp kế tiếp. Các mô hình được huấn luyện trên một instance Amazon p2.xlarge EC2 với một GPU NVIDIA K80, 4 vCPU và 64 GiB bộ nhớ máy chủ.

### 4.3.2 ULMFit

Như đã giải thích ở mục 3.1.3, phân loại bằng ULMFit gồm ba bước. Bước đầu, tiền huấn luyện mô hình ngôn ngữ, đã được Howard và Ruder (2018) thực hiện và công bố trọng số. Nghiên cứu tiếp tục tiền huấn luyện mô hình ngôn ngữ AWD-LSTM trên kho ngữ liệu TRC2-financial trong 3 epoch, sau đó tinh chỉnh mô hình cho bài toán phân loại trên Financial PhraseBank.

## 5. Kết quả thực nghiệm (RQ1 và RQ2)

Kết quả của FinBERT, các phương pháp cơ sở và các mô hình tiên tiến nhất (state-of-the-art) trên tác vụ phân loại bộ dữ liệu Financial PhraseBank được trình bày ở bảng 2, cho cả toàn bộ dữ liệu và tập con có 100% người gán nhãn đồng thuận.

*(Chú thích 6: Dữ liệu tại https://sites.google.com/view/fiqa/home)*

**Bảng 2: Kết quả thực nghiệm trên bộ dữ liệu Financial PhraseBank**

| Mô hình | Loss (toàn bộ) | Accuracy (toàn bộ) | F1 (toàn bộ) | Loss (100% đồng thuận) | Accuracy (100% đồng thuận) | F1 (100% đồng thuận) |
|---|---|---|---|---|---|---|
| LSTM | 0.81 | 0.71 | 0.64 | 0.57 | 0.81 | 0.74 |
| LSTM với ELMo | 0.72 | 0.75 | 0.7 | 0.50 | 0.84 | 0.77 |
| ULMFit | 0.41 | 0.83 | 0.79 | 0.20 | 0.93 | 0.91 |
| LPS | - | 0.71 | 0.71 | - | 0.79 | 0.80 |
| HSC | - | 0.71 | 0.76 | - | 0.83 | 0.86 |
| FinSSLX | - | - | - | - | 0.91 | 0.88 |
| FinBERT | 0.37 | 0.86 | 0.84 | 0.13 | 0.97 | 0.95 |

Chú thích: in đậm là kết quả tốt nhất theo từng chỉ số. Kết quả của LPS [17], HSC [8] và FinSSLX [15] lấy từ các bài báo gốc; với LPS và HSC, độ chính xác tổng thể không được báo cáo nên được tính lại từ độ bao phủ (recall) của từng lớp. Với các mô hình tự triển khai, báo cáo kết quả kiểm định chéo 10 lần.

Trên mọi chỉ số, FinBERT rõ ràng tốt nhất, vượt cả các phương pháp tự triển khai (LSTM, ULMFit) lẫn các mô hình trong các bài báo khác (LPS [17], HSC [8], FinSSLX [14]). Bộ phân loại LSTM không có thông tin mô hình ngôn ngữ kém nhất: độ chính xác gần LPS và HSC (thậm chí hơn LPS ở tập đồng thuận hoàn toàn) nhưng F1 thấp, do hoạt động tốt hơn hẳn ở lớp trung lập. LSTM với embedding ELMo cải thiện so với LSTM dùng embedding tĩnh ở mọi chỉ số, nhưng vẫn có F1 trung bình thấp do kém ở các nhãn ít xuất hiện; hiệu năng tương đương LPS và HSC và vượt chúng về độ chính xác. Như vậy nhúng từ theo ngữ cảnh cho hiệu năng gần với các phương pháp dựa trên học máy ở bộ dữ liệu cỡ này.

ULMFit cải thiện đáng kể mọi chỉ số và không bị lệch hiệu năng giữa các lớp; nó cũng dễ dàng vượt LPS và HSC (dựa trên học máy), cho thấy hiệu quả của tiền huấn luyện mô hình ngôn ngữ. AWD-LSTM là mô hình rất lớn, lẽ ra dễ quá khớp với bộ dữ liệu nhỏ như vậy, nhưng nhờ tiền huấn luyện và chiến lược huấn luyện hiệu quả, nó vượt qua vấn đề dữ liệu nhỏ. ULMFit cũng vượt FinSSLX, vốn có bước đơn giản hóa văn bản và tiền huấn luyện nhúng từ trên kho ngữ liệu tài chính lớn có nhãn cảm xúc.

FinBERT vượt ULMFit và do đó vượt mọi phương pháp khác trên mọi chỉ số. Để đo hiệu năng theo quy mô tập huấn luyện có nhãn, nghiên cứu chạy các bộ phân loại LSTM, ULMFit và FinBERT trên 5 cấu hình; hình 2 vẽ hàm mất mát cross entropy trên tập kiểm tra của từng mô hình. 100 mẫu huấn luyện là quá ít cho mọi mô hình; nhưng khi đạt 250 mẫu, ULMFit và FinBERT bắt đầu phân biệt nhãn thành công, FinBERT đạt độ chính xác tới 80%. Mọi phương pháp đều tốt dần khi có thêm dữ liệu, song ULMFit và FinBERT với 250 mẫu đã tốt hơn LSTM dùng toàn bộ dữ liệu, cho thấy hiệu quả của tiền huấn luyện mô hình ngôn ngữ.

**Hình 2: Hàm mất mát trên tập kiểm tra theo các quy mô tập huấn luyện khác nhau**
