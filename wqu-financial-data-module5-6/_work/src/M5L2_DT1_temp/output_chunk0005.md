3.2.3 FinBERT cho hồi quy. Mặc dù trọng tâm của bài báo là phân loại, nhóm tác giả cũng triển khai bài toán hồi quy với kiến trúc gần như giống hệt trên một bộ dữ liệu khác có mục tiêu liên tục. Khác biệt duy nhất là hàm mất mát được dùng là sai số bình phương trung bình thay cho hàm mất mát entropy chéo.

3.2.4 Các chiến lược huấn luyện để tránh quên thảm khốc (catastrophic forgetting). Như Howard và Ruder (2018) [5] đã chỉ ra, quên thảm khốc là một nguy cơ đáng kể của cách tinh chỉnh này, vì quá trình tinh chỉnh có thể nhanh chóng khiến mô hình "quên" thông tin từ tác vụ mô hình hóa ngôn ngữ khi nó thích nghi với tác vụ mới. Để xử lý hiện tượng này, nhóm tác giả áp dụng ba kỹ thuật do Howard và Ruder (2018) đề xuất: tốc độ học tam giác nghiêng (slanted triangular learning rates), tinh chỉnh phân biệt theo tầng (discriminative fine-tuning) và rã đông dần (gradual unfreezing).

Tốc độ học tam giác nghiêng áp dụng một lịch trình tốc độ học có hình tam giác nghiêng: tốc độ học tăng tuyến tính đến một điểm nào đó rồi giảm tuyến tính sau điểm đó.

Tinh chỉnh phân biệt theo tầng là dùng tốc độ học thấp hơn cho các tầng thấp hơn của mạng. Giả sử tốc độ học ở tầng $l$ là $\alpha$; với hệ số phân biệt $\theta$, tốc độ học của tầng $l-1$ được tính là $\alpha_{l-1} = \theta\alpha_l$. Giả định đằng sau phương pháp này là các tầng thấp biểu diễn thông tin ngôn ngữ ở mức sâu, còn các tầng trên chứa thông tin cho tác vụ phân loại thực tế, nên cần tinh chỉnh chúng khác nhau.

Với rã đông dần, quá trình huấn luyện bắt đầu khi mọi tầng trừ tầng bộ phân loại đều bị đóng băng. Trong lúc huấn luyện, các tầng lần lượt được rã đông, bắt đầu từ tầng cao nhất, sao cho các đặc trưng mức thấp được tinh chỉnh ít nhất. Nhờ vậy, ở các giai đoạn đầu, mô hình không "quên" thông tin ngôn ngữ mức thấp đã học được từ quá trình tiền huấn luyện.

## 4 THIẾT LẬP THỰC NGHIỆM

### 4.1 Câu hỏi nghiên cứu

Nhóm tác giả nhằm trả lời các câu hỏi nghiên cứu sau:

(RQ1) Hiệu năng của FinBERT trong phân loại câu ngắn là bao nhiêu so với các phương pháp học chuyển giao khác như ELMo và ULMFit?

[Hình 1: Tổng quan về tiền huấn luyện, tiền huấn luyện bổ sung và tinh chỉnh phân loại. Mô hình ngôn ngữ trên kho ngữ liệu tổng quát (BookCorpus + Wikipedia) được tiền huấn luyện bổ sung trên kho ngữ liệu tài chính (Reuters TRC2-financial), sau đó mô hình phân loại được tinh chỉnh trên bộ dữ liệu cảm xúc tài chính (Financial PhraseBank), gồm 12 tầng bộ mã hóa (encoder), lớp embedding và các lớp Dense.]

### 4.2 Bộ dữ liệu

