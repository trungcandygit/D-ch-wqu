## **2.4 Xem xét kết quả mô hình**
Khối tiếp theo của phần tóm tắt là kết quả mô hình GWR, trước hết cho biết hàm nhân (kernel) bisquare và băng thông (bandwidth) 192 được chọn cho mô hình này, cùng nhiều thông tin chẩn đoán mô hình. Chẳng hạn, R<sup>2</sup> hiệu chỉnh của mô hình OLS là 0,271 trong khi của mô hình GWR là 0,391; như vậy GWR phù hợp dữ liệu tốt hơn OLS.

Tiếp theo là kết quả ước lượng tham số. Trong mô hình GWR, mỗi vị trí có một bộ ước lượng tham số cho các biến độc lập; ở đây mỗi biến độc lập có 2.203 ước lượng tham số. Trong phần tóm tắt trên, X0 là hệ số chặn, X1 là điểm đánh giá, X2 là số khách được phục vụ, X3 là số phòng tắm. Vì vậy phần tóm tắt cho biết trung bình, độ lệch chuẩn, giá trị nhỏ nhất, trung vị và lớn nhất của các ước lượng tham số của từng biến độc lập. Để xem chi tiết, ta dùng mã Python sau, hiển thị bộ tham số ước lượng cho từng vị trí; dưới đây là năm vị trí đầu tiên.

```python
# Show estimated parameters for
gwr_results.params[0:5]
```

Output:
```
array([[ 3.30479996e+00,  1.61014298e-03,  2.06243405e-01,
        -2.67321919e-02],
       [ 3.43635569e+00, -4.51930353e-04,  1.95844944e-01,
         5.37474550e-02],
       [ 3.27912291e+00,  2.92768647e-03,  2.12363255e-01,
        -8.10919052e-02],
       [ 2.88779932e+00,  5.06056110e-03,  2.45744327e-01,
        4.65164479e-02],
       [ 2.89309002e+00,  3.06784769e-03,  1.67282256e-01,
         3.42487452e-01]])
```

GWR xây dựng một hồi quy cho mỗi vị trí nên mỗi vị trí cũng có R<sup>2</sup> riêng. Dưới đây là R<sup>2</sup> của 10 vị trí đầu tiên.

```python
gwr_results.localR2[0:10]
```

Output:
```
array([[0.39583113],
       [0.41660429],
       [0.35650484],
       [0.43641022],
       [0.44784271],
       [0.41771337],
       [0.42162229],
       [0.41387561],
       [0.36649332],
       [0.46269692]])
```

Ta cũng có thể vẽ biểu đồ R<sup>2</sup> của mọi vị trí.

```python
#Show local model fit (R squared) for all locations
prenz['R2'] = gwr_results.localR2
prenz.plot('R2', legend = True)
ax = plt.gca()
ax.get_xaxis().set_visible(False)
ax.get_yaxis().set_visible(False)
plt.title("Local Model Fit")
plt.show()
```

![](images/img007.png)

Từ biểu đồ "Local Model Fit", hai vùng sáng bên trái có nhiều vị trí nhất với R<sup>2</sup> trên 0,5. Tuy nhiên, ở khu vực lệch trái so với trung tâm của khu phố, nhiều vị trí có R<sup>2</sup> dưới 0,2.
