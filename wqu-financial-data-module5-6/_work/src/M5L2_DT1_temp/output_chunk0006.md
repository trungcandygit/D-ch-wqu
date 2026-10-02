Phương pháp cơ sở (Baseline)

Để so sánh đối chứng, nhóm xét ba phương pháp cơ sở: bộ phân loại LSTM với nhúng từ (word embeddings) GLoVe, bộ phân loại LSTM với embedding ELMo và bộ phân loại ULMFit. Cần lưu ý rằng các phương pháp cơ sở này không được thử nghiệm kỹ lưỡng như BERT, nên kết quả không nên được hiểu là kết luận dứt khoát rằng phương pháp nào tốt hơn.

4.3.1 Bộ phân loại LSTM. Nhóm cài đặt hai bộ phân loại dùng mô hình LSTM hai chiều. Cả hai đều dùng kích thước ẩn 128, nên trạng thái ẩn cuối có kích thước 256 do tính hai chiều. Một lớp truyền thẳng kết nối đầy đủ ánh xạ trạng thái ẩn cuối thành vectơ ba chiều, biểu diễn khả năng của ba nhãn. Hai mô hình khác nhau ở chỗ một dùng embedding GLoVe, mô hình còn lại dùng embedding ELMo. Cả hai dùng xác suất dropout 0,3 và tốc độ học 3e-5. Mô hình được huấn luyện cho đến khi hàm mất mát trên tập xác thực không cải thiện sau 10 epoch.

4.4 Chi tiết triển khai

Với BERT, nhóm dùng xác suất dropout p = 0,1, tỉ lệ warm-up 0,2, độ dài chuỗi tối đa 64 token, tốc độ học 2e − 5 và mini-batch 64. Mô hình được huấn luyện 6 epoch, đánh giá trên tập xác thực và chọn mô hình tốt nhất. Với tinh chỉnh phân biệt (discriminative fine-tuning), tỉ lệ phân biệt đặt là 0,85. Quá trình huấn luyện bắt đầu chỉ với lớp phân loại được mở khóa; sau mỗi một phần ba epoch, lớp kế tiếp được mở khóa. Các mô hình được huấn luyện trên một instance Amazon p2.xlarge EC2 với một GPU NVIDIA K80, 4 vCPU và 64 GiB bộ nhớ máy chủ.

4.3.2 ULMFit. Như đã giải thích ở mục 3.1.3, phân loại bằng ULMFit gồm ba bước. Bước đầu, tiền huấn luyện mô hình ngôn ngữ, đã được thực hiện sẵn và trọng số tiền huấn luyện do Howard và Ruder (2018) công bố. Trước hết nhóm tiếp tục tiền huấn luyện mô hình ngôn ngữ AWD-LSTM trên kho ngữ liệu TRC2-financial trong 3 epoch. Sau đó, mô hình được tinh chỉnh (fine-tune) cho bài toán phân loại trên Financial PhraseBank.

5 KẾT QUẢ THỰC NGHIỆM (RQ1 & RQ2)

Kết quả của FinBERT, các phương pháp cơ sở và các mô hình tiên tiến nhất (state-of-the-art) trong bài toán phân loại trên bộ dữ liệu Financial PhraseBank được trình bày ở bảng 2, cho cả toàn bộ dữ liệu và tập con có 100% người gán nhãn đồng thuận.

Bảng 2: Kết quả thực nghiệm trên bộ dữ liệu Financial PhraseBank

