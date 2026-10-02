## **7.5 Chuyển đổi sang Geodataframe**

Bây giờ chúng ta đã có một dataframe hoàn chỉnh cho đường đi của bão Irene. Để chuyển dataframe này thành dataframe không gian địa lý, chúng ta cần tạo một biến hình học (geometry), như đã giải thích ở phần trước. Chúng ta sẽ dùng một phương thức của geopandas để tạo biến này. Một trong các tham số trong đoạn mã dưới đây là "EPSG:4326", là mã định danh của hệ kinh độ - vĩ độ mà chúng ta đã quen thuộc. Hãy nhớ rằng có nhiều hệ tham chiếu tọa độ (CRS) khác nhau, nhưng chúng ta sẽ tiếp tục với hệ được sử dụng phổ biến này.

```python
# Tạo biến vị trí địa lý
geometry = gpd.points_from_xy(irene_2.Longitude, irene_2.Latitude, crs="EPSG:4326")
```

Bây giờ hãy chuyển pandas dataframe hiện tại thành geodataframe.

```python
# Chuyển dataframe hiện tại thành geodataframe với biến geometry
irene_3 = gpd.GeoDataFrame(
    irene_2, geometry=geometry, crs="EPSG:4326"
)
```

Tuyệt vời! Bây giờ chúng ta đã có một geodataframe. Hãy xem năm dòng đầu tiên của dataframe này.

```python
irene_3.head()
```

Output:
```
         Date_Time  Longitude  Latitude  Wind Speed            geometry
1  08/21/2011/0000      -59.0      15.0        45.0      POINT (-59 15)
2  08/21/2011/0600      -60.6      16.0        45.0    POINT (-60.6 16)
3  08/21/2011/1200      -62.2      16.8        45.0  POINT (-62.2 16.8)
4  08/21/2011/1800      -63.7      17.5        50.0  POINT (-63.7 17.5)
5  08/22/2011/0000      -65.0      17.9        60.0    POINT (-65 17.9)
```

Trong biến geometry của geodataframe ở trên, chúng ta có các hình dạng điểm và cặp tọa độ của chúng trên bản đồ. Hãy xác nhận kiểu của dataframe mới này.

```python
type(irene_3)
```

Output:
```
geopandas.geodataframe.GeoDataFrame
```

Và hãy kiểm tra biến geometry của chúng ta.

```python
type(irene_3['geometry'])
```

Output:
```
geopandas.geoseries.GeoSeries
```

Về cơ bản, geodataframe hoạt động giống như pandas dataframe. Do đó, chúng ta có thể áp dụng các phương thức và phân tích tương tự của pandas cho geopandas. Sau đây là một ví dụ.

```python
print("Mean wind speed of Hurricane Irene is {} knots and it can go up to {} knots maximum".format(round(irene_2['Wind Speed'].mean(),4),
                                                                                         irene_2['Wind Speed'].max())+".")
```

Output:
```
Mean wind speed of Hurricane Irene is 69.6154 knots and it can go up to 105.0 knots maximum.
```
