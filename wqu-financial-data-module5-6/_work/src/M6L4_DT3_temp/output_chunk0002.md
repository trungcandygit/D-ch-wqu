\* 1 mil bằng $10^{-3}$ inch.

2. Thử khớp các đa thức bậc n = 2, 3, ... với dữ liệu và áp dụng các thước đo ở bài 1(c), (d) và (e) cho kết quả.

3. Thử biến đổi tập dữ liệu bằng hàm logarit hoặc hàm lũy thừa rồi khớp hàm tuyến tính với các biến đã biến đổi. Áp dụng các thước đo ở bài 1(c), (d) và (e) cho kết quả và so sánh.

4. Với các kết quả trên, dữ liệu sẽ hữu ích đến mức nào khi lập luận cho quyết định "không phóng"? Nhận xét về các hệ quả đạo đức.

## LỜI GIẢI

Giả định sinh viên đã được học về các khía cạnh kỹ thuật của thảm họa.

Mục đích của các bài tập là giúp sinh viên nhạy bén với các vấn đề sau:

- Thế giới mang tính xác suất, không tất định, và không có gì là "chắc chắn".
- Dù dữ liệu có thể chưa đủ kết luận, khi tính mạng và tài sản bị đe dọa thì "không biết" phải được coi là "chúng ta đang có vấn đề".
- Hồi quy tuyến tính chỉ là một cách khớp hàm với dữ liệu và diễn giải kết quả về mặt thống kê.

1. (Đồ thị được cho bên dưới, phù hợp để làm slide chiếu.) (Phương trình ghi ba chữ số có nghĩa để đối chiếu kết quả.) Tại 29 °F, mức hao hụt vật liệu (độ tin cậy 95 %) nằm trong khoảng 25 đến 105 mil. Biến thiên cực lớn này cho thấy (xem thêm bên dưới) rủi ro hỏng gioăng rất cao. Dù ngoại suy luôn đáng ngờ, chính việc "không biết" một cách có ý nghĩa thống kê gioăng sẽ hoạt động ra sao ở 29 °F lẽ ra đã là lý do đủ để hủy phóng.

   a. Từ Hình 1, r = −0,56. Tra bảng giá trị tới hạn của hệ số tương quan, ở mức tin cậy 95 % (mức ý nghĩa 5 %), với 20 bậc tự do [22 cặp dữ liệu trừ hai tham số của phương trình tuyến tính], tìm được $r_c = 0{,}423$. Điều này có nghĩa là với xác suất 5 %, dữ liệu có hệ số tương quan lớn đến 0,423 vẫn có thể là không tương quan. Hay nói cách khác, $r_c$ là giá trị lớn nhất mà $r$ có thể đạt được chỉ do ngẫu nhiên (trong 95 % số lần) khi không tồn tại tương quan.

   b. Hệ số tương quan r được định nghĩa là: $r = S_{XY}/(S_X S_Y)$. Tử số là hiệp phương sai mẫu, mẫu số là tích của các độ lệch chuẩn mẫu của hai biến X, Y. Do đó giá trị r là thước đo mức độ liên hệ giữa hai biến. Ta có $0 \le |r| \le 1$, với $r = \pm 1$ là tương quan hoàn hảo và $r = 0$ là hoàn toàn không tương quan. Khi đó $r^2$ là thước đo phần biến thiên do quan hệ nhân quả, còn $1 - r^2$ là thước đo phần biến thiên do ngẫu nhiên. Xem thêm các nhận xét ngay sau đề bài ở trên.

   c. Xem Hình 1. Giải thích ý nghĩa của khoảng tin cậy. Một cách diễn giải: "Nếu thực hiện một số rất lớn phép thử, 95 % kết quả sẽ nằm trong khoảng giới hạn 95 % đã chỉ ra."

   d. Đối với cả kiểm định Chi-square và kiểm định K-S ở bài (e), giả thuyết kiểm định là: $H_0$: dữ liệu không tương quan.

      Ta chấp nhận giả thuyết nếu: $\chi_0^2 > \chi^2_{1-\alpha,\nu}$

      trong đó $1 - \alpha = C$ là mức tin cậy ($\alpha$ là mức ý nghĩa), và $\nu$ là số bậc tự do. Ở đây, $\nu = N - 1 - m$, với N là số quan sát của các biến (22 trong trường hợp này) và m là số tham số của phương trình được kiểm định (m = 2 với phương trình tuyến tính).

      Vế trái của bất đẳng thức là thống kê Chi-square quan sát được, tính từ dữ liệu. Vế phải là giá trị của biến Chi-square ứng với xác suất C, tức là giá trị của tích phân hàm mật độ đến biến ngẫu nhiên đó; các giá trị này đã được lập bảng.

      Với bài toán đang xét: $\chi^2_{0.95,19} = 30{,}1$ và $\chi_0^2 = 422$.

      Do đó, giả thuyết được chấp nhận: dữ liệu không tương quan tuyến tính.

   e. Với kiểm định Kolmogorov-Smirnov, ta dùng cùng giả thuyết: $H_0$: dữ liệu không tương quan.

      Ta bác bỏ giả thuyết nếu: $\sup\{|y_f - y_d|\} \ge d_\alpha(\nu)$

      Chỉ số dưới của y lần lượt là giá trị "khớp" (fitted) và giá trị "dữ liệu" (data). Như vậy, với một cặp dữ liệu $x_d, y_d$, giá trị của hàm khớp tại $x_d$ là $y_f$. Giá trị lớn nhất ("supremum") được so sánh với thống kê K-S ứng với mức ý nghĩa và số bậc tự do như ở bài (d).

      Ta có $\sup\{|y_f - y_d|\} = 45$ và $d_{0.05}(19) = 0{,}301$, nên không thể bác bỏ giả thuyết rằng dữ liệu không tương quan tuyến tính.
