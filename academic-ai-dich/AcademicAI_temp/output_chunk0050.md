| Ví dụ thực tế: Làm sạch các phản hồi khảo sát khách hàng bằng Google DataPrep |
| |
| 1\. Thiết lập và nhập dữ liệu |
| |
| Truy cập Google DataPrep |
| |
| Trong Google Cloud Console, hãy điều hướng đến mục "Dataprep" (thường nằm trong "Big Data" hoặc "Data Analytics"). |
| |
| Nếu đây là lần đầu bạn sử dụng, hãy tạo một **luồng DataPrep (DataPrep flow)** hoặc dự án mới bằng cách làm theo hướng dẫn trên màn hình để kết nối với bucket Google Cloud Storage (GCS) của bạn. |
| |
| Tải lên hoặc kết nối với bộ dữ liệu của bạn |
| |
| Đặt các tệp thô của bạn (ví dụ: CSV, Excel hoặc JSON) vào một bucket Google Cloud Storage. |
| |
| Trong DataPrep, nhấp vào **"Import Datasets"**, sau đó chọn nguồn của bạn. Công cụ sẽ tạo bản xem trước và tự động lấy mẫu dữ liệu. |
| |
| Đánh giá dữ liệu ban đầu |
| |
| DataPrep tự động tạo một **tổng quan về chất lượng dữ liệu**, làm nổi bật các vấn đề như giá trị bị thiếu hoặc không khớp kiểu dữ liệu. |
| |
| Khám phá **hồ sơ (profile)** của từng cột (phân phối, giá trị nhỏ nhất/lớn nhất) để phát hiện các lỗi tiềm ẩn (ví dụ: ký hiệu bất thường, giá trị nằm ngoài phạm vi). |
| |
| 2\. Chuẩn hóa văn bản |
| |
| Xác định và chọn các cột văn bản tự do |
| |
| Nhận diện các cột như "Customer_Comments" hoặc "Feedback_Text." |
| |
| Nhấp vào tiêu đề cột để truy cập các tùy chọn biến đổi. |
| |
| Sử dụng các hàm "Text Cleanup" tích hợp sẵn |
| |
