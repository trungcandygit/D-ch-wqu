# **5. Dữ liệu vector**
Ở phần trước, chúng ta đã trình bày cách biểu diễn một vị trí bằng CRS. Cho đến nay, ta mới chỉ đề cập đến vị trí điểm, tức là một chấm trên hệ tọa độ vĩ độ - kinh độ. Ngoài hình dạng điểm, chúng ta còn có thể đưa vào các hình dạng đường và hình dạng đa giác cùng với CRS. Hình 3 minh họa ví dụ về hình dạng điểm, hình dạng đường và hình dạng đa giác.
<br>
**Hình 3. Các hình dạng điểm, đường và đa giác**
![vector data.jpg](images/img001.jpeg)
<br>
Ba hình dạng trên trong Hình 3 đều được cấu thành từ các điểm và các đường. Các điểm này được gọi là đỉnh (vertex). Vị trí của mỗi đỉnh có thể được biểu diễn bằng một cặp tọa độ vĩ độ - kinh độ. Nhờ có thông tin về hình dạng và thông tin về tọa độ của các đỉnh, chúng ta có thể xác định vị trí không gian địa lý của một đặc trưng trên hệ tọa độ vĩ độ - kinh độ. Trong dữ liệu vector, chúng ta lưu trữ thông tin hình dạng và thông tin tọa độ trong một biến gọi là **geometry**. Chính biến geometry này làm cho dữ liệu không gian địa lý khác biệt với dữ liệu dạng bảng truyền thống.
<br> Về định dạng dữ liệu không gian địa lý vector, có hai định dạng phổ biến: **GeoJSON** và **Shapefile**. Các tài liệu đọc bắt buộc sẽ giới thiệu rất ngắn gọn về hai định dạng dữ liệu này.
<br>
