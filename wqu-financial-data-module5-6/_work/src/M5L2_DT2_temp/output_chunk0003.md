| Kho ngữ liệu | Số token |
|---|---|
| Báo cáo doanh nghiệp 10-K & 10-Q | 2,5 tỷ |
| Bản ghi cuộc họp công bố kết quả kinh doanh (Earnings Call Transcripts) | 1,3 tỷ |
| Báo cáo của nhà phân tích | 1,1 tỷ |

Bảng 1: Quy mô các kho ngữ liệu tài chính dùng để tiền huấn luyện.

## 4 Huấn luyện FinBERT

**Từ vựng.** Nhóm tác giả xây dựng FinVocab, một bộ từ vựng WordPiece mới trên kho ngữ liệu tài chính bằng thư viện SentencePiece. Có cả phiên bản phân biệt hoa thường (cased) và không phân biệt (uncased), với kích thước lần lượt là 28.573 và 30.873 token, rất gần với 28.996 và 30.522 token của BaseVocab gốc của BERT (cased và uncased). Mức trùng lặp giữa BaseVocab của BERT và FinVocab là 41% ở cả hai phiên bản.

**Các biến thể FinBERT.** Nhóm dùng mã BERT gốc (Google Research) để huấn luyện FinBERT trên kho ngữ liệu tài chính với cấu hình giống BERT-Base. Theo cách huấn luyện BERT gốc, độ dài câu tối đa ban đầu là 128 token và mô hình được huấn luyện đến khi hàm mất mát huấn luyện bắt đầu hội tụ; sau đó tiếp tục huấn luyện với độ dài câu tới 512 token. Tổng cộng có bốn phiên bản FinBERT: cased hoặc uncased; BaseVocab hoặc FinVocab.

- FinBERT-BaseVocab (uncased/cased): khởi tạo từ mô hình BERT-Base uncased/cased gốc, rồi tiền huấn luyện tiếp trên kho ngữ liệu tài chính 250 nghìn vòng lặp với tốc độ học nhỏ hơn là 2e−5, đúng như khuyến nghị của mã BERT.
- FinBERT-FinVocab (uncased/cased): huấn luyện từ đầu với bộ từ vựng tài chính mới FinVocab (uncased/cased) trong 1 triệu vòng lặp.

**Huấn luyện.** Toàn bộ quá trình chạy trên máy NVIDIA DGX-1 gồm 4 GPU Tesla P100, tổng bộ nhớ GPU 128 GB, cho phép huấn luyện BERT với kích thước batch 128. Nhóm dùng khung Horovod (Sergeev và Del Balso, 2018) để huấn luyện đa GPU. Tiền huấn luyện một mô hình mất khoảng 2 ngày. Việc công bố FinBERT giúp các chuyên gia và nhà nghiên cứu tài chính tận dụng mô hình mà không cần nguồn lực tính toán lớn để huấn luyện.

## 5 Thực nghiệm phân tích cảm xúc tài chính

Do phân tích cảm xúc có vai trò quan trọng trong các tác vụ NLP tài chính, nhóm thực hiện thực nghiệm trên các bộ dữ liệu phân loại cảm xúc tài chính.

### 5.1 Bộ dữ liệu

- **Financial Phrase Bank**: bộ dữ liệu công khai về phân loại cảm xúc tài chính (Malo và cs., 2014), gồm 4.840 câu chọn từ tin tức tài chính, do 16 nhà nghiên cứu có nền tảng kiến thức về thị trường tài chính gán nhãn thủ công. Nhãn cảm xúc là tích cực, trung lập hoặc tiêu cực.
- **AnalystTone**: bộ dữ liệu đo lường quan điểm trong báo cáo phân tích, thường dùng trong các nghiên cứu kế toán và tài chính (Huang và cs., 2014). Gồm 10.000 câu chọn ngẫu nhiên từ báo cáo phân tích trong cơ sở dữ liệu Investext, được gán nhãn thủ công thành ba loại: tích cực, tiêu cực, trung lập, với tổng cộng 3.580 câu tích cực, 1.830 câu tiêu cực và 4.590 câu trung lập.
- **FiQA**: bộ dữ liệu thử thách mở về phân tích cảm xúc tài chính, gồm 1.111 câu. Với một câu tiếng Anh thuộc lĩnh vực tài chính (tin nhắn microblog, nhận định tin tức), nhiệm vụ là dự đoán điểm cảm xúc dạng số trong khoảng từ −1 đến 1. Nhóm chuyển bài toán hồi quy gốc thành phân loại nhị phân để so sánh nhất quán với hai bộ dữ liệu trên.

