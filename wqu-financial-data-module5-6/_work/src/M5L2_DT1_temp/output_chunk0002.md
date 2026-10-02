- Chúng tôi giới thiệu FinBERT, một mô hình ngôn ngữ dựa trên BERT cho các tác vụ NLP tài chính, và đánh giá FinBERT trên hai bộ dữ liệu phân tích cảm xúc tài chính.
- Chúng tôi đạt kết quả tốt nhất hiện nay (state-of-the-art) trên FiQA sentiment scoring và Financial PhraseBank.
- Chúng tôi triển khai thêm hai mô hình ngôn ngữ tiền huấn luyện khác là ULMFit và ELMo cho phân tích cảm xúc tài chính và so sánh với FinBERT.
- Chúng tôi thực hiện các thí nghiệm khảo sát nhiều khía cạnh của mô hình: tác động của việc tiền huấn luyện thêm trên kho ngữ liệu tài chính, các chiến lược huấn luyện nhằm tránh quên thảm khốc (catastrophic forgetting), và chỉ tinh chỉnh một tập con nhỏ các tầng của mô hình để giảm thời gian huấn luyện mà hiệu năng không giảm đáng kể.

Phần còn lại của luận văn được bố cục như sau: Mục 2 thảo luận các tài liệu liên quan về phân tích phân cực (polarity) trong tài chính và các mô hình ngôn ngữ tiền huấn luyện. Mục 3 mô tả các mô hình được đánh giá. Mục 4 trình bày thiết lập thí nghiệm. Mục 5 nêu kết quả thí nghiệm trên các bộ dữ liệu cảm xúc tài chính. Mục 6 phân tích sâu hơn FinBERT từ nhiều góc độ, và Mục 7 là phần kết luận.

## 2. Tài liệu liên quan

Mục này mô tả các nghiên cứu trước đây về phân tích cảm xúc trong tài chính (2.1) và phân loại văn bản bằng các mô hình ngôn ngữ tiền huấn luyện (2.2).

### 2.1 Phân tích cảm xúc trong tài chính

Phân tích cảm xúc là tác vụ trích xuất cảm xúc hay quan điểm của con người từ ngôn ngữ viết [10]. Các nỗ lực gần đây chia thành hai nhóm: 1) các phương pháp học máy với đặc trưng trích từ văn bản bằng "đếm từ" [1, 19, 28, 30]; 2) các phương pháp học sâu, trong đó văn bản được biểu diễn bằng chuỗi embedding [2, 25, 32]. Nhóm thứ nhất không biểu diễn được thông tin ngữ nghĩa sinh ra từ một chuỗi từ cụ thể, còn nhóm thứ hai thường bị xem là quá "khát dữ liệu" do phải học số lượng tham số lớn hơn nhiều [18].

Phân tích cảm xúc tài chính khác phân tích cảm xúc thông thường không chỉ về lĩnh vực mà cả mục đích. Mục đích thường là dự đoán thị trường sẽ phản ứng thế nào với thông tin trong văn bản [9]. Loughran và McDonald (2016) trình bày khảo sát toàn diện các công trình phân tích văn bản tài chính dùng học máy với cách tiếp cận "túi từ" (bag-of-words) hoặc phương pháp dựa trên từ điển [12]. Chẳng hạn, Loughran và McDonald (2011) xây dựng từ điển thuật ngữ tài chính gán các giá trị như "tích cực" hay "không chắc chắn" và đo sắc thái của văn bản bằng cách đếm các từ có giá trị từ điển tương ứng [11]. Một ví dụ khác là Pagolu và cộng sự (2016), trong đó các n-gram từ tweet chứa thông tin tài chính được đưa vào các thuật toán học máy có giám sát để phát hiện cảm xúc đối với thực thể tài chính được nhắc đến.

Một trong những bài báo đầu tiên dùng học sâu cho phân tích phân cực văn bản tài chính là Kraus và Feuerriegel (2017) [7]. Họ áp dụng mạng nơ-ron LSTM lên các thông báo đột xuất (ad-hoc) của công ty để dự đoán biến động thị trường chứng khoán và cho thấy phương pháp này chính xác hơn các phương pháp học máy truyền thống. Họ nhận thấy tiền huấn luyện mô hình trên kho ngữ liệu lớn hơn cải thiện kết quả; tuy nhiên việc tiền huấn luyện của họ dùng tập dữ liệu có nhãn, vốn hạn chế hơn cách của chúng tôi, vì chúng tôi tiền huấn luyện mô hình ngôn ngữ như một tác vụ không giám sát.

Còn nhiều công trình khác dùng các kiến trúc mạng nơ-ron khác nhau cho phân tích cảm xúc tài chính. Sohangir và cộng sự (2018) [26] áp dụng một số kiến trúc mạng nơ-ron phổ thông lên bộ dữ liệu StockTwits và thấy CNN là kiến trúc tốt nhất. Lutz và cộng sự (2018) [13] dùng doc2vec để tạo embedding câu cho thông báo đột xuất của công ty và dùng học đa thể hiện (multi-instance learning) để dự đoán kết quả thị trường chứng khoán. Maia và cộng sự (2018) [14] kết hợp đơn giản hóa văn bản và mạng LSTM để phân loại một tập câu từ tin tức tài chính theo cảm xúc, đạt kết quả tốt nhất hiện nay trên Financial PhraseBank, cũng là bộ dữ liệu được dùng trong luận văn này.

Do thiếu các bộ dữ liệu tài chính có nhãn quy mô lớn, rất khó khai thác hết tiềm năng của mạng nơ-ron cho phân tích cảm xúc. Ngay cả khi các tầng đầu tiên (tầng nhúng từ) được khởi tạo bằng giá trị tiền huấn luyện, phần còn lại của mô hình vẫn phải học các quan hệ phức tạp từ lượng dữ liệu có nhãn tương đối nhỏ. Một giải pháp hứa hẹn hơn là khởi tạo gần như toàn bộ mô hình bằng giá trị tiền huấn luyện và tinh chỉnh (fine-tune) các giá trị đó theo tác vụ phân loại.

### 2.2 Phân loại văn bản bằng mô hình ngôn ngữ tiền huấn luyện
