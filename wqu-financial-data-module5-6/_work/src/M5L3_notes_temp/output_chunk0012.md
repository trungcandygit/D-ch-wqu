## **1.2 Xử lý các bản ghi của tệp WARC**

Với các tệp WARC lớn như thế này, chúng ta có thể xử lý chúng theo từng phần nhỏ để tránh các vấn đề về bộ nhớ. Dòng `requests.get(..., stream=True)` trong đoạn mã ở trên khởi tạo một lần tải xuống theo luồng (streaming), nghĩa là nó không nạp toàn bộ tệp WARC vào bộ nhớ cùng một lúc. Thay vào đó, nó tải từng khối dữ liệu khi cần. Cách này giúp giảm thiểu mức sử dụng bộ nhớ, đặc biệt đối với các tệp WARC lớn. Hàm `requests.get()` trả về một đối tượng Response, được gán cho biến `response`. Đối tượng này chứa thông tin về phản hồi của máy chủ, bao gồm mã trạng thái, tiêu đề (header) và nội dung của phản hồi (trong trường hợp này là dữ liệu của tệp WARC). Tuy nhiên, cần hiểu rằng đối tượng `response` không chứa toàn bộ tệp WARC. Hãy hình dung `response` như một chiếc hộp có nhiều ngăn. Một ngăn chứa thông tin về phản hồi (header, mã trạng thái), còn một ngăn khác là đường ống nối với máy chủ, nơi dữ liệu của tệp WARC chảy qua theo từng khối. Có thể ví nó như một ống nước nối với một hồ chứa. Chiếc ống (đối tượng `response`) tồn tại, nhưng toàn bộ hồ chứa (dữ liệu tệp WARC) không chảy qua ống cùng một lúc. Thay vào đó, nước chảy qua với lượng được kiểm soát khi cần.

Sau này, chúng ta có thể tận dụng hiệu quả tính năng truyền luồng này để giữ mức chiếm dụng bộ nhớ ở mức tương đối thấp. May mắn là các thư viện như `warcio,` một thư viện Python để đọc và ghi tệp WARC, cho phép lặp qua các bản ghi trong tệp WARC mà không cần nạp toàn bộ tệp vào bộ nhớ. Khi truy cập nội dung bằng `response.raw`, chúng ta không nhận được một tệp hoàn chỉnh trong bộ nhớ; chúng ta đang truy cập đường ống mà dữ liệu truyền qua. `warcio.ArchiveIterator` được thiết kế để làm việc với đường ống này. Nó đọc từng khối dữ liệu khi chúng đi qua đường ống và xử lý lần lượt từng khối. Ví dụ, đoạn mã sau lặp qua tất cả các bản ghi và tạo một DataFrame với URL, ngày và độ dài nội dung của mỗi bản ghi trong tệp WARC đã chọn. Đoạn mã chỉ tập trung vào các bản ghi `"response"`, vốn thường chứa nội dung trang web thực tế:

In \[ \]:

``` calibre12
# Function to process the WARC file and extract data
def process_warc_file(warc_file_url):
    data = []
    with requests.get(warc_file_url, stream=True) as response:
        response.raise_for_status()

        # Process WARC records
        for record in warcio.ArchiveIterator(response.raw):
            if record.rec_type == 'response':

                # Extract URL, date and content length
                url = record.rec_headers.get_header('WARC-Target-URI')
                date = record.rec_headers.get_header('WARC-Date')
                content_length = record.rec_headers.get_header('Content-Length')

                # Store extracted info in 'data' list
                data.append([url, date, content_length])

    # Create DataFrame
    df = pd.DataFrame(data, columns=['URL', 'Date', 'Content-Length'])
    return df

# Process the WARC file and get the DataFrame
df = process_warc_file(warc_file_url)
df
```

Ở đây, chúng ta thấy có 25.498 bản ghi tin tức trong tệp WARC đã chọn này, được thu thập vào khoảng 7:48 sáng ngày 23 tháng 9 năm 2024. Số lượng này lớn, nhưng đoạn mã mất chưa đến một phút để lặp qua toàn bộ các bản ghi. Việc xử lý đoạn mã trên cũng tương đối nhanh vì tất cả các thuộc tính của bản ghi (URL, ngày thu thập và độ dài nội dung) đều được lưu trong phần header của bản ghi.

Tuy nhiên, chúng ta vẫn chưa có bất kỳ thông tin nào về nội dung của các bài báo. Để làm việc với nội dung bài báo, chúng ta cần truy cập nội dung HTML từ phần thân của bản ghi tin tức, rồi dùng một thư viện phân tích cú pháp HTML để trích xuất các thành phần cụ thể từ HTML, chẳng hạn như tiêu đề bài báo, nội dung chính, tác giả và/hoặc ngày xuất bản. Việc xử lý HTML, đặc biệt là các tệp HTML lớn hoặc số lượng lớn tệp HTML, có thể tốn nhiều thời gian tùy thuộc vào độ phức tạp của HTML và các thao tác được thực hiện. Có những kỹ thuật nâng cao như xử lý song song hoặc tính toán phân tán để tối ưu hóa thêm thời gian xử lý. Tuy nhiên, để đơn giản, chúng ta sẽ chỉ giới hạn số bài báo cần xử lý ở vài nghìn bản ghi đầu tiên. Như vậy là đủ để hiểu cách trích xuất các thuộc tính của bản ghi tin tức từ các tệp WARC của News Crawl.

Bây giờ, hãy bổ sung thêm chức năng cho hàm `process_warc_file()` trong đoạn mã ở trên. Lần này, chúng ta sẽ triển khai một hàm có thể tái sử dụng, được thiết kế để trích xuất các bài báo liên quan đến Netflix từ một tệp WARC. Hàm này xử lý việc lọc ngôn ngữ, lọc từ khóa, trích xuất dữ liệu, xử lý lỗi và tổ chức dữ liệu, cung cấp một cách gọn gàng để xử lý các tệp WARC nhằm truy xuất thông tin cụ thể:

In \[ \]:
