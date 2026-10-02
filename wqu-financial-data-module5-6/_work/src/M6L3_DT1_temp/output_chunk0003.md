trong đó $a_{ik}$ là giá trị của tham số thứ $k$ tại vị trí $i$. Lưu ý (1) là trường hợp đặc biệt của (3), khi mọi hàm đều là hằng số trên toàn không gian. Như sẽ trình bày dưới đây, điểm $i$ tại đó các tham số được ước lượng hoàn toàn có thể khái quát hóa và không nhất thiết chỉ là những điểm có dữ liệu thu thập. Với GWR, ta dễ dàng tính ước lượng tham số cho các vị trí nằm giữa các điểm dữ liệu, nhờ đó có thể lập bản đồ chi tiết về sự biến thiên không gian của các mối quan hệ.

Mặc dù mô hình (3) có vẻ chỉ là phần mở rộng đơn giản của mô hình (1), việc hiệu chỉnh (3) gặp khó khăn vì các đại lượng chưa biết thực chất là những hàm ánh xạ không gian địa lý lên trục số thực, chứ không phải các số vô hướng như trong (1). Trong một tập dữ liệu điển hình, các mẫu của biến phụ thuộc và biến độc lập được lấy tại một tập điểm mẫu, và các tham số phải được ước lượng từ chúng. Trong mô hình truyền thống, các ước lượng này là hằng số với mọi $i$, nhưng ở phương trình (3) thì rõ ràng không phải vậy.

Với mô hình (3), một cách trực giác hợp lý là dựa các ước lượng $a_{ik}$ vào các quan sát tại những điểm mẫu gần $i$. Nếu giả định các $a_{ik}$ có mức độ trơn nhất định, ta có thể xấp xỉ hợp lý bằng cách xét quan hệ giữa các biến quan sát trong vùng gần $i$ về mặt địa lý.

Với phương pháp bình phương tối thiểu có trọng số (weighted least squares) để hiệu chỉnh mô hình hồi quy, các quan sát khác nhau có thể được nhấn mạnh khác nhau khi sinh ra tham số ước lượng. Trong bình phương tối thiểu thông thường, các ước lượng hệ số cực tiểu hóa tổng bình phương chênh lệch giữa $y_i$ dự đoán và thực tế. Trong bình phương tối thiểu có trọng số, một nhân tố trọng số $w_i$ được áp dụng cho mỗi bình phương chênh lệch trước khi cực tiểu hóa, sao cho sai số của một số dự đoán bị phạt nặng hơn các dự đoán khác. Nếu $\mathbf{W}$ là ma trận đường chéo của các $w_i$, thì các hệ số ước lượng thỏa mãn

$$\hat{a} = (X^T W X)^{-1} X^T W y \quad (4)$$

Trong GWR, việc đặt trọng số cho quan sát theo mức độ gần $i$ cho phép ước lượng $a_{ik}$ thỏa tiêu chí "các điểm hiệu chỉnh ở gần" nêu trên.

Lưu ý rằng trong các mô hình hồi quy có trọng số thông thường, giá trị $w_i$ là hằng số, nên chỉ cần một lần hiệu chỉnh để có tập ước lượng hệ số; nhưng ở đây $w$ thay đổi theo $i$, nên mỗi điểm trong vùng nghiên cứu có một lần hiệu chỉnh riêng. Khi đó, công thức ước lượng tham số có thể viết tổng quát hơn là

$$\hat{a}(i) = (X^T W(i) X)^{-1} X^T W(i) y \quad (5)$$

Phương pháp này có nét tương đồng với hồi quy kernel và ước lượng mật độ kernel (Parzen 1962; Cleveland 1979; Cleveland và Devlin 1988; Silverman 1986; Brunsdon 1991, 1995; Wand và Jones 1995, tr. 114-115). Trong hồi quy kernel, $y$ được mô hình hóa như một hàm phi tuyến của $x$ bằng hồi quy có trọng số, với trọng số của quan sát thứ $i$ phụ thuộc vào mức gần nhau giữa $x$ và $x_i$, với mỗi $i$, và bộ ước lượng là

$$\hat{f}(x) = (X^T W(x) X)^{-1} X^T W(x) y. \quad (6)$$

Khác biệt cốt yếu giữa hai phương pháp là: ở (6), hồi quy kernel, hệ thống trọng số phụ thuộc vào vị trí trong "không gian thuộc tính" (Openshaw 1993) của các biến độc lập, còn ở (5), GWR, nó phụ thuộc vào vị trí trong không gian địa lý. Đầu ra của (5) thường là tập ước lượng tham số cục bộ trong không gian $x$, nên có thể mô hình hóa các quan hệ phi tuyến và không đơn điệu mạnh giữa $y$ và $x$. Tuy nhiên, đầu ra điển hình của (6) là tập ước lượng tham số có thể vẽ lên bản đồ địa lý để biểu diễn tính không dừng hay sự "trôi" tham số.

### 3.1 Lựa chọn hàm trọng số không gian

Đến đây, ta mới chỉ nêu rằng $w(i)$ là một sơ đồ trọng số dựa trên mức gần của $i$ với các vị trí lấy mẫu xung quanh $i$, mà chưa nêu quan hệ tường minh. Phần này xét việc lựa chọn quan hệ đó. Trước hết, xét sơ đồ trọng số ngầm định của (2). Ở đây

$$w_{ij} = 1 \quad \forall i, j \quad (7)$$

trong đó $j$ là một điểm cụ thể trong không gian có dữ liệu quan sát và $i$ là điểm bất kỳ trong không gian cần ước lượng tham số. Nghĩa là trong mô hình toàn cục, mỗi quan sát có trọng số bằng một. Bước đầu hướng tới việc đặt trọng số theo vùng lân cận là loại khỏi quá trình hiệu chỉnh mô hình những quan sát cách vùng đó xa hơn một khoảng $d$ nào đó. Điều này tương đương đặt trọng số của chúng bằng không, cho hàm trọng số

$$w_{ij} = 1 \text{ nếu } d_{ij} < d; \quad w_{ij} = 0 \text{ trong trường hợp còn lại.} \quad (8)$$
