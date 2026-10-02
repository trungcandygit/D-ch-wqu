``` calibre12
# Hàm hỗ trợ xử lý tệp WARC
def process_warc_file(warc_file_url, limit=1000):
    data = []
    count = 0

    with requests.get(warc_file_url, stream=True) as response:
        response.raise_for_status()

        # Bọc iterator bằng tqdm để xử lý các bản ghi kèm thanh tiến trình đến giới hạn
        for record in tqdm.tqdm(warcio.ArchiveIterator(response.raw), total=limit, desc="Processing records"):
            if record.rec_type == 'response':

                # Tiến hành trích xuất và lọc dữ liệu
                url = record.rec_headers.get_header('WARC-Target-URI')
                date = record.rec_headers.get_header('WARC-Date')
                content_length = record.rec_headers.get_header('Content-Length')

                try:
                    html_content = record.content_stream().read().decode('utf-8', 'ignore')

                    # Kiểm tra lang="en" trước <head> (xử lý cả xuống dòng)
                    if re.search(r'lang\s*=\s*[\'"]?en[\'"]?[\s\S]*?<head>', html_content, re.IGNORECASE):

                        # Trích xuất tiêu đề và nội dung bài viết bằng newspaper3k
                        article = Article(url, language='en')
                        article.download(input_html=html_content)
                        article.parse()
                        title = article.title
                        news_article = article.text

                        # Lọc các văn bản tin tức chứa "netflix" (không phân biệt hoa thường)
                        if news_article and re.search(r'netflix', news_article, re.IGNORECASE):
                            data.append([url, date, content_length, title, news_article])

                # Xử lý lỗi
                except UnicodeDecodeError as e:
                    print(f"Error decoding HTML content from {url}: {e}")
                except Exception as e:
                    print(f"Error extracting article from {url}: {e}")

            # Tăng biến đếm và kiểm tra giới hạn sau khi xử lý mỗi bản ghi
            count += 1
            if count > limit:
                break # Thoát vòng lặp nếu đạt giới hạn

    # Tạo DataFrame
    df = pd.DataFrame(data, columns=['URL', 'Date', 'Content-Length', 'Title', 'News_Article'])
    return df
```

Ở đây chúng ta dùng regex (biểu thức chính quy) `lang\s*=\s*[\'"]?en[\'"]?[\s\S]*?<head>`. Biểu thức này tìm thuộc tính `lang` trong nội dung HTML, kiểm tra cụ thể xem nó có được đặt là `"en"` hay không, rồi lấy mọi thứ từ vị trí đó đến thẻ `<head>`, kể cả khi giữa chúng có xuống dòng. Biểu thức này cho phép linh hoạt trong cách viết thuộc tính, ví dụ `lang="en"`, `lang = 'en'`, `lang=en`.

Tiếp theo, chúng ta tiến hành trích xuất chi tiết bài báo. Mã thực hiện việc này bằng thư viện `newspaper3k` để lấy tiêu đề và phần nội dung chính của bài báo từ HTML. `newspaper3k` là một thư viện Python dùng để trích xuất và phân tích các bài viết từ các trang tin tức và blog, được thiết kế để việc thu thập (web scraping) tin tức dễ dàng và hiệu quả hơn. Sau đó, mã lọc các văn bản tin tức có chứa "netflix" và thêm thông tin đã trích xuất vào danh sách `data`, danh sách này được dùng để tạo `df` (pandas DataFrame) cuối cùng do hàm trả về.

Cũng lưu ý rằng lần này `warcio.ArchiveIterator` được bọc trong `tqdm.tqdm(...)` để tạo thanh tiến trình cập nhật khi vòng lặp duyệt qua các bản ghi WARC. Thanh tiến trình cho biết số thứ tự bản ghi hiện tại, phần trăm hoàn thành và thời gian còn lại ước tính, giúp bạn hình dung trực quan tiến độ xử lý.

Bây giờ khi đã có hàm `process_warc_file()` hoàn chỉnh hơn, hãy gọi nó:

In \[ \]:

``` calibre12
# Ghi lại thời điểm bắt đầu
start_time = time.time()

# Xử lý 5000 bản ghi tiếng Anh đầu tiên có "netflix" trong tiêu đề
df = process_warc_file(warc_file_url, limit=5000)

# Tính và in tổng thời gian xử lý
end_time = time.time()
processing_time = end_time - start_time
print(f"\nTotal processing time: {processing_time:.2f} seconds")

# Hiển thị DataFrame
df
```

Đây chỉ là một ví dụ đơn giản hóa để minh họa cách lấy bộ dữ liệu tin tức từ tệp WARC của News Crawl. Kết quả là chúng ta có dữ liệu tin tức đã lọc trong DataFrame `df`, mà trong trường hợp này chỉ có một số ít bài viết liên quan đến Netflix. Chúng ta có thể dùng DataFrame này để xử lý tiếp theo cách tương tự như với các bộ dữ liệu tin tức thu được bằng những cách khác.
