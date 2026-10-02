## **4.3 Áp dụng NMF**

Sau khi tạo `dtm`, giờ đây chúng ta có thể áp dụng NMF lên ma trận này để khám phá các chủ đề tiềm ẩn trong các bài báo tin tức tài chính. Chúng ta sẽ thực hiện việc này với tham số `n_components=5`, tham số quy định số lượng chủ đề (hay thành phần) mà ta muốn trích xuất từ dữ liệu. Trong trường hợp này, ta nhắm đến năm chủ đề.
`random_state=42` đặt một hạt giống ngẫu nhiên (random seed) để đảm bảo khả năng tái lập kết quả. Việc dùng cùng một hạt giống bảo đảm ta thu được cùng một kết quả mỗi lần chạy mã:

```python
# NMF
nmf_model = NMF(n_components=5, random_state=42) # 5 topics
W = nmf_model.fit_transform(dtm)
H = nmf_model.components_

```

NMF được dùng để khám phá các chủ đề tiềm ẩn trong dữ liệu văn bản. Phương pháp này phân rã ma trận tài liệu-thuật ngữ thành hai ma trận có số chiều thấp hơn, biểu diễn mối quan hệ giữa từ và chủ đề, cũng như giữa chủ đề và tài liệu. Giờ đây chúng ta đã thu được:

 - $W$ (Ma trận Tài liệu-Chủ đề) biểu diễn phân phối của các chủ đề trong từng tài liệu. Mỗi hàng của $W$ tương ứng với một tài liệu trong kho ngữ liệu, và mỗi cột tương ứng với một chủ đề do NMF khám phá. Các giá trị trong $W$ cho biết trọng số hay xác suất xuất hiện của từng chủ đề trong mỗi tài liệu.
 - $H$ (Ma trận Chủ đề-Từ) biểu diễn phân phối của các từ trong từng chủ đề. Mỗi hàng của $H$ tương ứng với một chủ đề, và mỗi cột tương ứng với một từ trong từ vựng. Các giá trị trong $H$ cho biết trọng số hay mức độ quan trọng của từng từ trong mỗi chủ đề.

Tham số `n_components=5` xác định số lượng chủ đề (hay thành phần) mà ta muốn trích xuất từ dữ liệu. Trong trường hợp của chúng ta, ta nhắm đến việc khám phá năm chủ đề riêng biệt trong các bài báo tin tức tài chính liên quan đến Microsoft. Số lượng chủ đề nhỏ (như năm) thường cho kết quả dễ diễn giải hơn. Việc hiểu và gán nhãn có ý nghĩa cho năm chủ đề dễ dàng hơn so với, chẳng hạn, 20 hay 50 chủ đề. Khi mới bắt đầu với mô hình hóa chủ đề, thông thường nên bắt đầu với số lượng chủ đề nhỏ rồi tăng dần nếu cần. Cách này giúp nắm được bức tranh tổng quát về các chủ đề chính trong dữ liệu trước khi đi vào phân tích chi tiết hơn. Số lượng chủ đề nhỏ cũng làm giảm chi phí tính toán của NMF, giúp quá trình nhanh hơn, đặc biệt với các tập dữ liệu lớn hơn.
