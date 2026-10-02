# M5L2_DT1

FinBERT: Phân tích cảm xúc tài chính bằng các mô hình ngôn ngữ tiền huấn luyện

arXiv:1908.10063v1 [cs.CL] 27 Aug 2019

Luận văn nộp một phần yêu cầu để lấy bằng thạc sĩ khoa học — Dogu Araci (12255068), ngành Nghiên cứu thông tin, chuyên ngành Khoa học dữ liệu, Khoa Khoa học, Đại học Amsterdam, 2019-06-25.

| Vai trò | Họ tên | Đơn vị | Email |
|---|---|---|---|
| Người hướng dẫn nội bộ | Dr Pengjie Ren | UvA, ILPS | p.ren@uva.nl |
| Người hướng dẫn bên ngoài | Dr Zulkuf Genc | Naspers Group | zulkuf.genc@naspers.com |

FinBERT: Phân tích cảm xúc tài chính bằng các mô hình ngôn ngữ tiền huấn luyện

Dogu Tan Araci, dogu.araci@student.uva.nl, University of Amsterdam, Amsterdam, Hà Lan

## TÓM TẮT

Các phương pháp học chuyển giao (transfer learning) trong xử lý ngôn ngữ tự nhiên (NLP) là giải pháp đầy triển vọng cho cả hai thách thức nêu trên và là trọng tâm của luận văn. Ý tưởng cốt lõi: huấn luyện mô hình ngôn ngữ trên các kho ngữ liệu rất lớn, rồi khởi tạo các mô hình tác vụ hạ nguồn bằng trọng số học được từ tác vụ mô hình hóa ngôn ngữ, nhờ đó đạt hiệu năng tốt hơn nhiều. Phần được khởi tạo có thể chỉ là một lớp nhúng từ (word embedding) [23] hoặc toàn bộ mô hình [5]. Về lý thuyết, cách này giải quyết bài toán khan hiếm dữ liệu có nhãn: mô hình ngôn ngữ không cần nhãn vì tác vụ là dự đoán từ tiếp theo, và vẫn học được cách biểu diễn thông tin ngữ nghĩa. Khi đó, bước tinh chỉnh (fine-tune) trên dữ liệu có nhãn chỉ còn phải học cách dùng thông tin ngữ nghĩa này để dự đoán nhãn.

Một thành phần đặc thù của học chuyển giao là khả năng tiếp tục tiền huấn luyện mô hình ngôn ngữ trên kho ngữ liệu không nhãn thuộc lĩnh vực cụ thể. Nhờ vậy mô hình học được các quan hệ ngữ nghĩa trong văn bản của lĩnh vực đích, vốn có khả năng phân phối khác với kho ngữ liệu tổng quát. Cách tiếp cận này đặc biệt hứa hẹn với lĩnh vực ngách như tài chính, nơi ngôn ngữ và từ vựng khác biệt rất lớn so với ngôn ngữ thông thường.

Mục tiêu của luận văn là kiểm chứng các ưu thế được giả định của việc sử dụng và tinh chỉnh mô hình ngôn ngữ tiền huấn luyện cho lĩnh vực tài chính. Để làm vậy, luận văn dự đoán cảm xúc của một câu trong bài báo tài chính đối với chủ thể tài chính được nhắc đến trong câu, sử dụng Financial PhraseBank do Malo et al. (2014) [17] xây dựng và tập dữ liệu chấm điểm cảm xúc FiQA Task 1 [15].

Các đóng góp chính của luận văn như sau:

Phân tích cảm xúc tài chính là tác vụ khó do ngôn ngữ chuyên biệt và thiếu dữ liệu có nhãn trong lĩnh vực này. Các mô hình đa dụng kém hiệu quả vì ngôn ngữ tài chính chuyên biệt. Giả thuyết của chúng tôi là mô hình ngôn ngữ tiền huấn luyện giúp giải quyết vấn đề, vì cần ít ví dụ có nhãn hơn và có thể huấn luyện thêm trên kho ngữ liệu chuyên ngành. Chúng tôi giới thiệu FinBERT, mô hình ngôn ngữ dựa trên BERT, cho các tác vụ NLP tài chính. Kết quả cho thấy cải thiện ở mọi chỉ số đo được so với kết quả tốt nhất hiện nay (state-of-the-art) trên hai tập dữ liệu phân tích cảm xúc tài chính. Ngay cả với tập huấn luyện nhỏ hơn và chỉ tinh chỉnh một phần mô hình, FinBERT vẫn vượt các phương pháp học máy tốt nhất hiện có.

## 1 GIỚI THIỆU

Giá trong thị trường mở phản ánh toàn bộ thông tin sẵn có về các tài sản được giao dịch trong nền kinh tế [16]. Khi có thông tin mới, mọi chủ thể cập nhật vị thế và giá điều chỉnh theo, khiến việc liên tục đánh bại thị trường là bất khả thi. Tuy nhiên, định nghĩa "thông tin mới" có thể thay đổi khi xuất hiện các công nghệ truy xuất thông tin mới, và việc sớm áp dụng chúng có thể mang lại lợi thế ngắn hạn.

Phân tích văn bản tài chính (tin tức, báo cáo phân tích, thông báo chính thức của công ty) là một nguồn thông tin mới tiềm năng. Lượng văn bản như vậy được tạo ra mỗi ngày chưa từng có, nên không một đơn vị nào đủ sức phân tích thủ công và rút ra thông tin khả dụng. Vì thế, phân tích cảm xúc hay độ phân cực (polarity) tự động của văn bản do các chủ thể tài chính tạo ra bằng các phương pháp NLP đã trở nên phổ biến trong thập kỷ qua [4].

Mối quan tâm nghiên cứu chính của luận văn là phân tích độ phân cực, tức phân loại văn bản thành tích cực, tiêu cực hoặc trung lập trong một lĩnh vực cụ thể. Việc này phải giải quyết hai thách thức: 1) Các phương pháp phân loại tinh vi nhất dùng mạng nơ-ron cần lượng dữ liệu có nhãn rất lớn, mà gán nhãn văn bản tài chính đòi hỏi chuyên môn tốn kém. 2) Các mô hình phân tích cảm xúc huấn luyện trên kho ngữ liệu tổng quát không phù hợp, vì văn bản tài chính có ngôn ngữ chuyên biệt với từ vựng riêng và thường dùng cách diễn đạt mơ hồ thay vì các từ tích cực/tiêu cực dễ nhận biết.

Dùng các từ điển cảm xúc tài chính được xây dựng kỹ như Loughran và McDonald (2011) [11] có vẻ là giải pháp vì chúng đưa kiến thức tài chính sẵn có vào phân tích văn bản. Tuy nhiên, chúng dựa trên phương pháp "đếm từ", không đủ khả năng phân tích ý nghĩa ngữ nghĩa sâu hơn của văn bản.
