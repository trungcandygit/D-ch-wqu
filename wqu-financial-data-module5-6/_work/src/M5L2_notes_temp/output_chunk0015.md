## **4.2 Trích xuất đặc trưng - Ma trận tài liệu-thuật ngữ (TDM)**

Trong đoạn mã sau, chúng ta khớp (fit) bộ vector hóa `TfidfVectorizer` với dữ liệu trong cột 'Processed_Description'. Chúng ta áp dụng `TfidfVectorizer` với tham số `max_features=250`, giới hạn kích thước từ vựng ở 250 từ xuất hiện thường xuyên nhất. Điều này giúp giảm số chiều của ma trận tài liệu-thuật ngữ (DTM) và có thể cải thiện hiệu năng. Chúng ta cũng dùng tham số `stop_words='english'` để loại bỏ các từ tiếng Anh thông dụng (như "the," "a," "is") khỏi từ vựng, vì chúng thường không mang nhiều thông tin có ý nghĩa. Thao tác này sẽ chuyển dữ liệu văn bản trong 'Processed_Description' thành ma trận tài liệu-thuật ngữ (DTM), được biểu diễn bằng biến `dtm`:


```python
# TF-IDF Vectorization
vectorizer = TfidfVectorizer(max_features=250, stop_words='english')
dtm = vectorizer.fit_transform(df['Processed_Description'])
dtm.shape
```

Biến `dtm` lúc này chứa một ma trận thưa, trong đó:
- Mỗi hàng đại diện cho một tài liệu (trong trường hợp của chúng ta là một bài báo tin tức).
- Mỗi cột đại diện cho một từ (hay đặc trưng) trong từ vựng.
- Các giá trị trong ma trận biểu thị điểm TF-IDF của từng từ trong từng tài liệu.
- `dtm` thường được lưu dưới dạng ma trận thưa để tiết kiệm bộ nhớ vì nó thường chứa nhiều giá trị bằng không.

Phạm vi thông thường của `max_features` là từ 1000 đến 5000, nhưng có thể thay đổi rất nhiều tùy theo tập dữ liệu và tác vụ, dựa trên các yếu tố như kích thước tập dữ liệu, độ phức tạp của tác vụ, tài nguyên tính toán, thực nghiệm, v.v. Với một tập dữ liệu như của chúng ta chỉ có khoảng 90 hàng, giá trị `max_features` từ 100 đến 500 có lẽ là điểm khởi đầu phù hợp để cân bằng giữa số chiều và lượng thông tin.
