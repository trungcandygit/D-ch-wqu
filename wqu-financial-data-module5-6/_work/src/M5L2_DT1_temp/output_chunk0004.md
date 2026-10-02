3.1.5 BERT. BERT [3] về bản chất là một mô hình ngôn ngữ gồm nhiều bộ mã hóa Transformer (Transformer encoders) xếp chồng lên nhau. Tuy nhiên, BERT định nghĩa tác vụ mô hình hóa ngôn ngữ khác với ELMo và AWD-LSTM: thay vì dự đoán từ kế tiếp dựa trên các từ trước đó, BERT "che" (mask) ngẫu nhiên 15% số token. Một lớp softmax trên toàn bộ từ vựng đặt ở đỉnh lớp mã hóa cuối cùng sẽ dự đoán các token bị che. Tác vụ huấn luyện thứ hai là "dự đoán câu kế tiếp": với hai câu cho trước, mô hình dự đoán hai câu đó có thực sự nối tiếp nhau hay không. Chuỗi đầu vào được biểu diễn bằng embedding của token và embedding vị trí; hai token đặc biệt [CLS] và [SEP] lần lượt được thêm vào đầu và cuối chuỗi. Với mọi tác vụ phân loại, kể cả dự đoán câu kế tiếp, token [CLS] được sử dụng.

BERT có hai phiên bản: BERT-base (12 lớp mã hóa, kích thước ẩn 768, 12 đầu chú ý đa đầu, tổng cộng 110M tham số) và BERT-large (24 lớp mã hóa, kích thước ẩn 1024, 16 đầu chú ý đa đầu, 340M tham số). Cả hai được huấn luyện trên BookCorpus [33] và Wikipedia tiếng Anh, tổng cộng hơn 3.500M từ ³.

3.1.2 ELMo. Embedding ELMo [23] là biểu diễn từ theo ngữ cảnh, theo nghĩa các từ xung quanh ảnh hưởng đến biểu diễn của từ. Cốt lõi của ELMo là một mô hình ngôn ngữ hai chiều với nhiều lớp LSTM. Mục tiêu của mô hình ngôn ngữ là học phân phối xác suất trên các chuỗi token thuộc một từ vựng cho trước. ELMo mô hình hóa xác suất của một token dựa trên các token đứng trước (và riêng biệt, các token đứng sau) trong chuỗi. Sau đó mô hình còn học cách gán trọng số cho các biểu diễn từ những lớp LSTM khác nhau để tính ra một vector theo ngữ cảnh cho mỗi token. Khi đã trích xuất được các biểu diễn theo ngữ cảnh, chúng có thể dùng để khởi tạo bất kỳ tác vụ NLP hạ nguồn nào ².

3.1.3 ULMFit. ULMFit là mô hình học chuyển giao cho các tác vụ NLP hạ nguồn, tận dụng tiền huấn luyện mô hình ngôn ngữ [5]. Khác với ELMo, ULMFit tinh chỉnh (fine-tune) toàn bộ mô hình ngôn ngữ cùng với các lớp riêng cho tác vụ. Mô hình ngôn ngữ nền tảng của ULMFit là AWD-LSTM, dùng các chiến lược điều chỉnh dropout tinh vi để chính quy hóa LSTM tốt hơn [21]. Với phân loại bằng ULMFit, hai lớp tuyến tính được thêm vào AWD-LSTM đã tiền huấn luyện; lớp đầu tiên nhận trạng thái ẩn cuối cùng đã được gộp (pooled) làm đầu vào.

ULMFit đi kèm các chiến lược huấn luyện mới để tiếp tục tiền huấn luyện mô hình ngôn ngữ trên kho ngữ liệu theo miền và tinh chỉnh trên tác vụ hạ nguồn. Các chiến lược này được triển khai cùng FinBERT như giải thích ở mục 3.2.

¹ Trọng số tiền huấn luyện của GloVe có tại https://nlp.stanford.edu/projects/glove/

² Các mô hình ELMo tiền huấn luyện có tại: https://allennlp.org/elmo

