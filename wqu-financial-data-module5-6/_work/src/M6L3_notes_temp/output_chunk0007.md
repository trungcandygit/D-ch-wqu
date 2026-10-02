## **2.2 Trực quan hóa dữ liệu**
Bộ dữ liệu đã được cài đặt. Hãy xem bên trong có gì.

```python
# Check file lists from the installed dataset
berlin.get_file_list()
```

Output:
```
['/usr/local/lib/python3.10/dist-packages/libpysal/examples/berlin/prenzlauer.zip',
 '/usr/local/lib/python3.10/dist-packages/libpysal/examples/berlin/README.md',
 '/usr/local/lib/python3.10/dist-packages/libpysal/examples/berlin/prenz_bound.zip']
```

Trong danh sách tệp, "prenzlauer.zip" chứa dữ liệu cần phân tích, còn "prenz_bound.zip" dùng để vẽ ranh giới khu Prenz. Ta dùng hàm "get_path" của Pysal và hàm "read.file" của geopandas để chuyển hai tệp này thành geo-dataframe.

```python
# Convert two zipped files to geo dataframes
prenz = gp.read_file(berlin.get_path('prenzlauer.zip'))
prenz_bound = gp.read_file(berlin.get_path('prenz_bound.zip'))
```

Kiểm tra lại kiểu của hai tệp đã chuyển đổi.

```python
# Check the type of Prenz dataset
type(prenz)
```

Output:
```
geopandas.geodataframe.GeoDataFrame
```

```python
# Check the type of Prenz_bound dataset
type(prenz)
```

Output:
```
geopandas.geodataframe.GeoDataFrame
```

Cả hai đều là bộ dữ liệu địa lý. Xem nội dung của chúng.

```python
prenz.head()
```

Output:
```
   accommodat  review_sco  bedrooms  bathrooms  beds  price             X  \
0           2       100.0       1.0        1.0   1.0   35.0  1.494450e+06   
1           2        90.0       1.0        1.0   1.0   23.0  1.494354e+06   
2           2        93.0       1.0        1.0   1.0   38.0  1.494406e+06   
3           2       100.0       1.0        1.0   1.0   50.0  1.494271e+06   
4           2       100.0       1.0        1.0   1.0   80.0  1.493982e+06   

              Y                         geometry  
0  6.899036e+06  POINT (1494450.105 6899036.141)  
1  6.899121e+06  POINT (1494353.555 6899120.594)  
2  6.898809e+06  POINT (1494405.897 6898808.518)  
3  6.898655e+06  POINT (1494270.517 6898655.223)  
4  6.899397e+06  POINT (1493982.078 6899397.385)
```

```python
# Find out number of rental properties in the dataset
len(prenz)
```

Output:
```
2203
```

Đoạn mã trên hiển thị năm dòng đầu của dữ liệu Prenz và cho biết bộ dữ liệu có 2.203 căn nhà cho thuê. Mô tả các biến:

- **accommodat**: Số khách tối đa căn nhà có thể tiếp nhận
- **review_sco**: Điểm đánh giá tích lũy từ khách gần nhất đã lưu trú
- **bedrooms**: Số phòng ngủ
- **bathrooms**: Số phòng tắm
- **beds**: Số giường
- **price**: Giá thuê
- **X**: Vĩ độ của vị trí căn nhà
- **Y**: Kinh độ của vị trí căn nhà
- **geometry**: Vị trí địa lý của căn nhà

Bài trước đã nêu đặc điểm chính của bộ dữ liệu địa lý là có biến địa lý "geometry" cung cấp thông tin vị trí cho mỗi đặc trưng. Vì vị trí nhà cho thuê là dữ liệu điểm, ta chỉ có một cặp tọa độ gồm vĩ độ và kinh độ.
<br>
Tiếp theo, xem bộ dữ liệu địa lý prenz_bound.

```python
prenz_bound.head()
```

Output:
```
       neighbourh                                           geometry
0  Helmholtzplatz  POLYGON ((1496989.669 6899662.266, 1497008.148...
```

Như đã giải thích, prenz_bound cung cấp thông tin địa lý để vẽ ranh giới khu Prenz. Bộ dữ liệu này gồm tọa độ của nhiều điểm trên bản đồ; nối các điểm đó lại sẽ tạo thành một vùng (đa giác), nên prenz_bound chỉ có một dòng dữ liệu.
<br>
Trước khi phân tích, hãy vẽ vị trí các căn nhà cho thuê lên bản đồ.

```python
# Draw Rental Properties of Prenz on a map

# First, create a basemap
map = folium.Map(location=[52.542986,13.427986], zoom_start=13.5, control_scale=True)

# Then add the Prenz neighborhood borders to the map
folium.GeoJson(prenz_bound).add_to(map)

# Then add the Airbnb rental locations to the map. We will use a red dot to represent the location of one airbnb rental.
folium.GeoJson(prenz,
               marker=folium.Circle(radius=10, fill_color="red", fill_opacity=0.4, color="red", weight=1)).add_to(map)

map
```

Output:
```
<folium.folium.Map at 0x7e6897fc5000>
```
