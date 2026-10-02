## **3.1 Phân tích cảm xúc bằng FinBERT**

Thật không may cho chúng ta, tính năng Sentiment Analysis của News API là tính năng trả phí. Nếu bạn có quyền truy cập gói trả phí đó, phản hồi của API sẽ bao gồm sẵn các điểm cảm xúc (tích cực, tiêu cực, trung lập) cho từng bài báo. Khi đó, bạn có thể sử dụng trực tiếp các điểm này trong các chiến lược giao dịch của mình.

Trong bài học này, chúng ta sẽ dùng một phương pháp thay thế là tự xây dựng thủ công hàm chấm điểm cảm xúc. Để làm việc này, chúng ta sẽ sử dụng **FinBERT**, một mô hình NLP được huấn luyện trước, thiết kế riêng cho văn bản tài chính. Mô hình này dựa trên kiến trúc BERT (Bidirectional Encoder Representations from Transformers), một loại mô hình Transformer, và đã được tinh chỉnh trên một kho ngữ liệu tài chính lớn.

**Transformer** là một loại mô hình học sâu đã đạt được nhiều thành công trong các tác vụ xử lý ngôn ngữ tự nhiên (NLP). Chúng đặc biệt giỏi trong việc hiểu mối quan hệ giữa các từ khác nhau trong một câu, điều quan trọng đối với các tác vụ như phân tích cảm xúc. FinBERT là một loại mô hình Transformer cụ thể đã được huấn luyện trước trên một kho ngữ liệu văn bản tài chính lớn. Điều này có nghĩa là nó đã học được rất nhiều về ngôn ngữ được dùng trong các tài liệu tài chính. Nhờ đó, nó đặc biệt giỏi trong việc hiểu các sắc thái của ngôn ngữ tài chính, bao gồm thuật ngữ chuyên ngành, cảm xúc và các khái niệm tài chính cụ thể, và điều này làm cho nó rất phù hợp với các tác vụ như phân tích cảm xúc của các bài báo tin tức tài chính.

Trong đoạn mã sau, chúng ta sử dụng mô hình FinBERT để gán điểm cảm xúc cho từng bài báo. Để làm điều này, trước tiên chúng ta cần tiền xử lý nội dung của mỗi bài báo bằng hàm `preprocess`. Sau đó, chúng ta áp dụng `get_sentiment()` để thực hiện phân tích cảm xúc trên một văn bản đã tiền xử lý bằng mô hình FinBERT. Cách hoạt động như sau:

 - **Tách token (Tokenization):** Văn bản đã tiền xử lý được tách token bằng đối tượng tokenizer. Tách token là quá trình chia nhỏ văn bản thành các đơn vị riêng lẻ (token) - từ hoặc từ con - mà mô hình có thể hiểu được. Tham số `return_tensors='pt' ` chỉ định rằng các token phải được trả về dưới dạng tensor PyTorch. Tensor PyTorch là các mảng đa chiều, một cấu trúc dữ liệu nền tảng trong thư viện PyTorch. Chúng tương tự như mảng NumPy nhưng có một số ưu điểm chính. Để hình dung, hãy coi tensor PyTorch như những chiếc hộp chứa dữ liệu số có thể có nhiều chiều khác nhau (ví dụ: 1 chiều cho vector, 2 chiều cho ma trận, 3 chiều trở lên cho dữ liệu phức tạp hơn).
 - **Suy luận mô hình và trích xuất điểm bằng Softmax:** Đầu vào đã tách token được đưa vào mô hình FinBERT để suy luận. Các điểm liên quan được trích xuất từ đầu ra của mô hình và chuyển thành mảng NumPy bằng `detach().numpy()`. Sau đó các điểm được đưa qua hàm `softmax`. Softmax chuyển các điểm thành xác suất, đảm bảo tổng của chúng bằng 1.

Hàm `get_sentiment()` trả về một từ điển chứa các xác suất cho cảm xúc tiêu cực, trung lập và tích cực, với xác suất cao nhất đứng đầu.

Đoạn mã sau xử lý phản hồi từ News API và thực hiện phân tích cảm xúc (bằng cách lần lượt thực hiện tiền xử lý văn bản, tách token, suy luận mô hình và lấy cảm xúc) trên trường 'Description' của từng bài báo đã truy xuất. Chúng ta cũng loại bỏ các hàng có 'Description' đã bị gỡ và bài báo không còn khả dụng:


```python
# Specify the FinBERT model
MODEL = f"ProsusAI/finbert"
tokenizer = AutoTokenizer.from_pretrained(MODEL)
model = AutoModelForSequenceClassification.from_pretrained(MODEL)

# Text processing function
def preprocess(text):
    if text is None: # Handle None values by returning an empty string if text is None
        return ""
    new_text = []
    for t in text.split(" "):
        t = '' if t.startswith('#') and len(t) > 1 else t  # remove hashtags
        t = '' if t.startswith('@') and len(t) > 1 else t  # remove usernames
        t = '' if t.startswith('http') else t  # remove URLs
        new_text.append(t)
    return " ".join(new_text)

# Sentiment scoring function
def get_sentiment(text):
    text = preprocess(text)
    encoded_input = tokenizer(text, return_tensors='pt')
    output = model(**encoded_input)
    scores = output[0][0].detach().numpy()
    scores = softmax(scores)
    return {
        'positive': scores[0],
        'negative': scores[1],
        'neutral': scores[2]
    }
```

Bây giờ chúng ta đã khởi tạo mô hình FinBERT và xây dựng các hàm hỗ trợ, chúng ta có thể áp dụng các kỹ thuật này lên DataFrame dữ liệu tin tức `df`. Xin lưu ý rằng vào thời điểm bạn chạy mã trong bài học này, dữ liệu tin tức khả dụng qua gói miễn phí của News API sẽ đã thay đổi vì gói này chỉ cho phép truy xuất lịch sử một tháng. Chúng tôi đã lưu dữ liệu tin tức gốc khi viết bài học này. Bạn sẽ cần tải tệp 'WQU_FD_news_data.csv' để có được kết quả giống như trong bài học này. Nếu không, hãy tiếp tục khám phá dữ liệu mới.

```python
# Open saved DataFrame - OPTIONAL
df = pd.read_csv('WQU_FD_news_data.csv')
df.head()
```

Kết quả:
