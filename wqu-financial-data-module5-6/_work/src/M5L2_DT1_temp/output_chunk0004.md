3.1.5 BERT. BERT [3] về bản chất là một mô hình ngôn ngữ gồm nhiều bộ mã hóa Transformer xếp chồng lên nhau. Tuy nhiên, BERT định nghĩa tác vụ mô hình hóa ngôn ngữ khác với ELMo và AWD-LSTM: thay vì dự đoán từ kế tiếp dựa trên các từ trước đó, BERT "che" (mask) ngẫu nhiên 15% số token. Một lớp softmax trên toàn bộ từ vựng, đặt phía trên lớp mã hóa cuối cùng, được dùng để dự đoán các token bị che. Tác vụ huấn luyện thứ hai là "dự đoán câu kế tiếp": với hai câu cho trước, mô hình dự đoán hai câu đó có thật sự nối tiếp nhau hay không. Chuỗi đầu vào được biểu diễn bằng embedding của token và embedding vị trí. Hai token [CLS] và [SEP] được thêm lần lượt vào đầu và cuối chuỗi. Với mọi tác vụ phân loại, kể cả dự đoán câu kế tiếp, token [CLS] được sử dụng.

BERT có hai phiên bản: BERT-base (12 lớp mã hóa, kích thước ẩn 768, 12 đầu chú ý đa đầu, tổng cộng 110M tham số) và BERT-large (24 lớp mã hóa, kích thước ẩn 1024, 16 đầu chú ý đa đầu, 340M tham số). Cả hai được huấn luyện trên BookCorpus [33] và Wikipedia tiếng Anh, tổng cộng hơn 3.500M từ (chú thích 3).

3.1.2 ELMo. Embedding của ELMo [23] là biểu diễn từ có ngữ cảnh, theo nghĩa các từ xung quanh ảnh hưởng đến biểu diễn của từ đó. Lõi của ELMo là một mô hình ngôn ngữ hai chiều với nhiều lớp LSTM. Mục tiêu của mô hình ngôn ngữ là học phân phối xác suất trên các chuỗi token trong một từ vựng cho trước. ELMo mô hình hóa xác suất của một token dựa trên các token đứng trước (và riêng biệt, các token đứng sau) trong chuỗi. Sau đó mô hình còn học cách gán trọng số cho các biểu diễn từ các lớp LSTM khác nhau để tính ra một vector có ngữ cảnh cho mỗi token. Khi các biểu diễn có ngữ cảnh đã được trích xuất, chúng có thể dùng để khởi tạo bất kỳ tác vụ NLP hạ nguồn nào (chú thích 2).

3.1.3 ULMFit. ULMFit là mô hình học chuyển giao cho các tác vụ NLP hạ nguồn, tận dụng bước tiền huấn luyện mô hình ngôn ngữ [5]. Khác với ELMo, ở ULMFit toàn bộ mô hình ngôn ngữ được tinh chỉnh (fine-tune) cùng với các lớp riêng cho tác vụ. Mô hình ngôn ngữ nền tảng của ULMFit là AWD-LSTM, dùng các chiến lược điều chỉnh dropout phức tạp để chính quy hóa mô hình LSTM tốt hơn [21]. Để phân loại bằng ULMFit, hai lớp tuyến tính được thêm vào AWD-LSTM tiền huấn luyện, lớp đầu tiên nhận các trạng thái ẩn cuối cùng đã được gộp (pooled) làm đầu vào.

ULMFit đi kèm các chiến lược huấn luyện mới để tiếp tục tiền huấn luyện mô hình ngôn ngữ trên kho ngữ liệu theo lĩnh vực và tinh chỉnh trên tác vụ hạ nguồn. Các chiến lược này được áp dụng với FinBERT như trình bày ở mục 3.2.

Chú thích:
1. Trọng số tiền huấn luyện của GloVe có tại https://nlp.stanford.edu/projects/glove/
2. Các mô hình ELMo tiền huấn luyện có tại: https://allennlp.org/elmo
3. Trọng số tiền huấn luyện do các tác giả BERT công bố. Mã nguồn và trọng số có tại: https://github.com/google-research/bert

