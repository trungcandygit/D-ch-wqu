### **1.1 Sơ đồ trọng số (sơ đồ "mượn dữ liệu")**

Sơ đồ trọng số trong GWR còn gọi là "sơ đồ mượn dữ liệu" (data-borrowing scheme). Tên gọi này nhấn mạnh rằng sự gần nhau về không gian, tức việc mượn các quan sát lân cận, là yếu tố then chốt để ước lượng các hệ số hồi quy cục bộ.

Trọng số của mỗi quan sát được cho bởi các hàm nhân không gian (kernel). Ba hàm nhân phổ biến nhất là:

* **Hàm nhân Gaussian**:

$$
w_{ij} = \exp \left ( -\frac{d^{2}_{ij}}{2b^{2}} \right )
$$

* **Hàm nhân Bisquare**:

$$
w_{ij} = \begin{cases}
     \left ( 1 - \left ( \frac{d_{ij}}{b} \right )^{2} \right )^2 & \text{ if } d_{ij} < b \\
     0 & \text{ otherwise }
\end{cases}
$$

* **Hàm nhân mũ (Exponential)**:

$$
w_{ij} = \exp \left ( -\frac{d_{ij}}{b} \right )
$$

trong đó

* $w_{ij}$ là trọng số của quan sát $j$ khi ước lượng mô hình tại quan sát $i$

* $d_{ij}$ là khoảng cách giữa $i$ và $j$

* $b$ là tham số băng thông (bandwidth), kiểm soát mức suy giảm của trọng số theo khoảng cách

**Khoảng cách**

Việc chọn thước đo khoảng cách giữa hai điểm tùy theo từng bài toán. Thông thường khoảng cách Euclid (đường thẳng giữa hai điểm) là đủ:

$$
d_{ij} = \sqrt{(u_{i} - u_{j})^{2} + (v_{i} - v_{j})^{2}}
$$

Nếu bài toán cần tính đến mạng lưới đường phố dạng ô vuông, có thể dùng khoảng cách Manhattan:

$$
d_{ij} = |u_{i} - u_{j}| + |v_{i} - v_{j}|
$$

Nếu vùng nghiên cứu rộng (độ cong Trái Đất trở nên đáng kể) và/hoặc địa hình đa dạng, đường trắc địa hay khoảng cách trắc địa có thể phù hợp hơn.

**Tham số băng thông**

Băng thông $b$ điều tiết sự đánh đổi giữa thiên lệch (bias) và phương sai thông qua mức độ gần của các điểm dùng trong các hồi quy cục bộ. Băng thông nhỏ nhấn mạnh biến thiên cục bộ nhưng chỉ giữ ít quan sát để ước lượng tham số. Băng thông lớn có thể giảm phương sai của hệ số nhưng có thể bỏ sót đặc điểm cục bộ do bị "làm trơn quá mức" khi đưa các điểm ở xa vào phân tích. Băng thông thường được chọn bằng kiểm định chéo (CV) hoặc tiêu chí thông tin Akaike (AIC).

Hãy minh họa hình dạng các hàm nhân trong thực tế. Trong ví dụ tiếp theo, ta dùng một "bản đồ" vuông gồm $100 \times 100 = 10,000$ quan sát. Các hình minh họa gồm cả ba hàm nhân và cho thấy khác biệt giữa khoảng cách Manhattan và Euclid. Để đơn giản, điểm quan tâm được cố định tại tâm bản đồ.

```python
# Figure 1
# Create a meshgrid
i_indices = np.arange(100)
j_indices = np.arange(100)
I, J = np.meshgrid(i_indices, j_indices, indexing='ij')

# Manhattan and Euclidean distances
manhattan_distance = np.abs(I - 50) + np.abs(J - 50)
euclidean_distance = np.sqrt((I - 50)**2 + (J - 50)**2)

# Kernel functions
def gaussian_kernel(D, b):
    return np.exp(- (D ** 2) / (2 * b ** 2))

def bisquare_kernel(D, b):
    return ((1 - (D / b) ** 2) ** 2) * (D < b) # Comment this line yourself

def exponential_kernel(D, b):
    return np.exp(- D / b)

# Plotting function
def plot_kernels(D, bandwidth):
    # Compute weights
    W_gaussian = gaussian_kernel(D, bandwidth)
    W_bisquare = bisquare_kernel(D, bandwidth)
    W_exponential = exponential_kernel(D, bandwidth)

    # Set up the plot
    fig, axs = plt.subplots(1, 3, figsize=(18, 6))

    # Gaussian Kernel
    sns.heatmap(W_gaussian, cmap='viridis', ax=axs[0])
    axs[0].set_title(f'Gaussian Kernel (b = {bandwidth})')

    # Bisquare Kernel
    sns.heatmap(W_bisquare, cmap='viridis', ax=axs[1])
    axs[1].set_title(f'Bisquare Kernel (b = {bandwidth})')

    # Exponential Kernel
    sns.heatmap(W_exponential, cmap='viridis', ax=axs[2])
    axs[2].set_title(f'Exponential Kernel (b = {bandwidth})')

    plt.tight_layout()
    plt.show()


# Plot the kernels using manhattan distance
for b in [10, 25, 50]:
    plot_kernels(D = manhattan_distance, bandwidth=b)
```

![](images/img001.png)

![](images/img002.png)

![](images/img003.png)

```python
# Figure 2
# Plot the kernels using Euclidean distance
for b in [10, 25, 50]:
    plot_kernels(D = euclidean_distance, bandwidth=b)
```

![](images/img004.png)

![](images/img005.png)

![](images/img006.png)

Ở Hình 1 và 2, ta thấy tác động của băng thông lên việc chọn vùng lân cận: băng thông tăng thì vùng dùng trong hồi quy cục bộ cũng rộng ra. Hình dạng vùng cũng khác nhau theo từng thước đo khoảng cách. Quan trọng hơn, các hình làm rõ sự khác biệt giữa các hàm nhân:

* Gaussian: suy giảm dần và mượt, bắt đầu từ điểm quan tâm

* Bisquare: cắt đột ngột, xác định rõ biên ảnh hưởng

* Exponential: suy giảm nhanh nhưng có đuôi dài phản ánh các tác động ở khoảng cách xa
