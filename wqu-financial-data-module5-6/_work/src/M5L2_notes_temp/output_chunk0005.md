## **2.2 Nguồn cấp RSS: Google News RSS**

Một cách khác để nhận cập nhật tin tức là đăng ký một nguồn cấp RSS (RSS feed). RSS là viết tắt của Really Simple Syndication hoặc Rich Site Summary. Đây là một định dạng nguồn cấp web chuẩn hóa, cho phép người dùng đăng ký nhận các cập nhật từ website hoặc blog. Các cập nhật này thường được gửi dưới dạng tiêu đề tin tức, tóm tắt bài viết hoặc các thay đổi nội dung khác. Nhiều nguồn tin tài chính nổi tiếng cung cấp nguồn cấp RSS, chẳng hạn *Wall Street Journal*, Bloomberg, Reuters, *Financial Times*, Seeking Alpha, The Motley Fool, Benzinga, v.v.

Trong bài học này, chúng ta khám phá việc dùng Google News RSS để truy cập các bài báo từ Google News ở dạng có cấu trúc, máy có thể xử lý dễ dàng. Dù không hẳn là một API, chúng ta có thể phân tích cú pháp (parse) nguồn cấp Google News RSS miễn phí bằng các thư viện như `feedparser`, một thư viện Python được thiết kế để phân tích các nguồn cấp phân phối nội dung, phổ biến nhất là RSS và Atom. Thư viện này xử lý được nhiều định dạng và biến thể nguồn cấp khác nhau, nên là công cụ linh hoạt để trích xuất thông tin từ nhiều nguồn.

Trong đoạn mã sau, chúng ta xác định URL nguồn cấp RSS và trích xuất thông tin bài viết (tiêu đề, liên kết, ngày đăng, v.v.) cho từ khóa truy vấn "Microsoft":

```python
# Xác định URL nguồn cấp RSS và truy xuất nguồn cấp
query = "Microsoft"
rss_url = f"https://news.google.com/rss/search?q={query}t&hl=en-US&gl=US&ceid=US:en"
feed = feedparser.parse(rss_url)

for entry in feed.entries:
    print("Published:", entry.published)
    print("Title:", entry.title)
    print("Link:", entry.link)
    print("-" * 30)
```

