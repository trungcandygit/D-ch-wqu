## **2.3 News API**

Mặc dù không phải là một gói Python, News API cung cấp một cách đơn giản để lấy dữ liệu tin tức. Dịch vụ này có gói miễn phí với số yêu cầu giới hạn mỗi ngày, có thể đủ cho các dự án quy mô nhỏ hoặc mục đích học tập. Bạn cần đăng ký khóa API miễn phí trên trang web NewsAPI trước khi sử dụng.

News API là một REST API dựa trên đám mây, cho phép truy cập theo cách lập trình vào một bộ sưu tập lớn các bài báo từ hàng nghìn nguồn trên khắp thế giới.
Dịch vụ này tổng hợp tin tức từ các nhà xuất bản uy tín, hãng thông tấn, blog và các phương tiện truyền thông trực tuyến khác.

**So với `yfinance` và Google News RSS:**
 - Nhiều bài báo hơn: Với News API, bạn có thể lấy được số lượng bài báo lớn hơn nhiều.
 - Khả năng tùy biến: Bạn kiểm soát chi tiết hơn nhiều dữ liệu tin tức cần lấy thông qua các tùy chọn tìm kiếm và lọc.
 - Tính năng bổ sung: Phân tích cảm xúc và nhiều điểm cuối (endpoint) API khác nhau bổ sung thêm khả năng phân tích.

**Hạn chế:**
 - Chi phí: Dù có gói miễn phí với số yêu cầu giới hạn, bạn sẽ cần đăng ký gói trả phí nếu sử dụng ở quy mô lớn hơn hoặc muốn dùng mọi tính năng.
 - Giới hạn tốc độ: Ngay cả với các gói trả phí vẫn có giới hạn về số yêu cầu bạn có thể gửi trong một khoảng thời gian nhất định.

**Các trường hợp sử dụng:**
 - Theo dõi và phân tích tin tức: Theo dõi xu hướng tin tức, nhận diện các chủ đề mới nổi và phân tích mức độ đưa tin về các công ty, ngành hoặc sự kiện cụ thể.
 - Phân tích cảm xúc: Đánh giá cảm xúc của công chúng đối với thương hiệu, sản phẩm hoặc các nhân vật chính trị.
 - Nghiên cứu thị trường: Thu thập thông tin chi tiết về hành vi người tiêu dùng, hoạt động của đối thủ cạnh tranh và xu hướng ngành.
 - Tuyển chọn nội dung: Xây dựng các trình tổng hợp tin tức hoặc nguồn cấp tin được cá nhân hóa.
 - Giao dịch thuật toán: Đưa cảm xúc và các sự kiện từ tin tức vào các chiến lược giao dịch.

Nhìn chung, News API là một công cụ mạnh mẽ và linh hoạt hơn để phân tích dữ liệu tin tức so với `yfinance` và Google News RSS. Đây là lựa chọn rất tốt nếu bạn cần tập dữ liệu lớn hơn, khả năng tùy biến cao hơn và các tính năng bổ sung như phân tích cảm xúc. Tuy nhiên, việc sử dụng ở quy mô rộng hơn sẽ phát sinh chi phí.

Trong phần còn lại của bài học này, chúng ta sẽ khám phá một số tính năng của News API. Trước tiên, chúng ta cần đăng ký và lấy khóa API.

 - Đăng ký: Tạo tài khoản miễn phí trên trang web News API: https://newsapi.org/pricing, chọn gói giá Developer miễn phí. Hãy đăng ký với tư cách cá nhân. Gói miễn phí cho phép một số yêu cầu giới hạn mỗi ngày và cho phép tìm kiếm các bài báo (với độ trễ 24 giờ) trong vòng một tháng trở lại, nhưng như vậy là đủ cho mục đích học tập.
 - Lấy khóa API: Ngay sau khi đăng ký, bạn sẽ thấy khóa API riêng của mình, khóa này cần được đưa vào các yêu cầu của bạn.
 - Trên trang chào mừng, bạn cũng sẽ thấy liên kết đến "Getting Started Guide". Hãy dành thời gian khám phá tài liệu API để biết thông tin chi tiết về các endpoint, tham số và định dạng phản hồi.

Trong bài học này, chúng ta sẽ khám phá một số chức năng cơ bản và thử nghiệm các truy vấn và bộ lọc khác nhau để điều chỉnh kết quả cho phù hợp với nhu cầu cụ thể.

Sau đây là đoạn mã ví dụ lấy các bài báo liên quan đến "Microsoft" từ News API, lưu chúng vào DataFrame và xử lý các lỗi có thể xảy ra trong quá trình này. Đừng quên lấy khóa API của riêng bạn. Sau đó, hãy quay lại đầu bài học này và thay `API_KEY` bằng khóa API thực của bạn trong ô mã ở đầu notebook. Hãy chạy lại ô mã đó rồi tiếp tục với ô mã bên dưới:

```python
# Define News API variables
query = "Microsoft"
url = f"https://newsapi.org/v2/everything?q={query}&apiKey={api_key}&language=en"
response = requests.get(url)

# Get news data
results = []
if response.status_code == 200:
    news_data = response.json()
    for article in news_data['articles']:
        results.append({
            'Date': article['publishedAt'][:10],  # Extract date
            'URL': article['url'],
            'Source': article['source']['name'],
            'Author': article['author'],
            'Title': article['title'],
            'Description': article['description'],
            'Content': article['content']
        })
else:
    print("Error fetching news:", response.status_code)

# Create DataFrame
df = pd.DataFrame(results)
df

```

Chúng ta cũng có thể lưu tập dữ liệu cục bộ vào tệp news_data.csv. Việc lưu dữ liệu News API vào tệp CSV là hữu ích do những hạn chế về khả năng truy cập dữ liệu ở một số khoảng thời gian, đặc biệt là với gói miễn phí. Rất có thể phần mã còn lại trong bài học này sẽ cho ra kết quả khác khi bạn chạy. Vì vậy, tham chiếu đến news_data.csv có thể hữu ích.

```python
# Save News dataset
df.to_csv('news_data.csv', index=False)
```

`if response.status_code == 200:` Dòng này kiểm tra xem giá trị của `response.status_code` có bằng 200 hay không. Trong ngữ cảnh các yêu cầu HTTP, mã trạng thái 200 thường biểu thị yêu cầu thành công.

Nếu điều kiện trong câu lệnh if đúng (tức là mã trạng thái là 200), dòng này được thực thi và việc chạy mã sẽ chuyển sang dòng tiếp theo. `response.json()` ở dòng tiếp theo là một phương thức cố gắng phân tích nội dung phản hồi dưới dạng JSON (JavaScript Object Notation). JSON là một định dạng dữ liệu phổ biến dùng để trao đổi dữ liệu trên web. Dữ liệu JSON đã được phân tích sau đó được gán cho biến `news_data`.

Kết quả của mã lưu siêu dữ liệu bài báo cho từng tin: các thông tin như ngày xuất bản (publishedAt), nguồn (source), tác giả (author), tiêu đề (title), mô tả (description), nội dung (content) và URL (url) cung cấp ngữ cảnh cho phân tích cảm xúc.

Lưu ý "[Removed]" trong cột Content của dataframe. Điều này có thể là do các hạn chế về nội dung do nguồn tin hoặc chính News API áp đặt. Lý do như sau:
