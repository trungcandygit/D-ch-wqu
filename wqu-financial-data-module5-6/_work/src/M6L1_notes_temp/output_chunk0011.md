# **7. Ứng dụng của dữ liệu không gian địa lý**
Trong phần này, chúng ta sẽ sử dụng Python để minh họa cách lấy dữ liệu không gian địa lý từ nguồn dữ liệu trực tuyến, làm sạch dữ liệu để sẵn sàng cho phân tích và trực quan hóa dữ liệu.
<br>
Chúng ta sẽ lấy đường đi của bão Irene dọc theo bờ biển phía đông Hoa Kỳ làm ví dụ. Vào cuối tháng 8 năm 2011, bão Irene đã gây thiệt hại nghiêm trọng cho khu vực này của Hoa Kỳ. Chẳng hạn, khu vực hạ Manhattan của thành phố New York bị mất điện trong một tuần do cơn bão.

Trong ứng dụng này, chúng ta sẽ lấy dữ liệu về đường đi và sức gió của cơn bão từ Trung tâm Bão Quốc gia (National Hurricane Center - NHC) thuộc Cơ quan Quản lý Khí quyển và Đại dương Quốc gia Hoa Kỳ (National Oceanic and Atmospheric Administration - NOAA). Chúng ta sẽ lấy dữ liệu và vẽ đường đi của cơn bão lên bản đồ. Trong phần minh họa này, chúng ta cũng sẽ trình bày cách chồng các thông tin khác nhau lên bản đồ. Chúng ta sẽ chồng ranh giới các bang của Hoa Kỳ lên bản đồ để cho thấy những bang nào chịu ảnh hưởng của cơn bão này.
<br>
Gói Python chính dùng để phân tích dữ liệu không gian địa lý là geopandas. Geopandas là phiên bản dữ liệu không gian địa lý của pandas. Gói này có thể xử lý nhiều loại dữ liệu không gian địa lý mà chúng ta đã đề cập ở các phần trước. Sau đó, chúng ta sẽ dùng gói folium để trực quan hóa đường đi của cơn bão. Chúng ta bắt đầu thôi.
