## **2.1 Sử dụng `yfinance` để lấy dữ liệu tin tức**

Mặc dù `yfinance` chủ yếu được biết đến với dữ liệu giá cổ phiếu lịch sử, thư viện này cũng cho phép truy cập các tin tức tài chính liên quan đến từng cổ phiếu cụ thể.

Ví dụ, chúng ta có thể dùng thư viện `yfinance` để lấy thông tin cổ phiếu của Microsoft. Chúng ta có thể tận dụng việc dữ liệu tin tức thường là một danh sách các từ điển. Mỗi từ điển đại diện cho một bài báo và chứa các khóa như `title`, `publisher`, `link`, `published`, v.v.

Khi đã có tất cả các thông tin cần thiết, chúng ta có thể in dữ liệu tin tức, đồng thời cũng có thể tạo một DataFrame từ các thông tin cụ thể để lưu lại dữ liệu phục vụ cho các thao tác xử lý tiếp theo và phân tích dữ liệu khám phá.

```python
# Create a Ticker object for Microsoft and access the news data
msft = yf.Ticker("MSFT")
news_data = msft.news

# Print the desired information for each article
for article in news_data:
    content = article.get('content')
    if content:
        # Assuming title, publisher, link are now within 'content'
        print("Published Time:", content.get('pubDate'))
        print("Title:", content.get('title'))  
        print("Publisher:", content.get('provider').get('displayName'))  
        print("Link:", content.get('canonicalUrl').get('url'))
        print("Content Type:", content.get('contentType'))
        print("-" * 30)
```

Như bạn thấy, ở đây chúng ta chỉ có 8 bài báo. `yfinance` có một số hạn chế khi truy xuất các bài báo tin tức.

 - **Số lượng bài báo bị giới hạn:** `yfinance` không cung cấp cách trực tiếp để kiểm soát số lượng bài báo được tải về. Số bài báo trả về có thể thay đổi và dường như bị giới hạn ở một mức tối đa, thường cho ra tập dữ liệu nhỏ hơn mong đợi. Giới hạn chính xác không được ghi rõ trong tài liệu và có thể phụ thuộc vào các yếu tố như mã cổ phiếu, mức độ sẵn có của tin tức và nguồn dữ liệu cơ sở mà `yfinance` sử dụng.

 - **Phụ thuộc vào các API bên ngoài:** `yfinance` không có cơ sở dữ liệu tin tức riêng. Thư viện này dựa vào việc tổng hợp tin tức từ nhiều nguồn và API bên ngoài. Điều này có nghĩa là mức độ sẵn có và số lượng dữ liệu tin tức có thể chịu ảnh hưởng bởi các hạn chế và những thay đổi tiềm ẩn của các nguồn bên ngoài đó.

 - **Thiếu khả năng kiểm soát chi tiết:** `yfinance` không có tùy chọn lọc bài báo theo các tiêu chí cụ thể như khoảng thời gian, nhà cung cấp tin tức hay từ khóa. Bạn chỉ nhận được một tập các bài báo gần đây liên quan đến mã cổ phiếu, nhưng không thể tùy chỉnh truy vấn sâu hơn.


Tóm lại: Mặc dù `yfinance` là công cụ tiện lợi để lấy thông tin cổ phiếu cơ bản và xem nhanh các tin tức gần đây, nó không lý tưởng cho phân tích tin tức toàn diện hoặc khi bạn cần một tập dữ liệu tin tức lớn và có thể tùy chỉnh. Tuy nhiên, bất chấp các hạn chế, `yfinance` vẫn có nhiều trường hợp sử dụng, đặc biệt khi bạn cần truy cập dữ liệu tài chính nhanh chóng và dễ dàng.

 - **Theo dõi tin tức đơn giản:** Nắm bắt nhanh các tin tức gần đây liên quan đến một cổ phiếu. Dù còn hạn chế, tính năng tin tức của `yfinance` có thể hữu ích để cập nhật các diễn biến lớn hoặc tiêu đề ảnh hưởng đến một công ty.

 - **Tạo nguyên mẫu hoặc mục đích giáo dục:** Đây là công cụ tuyệt vời để học về phân tích dữ liệu tài chính hoặc để thử nhanh các ý tưởng mà không phải tốn công với các nguồn dữ liệu phức tạp hơn.
