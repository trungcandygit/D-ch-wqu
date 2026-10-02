3.2.3 FinBERT cho hồi quy. Dù trọng tâm của bài báo là phân loại, chúng tôi cũng triển khai hồi quy (regression) với kiến trúc gần như giống hệt trên một bộ dữ liệu khác có mục tiêu liên tục. Khác biệt duy nhất là hàm mất mát được dùng là sai số bình phương trung bình thay cho hàm mất mát entropy chéo.

3.2.4 Các chiến lược huấn luyện nhằm ngăn quên thảm khốc. Như Howard và Ruder (2018) [5] đã chỉ ra, quên thảm khốc (catastrophic forgetting) là mối nguy đáng kể của cách tinh chỉnh này, vì quá trình tinh chỉnh có thể nhanh chóng khiến mô hình "quên" thông tin từ tác vụ mô hình hóa ngôn ngữ khi nó thích nghi với tác vụ mới. Để xử lý, chúng tôi áp dụng ba kỹ thuật theo đề xuất của Howard và Ruder (2018): tốc độ học tam giác nghiêng (slanted triangular learning rates), tinh chỉnh phân biệt theo tầng (discriminative fine-tuning) và rã đông dần (gradual unfreezing).

Tốc độ học tam giác nghiêng áp dụng lịch tốc độ học có dạng tam giác nghiêng: tốc độ học tăng tuyến tính đến một điểm nào đó, rồi giảm tuyến tính sau điểm đó.

Tinh chỉnh phân biệt theo tầng là dùng tốc độ học thấp hơn cho các tầng thấp hơn của mạng. Giả sử tốc độ học ở tầng l là α; với hệ số phân biệt θ, tốc độ học của tầng l − 1 được tính là α_{l−1} = θα_l. Giả định đằng sau phương pháp là các tầng thấp biểu diễn thông tin ngôn ngữ ở mức sâu, còn các tầng trên chứa thông tin cho tác vụ phân loại thực sự, nên cần tinh chỉnh chúng khác nhau.

Với rã đông dần, ta bắt đầu huấn luyện khi mọi tầng trừ tầng bộ phân loại đều bị đóng băng. Trong quá trình huấn luyện, ta dần rã đông tất cả các tầng, bắt đầu từ tầng cao nhất, sao cho các đặc trưng mức thấp được tinh chỉnh ít nhất. Nhờ đó, ở các giai đoạn đầu, mô hình không "quên" thông tin ngôn ngữ mức thấp đã học được từ tiền huấn luyện.

4.2 Bộ dữ liệu

4.2.1 TRC2-financial. Để tiền huấn luyện thêm BERT, chúng tôi dùng một kho ngữ liệu tài chính gọi là TRC2-financial. Đây là tập con của TRC2 của Reuters^4, gồm 1,8 triệu bài báo do Reuters đăng từ 2008 đến 2010. Chúng tôi lọc theo một số từ khóa tài chính để kho ngữ liệu sát chủ đề hơn và phù hợp với sức mạnh tính toán sẵn có. Kho TRC2-financial thu được gồm 46.143 tài liệu với hơn 29 triệu từ và gần 400 nghìn câu.

4.2.2 Financial PhraseBank. Bộ dữ liệu phân tích cảm xúc chính của bài báo là Financial PhraseBank^5 của Malo và cộng sự (2014) [17]. Bộ này gồm 4.845 câu tiếng Anh chọn ngẫu nhiên từ tin tức tài chính trên cơ sở dữ liệu LexisNexis, được 16 người có nền tảng tài chính và kinh doanh gán nhãn. Người gán nhãn được yêu cầu gán nhãn theo việc họ cho rằng thông tin trong câu có thể ảnh hưởng thế nào đến giá cổ phiếu của công ty được nhắc đến. Bộ dữ liệu cũng có thông tin về mức độ đồng thuận giữa những người gán nhãn đối với từng câu. Phân bố mức đồng thuận và nhãn cảm xúc được trình bày ở bảng 1. Chúng tôi tách 20% tổng số câu làm tập kiểm tra và 20% phần còn lại làm tập xác thực; cuối cùng, tập huấn luyện gồm 3.101 mẫu. Với một số thí nghiệm, chúng tôi còn dùng kiểm định chéo 10 lớp (10-fold cross validation).

4 THIẾT LẬP THÍ NGHIỆM

4.1 Các câu hỏi nghiên cứu

Chúng tôi nhằm trả lời các câu hỏi nghiên cứu sau:

(RQ1) Hiệu năng của FinBERT trong phân loại câu ngắn là bao nhiêu so với các phương pháp học chuyển giao khác như ELMo và ULMFit?

^4 Kho ngữ liệu có thể được cấp cho mục đích nghiên cứu khi đăng ký tại: https://trec.nist.gov/data/reuters/reuters.html

^5 Bộ dữ liệu có tại: https://www.researchgate.net/publication/251231364_FinancialPhraseBank-v10

Hình 1: Tổng quan về tiền huấn luyện, tiền huấn luyện bổ sung và tinh chỉnh phân loại. (Ba giai đoạn: mô hình ngôn ngữ trên kho ngữ liệu tổng quát BookCorpus + Wikipedia; mô hình ngôn ngữ trên kho ngữ liệu tài chính Reuters TRC2-financial; mô hình phân loại trên bộ dữ liệu cảm xúc tài chính Financial PhraseBank.)

4.2.3 FiQA Sentiment. FiQA [15] là bộ dữ liệu được tạo cho thử thách khai phá ý kiến tài chính và hỏi đáp tại hội nghị WWW '18^6. Chúng tôi dùng dữ liệu của Tác vụ 1, gồm 1.174 tiêu đề tin tức tài chính và tweet cùng điểm cảm xúc tương ứng. Khác với Financial PhraseBank, mục tiêu của bộ dữ liệu này là liên tục trong khoảng [−1, 1], với 1 là tích cực nhất. Mỗi mẫu cũng có thông tin về thực thể tài chính nào được nhắm đến trong câu. Chúng tôi dùng kiểm định chéo 10 lớp để đánh giá mô hình trên bộ dữ liệu này.

4.3 (tiêu đề mục không còn trong bản trích)

... bằng cách thêm một tầng kết nối đầy đủ vào đầu ra của mô hình ngôn ngữ tiền huấn luyện, trên bộ dữ liệu PhraseBank.

4.4 Các độ đo đánh giá

Để đánh giá các mô hình phân loại, chúng tôi dùng ba độ đo: độ chính xác (Accuracy), hàm mất mát entropy chéo và trung bình macro F1. Hàm mất mát entropy chéo được đánh trọng số bằng căn bậc hai của nghịch đảo tần suất; ví dụ, nếu một nhãn chiếm 25% tổng số mẫu, ta nhân trọng số 2 cho phần mất mát của nhãn đó. Trung bình macro F1 tính điểm F1 cho từng lớp rồi lấy trung bình. Vì dữ liệu Financial PhraseBank mất cân bằng nhãn (gần 60% số câu là trung lập), độ đo này cho thêm một thước đo tốt về chất lượng phân loại. Để đánh giá mô hình hồi quy, chúng tôi báo cáo sai số bình phương trung bình và R², vì cả hai đều là chuẩn và cũng được các bài báo hiện đại nhất về bộ dữ liệu FiQA báo cáo.
