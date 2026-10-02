## **7.4 Đảm bảo dữ liệu không gian địa lý chính xác**

Chúng ta cũng nhận thấy rằng các giá trị kinh độ trong bộ dữ liệu đều là số dương. Tuy nhiên, hướng của kinh độ là "W" (Tây). Dựa trên Hình 1 ở mục 3, các số liệu kinh độ lẽ ra phải là số âm. Do đó, chúng ta cần thêm dấu âm vào trước tất cả các giá trị của biến kinh độ để phản ánh đúng vị trí.

```python
# Adjust Longitude value to correctly reflect the geolocation
irene_1['Longitude'] = 0 - irene_1['Longitude']
```

```python
# Select the variables we are interest for next steps
irene_2 = irene_1[["Date_Time","Longitude","Latitude","Wind Speed"]]
```
