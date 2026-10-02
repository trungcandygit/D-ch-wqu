## **1.1 Thu thập dữ liệu News Crawl**

Điều quan trọng là phải hiểu cấu trúc của dữ liệu News Crawl và cách truy cập dữ liệu này. Các tệp dữ liệu của Common Crawl chủ yếu được lưu trữ ở **định dạng WARC (Web ARChive)**. WARC là một chuẩn được sử dụng rộng rãi để lưu trữ nội dung web, rất phù hợp để lưu trữ lượng dữ liệu lớn, bao gồm các trang web, siêu dữ liệu (metadata) và các tài nguyên đi kèm. Các tệp này chứa các trang web thô đã được thu thập, cùng với siêu dữ liệu như URL, dấu thời gian, loại nội dung và tiêu đề HTTP. Đây là nguồn dữ liệu chính trong Common Crawl.

Common Crawl cũng cung cấp các tập dữ liệu chính ở dạng **tệp WAT (Web Annotation Text)**, nơi lưu trữ siêu dữ liệu quan trọng về các bản ghi, cung cấp thêm ngữ cảnh và thông tin, và ở dạng **tệp WET (Web Extracted Text)** chứa nội dung văn bản thuần được trích xuất từ các trang web, giúp việc tìm kiếm và phân tích văn bản dễ dàng hơn mà không cần phân tích cú pháp HTML. Bạn có thể xem ví dụ về từng định dạng tệp trên trang web của Common Crawl tại đây: <https://commoncrawl.org/get-started>.

Khác với các tập dữ liệu chính của Common Crawl, các tập dữ liệu News Crawl chỉ được cung cấp ở định dạng WARC. Các tập dữ liệu News của Common Crawl được tổ chức thành các phân đoạn theo tháng, gọi là **Danh sách đường dẫn tệp WARC (WARC File Path Listings)**, và dữ liệu trong mỗi phân đoạn được lưu trong các tệp WARC. Các tệp này tiếp tục được nhóm thành các đợt thu thập theo ngày. Danh sách đường dẫn tệp WARC có sẵn trên AWS (Amazon Web Services) và có thể truy cập theo mẫu `s3://commoncrawl/CC-NEWS/yyyy/mm/warc.paths.gz` (việc truy cập đám mây AWS có thể phát sinh phí truyền dữ liệu giữa các vùng tùy theo vị trí của bạn). Ngoài ra, dữ liệu cũng có thể truy cập qua lược đồ URL `https://data.commoncrawl.org/CC-NEWS/yyyy/mm/warc.paths.gz`. Chúng ta chỉ cần thay `yyyy` và `mm` lần lượt bằng giá trị số của năm và tháng.

Bên trong mỗi danh sách đường dẫn WARC có một danh sách tất cả các đợt thu thập đã được lưu trong các tệp WARC của phân đoạn này trong tháng. Các tệp WARC được phát hành hằng ngày, và tên tệp WARC tuân theo mẫu: `crawl-data/CC-NEWS/yyyy/mm/CC-NEWS-yyyymmddHHMMSS-nnnnn.warc.gz`. Dấu thời gian (yyyymmddHHMMSS) cho biết thời điểm bản ghi đầu tiên trong tệp WARC được tạo, trong đó:

  ----------------------------------- -----------------------------------
  yyyy                                năm

  mm                                  tháng (01..12)

  dd                                  ngày trong tháng (01, v.v.)

  HH                                  giờ (00..23)

  MM                                  phút (00..59)

  SS                                  giây (00..59)

  nnnnn                               số thứ tự của tệp WARC.
                                      Số thứ tự được đặt lại khi
                                      quá trình thu thập được tiếp tục.
  ----------------------------------- -----------------------------------

Bây giờ chúng ta hãy thử lấy dữ liệu News Crawl bằng Danh sách đường dẫn tệp WARC của Common Crawl. Đoạn mã sau nhằm tải xuống và hiển thị danh sách các đường dẫn tệp WARC của tập dữ liệu Common Crawl News cho tháng 9 năm 2024. Mã này tải xuống một tệp nén chứa danh sách đường dẫn tệp WARC của tập dữ liệu Common Crawl News, giải nén tệp, rồi in từng đường dẫn ra console:

In \[15\]:

``` calibre12
# Get September 2024 WARC paths list
url = "https://data.commoncrawl.org/crawl-data/CC-NEWS/2024/09/warc.paths.gz"

# Fetch the file
response = requests.get(url, stream=True)
response.raise_for_status()  # Raise an exception for bad responses (4xx or 5xx)

# Decompress and print content
with gzip.GzipFile(fileobj=io.BytesIO(response.content)) as gz:
    for line in gz:
        print(line.decode('utf-8').strip()) # Print each line, removing leading/trailing spaces
```
