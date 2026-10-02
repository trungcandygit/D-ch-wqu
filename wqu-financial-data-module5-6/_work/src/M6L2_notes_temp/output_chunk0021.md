Ta vừa thấy cách hiển thị một ảnh trên bản đồ. Để hiển thị tương tác các ảnh khác trong bộ sưu tập, ta tạo một bản đồ mới và thêm thanh trượt chuỗi thời gian (time series slider) lên bản đồ.

```python
image = landsat.toBands()

Map2 = geemap.Map()
Map2.addLayer(image,{},"Time series", False)
Map2.setCenter(lon,lat,8)
Map2.add_time_slider(landsat, parameters, labels = labels, time_interval=1)
Map2
```

Bản đồ mới có thanh trượt ở góc dưới bên phải. **Lưu ý khi dùng thanh trượt:** do một số vấn đề kỹ thuật, không dùng nút "Play the time slider".

Cạnh thanh trượt hiển thị nhãn của ảnh đầu tiên (ảnh #0). Di chuột tới chấm bên trái thanh trượt, chấm sẽ chuyển xanh; kéo chấm xanh dọc thanh để xem các ảnh khác. Nhãn cho biết thông tin ảnh đang hiển thị. Chẳng hạn, ảnh #3 có nhiều mây (độ phủ mây 67) nên phần lớn là màu trắng; ảnh #5 có độ phủ mây 6 nên thấy rõ bề mặt Trái Đất hơn.

##**5.7 Chọn và phóng to các ảnh không mây**
Sau khi xem toàn bộ ảnh lấy từ danh mục dữ liệu, ta chọn ảnh dùng cho phân tích: 3 ảnh không mây, gồm một ảnh trước đám cháy, một ảnh trong đám cháy và một ảnh sau đám cháy, đồng thời phóng to vùng quan tâm. Qua xem xét 8 ảnh, ảnh #0, #2 và #5 đáp ứng tiêu chí.

```python
#Select images we want and create a new image collection
img1 = ee.Image(landsat_list.get(0))
img2 = ee.Image(landsat_list.get(2))
img3 = ee.Image(landsat_list.get(5))

landsat_2 = ee.ImageCollection.fromImages([img1, img2, img3])
print('Total number:', landsat_2.size().getInfo())
```

Tiếp theo, tạo nhãn mới cho bộ ảnh mới và cập nhật tham số hiển thị.

```python
# Create a new list
landsat_list_2 = landsat_2.toList(landsat_2.size())

# Define a region of interest with a buffer zone
roi = poi.buffer(20000) # meters

# New visualization parameters
parameters_2 = {
                'min': 6000,
                'max': 16000,
                'dimensions': 800,
                'bands': ['SR_B4', 'SR_B3', 'SR_B2'],
                'region':roi
             }

#Create new labels for images
labels_2 = ["Image #"+str(i)+", "+str(ee.Image(landsat_list_2.get(i)).get('DATE_ACQUIRED').getInfo())+", Cloud cover:"+ str(ee.Image(landsat_list_2.get(i)).get('CLOUD_COVER').getInfo()) for i in range(landsat_2.size().getInfo())]
labels_2
```

```python
image2 = landsat_2.toBands()

Map3 = geemap.Map()
Map3.addLayer(image2,{},"Time series", False)
Map3.setCenter(lon,lat,8)
Map3.add_time_slider(landsat_2, parameters_2, labels = labels_2, time_interval=1)
Map3
```

Góc trên của ảnh giữa có thấy đám cháy, nhưng so sánh ảnh đầu với ảnh cuối vẫn khó nhận ra tác động của đám cháy. Ta dùng chỉ số NDVI để đánh giá thiệt hại rõ hơn.

##**5.8 Chỉ số thực vật khác biệt chuẩn hóa (NDVI)**
Chỉ số thực vật khác biệt chuẩn hóa (Normalized Difference Vegetation Index, NDVI) dùng để đánh giá sức khỏe thực vật, được tính từ ánh sáng phản xạ ở băng đỏ và băng cận hồng ngoại của ảnh vệ tinh. Chỉ số càng cao thì cây càng khỏe và xanh; chỉ số càng thấp thì cây càng úa và kém khỏe. Khái niệm được minh họa ở Hình 7.
<br>
<br>
**Hình 7. Minh họa NDVI**
![alt text](https://drive.google.com/uc?id=1sQF7SKkFZGfL-dSvY_EiubYPBd4_44km)
<br>
<br>
Ở phần sau, ta chuyển ba ảnh thành ảnh NDVI. Mỗi pixel có một giá trị NDVI: giá trị cao được tô xanh lá, giá trị thấp tô đỏ, giá trị trung gian tô vàng.

Trước hết, tính giá trị NDVI cho từng ảnh.

```python
#Calculate NDVI for each image
img_ndvi_1 = ee.Image(landsat_list_2.get(0)).normalizedDifference(['SR_B5', 'SR_B4'])
img_ndvi_2 = ee.Image(landsat_list_2.get(1)).normalizedDifference(['SR_B5', 'SR_B4'])
img_ndvi_3 = ee.Image(landsat_list_2.get(2)).normalizedDifference(['SR_B5', 'SR_B4'])

landsat_3 = ee.ImageCollection.fromImages([img_ndvi_1, img_ndvi_2, img_ndvi_3])
print('Total number:', landsat_3.size().getInfo())
```

Sau đó, thiết lập bảng màu mới và tham số hiển thị NDVI.

```python
# Create a new list
landsat_list_3 = landsat_3.toList(landsat_3.size())

# ndvi palette: red is low, green is high vegetation
palette = ['red', 'yellow', 'green']

ndvi_parameters = {'min': 0,
                   'max': 0.4,
                   'dimensions': 512,
                   'palette': palette,
                   'region': roi}

```

Bây giờ hiển thị các ảnh NDVI.

```python
image3 = landsat_3.toBands()

Map4 = geemap.Map()
Map4.addLayer(image3,{},"Time series", False)
Map4.setCenter(lon,lat,8)
Map4.add_time_slider(landsat_3, ndvi_parameters, labels = labels_2, time_interval=1)
Map4
```

Xét phần giữa phía trên của mỗi ảnh NDVI tương tác. Ảnh #0 (trước Camp Fire) có xen lẫn xanh, vàng và đỏ. Ảnh #1 (trong Camp Fire) có một dải đỏ lớn chạy từ phải sang trái rồi đi xuống; vùng đỏ là nơi lửa cháy. Ảnh #3 (sau Camp Fire) có vùng đỏ lớn ở phần giữa phía trên và một phần ở phía trên bên trái. Tóm lại, ảnh NDVI giúp nhận diện rõ hơn các thay đổi của thảm thực vật trên bề mặt Trái Đất.
