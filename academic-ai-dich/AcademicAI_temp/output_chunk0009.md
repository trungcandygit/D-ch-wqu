#### 1. Các mô hình dựa trên Transformer: Xương sống của AI hiện đại

Bước đột phá giúp AI tạo sinh ngày nay ra đời là sự xuất hiện của **kiến trúc transformer**. Không giống các mô hình mạng nơ-ron trước đây xử lý đầu vào theo trình tự (chẳng hạn mạng nơ-ron hồi quy, RNN), transformer sử dụng **cơ chế tự chú ý (self-attention)** để phân tích song song toàn bộ chuỗi đầu vào. Điều này cho phép mô hình nhận biết các phụ thuộc tầm xa trong văn bản, qua đó cải thiện đáng kể khả năng tạo ra các phản hồi mạch lạc, nhạy bén với ngữ cảnh.

Các mô hình dựa trên transformer được sử dụng rộng rãi nhất gồm:

● **GPT (Generative Pre-trained Transformer)** -- Được OpenAI phát triển, họ mô hình này (GPT-3, GPT-4 và các phiên bản tương lai) được huấn luyện trên các kho ngữ liệu văn bản khổng lồ để tạo ra văn bản trôi chảy, giống con người. Các mô hình GPT được dùng rộng rãi trong viết học thuật, lập trình và AI hội thoại.

● **Claude** -- Do Anthropic tạo ra, Claude tập trung vào tính an toàn, khả năng diễn giải và giảm thiểu thiên lệch, khiến nó trở thành một lựa chọn thay thế mạnh mẽ cho việc sử dụng AI có trách nhiệm trong môi trường học thuật.

● **BERT (Bidirectional Encoder Representations from Transformers)** -- Không giống GPT, vốn thiên về tạo sinh, BERT chủ yếu được thiết kế để hiểu và phân loại văn bản. Mô hình này vượt trội ở các tác vụ như trả lời câu hỏi và tóm tắt văn bản.

● **Gemini (bộ công cụ AI của Google, trước đây là Bard)** -- Một AI đa phương thức tích hợp dữ liệu văn bản, hình ảnh và âm thanh nhằm nâng cao khả năng thích ứng của AI tạo sinh.

● **Llama (Large Language Model Meta AI của Meta)** -- Một lựa chọn mã nguồn mở, hiệu năng cao thay thế cho các mô hình độc quyền, được thiết kế để dễ tùy biến và mở rộng quy mô.

● **DeepSeek** - Một lựa chọn mã nguồn mở của Trung Quốc, có hiệu quả cao, thay thế cho các mô hình độc quyền, sử dụng cái gọi là "chú ý tiềm ẩn đa đầu (multi-head latent attention)" để giảm kích thước bộ nhớ đệm khóa-giá trị, cho phép các truy vấn tiêu tốn ít tài nguyên hơn nhiều.

Tất cả các mô hình này đều có chung cấu trúc dựa trên transformer, nhưng mục tiêu huấn luyện của chúng khác nhau. Các mô hình GPT tạo văn bản theo kiểu tự hồi quy (dự đoán từ tiếp theo dựa trên ngữ cảnh trước đó). Ngược lại, BERT được tối ưu hóa cho việc hiểu hai chiều, khiến nó phù hợp hơn với các tác vụ hiểu ngôn ngữ thay vì tạo sinh văn bản.
