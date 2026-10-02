# M5L2_DT1

FinBERT: Phân tích cảm xúc tài chính với các mô hình ngôn ngữ tiền huấn luyện

Tác giả: Dogu Tan Araci (University of Amsterdam, Amsterdam, Hà Lan). Luận văn thạc sĩ ngành Nghiên cứu thông tin, chuyên ngành Khoa học dữ liệu, Khoa Khoa học, University of Amsterdam, ngày 25/06/2019 (arXiv:1908.10063v1, 27/08/2019). Người hướng dẫn nội bộ: Dr Pengjie Ren (UvA, ILPS). Người hướng dẫn bên ngoài: Dr Zulkuf Genc (Naspers Group).

## TÓM TẮT

Các phương pháp học chuyển giao (transfer learning) trong NLP là giải pháp đầy hứa hẹn cho cả hai thách thức nêu trên và là trọng tâm của luận văn này. Ý tưởng cốt lõi: huấn luyện mô hình ngôn ngữ trên các kho ngữ liệu rất lớn, rồi khởi tạo các mô hình hạ nguồn bằng trọng số học được từ tác vụ mô hình hóa ngôn ngữ, nhờ đó đạt hiệu năng tốt hơn nhiều. Phần được khởi tạo có thể chỉ là lớp nhúng từ (word embedding) [23] hoặc toàn bộ mô hình [5]. Về lý thuyết, cách tiếp cận này giải quyết được vấn đề khan hiếm dữ liệu có nhãn: mô hình ngôn ngữ không cần nhãn vì tác vụ là dự đoán từ kế tiếp, và chúng học được cách biểu diễn thông tin ngữ nghĩa. Nhờ vậy, bước tinh chỉnh (fine-tuning) trên dữ liệu có nhãn chỉ còn phải học cách dùng thông tin ngữ nghĩa đó để dự đoán nhãn.

Một thành phần đặc thù của học chuyển giao là khả năng tiếp tục tiền huấn luyện mô hình ngôn ngữ trên kho ngữ liệu không nhãn thuộc một lĩnh vực cụ thể. Nhờ đó mô hình học được các quan hệ ngữ nghĩa trong văn bản của lĩnh vực đích, vốn có phân phối khác với kho ngữ liệu tổng quát. Cách tiếp cận này đặc biệt triển vọng với lĩnh vực chuyên biệt như tài chính, nơi ngôn ngữ và từ vựng khác biệt rõ rệt so với ngôn ngữ thông thường.

Mục tiêu của luận văn là kiểm chứng những ưu điểm giả định của việc dùng và tinh chỉnh mô hình ngôn ngữ tiền huấn luyện cho lĩnh vực tài chính. Để làm vậy, luận văn dự đoán cảm xúc của một câu trong bài báo tài chính đối với chủ thể tài chính được nêu trong câu, sử dụng Financial PhraseBank do Malo và cộng sự (2014) [17] xây dựng và bộ dữ liệu chấm điểm cảm xúc FiQA Task 1 [15].

Các đóng góp chính của luận văn như sau:

Phân tích cảm xúc tài chính là tác vụ khó do ngôn ngữ chuyên biệt và thiếu dữ liệu có nhãn trong lĩnh vực này. Các mô hình đa dụng chưa đủ hiệu quả vì ngôn ngữ tài chính mang tính chuyên biệt. Nhóm tác giả giả định rằng mô hình ngôn ngữ tiền huấn luyện giúp giải quyết vấn đề, vì chúng cần ít mẫu có nhãn hơn và có thể được huấn luyện thêm trên kho ngữ liệu chuyên ngành. Họ giới thiệu FinBERT, mô hình ngôn ngữ dựa trên BERT, để xử lý các tác vụ NLP trong lĩnh vực tài chính. Kết quả cho thấy cải thiện ở mọi chỉ số được đo so với kết quả tốt nhất hiện có (state-of-the-art) trên hai bộ dữ liệu phân tích cảm xúc tài chính. Ngay cả với tập huấn luyện nhỏ hơn và chỉ tinh chỉnh một phần mô hình, FinBERT vẫn vượt các phương pháp học máy tiên tiến nhất.

## 1. GIỚI THIỆU

Giá trên thị trường mở phản ánh toàn bộ thông tin sẵn có về các tài sản được giao dịch trong nền kinh tế [16]. Khi có thông tin mới, mọi chủ thể điều chỉnh vị thế và giá cả điều chỉnh theo, khiến việc liên tục đánh bại thị trường là bất khả thi. Tuy nhiên, định nghĩa "thông tin mới" có thể thay đổi khi xuất hiện các công nghệ truy xuất thông tin mới, và việc sớm áp dụng chúng có thể mang lại lợi thế ngắn hạn.

Phân tích văn bản tài chính, như tin tức, báo cáo của nhà phân tích hay thông báo chính thức của công ty, là một nguồn thông tin mới tiềm năng. Với lượng văn bản khổng lồ chưa từng có được tạo ra mỗi ngày, việc phân tích thủ công và rút ra nhận định có thể hành động là quá sức với bất kỳ đơn vị nào. Vì vậy, phân tích cảm xúc hay độ phân cực (polarity) tự động của văn bản do các chủ thể tài chính tạo ra, bằng các phương pháp xử lý ngôn ngữ tự nhiên (NLP), đã trở nên phổ biến trong thập kỷ qua [4].

Mối quan tâm nghiên cứu chính của luận văn là phân tích phân cực, tức phân loại văn bản thành tích cực, tiêu cực hoặc trung lập trong một lĩnh vực cụ thể. Việc này phải giải quyết hai thách thức: 1) Các phương pháp phân loại tinh vi nhất dùng mạng nơ-ron cần lượng dữ liệu có nhãn rất lớn, mà gán nhãn các đoạn văn bản tài chính đòi hỏi chuyên môn tốn kém. 2) Các mô hình phân tích cảm xúc huấn luyện trên kho ngữ liệu tổng quát không phù hợp, vì văn bản tài chính có ngôn ngữ chuyên biệt với từ vựng riêng và thường dùng cách diễn đạt mơ hồ thay vì các từ tích cực/tiêu cực dễ nhận biết.

Dùng các từ điển cảm xúc tài chính được xây dựng cẩn thận như Loughran và McDonald (2011) [11] có vẻ là giải pháp, vì chúng đưa kiến thức tài chính sẵn có vào phân tích văn bản. Tuy nhiên, chúng dựa trên phương pháp "đếm từ", vốn kém hiệu quả trong việc phân tích ý nghĩa ngữ nghĩa sâu hơn của văn bản.
