### **7.7 Trực quan hóa dữ liệu không gian địa lý**
Bây giờ chúng ta đã có tệp về đường đi của bão Irene và tệp về ranh giới các bang của Hoa Kỳ. Cả hai đều ở dạng geodataframe. Chúng ta có thể đưa toàn bộ thông tin vào một bản đồ để trực quan hóa. Chúng ta sẽ dùng gói folium để vẽ bản đồ, rồi thêm ranh giới các bang của Hoa Kỳ và đường đi của cơn bão vào bản đồ.

```python
pip install folium
```

```python
# Import a mapping library
import folium
```

Tuyệt vời! Bây giờ là lúc đưa thông tin lên bản đồ.

```python
# Vẽ đường đi của bão Irene và các thông tin khác lên bản đồ

# Đầu tiên, tạo bản đồ nền
map = folium.Map(location=[30,-102], zoom_start=4, control_scale=True)

# Sau đó thêm lớp đầu tiên là ranh giới các bang của Hoa Kỳ vào bản đồ
folium.GeoJson(us_state_shape_g).add_to(map)

# Tiếp theo thêm đường di chuyển của cơn bão vào bản đồ. Chúng ta dùng một chấm đỏ để biểu diễn vị trí của cơn bão tại một ngày/giờ cụ thể. Sau đó thêm một hộp thông tin và một hộp popup. Nếu di chuột đến chấm đỏ, bản đồ sẽ hiển thị ngày/giờ gắn với vị trí đó và tốc độ gió.
folium.GeoJson(irene_3,
               marker=folium.Circle(radius=2000, fill_color="red", fill_opacity=0.4, color="red", weight=5),
              tooltip=folium.GeoJsonTooltip(fields=["Date_Time","Wind Speed"]),
              popup=folium.GeoJsonPopup(fields=["Date_Time","Wind Speed"]),).add_to(map)

map
```

Output:
```
<folium.folium.Map at 0x73b5d8373dd0>
```

Xong rồi! Chúng ta vừa tạo một bản đồ chồng lớp ranh giới các bang của Hoa Kỳ và đường đi của bão Irene. Ở góc trên bên trái của bản đồ có một biểu tượng để phóng to và thu nhỏ. Ranh giới các bang của Hoa Kỳ được thể hiện bằng các đường liền màu xanh lam trên bản đồ. Đường đi của bão Irene được biểu diễn bằng một chuỗi các chấm đỏ. Khi di chuột qua một chấm đỏ, một hộp thông tin sẽ hiện ra, cung cấp thông tin về ngày/giờ và tốc độ gió. Với bản đồ này, chúng ta thấy bão Irene đi qua hầu hết các bang phía bắc dọc bờ biển phía đông Hoa Kỳ. Tốc độ gió đạt mạnh nhất khi cơn bão đi qua khu vực giữa Cộng hòa Dominica và Bahamas. Tốc độ gió giảm đáng kể sau khi bão đổ bộ vào đất liền.
