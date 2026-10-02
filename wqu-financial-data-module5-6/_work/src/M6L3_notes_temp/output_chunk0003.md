# **1. Hồi quy trọng số địa lý (GWR)**

Hồi quy trọng số địa lý (GWR) là phần mở rộng của hồi quy tuyến tính truyền thống, có xét đến **tính không đồng nhất không gian (spatial heterogeneity)** trong quan hệ giữa các biến. Phương pháp này cho phép các hệ số thay đổi theo vị trí địa lý, nhờ đó nắm bắt được sự khác biệt về quan hệ giữa các điểm khác nhau trong không gian. Nói ngắn gọn, đây là hồi quy tính đến vị trí của biến phụ thuộc trên bản đồ và giả định quan hệ của nó với các biến độc lập hoàn toàn có thể khác với quan hệ tại một điểm khác trên bản đồ.

Để đạt được điều đó, khung GWR thực hiện số hồi quy tuyến tính bằng số điểm dữ liệu trên bản đồ. Mỗi hồi quy là một hồi quy tuyến tính có trọng số (WLS), trong đó trọng số đóng vai trò hệ số suy giảm: điểm càng xa nơi thực hiện WLS thì càng ít quan trọng.

Điều đầu tiên cần thấy là các hệ số của GWR không còn là hằng số trên toàn bản đồ. Ngược lại, mỗi điểm có một bộ hệ số riêng, cùng với hệ số chặn và sai số. Đây chính là điểm mạnh của khung này: cho phép hiểu thấu đáo cách quan hệ giữa các biến thay đổi theo không gian.

Trước hết ta viết hồi quy tuyến tính truyền thống. Trong bối cảnh GWR, hồi quy này được gọi là *"toàn cục (global)"* vì giả định các hệ số toàn cục (không đổi). Công thức hồi quy tuyến tính (LR):

**Hồi quy tuyến tính truyền thống**

$$
y_{i} = \beta_{0} + \sum_{k = 1}^{p} \beta_{i} \cdot x_{ik} + \epsilon_{i}
$$

trong đó

* $y$ là biến phụ thuộc
* $\beta_{i}$ là các hệ số (giả định không đổi trên mọi quan sát)
* $x_{ik}$ là $k$ biến độc lập và
* $\epsilon_{i}$ là các sai số

**Hồi quy trọng số địa lý**

Trong GWR, ta cho phép các hệ số thay đổi theo vị trí; do đó chúng trở thành hàm của không gian: $\beta(u, v)$, với $(u,v)$ là tọa độ.

$$
y_{i} = \beta_{0}(u_{i}, v_{i}) + \sum_{k=1}^{p}\beta_{k}(u_{i}, v_{i})x_{ik} + \epsilon{i}
$$

Ký hiệu trên che giấu một bất tiện quan trọng: mỗi điểm trên bản đồ chỉ có một (hoặc vài) quan sát, nên không thể ước lượng đáng tin cậy các hệ số tại từng điểm bằng ước lượng OLS. Để xử lý, ta dùng lược đồ trọng số không gian mã hóa ảnh hưởng của các điểm lên điểm đang xét. Đương nhiên, điểm ở xa được gán trọng số nhỏ hơn điểm ở gần. Kết quả là ma trận trọng số đường chéo $W$ chứa các giá trị từ 0 đến 1.

Việc dùng ma trận trọng số có nghĩa là với mỗi điểm trên bản đồ, ta ước lượng $\beta{i}$ bằng mọi quan sát sẵn có, được gán trọng số theo độ gần với điểm đang xét. Khi đó ước lượng hệ số được cho bởi:

$$
\hat \beta(u_{i}, v_{i}) = [X^{T} W(u_{i}, v_{i}) X]^{-1} X^{T} W(u_{i}, v_{i}) y
$$

Suy ra giá trị dự báo của mỗi quan sát là:

$$
\hat y_{i} = X_{i} [X^{T} W(u_{i}, v_{i}) X]^{-1} X^{T} W(u_{i}, v_{i}) y
$$

Nếu đặt:

$$
S_{i} = X_{i} [X^{T} W(u_{i}, v_{i}) X]^{-1} X^{T} W(u_{i}, v_{i}) \text{ and } C_{i} = [X^{T} W(u_{i}, v_{i}) X]^{-1} X^{T} W(u_{i}, v_{i})
$$

thì ma trận hiệp phương sai cục bộ $V_{i}$ của các ước lượng tham số là:

$$
V_{i} = C_{i} C^{T}_{i} \hat \sigma^{2}
$$

trong đó $\hat \sigma^{2}$ là độ lệch chuẩn ước lượng của số hạng sai số, được định nghĩa là:

$$
\hat \sigma^{2} = \frac{\sum (y_{i} - \hat y_{i})^{2}}{m - tr(S)}
$$

Bây giờ ta xem xét lược đồ trọng số.
