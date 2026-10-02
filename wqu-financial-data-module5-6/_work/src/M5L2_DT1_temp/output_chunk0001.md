# M5L2_DT1

FinBERT: Phân tích cảm xúc tài chính với các mô hình ngôn ngữ tiền huấn luyện

arXiv:1908.10063v1 [cs.CL] 27/08/2019

Luận văn thạc sĩ khoa học, Dogu Araci (12255068), chuyên ngành Nghiên cứu thông tin (Master Information Studies), hướng Khoa học dữ liệu, Khoa Khoa học, Đại học Amsterdam (University of Amsterdam), ngày 25/06/2019.

Giảng viên hướng dẫn nội bộ: Dr Pengjie Ren (UvA, ILPS). Giảng viên hướng dẫn bên ngoài: Dr Zulkuf Genc (Naspers Group).

# FinBERT: Phân tích cảm xúc tài chính với các mô hình ngôn ngữ tiền huấn luyện

Dogu Tan Araci, Đại học Amsterdam, Amsterdam, Hà Lan

## TÓM TẮT

Phân tích cảm xúc tài chính là một tác vụ khó do ngôn ngữ chuyên ngành và việc thiếu dữ liệu có nhãn trong lĩnh vực này. Các mô hình đa dụng chưa đủ hiệu quả vì ngôn ngữ trong bối cảnh tài chính mang tính chuyên biệt. Tác giả giả thuyết rằng các mô hình ngôn ngữ tiền huấn luyện có thể giải quyết vấn đề này vì cần ít mẫu có nhãn hơn và có thể được huấn luyện thêm trên kho ngữ liệu chuyên ngành. Tác giả giới thiệu FinBERT, một mô hình ngôn ngữ dựa trên BERT, để xử lý các tác vụ NLP trong lĩnh vực tài chính. Kết quả cho thấy FinBERT cải thiện mọi chỉ số đo được so với kết quả tốt nhất hiện nay (state-of-the-art) trên hai bộ dữ liệu phân tích cảm xúc tài chính. Ngay cả với tập huấn luyện nhỏ hơn và chỉ tinh chỉnh (fine-tune) một phần mô hình, FinBERT vẫn vượt các phương pháp học máy tốt nhất hiện nay.

Các phương pháp học chuyển giao NLP là giải pháp đầy hứa hẹn cho cả hai thách thức nêu trên và là trọng tâm của luận văn. Ý tưởng cốt lõi: huấn luyện mô hình ngôn ngữ trên kho ngữ liệu rất lớn, rồi khởi tạo các mô hình hạ nguồn bằng trọng số học được từ tác vụ mô hình hóa ngôn ngữ, nhờ đó đạt hiệu năng tốt hơn nhiều. Các lớp được khởi tạo có thể chỉ là lớp nhúng từ (word embedding) đơn lẻ [23] hoặc toàn bộ mô hình [5]. Về lý thuyết, cách tiếp cận này giải quyết được vấn đề khan hiếm dữ liệu có nhãn: mô hình ngôn ngữ không cần nhãn vì tác vụ là dự đoán từ kế tiếp, và có thể học cách biểu diễn thông tin ngữ nghĩa. Việc tinh chỉnh trên dữ liệu có nhãn chỉ còn phải học cách dùng thông tin ngữ nghĩa này để dự đoán nhãn.

Một thành phần đặc thù của học chuyển giao là khả năng tiếp tục tiền huấn luyện mô hình ngôn ngữ trên kho ngữ liệu không nhãn thuộc lĩnh vực chuyên biệt. Nhờ đó mô hình học được các quan hệ ngữ nghĩa trong văn bản của miền đích, vốn có thể có phân phối khác với kho ngữ liệu tổng quát. Cách tiếp cận này đặc biệt hứa hẹn với lĩnh vực ngách như tài chính, nơi ngôn ngữ và từ vựng khác biệt rõ rệt so với ngôn ngữ thông thường.

Mục tiêu của luận văn là kiểm chứng những ưu điểm giả định của việc dùng và tinh chỉnh mô hình ngôn ngữ tiền huấn luyện cho lĩnh vực tài chính. Cụ thể, luận văn dự đoán cảm xúc của một câu trong bài báo tài chính đối với chủ thể tài chính được nêu trong câu, sử dụng Financial PhraseBank do Malo et al. (2014) [17] xây dựng và bộ dữ liệu chấm điểm cảm xúc FiQA Task 1 [15].

Các đóng góp chính của luận văn được trình bày như sau.

## 1. GIỚI THIỆU

Giá trên thị trường mở phản ánh toàn bộ thông tin sẵn có về các tài sản được giao dịch trong nền kinh tế [16]. Khi có thông tin mới, mọi chủ thể cập nhật vị thế và giá điều chỉnh tương ứng, khiến việc liên tục đánh bại thị trường là bất khả thi. Tuy nhiên, định nghĩa "thông tin mới" có thể thay đổi khi các công nghệ truy xuất thông tin mới xuất hiện, và việc sớm áp dụng chúng có thể mang lại lợi thế ngắn hạn.

Phân tích văn bản tài chính, như tin tức, báo cáo phân tích hay thông báo chính thức của công ty, là một nguồn thông tin mới khả dĩ. Do lượng văn bản như vậy được tạo ra mỗi ngày chưa từng có, việc phân tích thủ công và rút ra nhận định hữu ích là quá sức với bất kỳ đơn vị nào. Vì vậy, phân tích cảm xúc hay độ phân cực (polarity) tự động đối với văn bản của các chủ thể tài chính bằng các phương pháp xử lý ngôn ngữ tự nhiên (NLP) đã ngày càng phổ biến trong thập kỷ qua [4].

Mối quan tâm nghiên cứu chính của luận văn là phân tích độ phân cực, tức phân loại văn bản thành tích cực, tiêu cực hoặc trung tính, trong một lĩnh vực cụ thể. Việc này phải giải quyết hai thách thức: 1) Các phương pháp phân loại tinh vi nhất dùng mạng nơ-ron cần lượng lớn dữ liệu có nhãn, trong khi gán nhãn các đoạn văn bản tài chính đòi hỏi chuyên môn tốn kém. 2) Các mô hình phân tích cảm xúc huấn luyện trên kho ngữ liệu tổng quát không phù hợp, vì văn bản tài chính có ngôn ngữ chuyên biệt với từ vựng riêng và có xu hướng dùng cách diễn đạt mơ hồ thay vì các từ tích cực/tiêu cực dễ nhận biết.

Dùng các từ điển cảm xúc tài chính được xây dựng kỹ như Loughran và McDonald (2011) [11] có vẻ là một giải pháp vì chúng đưa tri thức tài chính sẵn có vào phân tích văn bản. Tuy nhiên, chúng dựa trên phương pháp "đếm từ", vốn không đủ khả năng phân tích ý nghĩa ngữ nghĩa sâu hơn của văn bản.