| Mô hình | Toàn bộ: Loss | Toàn bộ: Accuracy | Toàn bộ: F1 | 100% đồng thuận: Loss | 100% đồng thuận: Accuracy | 100% đồng thuận: F1 |
|---|---|---|---|---|---|---|
| LSTM | 0.81 | 0.71 | 0.64 | 0.57 | 0.81 | 0.74 |
| LSTM with ELMo | 0.72 | 0.75 | 0.7 | 0.50 | 0.84 | 0.77 |
| ULMFit | 0.41 | 0.83 | 0.79 | 0.20 | 0.93 | 0.91 |
| LPS | - | 0.71 | 0.71 | - | 0.79 | 0.80 |
| HSC | - | 0.71 | 0.76 | - | 0.83 | 0.86 |
| FinSSLX | - | - | - | - | 0.91 | 0.88 |
| FinBERT | 0.37 | 0.86 | 0.84 | 0.13 | 0.97 | 0.95 |

Chú thích: In đậm là kết quả tốt nhất theo từng chỉ số. Kết quả của LPS [17], HSC [8] và FinSSLX [15] lấy từ các bài báo tương ứng. Với LPS và HSC, độ chính xác tổng thể không được báo cáo; nhóm tự tính từ độ bao phủ (recall) của từng lớp. Với các mô hình do nhóm cài đặt, kết quả là trung bình kiểm định chéo 10 lần.

Ở mọi chỉ số, FinBERT rõ ràng tốt nhất, cả so với các phương pháp nhóm tự cài đặt (LSTM và ULMFit) lẫn các mô hình trong các bài báo khác (LPS [17], HSC [8], FinSSLX [14]). Bộ phân loại LSTM không có thông tin mô hình ngôn ngữ kém nhất: về độ chính xác nó gần với LPS và HSC (thậm chí tốt hơn LPS ở các mẫu đồng thuận hoàn toàn) nhưng F1 thấp, do nó hoạt động tốt hơn hẳn ở lớp trung lập. LSTM với embedding ELMo cải thiện so với LSTM dùng embedding tĩnh ở mọi chỉ số, nhưng F1 trung bình vẫn thấp do kém ở các nhãn ít xuất hiện; tuy vậy hiệu suất tương đương LPS và HSC và vượt chúng về độ chính xác. Như vậy, embedding ngữ cảnh hóa cho hiệu suất gần với các phương pháp dựa trên học máy với bộ dữ liệu cỡ này.

ULMFit cải thiện đáng kể mọi chỉ số và không bị tình trạng hiệu suất lệch mạnh giữa các lớp; nó cũng dễ dàng vượt các mô hình học máy LPS và HSC, cho thấy hiệu quả của tiền huấn luyện mô hình ngôn ngữ. AWD-LSTM là mô hình rất lớn nên đáng lẽ dễ bị quá khớp (over-fitting) với bộ dữ liệu nhỏ như vậy, nhưng nhờ tiền huấn luyện mô hình ngôn ngữ và các chiến lược huấn luyện hiệu quả, nó vượt qua được vấn đề dữ liệu nhỏ. ULMFit cũng vượt FinSSLX, vốn có bước đơn giản hóa văn bản và tiền huấn luyện nhúng từ trên kho ngữ liệu tài chính lớn có nhãn cảm xúc.

FinBERT vượt ULMFit và do đó vượt mọi phương pháp khác ở mọi chỉ số. Để đo hiệu suất với các kích thước tập huấn luyện có nhãn khác nhau, nhóm chạy các bộ phân loại LSTM, ULMFit và FinBERT trên 5 cấu hình; hàm mất mát cross entropy trên tập kiểm tra của từng mô hình được vẽ ở hình 2. Với 100 mẫu huấn luyện, tất cả mô hình đều quá ít. Tuy nhiên, khi lên 250 mẫu, ULMFit và FinBERT bắt đầu phân biệt nhãn thành công, với độ chính xác lên tới 80% ở FinBERT. Mọi phương pháp đều tốt dần khi có thêm dữ liệu, nhưng ULMFit và FinBERT với 250 mẫu đã tốt hơn các bộ phân loại LSTM dùng toàn bộ dữ liệu, cho thấy hiệu quả của tiền huấn luyện mô hình ngôn ngữ.

Hình 2: Mất mát trên tập kiểm tra với các kích thước tập huấn luyện khác nhau
