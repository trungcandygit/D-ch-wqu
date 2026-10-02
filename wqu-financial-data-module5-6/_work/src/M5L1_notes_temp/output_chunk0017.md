-   **Dịch chuyển (Shifting):** chúng ta có thể dịch chuyển ma trận tương quan bằng cách cộng 1 vào mọi phần tử, bảo đảm mọi giá trị nằm trong khoảng từ 0 đến 2. Cách này có thể làm thay đổi đôi chút việc diễn giải các hệ số tải nhân tố (factor loadings), nhưng sẽ không ảnh hưởng đáng kể đến chiến lược đa dạng hóa tổng thể.
-   **Giá trị tuyệt đối (Absolute Values):** Một lựa chọn khác là dùng giá trị tuyệt đối của các hệ số tương quan, tập trung vào độ mạnh của các mối quan hệ thay vì chiều hướng của chúng. Cách này có thể hữu ích khi chúng ta muốn xác định các nhóm tài sản có mức đồng biến động mạnh, bất kể mối quan hệ đó là dương hay âm.

Tiếp theo, chúng ta áp dụng NMF để phân rã ma trận tương quan thành hai ma trận nhỏ hơn:

In \[4\]:

``` calibre12
# 3. Apply NMF
n_components = 5  # Number of factors to extract
model = NMF(n_components=n_components, init='random', random_state=0)
W = model.fit_transform(correlation_matrix)  # Factor loadings
H = model.components_  # Factor scores
```

Ở đây, chúng ta sử dụng hàm `NMF()` từ module `sklearn.decomposition` trong thư viện scikit-learn.

-   `n_components` chỉ định số lượng nhân tố (hoặc thành phần) cần trích xuất từ dữ liệu. Trong bối cảnh đa dạng hóa danh mục đầu tư, các nhân tố này đại diện cho những động lực tiềm ẩn đằng sau sự đồng biến động của các tài sản. Trong trường hợp cụ thể này, việc đặt n_components = 5 giả định rằng có khoảng 5 nhân tố tiềm ẩn chính chi phối sự đồng biến động của các tài sản trong danh mục. Đây là một điểm khởi đầu hợp lý, nhưng chúng ta nên thử nghiệm với các giá trị khác nhau để tìm ra số lượng tối ưu cho dữ liệu và mục tiêu đầu tư cụ thể của mình. Việc chọn đúng số lượng thành phần thường là một quá trình lặp, đòi hỏi chuyên môn về lĩnh vực, thử nghiệm và đánh giá mô hình.
-   `init='random'` chỉ định phương pháp khởi tạo cho các ma trận nhân tố ($W$ và $H$). `'random'` khởi tạo chúng bằng các giá trị không âm ngẫu nhiên.
-   `random_state=0` đặt hạt giống ngẫu nhiên (random seed) để bảo đảm khả năng tái lập kết quả.

Bước tiếp theo là phân tích các hệ số tải nhân tố ($W$) thu được từ phép phân rã NMF để hiểu các nhân tố tiềm ẩn chi phối sự đồng biến động của tài sản, và dùng thông tin này để đa dạng hóa danh mục đầu tư. Chúng ta có thể truy cập các hệ số tải nhân tố ($W$) thông qua biến `W` thu được ở bước này:

In \[5\]:

``` calibre12
# Convert W to a pandas DataFrame for easier analysis
W_df = pd.DataFrame(W, index=returns_df.columns)
W_df
```

Out\[5\]:

           0          1          2              3          4
  -------- ---------- ---------- -------------- ---------- ----------
  Ticker                                                   
  AAPL     0.464388   0.268745   2.308214e-01   0.780431   0.083933
  AMZN     0.667705   0.000000   1.201896e-01   0.276369   0.499711
  GOOG     0.458127   0.178795   1.562598e-01   0.803559   0.246556
  JPM      0.251893   0.864869   1.182338e-07   0.396028   0.208776
  META     0.003509   0.265379   2.902255e-01   0.680854   0.639626
  MSFT     0.550908   0.165173   1.144742e-01   0.780761   0.174299
  NVDA     0.406847   0.266952   3.439407e-01   0.672617   0.173926
  TSLA     0.310220   0.169135   6.282613e-01   0.296556   0.046811

Ma trận hệ số tải nhân tố ($W$) cho biết mỗi tài sản đóng góp bao nhiêu vào từng nhân tố.

-   Hàng: Đại diện cho các tài sản trong danh mục đầu tư của bạn.
-   Cột: Đại diện cho các nhân tố đã được trích xuất.
-   Giá trị: Cho biết độ mạnh của mối quan hệ giữa một tài sản và một nhân tố. Giá trị càng cao cho thấy tài sản đóng góp càng mạnh vào nhân tố đó.

Để diễn giải các nhân tố, chúng ta cần xem xét những tài sản có hệ số tải cao trên từng nhân tố. Với mỗi nhân tố, chúng ta cần xác định các tài sản có hệ số tải cao nhất. Những tài sản này gắn kết chặt chẽ nhất với nhân tố đó.

In \[6\]:

``` calibre12
# Identify top contributing assets for each factor
n_top_assets = 3
for factor_num in range(W_df.shape[1]):
    print(f"\nFactor {factor_num + 1}:")
    top_assets = W_df.iloc[:, factor_num].nlargest(n_top_assets)
    print(top_assets)
```

``` calibre12
Factor 1:
Ticker
AMZN    0.667705
MSFT    0.550908
AAPL    0.464388
Name: 0, dtype: float64

Factor 2:
Ticker
JPM     0.864869
AAPL    0.268745
NVDA    0.266952
Name: 1, dtype: float64

Factor 3:
Ticker
TSLA    0.628261
NVDA    0.343941
META    0.290226
Name: 2, dtype: float64

Factor 4:
Ticker
GOOG    0.803559
MSFT    0.780761
AAPL    0.780431
Name: 3, dtype: float64

Factor 5:
Ticker
META    0.639626
AMZN    0.499711
GOOG    0.246556
Name: 4, dtype: float64
```

Kết quả này cho thấy 3 tài sản đóng góp nhiều nhất cho mỗi nhân tố cùng các hệ số tải của chúng. Hãy nhớ rằng chúng ta có thể điều chỉnh `n_top_assets` và cách diễn giải các nhân tố dựa trên dữ liệu và mục tiêu đầu tư cụ thể của mình. Hiện tại, chúng ta giữ 3 tài sản đóng góp nhiều nhất. Giờ đây, chúng ta có thể dùng thông tin này để diễn giải các nhân tố và xây dựng chiến lược đa dạng hóa. Dựa trên các tài sản đóng góp nhiều nhất cho mỗi nhân tố, chúng ta có thể thử diễn giải ý nghĩa kinh tế hoặc tài chính của chúng:
