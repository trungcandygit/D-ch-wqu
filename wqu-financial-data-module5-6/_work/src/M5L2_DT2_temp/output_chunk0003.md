
| Kho ngữ liệu | Số token |
|---|---|
| Báo cáo doanh nghiệp 10-K & 10-Q | 2,5 tỷ |
| Bản ghi cuộc họp công bố kết quả kinh doanh (Earnings Call) | 1,3 tỷ |
| Báo cáo của nhà phân tích | 1,1 tỷ |

Bảng 1: Quy mô các kho ngữ liệu tài chính dùng để tiền huấn luyện.

## 4 Huấn luyện FinBERT

**Từ vựng.** Nhóm tác giả xây dựng FinVocab, một bộ từ vựng WordPiece mới trên các kho ngữ liệu tài chính bằng thư viện SentencePiece. Có cả hai phiên bản phân biệt hoa thường (cased) và không phân biệt (uncased), với kích thước lần lượt là 28.573 và 30.873 token, rất gần với 28.996 và 30.522 token của BaseVocab gốc của BERT. Mức trùng lặp giữa BaseVocab của BERT và FinVocab là 41% cho cả hai phiên bản.

**Các biến thể FinBERT.** Dùng mã BERT gốc (github.com/google-research/bert) để huấn luyện FinBERT trên kho ngữ liệu tài chính với cấu hình như BERT-Base. Theo cách huấn luyện BERT gốc, độ dài câu tối đa ban đầu là 128 token, huấn luyện đến khi hàm mất mát huấn luyện bắt đầu hội tụ, sau đó tiếp tục với câu dài tới 512 token. Có bốn phiên bản FinBERT: cased hoặc uncased; BaseVocab hoặc FinVocab.

- FinBERT-BaseVocab (uncased/cased): khởi tạo từ mô hình BERT-Base uncased/cased gốc, tiếp tục tiền huấn luyện trên kho ngữ liệu tài chính 250 nghìn vòng lặp với tốc độ học nhỏ hơn là 2e−5, theo khuyến nghị của mã BERT.
- FinBERT-FinVocab (uncased/cased): huấn luyện từ đầu với bộ từ vựng tài chính FinVocab mới (uncased/cased) trong 1 triệu vòng lặp.

**Huấn luyện.** Toàn bộ huấn luyện dùng máy NVIDIA DGX-1 với 4 GPU Tesla P100, tổng bộ nhớ GPU 128 GB, cho phép dùng kích thước batch 128. Khung Horovod (Sergeev và Del Balso, 2018) được dùng cho huấn luyện đa GPU. Tổng thời gian tiền huấn luyện một mô hình khoảng 2 ngày. Khi phát hành FinBERT, nhóm tác giả hy vọng giới thực hành và nghiên cứu tài chính có thể dùng FinBERT mà không cần nguồn lực tính toán lớn để huấn luyện.

## 5 Thực nghiệm phân tích cảm xúc tài chính

Do tầm quan trọng của phân tích cảm xúc trong các tác vụ NLP tài chính, nhóm tác giả thực nghiệm trên các bộ dữ liệu phân loại cảm xúc tài chính.

### 5.1 Dữ liệu

- **Financial Phrase Bank**: bộ dữ liệu công khai về phân loại cảm xúc tài chính (Malo và cs., 2014), gồm 4.840 câu chọn từ tin tức tài chính, được 16 nhà nghiên cứu có đủ kiến thức nền về thị trường tài chính gán nhãn thủ công. Nhãn cảm xúc là tích cực, trung lập hoặc tiêu cực.
- **AnalystTone**: bộ dữ liệu đo quan điểm trong báo cáo của nhà phân tích, thường dùng trong văn liệu kế toán và tài chính (Huang và cs., 2014). Gồm 10.000 câu chọn ngẫu nhiên từ cơ sở dữ liệu Investext, gán nhãn thủ công thành tích cực, tiêu cực hoặc trung lập: 3.580 câu tích cực, 1.830 tiêu cực và 4.590 trung lập.
- **FiQA**: bộ dữ liệu thử thách mở về phân tích cảm xúc tài chính (sites.google.com/view/fiqa/home), gồm 1.111 câu. Với câu tiếng Anh thuộc lĩnh vực tài chính (tin nhắn microblog, phát biểu tin tức), nhiệm vụ là dự đoán điểm cảm xúc số trong khoảng từ −1 đến 1. Bài toán hồi quy gốc được chuyển thành phân loại nhị phân để so sánh nhất quán với hai bộ trên.

Mỗi bộ dữ liệu được chia ngẫu nhiên 90% huấn luyện và 10% kiểm tra, lặp 10 lần và lấy trung bình. Vì đều là phân loại cảm xúc, thước đo báo cáo là độ chính xác.

### 5.2 Chiến lược tinh chỉnh

Dùng kiến trúc tinh chỉnh và lựa chọn tối ưu hóa như Devlin và cs. (2019): một tầng tuyến tính đơn giản làm tầng phân loại với hàm kích hoạt softmax, và hàm mất mát cross-entropy. Một phương án khác là đưa embedding ngữ cảnh của từng token vào kiến trúc học sâu như Bi-LSTM đặt trên embedding BERT đã đóng băng; nhóm không chọn vì cách này cho kết quả kém hơn đáng kể so với tinh chỉnh BERT (Beltagy và cs., 2019).

### 5.3 Kết quả thực nghiệm

FinBERT được so sánh với BERT-Base gốc (Devlin và cs., 2019), đánh giá cả phiên bản cased và uncased. Kết quả chính ở Bảng 2.

**FinBERT so với BERT.** FinBERT cải thiện đáng kể so với BERT tổng quát. Trên PhraseBank, mô hình tốt nhất là FinBERT-FinVocab uncased đạt độ chính xác 0,872, tăng 4,4% so với BERT uncased và 15,4% so với BERT cased. Trên FiQA, FinBERT-FinVocab uncased đạt 0,844, tăng 15,6% so với BERT uncased và 29,2% so với BERT cased.

| Bộ dữ liệu | BERT cased | BERT uncased | FinBERT-BaseVocab cased | FinBERT-BaseVocab uncased | FinBERT-FinVocab cased | FinBERT-FinVocab uncased |
|---|---|---|---|---|---|---|
| PhraseBank | 0.755 | 0.835 | 0.856 | 0.870 | 0.864 | 0.872 |
| FiQA | 0.653 | 0.730 | 0.767 | 0.796 | 0.814 | 0.844 |
| AnalystTone | 0.840 | 0.850 | 0.872 | 0.880 | 0.876 | 0.887 |

Bảng 2: Hiệu năng của các mô hình BERT khác nhau trên ba tác vụ phân tích cảm xúc tài chính.

| Từ vựng | Bộ dữ liệu | 10-Ks/10-Qs | Earnings Call | Báo cáo nhà phân tích | Tất cả |
|---|---|---|---|---|---|
| BaseVocab | PhraseBank | 0.835 | 0.843 | 0.845 | 0.856 |
| BaseVocab | FiQA | 0.707 | 0.731 | 0.744 | 0.767 |
| BaseVocab | AnalystTone | 0.845 | 0.862 | 0.871 | 0.872 |
| FinVocab | PhraseBank | 0.847 | 0.860 | 0.861 | 0.864 |
| FinVocab | FiQA | 0.766 | 0.778 | 0.796 | 0.814 |
| FinVocab | AnalystTone | 0.858 | 0.870 | 0.872 | 0.876 |

Bảng 3: Hiệu năng khi tiền huấn luyện trên các kho ngữ liệu tài chính khác nhau.
