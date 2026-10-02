## **3.1 Nhập dữ liệu GDELT GKG**

Trong bài học này, chúng ta tập trung sử dụng GDELT để phân tích dữ liệu. Trước khi chạy mã, chúng ta cần hiểu một vài chi tiết quan trọng:

-   Quy ước đặt tên: Dữ liệu GKG được cập nhật mỗi 15 phút và được lưu trong các tệp nén riêng biệt. Tên tệp tuân theo một mẫu cụ thể: `YYYYMMDDHHMMSS.gkg.csv.zip`, trong đó:

    -   YYYY: Năm
    -   MM: Tháng
    -   DD: Ngày
    -   HH: Giờ
    -   MM: Phút
    -   SS: Giây

-   Không có hàng tiêu đề: Các tệp GKG thường không có hàng tiêu đề chứa tên cột. Bạn cần tham khảo Sổ mã GDELT GKG (GDELT GKG Codebook) để xác định ý nghĩa của từng cột. GKG có 27 cột biểu diễn các khía cạnh khác nhau của các bài báo. Vui lòng tham khảo [GDELT 2.0 Global Knowledge Graph Codebook (V2.1)](http://data.gdeltproject.org/documentation/GDELT-Global_Knowledge_Graph_Codebook-V2.1.pdf) để biết hướng dẫn đầy đủ.

-   Dữ liệu phức tạp: Dữ liệu trong mỗi cột có thể phức tạp, với nhiều giá trị được phân tách bằng dấu phân cách (ví dụ: dấu chấm phẩy, dấu phẩy) hoặc thông tin được mã hóa.

Khi hiểu được cách tổ chức của dữ liệu GDELT GKG, chúng ta có thể truy cập, xử lý và phân tích thông tin một cách hiệu quả để rút ra những hiểu biết từ tin tức và sự kiện toàn cầu. Hãy nhớ tham khảo Sổ mã GDELT GKG để biết thông tin chi tiết về định dạng dữ liệu và mô tả các cột.

Bây giờ chúng ta hãy chạy mã. Đoạn mã sau tải xuống dữ liệu GDELT GKG được chỉ định - `20240930081500.gkg.csv.zip` - tương ứng với dữ liệu GDELT được ghi nhận lúc 8:15 sáng ngày 30 tháng 9 năm 2024. Sau đó chúng ta sẽ giải nén, đọc vào một DataFrame của pandas, thêm tên cột, và lọc DataFrame để chỉ giữ lại các hàng mà cột "Organizations" chứa từ "netflix":

In \[ \]:

``` calibre12
# URL for GDELT GKG data
url = "http://data.gdeltproject.org/gdeltv2/20240930081500.gkg.csv.zip"

# Download and save the zipped file
response = requests.get(url, stream=True)
with open("gdelt_data.csv.zip", "wb") as file:
  for chunk in response.iter_content(chunk_size=1024):
    if chunk:
      file.write(chunk)

# Unzip the file
!unzip gdelt_data.csv.zip -d gdelt_data

# Read the CSV file into a pandas DataFrame
file_path = "gdelt_data/20240930081500.gkg.csv"
df = pd.read_csv(file_path, sep='\t', header=None)

# Add column names (replace with actual column names from GDELT documentation)
gkg_columns = [
    "GKGRECORDID", "DATE", "SourceCollectionIdentifier", "SourceCommonName",
    "DocumentIdentifier", "Counts", "V2Counts", "Themes", "V2Themes",
    "Locations", "V2Locations", "Persons", "V2Persons", "Organizations",
    "V2Organizations", "V2Tone", "Dates", "GCAM", "SharingImage",
    "RelatedImages", "SocialImageEmbeds", "SocialVideoEmbeds", "Quotations",
    "AllNames", "Amounts", "TranslationInfo", "Extras"
]
df.columns = gkg_columns

# Filter for news related to netflix (adjust column and keyword as needed)
netflix_news = df[df['Organizations'].str.contains("netflix", na=False)].copy()
netflix_news
```

Trước hết, xin lưu ý rằng các tệp GDELT GKG 2.0 (Global Knowledge Graph) thường có dung lượng khoảng 15-25 MB. Điều này có nghĩa là chúng ta thực sự không cần lo lắng về việc lập kế hoạch cho quy trình thu thập và phân tích dữ liệu, vì kích thước này tương đối nhỏ và không gây ra vấn đề đáng kể về bộ nhớ.

Dữ liệu GDELT GKG 2.0 có 27 cột. Các cột chứa thông tin về:

-   Siêu dữ liệu bài báo: ID duy nhất, ngày/giờ, nguồn, URL.
-   Thực thể: Các đề cập đến chủ đề, địa điểm, con người và tổ chức, kèm số lần xuất hiện và mức độ liên quan.
-   Cảm xúc: Sắc thái tổng thể, điểm tích cực/tiêu cực, phân cực (polarity), v.v.
-   Sự kiện và bối cảnh: Các ngày được đề cập, phân tích nội dung, hình ảnh/video liên quan, trích dẫn.
-   Bổ sung: Tất cả tên gọi, số lượng, thông tin dịch thuật và siêu dữ liệu mở rộng.

Về cơ bản, các cột này cung cấp một bức tranh toàn diện về nội dung, bối cảnh và cảm xúc của một bài báo.

Xin lưu ý rằng chúng ta chỉ lọc một tập dữ liệu GDELT nhỏ, vì dữ liệu GKG của nó được cập nhật mỗi 15 phút. Các tập dữ liệu trong khung thời gian ngắn như vậy, hoặc một chuỗi các tập dữ liệu liên tiếp, có thể hữu ích trong một số tình huống kỹ thuật tài chính như phân tích cấu trúc vi mô thị trường, quản lý rủi ro thời gian thực, thực thi thuật toán và phân tích cảm xúc tin tức.

Những lưu ý quan trọng: Mặc dù các tập dữ liệu trong khung thời gian ngắn có thể hữu ích trong các tình huống này, cần nhận thức rõ những hạn chế của chúng. Kết quả thu được từ các tập dữ liệu khung thời gian ngắn có thể không vững chắc hoặc không có ý nghĩa thống kê bằng kết quả từ các tập dữ liệu khung thời gian dài hơn. Điều cần thiết là phải kiểm chứng kỹ lưỡng kết quả và bảo đảm khoảng thời gian được chọn phù hợp với ứng dụng cụ thể. Việc kết hợp dữ liệu từ nhiều nguồn và sử dụng các kỹ thuật thống kê mạnh có thể giúp nâng cao độ tin cậy của phân tích dựa trên các tập dữ liệu khung thời gian ngắn.
