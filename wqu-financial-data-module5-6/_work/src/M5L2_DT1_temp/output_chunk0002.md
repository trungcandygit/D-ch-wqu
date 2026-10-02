- Giới thiệu FinBERT, một mô hình ngôn ngữ dựa trên BERT cho các tác vụ NLP tài chính, được đánh giá trên hai bộ dữ liệu phân tích cảm xúc tài chính.
- Đạt kết quả tốt nhất hiện nay (state-of-the-art) trên FiQA sentiment scoring và Financial PhraseBank.
- Triển khai thêm hai mô hình ngôn ngữ tiền huấn luyện khác là ULMFit và ELMo cho phân tích cảm xúc tài chính và so sánh với FinBERT.
- Thực hiện các thí nghiệm khảo sát nhiều khía cạnh của mô hình: tác động của việc tiền huấn luyện thêm trên kho ngữ liệu tài chính, các chiến lược huấn luyện nhằm tránh quên thảm khốc (catastrophic forgetting), và chỉ tinh chỉnh một tập con nhỏ các lớp của mô hình để giảm thời gian huấn luyện mà hiệu năng không giảm đáng kể.

Phần còn lại của luận văn được cấu trúc như sau: trước hết, các nghiên cứu liên quan về phân tích phân cực (polarity) trong tài chính và về các mô hình ngôn ngữ tiền huấn luyện được thảo luận (Mục 2). Tiếp theo, các mô hình được đánh giá được mô tả (Mục 3), rồi đến thiết lập thí nghiệm (Mục 4). Mục 5 trình bày kết quả thí nghiệm trên các bộ dữ liệu cảm xúc tài chính. Mục 6 phân tích sâu hơn FinBERT từ nhiều góc độ. Cuối cùng, Mục 7 là kết luận.

## 2 TÀI LIỆU LIÊN QUAN

Phần này mô tả các nghiên cứu trước đây về phân tích cảm xúc trong tài chính (2.1) và phân loại văn bản bằng mô hình ngôn ngữ tiền huấn luyện (2.2).

### 2.1 Phân tích cảm xúc trong tài chính

Phân tích cảm xúc là tác vụ trích xuất cảm xúc hay quan điểm của con người từ ngôn ngữ viết [10]. Các nỗ lực gần đây chia làm hai nhóm: 1) phương pháp học máy với đặc trưng trích từ văn bản bằng "đếm từ" (word counting) [1, 19, 28, 30]; 2) phương pháp học sâu, trong đó văn bản được biểu diễn bằng chuỗi embedding [2, 25, 32]. Nhóm đầu không biểu diễn được thông tin ngữ nghĩa phát sinh từ một chuỗi từ cụ thể, còn nhóm sau thường bị coi là quá "khát dữ liệu" vì phải học số tham số lớn hơn nhiều [18].

Phân tích cảm xúc tài chính khác phân tích cảm xúc thông thường không chỉ về lĩnh vực mà còn về mục đích: thường là đoán thị trường sẽ phản ứng thế nào với thông tin trong văn bản [9]. Loughran và McDonald (2016) tổng quan kỹ các công trình phân tích văn bản tài chính dùng học máy với cách tiếp cận "túi từ" (bag-of-words) hoặc phương pháp dựa trên từ điển [12]. Chẳng hạn, Loughran và McDonald (2011) xây dựng từ điển thuật ngữ tài chính gán các giá trị như "tích cực" hay "không chắc chắn" và đo sắc thái của tài liệu bằng cách đếm các từ có giá trị từ điển cụ thể [11]. Một ví dụ khác là Pagolu và cộng sự (2016), trong đó các n-gram từ tweet chứa thông tin tài chính được đưa vào các thuật toán học máy có giám sát để phát hiện cảm xúc đối với thực thể tài chính được nhắc đến.

Một trong những bài báo đầu tiên dùng học sâu cho phân tích phân cực văn bản tài chính là Kraus và Feuerriegel (2017) [7]. Họ áp dụng mạng nơ-ron LSTM lên các thông báo ad-hoc của công ty để dự đoán biến động thị trường chứng khoán và cho thấy phương pháp này chính xác hơn các phương pháp học máy truyền thống. Họ nhận thấy tiền huấn luyện mô hình trên kho ngữ liệu lớn hơn cải thiện kết quả; tuy nhiên việc tiền huấn luyện đó dùng tập dữ liệu có nhãn, là cách tiếp cận hạn chế hơn của chúng tôi, vì chúng tôi tiền huấn luyện mô hình ngôn ngữ như một tác vụ không giám sát.

Có nhiều công trình khác dùng các kiến trúc mạng nơ-ron khác nhau cho phân tích cảm xúc tài chính. Sohangir và cộng sự (2018) [26] áp dụng một số kiến trúc mạng nơ-ron thông dụng lên tập dữ liệu StockTwits và thấy CNN có hiệu quả nhất. Lutz và cộng sự (2018) [13] dùng doc2vec để tạo embedding câu trong thông báo ad-hoc của một công ty và dùng học đa thể hiện (multi-instance learning) để dự đoán kết quả thị trường chứng khoán. Maia và cộng sự (2018) [14] kết hợp đơn giản hóa văn bản và mạng LSTM để phân loại một tập câu từ tin tức tài chính theo cảm xúc, đạt kết quả state-of-the-art trên Financial PhraseBank, bộ dữ liệu cũng được dùng trong luận văn này.

Do thiếu các bộ dữ liệu tài chính có nhãn quy mô lớn, rất khó khai thác hết tiềm năng của mạng nơ-ron cho phân tích cảm xúc. Ngay cả khi các lớp đầu tiên (lớp nhúng từ) được khởi tạo bằng giá trị tiền huấn luyện, phần còn lại của mô hình vẫn phải học các quan hệ phức tạp từ lượng dữ liệu có nhãn tương đối nhỏ. Một giải pháp triển vọng hơn là khởi tạo gần như toàn bộ mô hình bằng giá trị tiền huấn luyện và tinh chỉnh các giá trị đó theo tác vụ phân loại.

### 2.2 Phân loại văn bản bằng mô hình ngôn ngữ tiền huấn luyện