## 3.2 BERT cho lĩnh vực tài chính: FinBERT

Mục này mô tả cách triển khai BERT của nhóm tác giả: 1) cách tiền huấn luyện bổ sung trên kho ngữ liệu theo lĩnh vực; 2-3) cách triển khai BERT cho tác vụ phân loại và hồi quy; 4) các chiến lược huấn luyện dùng khi tinh chỉnh nhằm tránh quên thảm họa (catastrophic forgetting).

3.2.1 Tiền huấn luyện bổ sung. Howard và Ruder (2018) [5] cho thấy việc tiền huấn luyện thêm mô hình ngôn ngữ trên kho ngữ liệu của lĩnh vực đích giúp cải thiện hiệu quả phân loại cuối cùng. Với BERT, chưa có nghiên cứu mang tính quyết định cho thấy điều này cũng đúng. Dù vậy, nhóm tác giả vẫn thực hiện tiền huấn luyện bổ sung để xem liệu sự thích nghi này có lợi cho lĩnh vực tài chính hay không. Có hai cách tiếp cận: (1) tiền huấn luyện mô hình trên một kho ngữ liệu tương đối lớn của lĩnh vực đích, cụ thể là tiền huấn luyện thêm mô hình ngôn ngữ BERT trên một kho ngữ liệu tài chính (chi tiết ở mục 4.2.1); (2) chỉ tiền huấn luyện trên các câu của tập huấn luyện dùng cho phân loại. Kho ngữ liệu thứ hai nhỏ hơn nhiều, nhưng dữ liệu lấy trực tiếp từ đích có thể giúp thích nghi lĩnh vực tốt hơn.

3.2.2 FinBERT cho phân loại văn bản. Phân loại cảm xúc được thực hiện bằng cách thêm một lớp dày đặc (dense) sau trạng thái ẩn cuối cùng của token [CLS]. Đây là cách làm được khuyến nghị khi dùng BERT cho mọi tác vụ phân loại [3]. Sau đó, mạng bộ phân loại được huấn luyện trên tập dữ liệu cảm xúc đã gán nhãn. Tổng quan các bước của quy trình được trình bày ở hình 1.

Bảng 1: Phân bố nhãn cảm xúc và mức độ đồng thuận trong Financial PhraseBank

| Mức đồng thuận | Tích cực | Tiêu cực | Trung lập | Số lượng |
|---|---|---|---|---|
| 100% | 25,2% | 13,4% | 61,4% | 2262 |
| 75% - 99% | 26,6% | 9,8% | 63,6% | 1191 |
| 66% - 74% | 36,7% | 12,3% | 50,9% | 765 |
| 50% - 65% | 31,1% | 14,4% | 54,5% | 627 |
| Tất cả | 28,1% | 12,4% | 59,4% | 4845 |

Các câu hỏi nghiên cứu:
- (RQ2) FinBERT so với các phương pháp tốt nhất hiện nay trong phân tích cảm xúc tài chính như thế nào, với nhãn rời rạc hoặc liên tục?
- (RQ3) Việc tiền huấn luyện bổ sung BERT trên lĩnh vực tài chính, hoặc trên kho ngữ liệu đích, ảnh hưởng thế nào đến hiệu quả phân loại?
- (RQ4) Các chiến lược huấn luyện như tốc độ học tam giác nghiêng (slanted triangular), tinh chỉnh phân biệt theo lớp (discriminative fine-tuning) và rã đông dần (gradual unfreezing) ảnh hưởng thế nào đến hiệu quả phân loại? Chúng có ngăn được quên thảm họa không?
- (RQ5) Lớp mã hóa nào cho kết quả phân loại câu tốt nhất (hoặc kém nhất)?
- (RQ6) Cần tinh chỉnh bao nhiêu là đủ? Tức là sau tiền huấn luyện, cần tinh chỉnh bao nhiêu lớp để đạt hiệu quả tương đương với tinh chỉnh toàn bộ mô hình?
