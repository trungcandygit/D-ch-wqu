3.2.3 FinBERT cho hồi quy. Dù trọng tâm của bài báo là phân loại, nhóm tác giả cũng triển khai hồi quy với kiến trúc gần như giống hệt trên một bộ dữ liệu khác có mục tiêu liên tục. Khác biệt duy nhất là hàm mất mát được dùng là sai số bình phương trung bình thay cho hàm mất mát entropy chéo.

3.2.4 Chiến lược huấn luyện để tránh quên thảm khốc (catastrophic forgetting). Như Howard và Ruder (2018) [5] đã chỉ ra, quên thảm khốc là nguy cơ đáng kể của cách tinh chỉnh này, vì quá trình tinh chỉnh có thể nhanh chóng khiến mô hình "quên" thông tin từ tác vụ mô hình hóa ngôn ngữ khi cố thích nghi với tác vụ mới. Để xử lý hiện tượng này, nhóm áp dụng ba kỹ thuật do Howard và Ruder (2018) đề xuất: tốc độ học tam giác xiên (slanted triangular learning rates), tinh chỉnh phân biệt (discriminative fine-tuning) và rã đông dần (gradual unfreezing).

- Tốc độ học tam giác xiên: áp dụng lịch tốc độ học có dạng tam giác xiên, tức là tốc độ học tăng tuyến tính đến một điểm nào đó rồi giảm tuyến tính sau điểm đó.
- Tinh chỉnh phân biệt: dùng tốc độ học thấp hơn cho các lớp thấp hơn của mạng. Giả sử tốc độ học ở lớp l là α; với hệ số phân biệt θ, tốc độ học của lớp l − 1 được tính là αl −1 = θαl. Giả định đằng sau phương pháp là các lớp thấp biểu diễn thông tin ngôn ngữ ở mức sâu, còn các lớp trên chứa thông tin cho tác vụ phân loại thực tế, nên cần tinh chỉnh chúng khác nhau.
- Rã đông dần: bắt đầu huấn luyện với mọi lớp bị đóng băng trừ lớp bộ phân loại. Trong quá trình huấn luyện, các lớp được rã đông dần, bắt đầu từ lớp cao nhất, sao cho các đặc trưng mức thấp được tinh chỉnh ít nhất. Nhờ vậy, ở các giai đoạn đầu, mô hình không "quên" thông tin ngôn ngữ mức thấp đã học từ tiền huấn luyện.

4.2

Bộ dữ liệu

4.2.1 TRC2-financial. Để tiền huấn luyện thêm cho BERT, nhóm dùng một kho ngữ liệu tài chính gọi là TRC2-financial. Đây là tập con của TRC2 của Reuters (chú thích 4), gồm 1,8 triệu bài báo do Reuters đăng từ 2008 đến 2010. Nhóm lọc theo một số từ khóa tài chính để kho ngữ liệu sát chủ đề hơn và phù hợp với năng lực tính toán sẵn có. Kết quả, TRC2-financial gồm 46.143 tài liệu với hơn 29 triệu từ và gần 400 nghìn câu.

4.2.2 Financial PhraseBank. Bộ dữ liệu phân tích cảm xúc chính của bài báo là Financial PhraseBank (chú thích 5) của Malo và cs. 2014 [17]. Bộ này gồm 4845 câu tiếng Anh được chọn ngẫu nhiên từ tin tức tài chính trên cơ sở dữ liệu LexisNexis, sau đó được 16 người có nền tảng tài chính và kinh doanh gán nhãn. Người gán nhãn được yêu cầu đánh nhãn theo việc họ cho rằng thông tin trong câu có thể ảnh hưởng thế nào đến giá cổ phiếu của công ty được nhắc đến. Bộ dữ liệu cũng có thông tin về mức độ đồng thuận giữa những người gán nhãn đối với từng câu; phân bố các mức đồng thuận và nhãn cảm xúc xem ở bảng 1. Nhóm để riêng 20% tổng số câu làm tập kiểm tra và 20% phần còn lại làm tập xác thực; cuối cùng tập huấn luyện gồm 3101 mẫu. Với một số thí nghiệm, nhóm còn dùng kiểm định chéo 10 lần (10-fold cross validation).

Chú thích:
4. Kho ngữ liệu có thể xin dùng cho mục đích nghiên cứu tại: https://trec.nist.gov/data/reuters/reuters.html
5. Bộ dữ liệu có tại: https://www.researchgate.net/publication/251231364_FinancialPhraseBank-v10

4 THIẾT LẬP THÍ NGHIỆM

4.1 Câu hỏi nghiên cứu

Nhóm tìm cách trả lời các câu hỏi nghiên cứu sau:

(RQ1) Hiệu năng của FinBERT trong phân loại câu ngắn là bao nhiêu so với các phương pháp học chuyển giao khác như ELMo và ULMFit?

Hình 1: Tổng quan về tiền huấn luyện, tiền huấn luyện thêm và tinh chỉnh phân loại. Ba giai đoạn gồm: mô hình ngôn ngữ trên kho ngữ liệu tổng quát (BookCorpus + Wikipedia); mô hình ngôn ngữ trên kho ngữ liệu tài chính (Reuters TRC2-financial); mô hình phân loại trên bộ dữ liệu cảm xúc tài chính (Financial PhraseBank). Mỗi giai đoạn dùng cùng kiến trúc gồm lớp Embeddings, 12 bộ mã hóa (Encoder 1 đến Encoder 12) trên các token [CLS], Token 1, Token 2, ..., [MASK]/Token k, [SEP]; hai giai đoạn đầu có đầu dự đoán câu kế tiếp ([is next sentence]) và dự đoán Masked LM, còn giai đoạn cuối có đầu dự đoán cảm xúc (Sentiment prediction).

4.2.3 FiQA Sentiment. FiQA [15] là bộ dữ liệu được tạo cho thử thách khai phá ý kiến và hỏi đáp tài chính của hội nghị WWW '18 (chú thích 6). Nhóm dùng dữ liệu của Tác vụ 1, gồm 1.174 tiêu đề tin tài chính và tweet kèm điểm cảm xúc tương ứng. Khác với Financial PhraseBank, mục tiêu của bộ dữ liệu này là liên tục trong khoảng [−1, 1], với 1 là tích cực nhất. Mỗi mẫu cũng có thông tin về thực thể tài chính được nhắm tới trong câu. Nhóm dùng kiểm định chéo 10 lần để đánh giá mô hình trên bộ dữ liệu này.

4.3

Mô hình phân loại được xây trên bộ PhraseBank bằng cách thêm một lớp kết nối đầy đủ vào đầu ra của mô hình ngôn ngữ tiền huấn luyện.

4.4 Các chỉ số đánh giá

Với các mô hình phân loại, nhóm dùng ba chỉ số: độ chính xác (Accuracy), hàm mất mát entropy chéo và trung bình macro F1. Hàm mất mát entropy chéo được đánh trọng số bằng căn bậc hai của nghịch đảo tần suất; ví dụ, nếu một nhãn chiếm 25% tổng số mẫu thì mất mát của nhãn đó được nhân trọng số 2. Trung bình macro F1 tính điểm F1 cho từng lớp rồi lấy trung bình. Vì dữ liệu Financial PhraseBank bị mất cân bằng nhãn (gần 60% số câu là trung tính), chỉ số này là thước đo bổ sung tốt cho chất lượng phân loại. Với mô hình hồi quy, nhóm báo cáo sai số bình phương trung bình và R², vì cả hai đều là chuẩn và cũng được các bài báo tiên tiến nhất trên bộ dữ liệu FiQA báo cáo.