Output:
```
Published: Mon, 01 Dec 2025 08:00:00 GMT
Title: Tech Moves: Expedia names first AI chief; Textio founder joins Microsoft; T-Mobile exec departs - GeekWire
Link: https://news.google.com/rss/articles/CBMiwAFBVV95cUxNdnhialhuOVhIZzVGQWVnb2d1UmVNTEFTbWw3Z1RwVGNENnhCMThxc085Yl8zYVNmT20tWnRFb1pTTW5rV2lLOTBJVnpXRVVrRk51RDJXeFVIalFjeC01Mmt1NE45VlZGT3VlN1FFV3c1UHBZczdOLWZvSUxMajFpeUFNVmh6bjBVZUVKQkRvWUFmeC16ZC1IUzl5V05iYXlFYThBRnlQWHBOWkplbHRlWDZvMHZLVDJ3Yk5QdGVkbW8?oc=5
------------------------------
Published: Thu, 11 Sep 2025 07:00:00 GMT
Title: Innovation Leader at Microsoft to Direct New AI Institute - The Catholic University of America
Link: https://news.google.com/rss/articles/CBMikgFBVV95cUxNUGpua3hrcFdjLWpHT3RtTkNGc0hJZF96U3RMWFZLa0JjQ0wtVUV0QS1CZHpXdE1VVVM4MzIxd1ptVnNvd0lyeFRodjlkeHhTQ09ZQkZVV2x4c1NjZzZiQm14bUxQSm5pcVNhY2Q0ZWpLamd1ODhia0J5QWZFb0U2QjduTnJxOHk0SzhHd0RqdU93Zw?oc=5
------------------------------
Published: Tue, 13 Aug 2024 07:00:00 GMT
Title: Kudo adds AI speech translation for Microsoft Teams - Inavate
Link: https://news.google.com/rss/articles/CBMiogFBVV95cUxPNXpORnZlU0c5d08xOFBxQzFDRHRzeDVZQjVJTEdaX3BoVDhNMVBnZ0p1cnJRR1lydU9uVmhCc0RtbG51bHVWMzJoX051eHh6WHVNckMwa3lxZC1qdzBUb0xzbGhJS1NLSEtnbEw2bDRUNlp3VmFyQ3RtdlRmanBtVFZIY0lOZFVVTjZ5OTRXLWNqLTduWUxKNks4bGJpN0xOOEE?oc=5
------------------------------
Published: Mon, 11 Oct 2021 07:00:00 GMT
Title: Azure AI empowers organizations to serve users in more than 100 languages - Microsoft Source
Link: https://news.google.com/rss/articles/CBMilAFBVV95cUxQSk9JVDhKQTM1cDB5Sm5XdTg4NVhpejB6a0NJdkVoYzBFaFJlRmM5QXdkZ0pJZVBJNUhSc3pTczNENGlJUXdhTXgyTlJ6eER5a2w3czlKMXBlUGNOOUpFalJrLVhnTHNLd3ZyMVl0cmUtdWlfdG82enVCanMtQTQ4cFZqT3FkSklLQU1wWmxjR0YzNnZ3?oc=5
------------------------------
Published: Wed, 06 May 2015 07:00:00 GMT
Title: Secret T-shirt message explains why Microsoft skipped Windows 9 - businessinsider.com
Link: https://news.google.com/rss/articles/CBMihAFBVV95cUxPMHJGREdockM1d3J0R1hoMnByMDM5MmJGWm1MWV9MXzVJc1Y5QjBqRU1Vb3BrNHlHbk0xUjUxM3I2U3lRS1JfcktrbjZ3bXJZVU9LNkc2UkZlTkhNbGlNZWZNSTNtQm45bVd5SzhJWVJkaFFwbFFrWFRzSXRFUHZyQ2ZWN2s?oc=5
------------------------------
```

Như bạn thấy, chúng ta có nhiều tiêu đề tin tức hơn so với khi dùng `yfinance`. Tuy nhiên, Google News RSS cũng có ưu điểm và hạn chế riêng:

**Ưu điểm của Google News RSS:**
 - Truy cập miễn phí: Bạn có thể truy cập và phân tích nguồn cấp Google News RSS mà không cần khóa API hay phí đăng ký.
 - Phạm vi chủ đề rộng: Google News bao phủ nhiều danh mục và chủ đề tin tức.
 - Nội dung mới: Nguồn cấp RSS được cập nhật thường xuyên, nên bạn tiếp cận được các bài báo mới nhất.

**Hạn chế:**
 - Không kiểm soát chi tiết: Bạn không thể lọc bài viết theo các tiêu chí cụ thể như khoảng thời gian hoặc nguồn tin ngay trong nguồn cấp RSS.
 - Khả năng bị giới hạn tần suất: Google có thể áp đặt giới hạn tần suất truy cập nguồn cấp RSS của họ.
 - Không có dữ liệu lịch sử: Nguồn cấp RSS thường chỉ cung cấp các bài viết gần đây, không phải kho lưu trữ lịch sử.

**Các trường hợp sử dụng:**
 - Cập nhật về các chủ đề cụ thể: Đăng ký nguồn cấp RSS về các chủ đề liên quan đến sở thích hoặc khoản đầu tư của bạn.
 - Xây dựng trình tổng hợp tin tức đơn giản: Tạo một trình tổng hợp tin tức cơ bản hiển thị bài viết từ nhiều nguồn cấp Google News RSS.
 - Phân tích cảm xúc và khai phá văn bản: Trích xuất văn bản từ các bài báo để phân tích cảm xúc hoặc các nghiên cứu dựa trên văn bản khác.

Nhìn chung, Google News RSS là nguồn tài nguyên hữu ích để truy cập dữ liệu tin tức miễn phí, đặc biệt cho các dự án nhỏ, mục đích cá nhân, hoặc khi bạn cần một cái nhìn tổng quan nhanh về tin tức gần đây theo chủ đề cụ thể.
