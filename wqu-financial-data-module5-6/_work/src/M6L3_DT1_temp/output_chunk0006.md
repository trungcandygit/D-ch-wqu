Trong phần này, kỹ thuật GWR được áp dụng cho dữ liệu điều tra dân số năm 1991 cấp phường (ward) của hạt Tyne and Wear, Vương quốc Anh. Hạt này có trung tâm là thành phố Newcastle và sông Tyne ở đông bắc nước Anh. Các mối quan hệ được khảo sát là giữa tỷ lệ sở hữu ô tô (biến phụ thuộc) và hai biến độc lập kinh tế - xã hội: tỷ lệ thất nghiệp nam giới và tỷ lệ hộ gia đình thuộc tầng lớp xã hội I (một biến điều tra dân số của Anh đo tỷ lệ hộ có chủ hộ làm nghề chuyên môn hoặc quản lý, thường được dùng làm biến đại diện cho các hộ thu nhập cao). Chi tiết về các biến này có trong Bảng 1 và phân bố không gian của chúng được vẽ ở Hình 2-4. Phân bố không gian của số ô tô trên mỗi hộ cho thấy các phường dọc sông Tyne, về phía trung tâm vùng, nhìn chung có số ô tô trên mỗi hộ thấp hơn các khu ngoại ô ở ngoại vi. Tỷ lệ thất nghiệp nam giới cao tập trung ở các phường trung tâm của Newcastle (ở gần giữa vùng) và Sunderland (ở phía đông nam). Phân bố của biến tầng lớp xã hội ít rõ nét hơn nhưng phản ánh các khu giàu có ở phía bắc Newcastle và một số khu ven biển ở phía đông của vùng.

Giả thuyết đặt ra là khi tỷ lệ thất nghiệp nam giới trong một phường tăng lên thì tỷ lệ sở hữu ô tô giảm, ceteris paribus (các yếu tố khác không đổi), và khi tỷ lệ hộ thuộc tầng lớp xã hội I tăng lên thì tỷ lệ sở hữu ô tô tăng, ceteris paribus. Các giả thuyết này được ủng hộ mạnh bởi kết quả hồi quy OLS toàn cục ở Bảng 2, trong đó cả hai ước lượng tham số đều khác 0 có ý nghĩa ở mức 99 phần trăm và đều có dấu như kỳ vọng. Giá trị R bình phương của mô hình là 0,83, cho thấy độ khớp cao với dữ liệu. Tuy nhiên, kết quả này không cho biết tính ổn định của các mối quan hệ trên toàn vùng nghiên cứu, và để làm điều đó cần áp dụng GWR.

FIG.2. Bản đồ số ô tô trên một trăm hộ theo phường (các mức: dưới 40; 40-55; 55-65; 65-75; trên 75)

FIG.3. Bản đồ tỷ lệ thất nghiệp nam giới theo phường (các mức: dưới 10%; 10%-15%; 15%-20%; 20%-25%; trên 25%)

## 4.1 Ứng dụng GWR

Vì GWR là kỹ thuật dựa trên các điểm mẫu, các biến gắn với mỗi phường được giả định là mẫu lấy tại tâm (centroid) của phường đó, sao cho điểm i được xác định là tâm của phường i. Theo cách này, hiệu ứng suy giảm theo khoảng cách vẫn được áp dụng, với ảnh hưởng của mỗi phường lên ước lượng a_ik giảm dần khi khoảng cách từ tâm phường đến i tăng. Điều này cũng cung cấp một cách hữu ích để lập bản đồ kết quả phân tích: nếu a_ik được ước lượng cho từng tâm phường và giá trị đó được gán cho phường tương ứng thì có thể vẽ bản đồ choropleth về sự biến thiên của các hệ số. Các giá trị hệ số này cũng có thể làm cơ sở cho các kiểm định ý nghĩa đã mô tả ở trên.

FIG.4. Bản đồ tỷ lệ chủ hộ thuộc tầng lớp xã hội I theo phường (các mức: dưới 1%; 1%-2%; 2%-3%; 3%-4%; trên 4%)

**BẢNG 2**
Kết quả hồi quy OLS toàn cục

| Tham số | Giá trị ước lượng | Sai số chuẩn | Giá trị t |
|---|---|---|---|
| Hệ số chặn (Intercept) | 88,5 | 2,89 | 30,6 |
| Tầng lớp xã hội | 1,88 | 0,33 | 5,7 |
| Thất nghiệp | -1,83 | 0,11 | 16,6 |

R² = 0,83

Các mô hình GWR với hàm trọng số không gian mô tả ở (9) và nhiều giá trị β khác nhau được áp dụng cho dữ liệu mô tả ở Bảng 1 và Hình 2-4. Giá trị tổng bình phương sai số kiểm định chéo (CVSS) được vẽ theo hàm của β ở Hình 5. Từ đó thấy có một giá trị β tối ưu toàn cục quanh 0,303, được xác nhận bằng thuật toán tối ưu Golden Section. Tại giá trị này, điểm CV xấp xỉ một nửa so với trường hợp hồi quy toàn cục (β = 0). Sơ đồ trọng số quanh một phường ở trung tâm thành phố ứng với β tối ưu được minh họa ở Hình 6. Mẫu này cho thấy dữ liệu được gán trọng số theo không gian như thế nào để ước lượng tham số cho phường đó. Sơ đồ trọng số được đặt tâm tại từng phường để ước lượng các tham số biến thiên theo không gian.

FIG.5. Hiệu chỉnh hàm trọng số không gian

FIG.6. Bản đồ hàm trọng số theo phường (các mức: dưới 0,01; 0,01-0,03; 0,03-0,06; 0,06-0,30; 0,30-1,00)

Kết quả chính của GWR, tức sự biến thiên không gian của các ước lượng tham số, được thể hiện ở Hình 7-9 lần lượt cho hệ số chặn, tầng lớp xã hội và thất nghiệp. Sự biến thiên không gian của các mối quan hệ được bộc lộ bởi
