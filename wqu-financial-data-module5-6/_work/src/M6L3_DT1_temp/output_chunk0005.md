Do đó, việc vẽ đồ thị điểm CV theo tham số cần thiết của hàm trọng số được chọn sẽ giúp định hướng chọn giá trị phù hợp cho tham số đó. Nếu muốn tự động hóa quy trình này, có thể cực đại hóa điểm CV bằng một kỹ thuật tối ưu hóa như tìm kiếm theo tỉ lệ vàng (Golden Section search; Greig 1980).

### 3.3 Kiểm định tính không dừng theo không gian

Cho đến đây, các kỹ thuật của GWR chủ yếu mang tính mô tả. Tuy nhiên, có hai câu hỏi hữu ích có thể được xem xét:

- Mô hình GWR có mô tả dữ liệu tốt hơn một cách có ý nghĩa thống kê so với mô hình hồi quy toàn cục hay không?
- Tập các tham số $a_{ik}$ có biến thiên không gian đáng kể hay không?

Ở câu hỏi thứ nhất, toàn bộ mô hình hồi quy thay đổi theo địa lý được đem ra kiểm định. Ở câu hỏi thứ hai, ta có thể kiểm định xem tốc độ thay đổi của một biến cụ thể có biến động đáng kể trên toàn vùng nghiên cứu hay không. Để trả lời cả hai câu hỏi, cần định nghĩa các thống kê mô tả cho mẫu. Trước hết, thống kê này mô tả mức độ "toàn cục" của mô hình. Một lựa chọn khả dĩ là tham số trọng số $\beta$ thu được từ thủ tục CV, dùng để đánh giá mức khác biệt giữa mô hình GWR và mô hình toàn cục. Như đã nêu, giá trị $\beta$ trong hàm mũ tiến về 0 đối với mô hình toàn cục, và độ lệch của ước lượng $\hat{\beta}$ khỏi 0 cho biết mức độ khác biệt giữa mô hình cục bộ và mô hình toàn cục.

Đối với giả thuyết thứ hai, chính độ biến thiên của $a_k$ có thể dùng để mô tả mức độ hợp lý của một hệ số không đổi. Nói chung, đây có thể xem như một thước đo phương sai. Với một $k$ cho trước, giả sử $\hat{a}_{ik}$ là ước lượng GWR của $a_{ik}$. Khi đó, một ước lượng khả dĩ của độ biến thiên là "độ gồ ghề" (roughness) của $a_k$, được định nghĩa là

(công thức gốc bị vỡ khi trích PDF; các thành phần: $\int_G (\cdot)^2\,dx\,dy$ với $G$ là vùng nghiên cứu)

trong đó $G$ là vùng nghiên cứu. Đại lượng này có thể được ước lượng nếu xây dựng được một xấp xỉ dạng lưới cho $a_{ik}$. Tuy nhiên, thống kê này khá cồng kềnh khi tính toán, nên ở đây đề xuất một phương án thay thế. Giả sử với mỗi điểm trong $n$ điểm mẫu $i$, ta tính được ước lượng tham số $\hat{a}_{ik}$. Khi đó ta có $n$ ước lượng của hệ số đang nghiên cứu. Một cách tiếp cận là tính độ lệch chuẩn của các giá trị này, cho ra ước lượng mẫu của (13). Thống kê này được gọi là $s_k$.

Như vậy đã có hai loại thống kê, mỗi loại tương ứng với một câu hỏi nêu trên. Bước tiếp theo là xác định phân phối mẫu của chúng dưới giả thuyết không rằng mô hình (1) đúng. Dù trong tương lai sẽ xem xét các tính chất lý thuyết của các phân phối này, hiện tại sẽ áp dụng phương pháp Monte Carlo. Dưới giả thuyết không, mọi hoán vị của các cặp $(x_i, y_i)$ giữa các điểm lấy mẫu địa lý $i$ đều có khả năng xảy ra như nhau. Do đó, các giá trị quan sát được của $\beta$ hoặc $s_k$ có thể được so sánh với các phân phối ngẫu nhiên hóa này để thực hiện kiểm định ý nghĩa thống kê. Với phương pháp Monte Carlo, việc chọn $N$ hoán vị ngẫu nhiên của các cặp $(x_i, y_i)$ giữa các điểm $i$ và tính $\hat{\beta}$ hoặc $s_k$ cũng cho một kiểm định ý nghĩa khi so với các thống kê quan sát được.

**Bảng 1.** Các biến dùng trong ví dụ GWR

| Biến | Tử số | Mẫu số | Phụ thuộc (D) hoặc độc lập (I) |
|------|-------|--------|------|
| Thất nghiệp nam | Dân số nam đang tìm việc | Dân số hoạt động kinh tế | I |
| Tầng lớp xã hội I | Số hộ có chủ hộ thuộc tầng lớp xã hội I | Tổng số hộ | I |
| Số xe trên mỗi hộ | Số xe | Số hộ (đơn vị trăm) | D |

Khi thực hiện kiểm định cho $\hat{\beta}$, lưu ý rằng chi phí tính toán có thể rất lớn: với mỗi hoán vị, phải tìm $\beta$ tối ưu theo CV bằng tìm kiếm theo tỉ lệ vàng. Dù phương pháp này tốn thời gian, việc tính từng thống kê $s_k$ cho mỗi hoán vị lại khá đơn giản sau khi $\beta$ đã được hiệu chỉnh. Một cách tiết kiệm thời gian, nếu không cần kiểm định ý nghĩa của $\beta$, là tối ưu $\hat{\beta}$ từ dữ liệu quan sát rồi dùng giá trị này để thực hiện các ước lượng $s_k$ còn lại dựa trên hoán vị.

## 4. NGHIÊN CỨU TÌNH HUỐNG: SỞ HỮU Ô TÔ TẠI TYNE AND WEAR