3.2 BERT cho miền tài chính: FinBERT

Mục này mô tả cách triển khai BERT của nhóm tác giả: 1) cách tiền huấn luyện tiếp trên kho ngữ liệu theo miền, 2-3) cách triển khai BERT cho tác vụ phân loại và hồi quy, 4) các chiến lược huấn luyện dùng khi tinh chỉnh để tránh quên thảm họa (catastrophic forgetting).

3.2.1 Tiền huấn luyện tiếp. Howard và Ruder (2018) [5] cho thấy việc tiền huấn luyện tiếp một mô hình ngôn ngữ trên kho ngữ liệu miền đích giúp cải thiện hiệu quả phân loại cuối cùng. Với BERT, chưa có nghiên cứu mang tính quyết định cho thấy điều tương tự cũng đúng.

³ Trọng số tiền huấn luyện do các tác giả BERT công bố. Mã nguồn và trọng số có tại: https://github.com/google-research/bert

Bảng 1: Phân bố nhãn cảm xúc và mức độ đồng thuận trong Financial PhraseBank

| Mức đồng thuận | Tích cực | Tiêu cực | Trung lập | Số lượng |
|---|---|---|---|---|
| 100% | %25.2 | %13.4 | %61.4 | 2262 |
| 75% - 99% | %26.6 | %9.8 | %63.6 | 1191 |
| 66% - 74% | %36.7 | %12.3 | %50.9 | 765 |
| 50% - 65% | %31.1 | %14.4 | %54.5 | 627 |
| Tất cả | %28.1 | %12.4 | %59.4 | 4845 |

Dù vậy, nhóm tác giả vẫn triển khai tiền huấn luyện tiếp để xem sự thích nghi này có lợi cho miền tài chính hay không. Có hai cách tiếp cận. Cách thứ nhất là tiền huấn luyện mô hình trên một kho ngữ liệu tương đối lớn thuộc miền đích: tiền huấn luyện tiếp mô hình ngôn ngữ BERT trên kho ngữ liệu tài chính (chi tiết ở mục 4.2.1). Cách thứ hai là chỉ tiền huấn luyện trên các câu của tập dữ liệu phân loại huấn luyện. Dù kho ngữ liệu thứ hai nhỏ hơn nhiều, dữ liệu lấy trực tiếp từ đích có thể giúp thích nghi miền đích tốt hơn.

3.2.2 FinBERT cho phân loại văn bản. Phân loại cảm xúc được thực hiện bằng cách thêm một lớp dense sau trạng thái ẩn cuối cùng của token [CLS]. Đây là thực hành được khuyến nghị khi dùng BERT cho mọi tác vụ phân loại [3]. Sau đó, mạng bộ phân loại được huấn luyện trên tập dữ liệu cảm xúc có nhãn. Tổng quan các bước của quy trình được trình bày ở hình 1.

Các câu hỏi nghiên cứu:

- (RQ2) FinBERT so với các phương pháp tiên tiến nhất trong phân tích cảm xúc tài chính ra sao, với mục tiêu rời rạc hoặc liên tục?
- (RQ3) Tiền huấn luyện tiếp BERT trên miền tài chính, hoặc trên kho ngữ liệu đích, ảnh hưởng thế nào đến hiệu quả phân loại?
- (RQ4) Các chiến lược huấn luyện như tốc độ học tam giác nghiêng (slanted triangular learning rates), tinh chỉnh phân biệt (discriminative fine-tuning) và rã đông dần (gradual unfreezing) ảnh hưởng ra sao đến hiệu quả phân loại? Chúng có ngăn được quên thảm họa không?
- (RQ5) Lớp mã hóa nào cho kết quả tốt nhất (hoặc kém nhất) khi phân loại câu?
- (RQ6) Cần tinh chỉnh bao nhiêu là đủ? Tức là, sau tiền huấn luyện, cần tinh chỉnh bao nhiêu lớp để đạt hiệu quả tương đương với tinh chỉnh toàn bộ mô hình?
