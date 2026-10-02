## **5.1 Tải các thư viện cần thiết cho phần minh họa này**

Chúng ta sẽ dùng Google Colab để truy cập Python API của GEE cho phần minh họa này.

```python
# pandas để xử lý dữ liệu dạng bảng và geopandas để xử lý dữ liệu không gian địa lý
import pandas as pd
import geopandas as gpd

# earth engine
import ee

# Bản đồ Google earth engine
import geemap

# cho phép hiển thị ảnh trong notebook
from IPython.display import Image
```

## **5.2 Truy cập Google Earth Engine**

Chúng ta sẽ dùng đoạn mã sau để truy cập API của Google Earth Engine. Hãy thay 'ee-si-learning-001' bằng ID dự án của riêng bạn. ID dự án được tạo khi bạn đăng ký Google Earth Engine. Trong quá trình xác thực, một hộp thoại sẽ xuất hiện và yêu cầu bạn chọn tài khoản Google đã dùng để đăng ký Google Earth Engine. Hãy nhấp vào tài khoản đó. Sau đó, sẽ có một số thông tin cùng với nút "continue" ở phía dưới bên phải của hộp thoại. Hãy nhấp vào nút "continue". Tiếp theo sẽ có một thông báo khác, và bạn cần đọc qua rồi nhấn nút "continue" để hoàn tất quá trình xác thực. Tổng cộng bạn sẽ phải nhấn hai nút continue.

```python
# Bắt đầu quá trình xác thực Google Earth Engine
ee.Authenticate()

# Khởi tạo Google Earth Engine với ID dự án bạn đã thiết lập ở bước tạo tài khoản
ee.Initialize(project='[REPLACE PROJECT ID]')

```

## **5.3 Thiết lập các tham số lọc**

Hãy xác định vị trí quan tâm bằng tọa độ vĩ độ và kinh độ, cùng với thời điểm bắt đầu và kết thúc của giai đoạn cần lấy ảnh vệ tinh. Chúng ta có thể dùng Google Maps để tìm tọa độ vĩ độ và kinh độ của Quận Butte ở California. Vì đám cháy bắt đầu vào ngày 8 tháng 11 năm 2018, chúng ta sẽ lấy ảnh từ tháng 10 năm 2018 đến tháng 12 năm 2018.

```python
# tọa độ của đám cháy Camp Fire
lat =  39.444012
lon = -121.833619

# điểm quan tâm dưới dạng ee.Geometry
poi = ee.Geometry.Point(lon,lat)

# ngày bắt đầu của khoảng thời gian cần lọc
start_date = '2018-10-01'

# ngày kết thúc
end_date = '2019-01-31'

```

## **5.4 Truy xuất ảnh từ Danh mục dữ liệu của Google Earth Engine**

Chúng ta sẽ truy xuất ảnh từ Landsat 8. Liên kết sau của Google Earth Engine cung cấp thông tin về bộ sưu tập ảnh này của Landsat 8. Trang này cũng cung cấp đoạn mã Python để lấy ảnh như được trình bày trong đoạn mã dưới đây.

https://developers.google.com/earth-engine/datasets/catalog/LANDSAT_LC08_C02_T1_L2

```python
# lấy dữ liệu vệ tinh
landsat = ee.ImageCollection("LANDSAT/LC08/C02/T1_L2")\
            .filterBounds(poi)\
            .filterDate(start_date,end_date)
```

## **5.5 Kiểm tra thông tin ảnh**

Bây giờ chúng ta đã tải xong các ảnh. Hãy xem xét một số thông tin.
Trước hết, hãy xem chúng ta nhận được bao nhiêu ảnh trong giai đoạn đã chọn. Độ phân giải thời gian của Landsat 8 là 16 ngày. Giai đoạn chúng ta chọn kéo dài 3 tháng. Do đó, chúng ta sẽ nhận được ít nhất 6 ảnh. ((3*30)/16 = 5,6)

