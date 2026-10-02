## **4.2. Ứng dụng Phương pháp 1: Lấy trung bình Tone cho từng tệp 15 phút và so sánh các điểm số trung bình**

Trong phần này, chúng ta sẽ sử dụng Phương pháp 1. Đoạn mã dưới đây tải dữ liệu GDELT cho các khoảng 15 phút từ 8 giờ sáng đến 11:45 tối ngày 23 tháng 9 năm 2024, lọc các tin tức liên quan đến Netflix, trích xuất thông tin cảm xúc (điểm Tone) và tính cảm xúc trung bình cho từng khoảng. Mã thực hiện việc này một cách hiệu quả bằng cách xử lý từng tệp dữ liệu trong bộ nhớ mà không lưu xuống đĩa, nên phù hợp để phân tích các tập dữ liệu lớn hơn:

```python
# Generate timestamps from 8 AM to 11:45 PM on September 23, 2024
start_time = datetime(2024, 9, 23, 8, 0, 0)
end_time = datetime(2024, 9, 23, 23, 45, 0)
timestamps = []
current_time = start_time
while current_time <= end_time:
    timestamps.append(current_time.strftime("%Y%m%d%H%M%S"))
    current_time += timedelta(minutes=15)

# Create a dictionary to store average Tone for each timestamp
avg_tones = {}

# Loop through timestamps, download, process, and discard each file
for timestamp in timestamps:
    url = f"http://data.gdeltproject.org/gdeltv2/{timestamp}.gkg.csv.zip"
    response = requests.get(url, stream=True)

    # Process the zip file in memory without extracting to disk
    with zipfile.ZipFile(io.BytesIO(response.content)) as zip_ref:
        for file_name in zip_ref.namelist():
            if file_name.endswith(".gkg.csv"):
                with zip_ref.open(file_name) as file:
                    # Specify the encoding as 'latin-1' to handle potential encoding issues
                    df = pd.read_csv(file, sep='\t', header=None,
                                     on_bad_lines='skip', # Skip lines with errors
                                     engine='python', # Use Python engine to handle large files
                                     encoding='latin-1') # Explicitly set encoding to 'latin-1'

                # Add column names (refer to GDELT documentation)
                gkg_columns = [
                    "GKGRECORDID", "DATE", "SourceCollectionIdentifier", "SourceCommonName",
                    "DocumentIdentifier", "Counts", "V2Counts", "Themes", "V2Themes",
                    "Locations", "V2Locations", "Persons", "V2Persons", "Organizations",
                    "V2Organizations", "V2Tone", "Dates", "GCAM", "SharingImage",
                    "RelatedImages", "SocialImageEmbeds", "SocialVideoEmbeds", "Quotations",
                    "AllNames", "Amounts", "TranslationInfo", "Extras"
                ]
                df.columns = gkg_columns

                # Filter for news related to Netflix
                netflix_news = df[df['Organizations'].str.contains("netflix", na=False)].copy()

                # Extract Tone components (similar to previous code)
                netflix_news[['Tone', 'Positive Score', 'Negative Score', 'Polarity', 'Activity', 'Self Direction', 'WordCount']] = netflix_news['V2Tone'].str.split(',', expand=True)
                numeric_columns = ['Tone', 'Positive Score', 'Negative Score', 'Polarity', 'Activity', 'Self Direction']
                netflix_news[numeric_columns] = netflix_news[numeric_columns].astype(float, errors='ignore').round(3) #ignore errors

                # Calculate and store average Tone
                avg_tone = netflix_news['Tone'].mean()
                avg_tones[timestamp] = avg_tone

    # File is automatically discarded when exiting the 'with' block

# Create a DataFrame from the avg_tones dictionary converting 'Timestamp' column to datetime objects
tone_df = pd.DataFrame(list(avg_tones.items()), columns=['Timestamp', 'AvgTone'])
tone_df['Timestamp'] = pd.to_datetime(tone_df['Timestamp'], format='%Y%m%d%H%M%S')
tone_df
```

Ở đây, trước hết chúng ta tạo một danh sách các mốc thời gian (timestamps) biểu diễn các khoảng 15 phút từ 4 giờ sáng đến 8 giờ tối ngày 23 tháng 9 năm 2024. Các mốc thời gian này sẽ được dùng để truy cập các tệp dữ liệu GDELT.

Sau đó, chúng ta lặp qua từng mốc thời gian để tải dữ liệu GDELT, xử lý dữ liệu, tính Tone trung bình và loại bỏ tệp. Mã này sử dụng xử lý trong bộ nhớ (in-memory processing). Xử lý trong bộ nhớ là yếu tố thiết yếu đối với phân tích dữ liệu GDELT nhờ khả năng xử lý hiệu quả khối lượng dữ liệu lớn, tăng tốc độ và khả năng phản hồi, cải thiện khả năng mở rộng, tối ưu việc sử dụng tài nguyên và mang lại sự linh hoạt cao hơn cho phân tích. Bằng cách xử lý từng tệp riêng lẻ và loại bỏ nó trước khi chuyển sang tệp kế tiếp, các phương pháp xử lý trong bộ nhớ cho phép các nhà nghiên cứu rút ra những hiểu biết có ý nghĩa từ dữ liệu GDELT mà không bị giới hạn bởi dung lượng lưu trữ hay các nút thắt hiệu năng.

Cuối cùng, chúng ta tạo một DataFrame pandas có tên `avg_tones`, chứa các mốc thời gian và điểm Tone trung bình tương ứng của Netflix. Điều này cho phép chúng ta tiếp tục phân tích và trực quan hóa diễn biến cảm xúc theo thời gian.
