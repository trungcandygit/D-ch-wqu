# **3. Hệ tham chiếu tọa độ**
**Hệ tham chiếu tọa độ (coordinate reference system, CRS)** là một hệ tọa độ dùng để mô tả thông tin vị trí trên bề mặt Trái Đất (Awati, 2022). Có nhiều khung hệ thống CRS có thể sử dụng, nhưng cách tiếp cận phổ biến nhất là dùng vĩ độ và kinh độ để tạo thành một hệ lưới trên bề mặt Trái Đất.
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Các đường **vĩ độ (latitude)** là những đường ngang vắt qua Trái Đất, cho biết một vị trí cách xích đạo bao xa theo hướng bắc và nam. Đường vĩ độ 0 độ nằm tại xích đạo. Nó chia Trái Đất thành Bắc bán cầu phía trên xích đạo và Nam bán cầu phía dưới xích đạo.
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Các đường **kinh độ (longitude)** là những đường dọc vắt qua Trái Đất, cho biết một vị trí cách kinh tuyến gốc bao xa theo hướng tây và đông. Đường kinh độ 0 độ nằm tại kinh tuyến gốc. Nó chia Trái Đất thành Đông bán cầu và Tây bán cầu. Hình 1 minh họa hệ tọa độ này.
<br>
<br>
**Hình 1. Hệ tọa độ vĩ độ và kinh độ của Trái Đất**
![latitude and longitude.jpg](images/img002.jpeg)

_Nguồn: TechTarget_
<br>
Khi xác định một vị trí trên CRS, quy ước chung là ghi vĩ độ trước, rồi đến kinh độ, theo dạng (vĩ độ, kinh độ). Có hai cách biểu diễn thông tin vĩ độ-kinh độ. Cách thứ nhất là độ, phút, giây (DMS). Ví dụ, tọa độ của New York theo DMS là (40° 43' 50.1960'' N, 73° 56' 6.8712'' W). Ký hiệu ° biểu thị độ, ' biểu thị phút và '' biểu thị giây. Cách thứ hai là độ thập phân (DD). Tọa độ của New York theo DD là (40.730610, -73.935242).
<br>
DMS và DD có hai khác biệt chính. Khác biệt thứ nhất là DMS và DD dùng các ký hiệu khác nhau để biểu thị thông tin hướng của một vị trí. DMS dùng chữ cái để mô tả vị trí nằm ở bán cầu nào (N so với S; W so với E), còn DD dùng dấu + và - để mô tả bán cầu. Trong phương pháp DMS, tọa độ hướng của New York là (N, W). Trong phương pháp DD, tọa độ hướng của New York là (+,-). Chúng ta có thể dùng Hình 1 để hiểu cách phương pháp DD gán dấu +/-. Ở phần bên trái của hình, ta thấy nếu một vị trí nằm ở Bắc bán cầu thì dấu của vĩ độ là +; nếu vị trí nằm ở phía nam thì dấu của vĩ độ là -. Khái niệm này cũng áp dụng tương tự cho kinh độ.
<br>
Khác biệt thứ hai là DMS tính bằng độ, phút, giây còn DD tính bằng số thập phân. Chúng ta có thể dễ dàng chuyển đổi giữa hai phương pháp. Để chuyển từ DMS sang DD, trước tiên ta giữ nguyên số độ. Sau đó, ta chia số phút cho 60 và chia số giây cho 3600. Tiếp theo, ta cộng kết quả của hai phép chia này rồi cộng vào số độ. Con số cuối cùng chính là giá trị theo DD. Đôi khi, bán cầu của dữ liệu được chỉ ra bởi tên biến hoặc tiêu đề cột, và giá trị của các điểm dữ liệu trong bảng đều là số dương. Trong trường hợp này, chúng ta cần điều chỉnh thủ công giá trị của các điểm dữ liệu để biểu diễn đúng vị trí bán cầu theo phương pháp DD.
<br>
Trong Python, chúng ta sẽ dùng phương pháp DD để biểu diễn thông tin tọa độ. Bạn có thể dễ dàng tìm tọa độ DD của một địa điểm trên Google Maps.
<br>