```python
# Kiểm tra số ảnh nhận được trong giai đoạn đã chọn.
print('Total number:', landsat.size().getInfo())
```

Tiếp theo, chúng ta dùng ảnh đầu tiên vừa lấy để xem có thể thu được những thông tin gì.

```python
landsat.first().getInfo()
```

Một yếu tố then chốt của ảnh vệ tinh là mức độ ảnh bị mây che phủ. Ảnh có độ che phủ mây dày sẽ không cung cấp nhiều thông tin cho phân tích của chúng ta. Thông thường, chúng ta muốn độ che phủ mây của ảnh vào khoảng hoặc dưới 0,05. Hãy xem thang đo độ che phủ mây của ảnh đầu tiên.

```python
landsat.first().get('CLOUD_COVER').getInfo()
```

Chúng ta thấy độ che phủ mây của ảnh đầu tiên là 0,05, đây là mức tốt. Bây giờ hãy kiểm tra xem ảnh đầu tiên được chụp khi nào.

```python
landsat.first().get('DATE_ACQUIRED').getInfo()
```

Điều tiếp theo chúng ta có thể kiểm tra là tên các dải phổ (band) thu được.

```python
landsat.first().bandNames().getInfo()
```

Từ kết quả của đoạn mã trên, chúng ta thấy có nhiều hơn 11 dải phổ so với những gì đã học ở phần trước. Các tên dải phổ có 'ST_' đều thuộc về một dải phổ. Chúng là các dải phổ con của dải Aerosol.

## **5.6 Trực quan hóa ảnh**

Giờ đây chúng ta đã sẵn sàng xem các ảnh vừa lấy. Trước hết, hãy tạo nhãn cho các ảnh để dùng trong phần trực quan hóa tiếp theo.

```python
# đưa các ảnh vào một danh sách
landsat_list = landsat.toList(landsat.size());

#Tạo nhãn cho các ảnh
labels = ["Image #"+str(i)+", "+str(ee.Image(landsat_list.get(i)).get('DATE_ACQUIRED').getInfo())+", Cloud cover:"+ str(ee.Image(landsat_list.get(i)).get('CLOUD_COVER').getInfo()) for i in range(landsat.size().getInfo())]
labels
```

Từ các nhãn ảnh, chúng ta thấy có 8 ảnh, từ ảnh 0 đến ảnh 7. Chúng ta cũng thấy ngày chụp và chỉ số che phủ mây của từng ảnh.

Bây giờ hãy xác định một số tham số để hiển thị các ảnh. Chúng ta sẽ dùng các dải đỏ, lục và lam để tạo thành một ảnh giống ảnh chụp thông thường. Chúng ta cũng xác định kích thước điểm ảnh (pixel) sẽ hiển thị. Cuối cùng, chúng ta đặt độ sáng bằng cách gán các giá trị min và max. Việc gán giá trị cho min và max là một quá trình thử và sai. Bạn cần thử nghiệm các con số để có được độ sáng phù hợp cho ảnh.

```python
parameters = {
                'min': 7000,
                'max': 16000,
                'dimensions': 800, # kích thước cạnh hình vuông tính bằng pixel
                'bands': ['SR_B4', 'SR_B3', 'SR_B2'] # các dải phổ để hiển thị (r,g,b)
             }
```

Bây giờ hãy dùng geemap để hiển thị ảnh đầu tiên chồng lên bản đồ.

```python
Map = geemap.Map()

first_image = landsat.first()

Map.addLayer(first_image, parameters, "First_Image")
Map.setCenter(lon,lat,8)
Map
```

Từ bản đồ trên, bạn có thể thấy ảnh đầu tiên trong bộ sưu tập ảnh của chúng ta. Đây là ảnh chụp ngày 7 tháng 11 năm 2018. Bạn có thể di chuột lên bản đồ và kéo bản đồ đi các hướng. Bạn có thể phóng to hoặc thu nhỏ ảnh bằng cách nhấp vào biểu tượng "+" hoặc "-" ở phía bên trái của bản đồ.
