## **2.5. Minh họa tính các tham số GWR bằng đại số tuyến tính**
Phần này trình bày cách dùng đại số tuyến tính để thu được các ước lượng tham số của GWR.
Trước hết, ta nhắc lại bộ ước lượng GWR cho các ước lượng tham số cục bộ tại vị trí $i$.
<br>
<br>
$$\hat{\beta}(i)=\left[ X'W(i)X \right]^{-1}X'W(i)y$$
<br>
<br>
Ta dùng công thức trên để tính ước lượng tham số cho vị trí 1 (i bằng 0 vì Python đánh chỉ số từ 0). Vì ma trận trọng số được suy ra từ phương pháp tìm kiếm tối ưu, ta lấy trực tiếp từ kết quả mô hình để làm đầu vào.

```python
#Pull the information of weight matrix of location 1 from GWR model result
W_1 = gwr_results.W[0]
W_matrix = np.diag(W_1)
```

Tiếp theo, tạo ma trận $X$: ma trận có các biến độc lập làm cột, kèm một cột toàn số 1 để ước lượng hệ số chặn.

```python
# Create X matrix with additional column of all 1s.
b_X_1 = np.hstack([np.ones((b_X.shape[0], 1)), b_X])
```

Tính trước ma trận nghịch đảo $\left[ X'W(i)X \right]^{-1}$ trong công thức.

```python
inverse_matrix = np.linalg.inv(b_X_1.T@W_matrix@b_X_1)
```

Tiếp theo, tính ước lượng tham số cho vị trí 1.

```python
beta_1 = inverse_matrix@b_X_1.T@W_matrix@b_y
beta_1
```

Output:
```
array([[ 3.30479996e+00],
       [ 1.61014298e-03],
       [ 2.06243405e-01],
       [-2.67321919e-02]])
```

So sánh với kết quả của mô hình GWR.

```python
gwr_results.params[0]
```

Output:
```
array([ 3.30479996e+00,  1.61014298e-03,  2.06243405e-01, -2.67321919e-02])
```

Hai kết quả trùng khớp, cho thấy đại số tuyến tính được áp dụng thế nào vào việc tính mô hình GWR.
