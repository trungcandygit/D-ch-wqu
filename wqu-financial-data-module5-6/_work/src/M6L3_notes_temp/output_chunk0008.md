## **2.3 Chạy mô hình GWR**
Trong phần này, ta dùng dữ liệu Prenz để xây dựng mô hình định giá GWR bằng gói Python mgwr. Biến phụ thuộc là logarit của giá, nhằm hiệu chỉnh độ lệch (skewness) của dữ liệu giá. Ba biến độc lập là điểm đánh giá, số khách và số phòng tắm. Phương trình tuyến tính có dạng sau.
<br>
<br>
**<center>log(price) = hệ số chặn + điểm đánh giá + số khách + số phòng tắm</center>**
<br>
<br>
Ta cũng tạo một biến danh sách chứa thông tin của hai biến $u$ và $v$ đã mô tả ở phần 1.

```python
#Create variables for Berlin GWR pricing model
#Take the logarithm of the price variable to correct for skewing
b_y = np.log(prenz['price'].values.reshape((-1, 1)))
b_X = prenz[['review_sco','accommodat','bathrooms']].values
u = prenz['X']
v = prenz['Y']
b_coords = list(zip(u, v))
```

Sau khi tạo xong các biến cần cho mô hình, bước tiếp theo là xác định tham số băng thông (bandwidth).
<br>
Gói mgwr cung cấp hàm Sel_BW để tìm băng thông tối ưu. Ta dùng quy trình tối ưu hóa và tiêu chí khớp mô hình mặc định của Sel_BW. Mặc định là hàm nhân (kernel) bisquare và khoảng cách Euclid. Chọn kernel bisquare vì nó gán trọng số 0 cho các vị trí ở xa, trong khi kernel Gaussian và hàm mũ luôn gán trọng số khác 0 cho các vị trí ở xa.
<br>
Sau đó, Sel_BW dùng phương pháp tìm kiếm mặc định dựa trên AIC hiệu chỉnh (AICc) để tìm băng thông tối ưu. **AIC hiệu chỉnh (AICc)** là một dạng AIC đặc biệt dùng cho phân tích không gian. AICc có thành phần phạt đối với băng thông nhỏ, vì băng thông nhỏ làm mô hình phức tạp hơn.
<br>
Bây giờ ta tìm băng thông cho mô hình.

```python
#Find bandwidth parameter
selector = Sel_BW(b_coords, b_y, b_X)
bw = selector.search()
print(bw)
```

Output:
```
192.0
```

Có băng thông rồi, ta dùng nó làm đầu vào để xây dựng mô hình GWR.

```python
# Build a GWR model and print out model summary
gwr_model = GWR(b_coords, b_y, b_X, bw)
gwr_results = gwr_model.fit()
gwr_results.summary()
```

Kết quả hồi quy toàn cục trong bản tóm tắt trên là kết quả mô hình OLS cho dữ liệu Prenz. Nó được dùng làm mô hình chuẩn so sánh (benchmark) với mô hình GWR. Kết quả OLS gồm phần tóm tắt mô hình thông thường mà ta đã quen thuộc.
<br>
