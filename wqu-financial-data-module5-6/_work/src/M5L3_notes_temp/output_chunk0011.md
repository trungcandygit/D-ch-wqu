Mỗi dòng là đường dẫn đến một tệp WARC. Các tệp này là kho lưu trữ nén chứa các trang web cùng siêu dữ liệu (metadata) đi kèm, cụ thể trong trường hợp này là các bài báo tin tức. Những đường dẫn này rất cần thiết để truy cập dữ liệu tin tức thực sự trong bộ dữ liệu Common Crawl. Thông thường, chúng ta sẽ dùng các đường dẫn này cùng với các công cụ hoặc thư viện có thể đọc và xử lý tệp WARC.

Bây giờ hãy xác định kích thước của một tệp WARC cụ thể trong bộ dữ liệu Common Crawl News. Ta chọn tệp `crawl-data/CC-NEWS/2024/09/CC-NEWS-20240923074837-06216.warc.gz`, tương ứng với dữ liệu được thu thập vào ngày 23 tháng 9 năm 2024 lúc khoảng 7:48 sáng:

In \[16\]:

``` calibre12
# Chỉ định đường dẫn tệp WARC
warc_file_url = "https://data.commoncrawl.org/crawl-data/CC-NEWS/2024/09/CC-NEWS-20240923074837-06216.warc.gz"

# Dùng yêu cầu HEAD để chỉ lấy phần tiêu đề (headers)
response = requests.get(warc_file_url, stream=True)
response.raise_for_status()

# Lấy kích thước tệp từ headers và in ra
file_size = int(response.headers.get('content-length', 0))
print(f"File size: {file_size} bytes")
print(f"File size: {file_size / (1024 * 1024):.2f} MB")  # Đổi sang MB
```

``` calibre12
File size: 1072759398 bytes
File size: 1023.06 MB
```

Đoạn mã này lấy kích thước của một tệp WARC cụ thể từ bộ dữ liệu Common Crawl News một cách hiệu quả mà không cần tải xuống toàn bộ tệp. Như ta thấy, tệp WARC này có kích thước xấp xỉ 1,02 GB (1023,06 MB). Hiểu rõ kích thước của các tệp WARC giúp ta lập kế hoạch tốt hơn cho quy trình thu thập và xử lý dữ liệu. Trong trường hợp của chúng ta, cần lưu ý rằng một tệp 1 GB có thể mất khá nhiều thời gian để tải xuống, đặc biệt khi kết nối internet chậm.