4.2.1 TRC2-financial. Để tiền huấn luyện bổ sung cho BERT, nhóm tác giả dùng một kho ngữ liệu tài chính gọi là TRC2-financial. Đây là tập con của TRC2^4 của Reuters, gồm 1,8 triệu bài báo do Reuters đăng từ năm 2008 đến 2010. Nhóm lọc theo một số từ khóa tài chính để kho ngữ liệu sát chủ đề hơn và phù hợp với khả năng tính toán sẵn có. Kho ngữ liệu TRC2-financial thu được gồm 46.143 tài liệu, hơn 29 triệu từ và gần 400 nghìn câu.

4.2.2 Financial PhraseBank. Bộ dữ liệu phân tích cảm xúc chính trong bài báo là Financial PhraseBank^5 của Malo và cộng sự (2014) [17]. Bộ dữ liệu gồm 4.845 câu tiếng Anh được chọn ngẫu nhiên từ tin tức tài chính trong cơ sở dữ liệu LexisNexis. Các câu này được 16 người có nền tảng tài chính và kinh doanh gán nhãn, theo đánh giá của họ về việc thông tin trong câu có thể ảnh hưởng thế nào đến giá cổ phiếu của công ty được nhắc đến. Bộ dữ liệu cũng có thông tin về mức độ đồng thuận giữa các người gán nhãn đối với từng câu. Phân bố mức đồng thuận và nhãn cảm xúc được trình bày ở bảng 1. Nhóm để riêng 20% tổng số câu làm tập kiểm tra và 20% phần còn lại làm tập xác thực; cuối cùng tập huấn luyện gồm 3.101 mẫu. Với một số thí nghiệm, nhóm còn dùng kiểm định chéo 10 lần (10-fold cross validation).

4.2.3 FiQA Sentiment. FiQA [15] là bộ dữ liệu được tạo cho thử thách khai phá ý kiến và hỏi đáp tài chính của hội nghị WWW '18^6. Nhóm dùng dữ liệu của Tác vụ 1, gồm 1.174 tiêu đề tin tức tài chính và tweet cùng điểm cảm xúc tương ứng. Khác với Financial PhraseBank, mục tiêu của bộ dữ liệu này là liên tục, nằm trong khoảng $[-1, 1]$, trong đó 1 là tích cực nhất. Mỗi mẫu còn có thông tin về thực thể tài chính được nhắm đến trong câu. Nhóm đánh giá mô hình trên bộ dữ liệu này bằng kiểm định chéo 10 lần.

### 4.3 Mô hình cơ sở cho hồi quy

Mô hình hồi quy được xây dựng giống như mô hình phân loại trên bộ dữ liệu PhraseBank, bằng cách thêm một tầng kết nối đầy đủ vào đầu ra của mô hình ngôn ngữ tiền huấn luyện.

### 4.4 Các chỉ số đánh giá

Để đánh giá các mô hình phân loại, nhóm dùng ba chỉ số: độ chính xác (Accuracy), hàm mất mát entropy chéo và trung bình F1 vĩ mô (macro F1). Hàm mất mát entropy chéo được đánh trọng số bằng căn bậc hai của nghịch đảo tần suất. Ví dụ, nếu một nhãn chiếm 25% tổng số mẫu thì mất mát của nhãn đó được nhân trọng số 2. Trung bình F1 vĩ mô tính điểm F1 cho từng lớp rồi lấy trung bình. Do dữ liệu Financial PhraseBank bị mất cân bằng nhãn (gần 60% số câu là trung tính), chỉ số này là thước đo tốt bổ sung cho hiệu năng phân loại. Để đánh giá mô hình hồi quy, nhóm báo cáo sai số bình phương trung bình và $R^2$, vì đây là các chỉ số chuẩn và cũng được các bài báo hiện đại nhất trên bộ dữ liệu FiQA báo cáo.

---

^4 Kho ngữ liệu có thể xin cho mục đích nghiên cứu tại: https://trec.nist.gov/data/reuters/reuters.html

^5 Bộ dữ liệu có tại: https://www.researchgate.net/publication/251231364_FinancialPhraseBank-v10

^6 Thử thách FiQA của WWW '18.