Mỗi bộ dữ liệu được chia ngẫu nhiên 90% huấn luyện và 10% kiểm tra, lặp 10 lần và lấy trung bình. Vì cả ba bộ đều dùng cho phân loại cảm xúc, thước đo báo cáo là độ chính xác.

### 5.2 Chiến lược tinh chỉnh (fine-tune)

Nhóm theo cùng kiến trúc tinh chỉnh và lựa chọn tối ưu hóa của Devlin và cs. (2019): dùng một lớp tuyến tính đơn giản làm lớp phân loại với hàm kích hoạt softmax, và dùng mất mát cross-entropy làm hàm mất mát. Một phương án khác là đưa các nhúng từ theo ngữ cảnh (contextualized word embeddings) của từng token vào kiến trúc học sâu như Bi-LSTM đặt trên embedding BERT đã đóng băng; nhóm không chọn cách này vì đã được chỉ ra là kém hơn đáng kể so với tinh chỉnh BERT (Beltagy và cs., 2019).

### 5.3 Kết quả thực nghiệm

Nhóm so sánh FinBERT với BERT-Base gốc (Devlin và cs., 2019), đánh giá cả phiên bản cased và uncased. Kết quả chính được nêu ở Bảng 2.

**FinBERT so với BERT.** Các mô hình FinBERT cải thiện đáng kể so với BERT tổng quát. Trên PhraseBank, mô hình tốt nhất là FinBERT-FinVocab uncased đạt độ chính xác 0,872, cao hơn 4,4% so với BERT uncased và 15,4% so với BERT cased. Trên FiQA, mô hình tốt nhất FinBERT-FinVocab uncased đạt 0,844, cao hơn 15,6% so với BERT uncased và 29,2% so với BERT cased.

| Bộ dữ liệu | BERT cased | BERT uncased | FinBERT-BaseVocab cased | FinBERT-BaseVocab uncased | FinBERT-FinVocab cased | FinBERT-FinVocab uncased |
|---|---|---|---|---|---|---|
| PhraseBank | 0.755 | 0.835 | 0.856 | 0.870 | 0.864 | 0.872 |
| FiQA | 0.653 | 0.730 | 0.767 | 0.796 | 0.814 | 0.844 |
| AnalystTone | 0.840 | 0.850 | 0.872 | 0.880 | 0.876 | 0.887 |

Bảng 2: Hiệu năng của các mô hình BERT khác nhau trên ba tác vụ phân tích cảm xúc tài chính.

| Từ vựng | Bộ dữ liệu | 10-Ks/10-Qs | Earnings Call | Báo cáo phân tích | Tất cả |
|---|---|---|---|---|---|
| BaseVocab | PhraseBank | 0.835 | 0.843 | 0.845 | 0.856 |
| BaseVocab | FiQA | 0.707 | 0.731 | 0.744 | 0.767 |
| BaseVocab | AnalystTone | 0.845 | 0.862 | 0.871 | 0.872 |
| FinVocab | PhraseBank | 0.847 | 0.860 | 0.861 | 0.864 |
| FinVocab | FiQA | 0.766 | 0.778 | 0.796 | 0.814 |
| FinVocab | AnalystTone | 0.858 | 0.870 | 0.872 | 0.876 |

Bảng 3: Hiệu năng khi tiền huấn luyện trên các kho ngữ liệu tài chính khác nhau.
