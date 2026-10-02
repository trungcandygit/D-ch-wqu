# M6L3_DT1

Chris Brunsdon, A. Stewart Fotheringham và Martin E. Charlton

Hồi quy trọng số địa lý (Geographically Weighted Regression): Một phương pháp khám phá tính không dừng theo không gian

**Tóm tắt.** Tính không dừng theo không gian (spatial nonstationarity) là tình trạng một mô hình "toàn cục" đơn giản không thể giải thích quan hệ giữa một số tập biến; bản chất của mô hình phải thay đổi theo không gian để phản ánh cấu trúc trong dữ liệu. Bài báo phát triển một kỹ thuật gọi là hồi quy trọng số địa lý (GWR), hiệu chỉnh một mô hình hồi quy bội cho phép các quan hệ khác nhau tồn tại tại các điểm khác nhau trong không gian. Kỹ thuật này dựa lỏng lẻo trên hồi quy hàm nhân (kernel). Bài báo giới thiệu phương pháp và thảo luận các vấn đề liên quan như việc chọn hàm trọng số không gian. Tiếp theo là một loạt kiểm định thống kê nhằm kiểm tra tính không dừng theo không gian. Bằng phương pháp Monte Carlo, các tác giả đề xuất kỹ thuật kiểm định giả thuyết không rằng dữ liệu có thể được mô tả bằng một mô hình toàn cục thay vì mô hình không dừng, cũng như kiểm định xem từng hệ số hồi quy có ổn định trên không gian địa lý hay không. Các kỹ thuật được minh họa trên bộ dữ liệu điều tra dân số Anh năm 1991, liên hệ tỷ lệ sở hữu ô tô với tầng lớp xã hội và tỷ lệ thất nghiệp ở nam giới. Bài báo kết thúc bằng việc bàn về các hướng mở rộng kỹ thuật.

## 1. GIỚI THIỆU

Một trong những mục tiêu chính của phân tích không gian là xác định bản chất các quan hệ giữa các biến, thường bằng cách tính thống kê hoặc ước lượng tham số từ quan sát tại các đơn vị không gian khác nhau trong vùng nghiên cứu. Các thống kê hay ước lượng tham số thu được thường được giả định là không đổi trên không gian, dù giả định này rất đáng ngờ trong nhiều trường hợp. Có thể quan hệ vốn khác nhau theo không gian, hoặc mô hình đo lường quan hệ bị đặc tả sai và điều đó biểu hiện thành các ước lượng tham số biến thiên theo không gian. Dù thế nào, một công cụ khám phá để mô tả và lập bản đồ các biến thiên không gian như vậy sẽ giúp hiểu rõ hơn các quan hệ đang nghiên cứu.

*Chú thích tác giả: Chris Brunsdon là giảng viên về phương pháp dựa trên máy tính tại Khoa Quy hoạch Đô thị và Nông thôn; A. Stewart Fotheringham là Giáo sư Địa lý định lượng; Martin Charlton là giảng viên về GIS tại Khoa Địa lý; tất cả thuộc Đại học Newcastle.*

*Geographical Analysis, Vol. 28, No. 4 (October 1996), Ohio State University Press. Nộp 6/7/95; bản sửa đổi được chấp nhận 2/16/96.*

Đã có một số kỹ thuật phục vụ mục đích này, nhưng các tác giả cho rằng phương pháp trong bài có nhiều ưu điểm quan trọng. Khung được biết đến nhiều nhất để đo "độ trôi" tham số là phương pháp mở rộng của Casetti (Casetti 1972; Casetti và Jones 1992), trong đó các tham số của mô hình toàn cục được làm thành hàm của không gian địa lý để đo xu hướng biến thiên tham số (xem Fotheringham và Pitts 1995; Eldridge và Jones 1991). Tuy quan trọng, đây chỉ là bài toán khớp xu hướng, ít hữu ích khi tham số biến thiên phức tạp trong không gian nghiên cứu. GWR cho phép ước lượng và lập bản đồ chính các tham số thực tại từng vị trí, thay vì khớp một mặt xu hướng lên chúng.

Phương pháp lọc thích nghi không gian (SAF) cũng từng được đề xuất để xử lý các quan hệ biến thiên theo không gian (Foster và Gorr 1986; Gorr và Olligschlaeger 1994). Tuy nhiên, cách này đưa quan hệ không gian vào theo kiểu ad hoc và cho ra các ước lượng tham số không thể kiểm định thống kê, nên phạm vi áp dụng hạn chế.

Hai phương pháp khác mô hình hóa biến thiên không gian của ước lượng tham số là mô hình hệ số ngẫu nhiên (Aitken 1996) và mô hình đa cấp (Goldstein 1987). Cả hai đều giả định các ước lượng tham số trong mô hình hồi quy là biến ngẫu nhiên: ở mô hình đa cấp, phân phối của chúng được giả định là Gauss, còn ở mô hình hệ số ngẫu nhiên, các tham số được mô hình hóa như phân phối hỗn hợp hữu hạn. Trong cả hai trường hợp, nhờ định lý Bayes có thể thu được ước lượng cho từng tham số, nhưng không có phụ thuộc không gian nào được giả định giữa các ước lượng, điều này không thực tế với mô hình các hiện tượng không gian. Dù các biến thể địa lý của mô hình đa cấp đã được áp dụng (Jones 1991), chúng phụ thuộc nhiều vào giả định về phân cấp các đơn vị không gian. Điều này có thể hợp lý nếu bản chất phân cấp được phản ánh tốt trong quá trình được mô hình hóa; còn trong các trường hợp khác, một mô hình liên kết không gian kiểu "suy giảm theo khoảng cách" như GWR có thể phù hợp hơn.

## 2. TÍNH KHÔNG DỪNG THEO KHÔNG GIAN TRONG BỐI CẢNH HỒI QUY

Mô hình thường dùng trong phân tích địa lý là hồi quy tuyến tính đơn giản (xem Dobson 1990, tr. 68-78). Trong kỹ thuật này, một biến (biến phụ thuộc) được mô hình hóa như hàm tuyến tính của một tập biến độc lập hay biến dự báo:

$$y_i = a_0 + \sum_{k=1}^{m} a_k x_{ik} + \varepsilon_i \tag{1}$$

trong đó $y_i$ là quan sát thứ $i$ của biến phụ thuộc, $x_{ik}$ là quan sát thứ $i$ của biến độc lập thứ $k$, các $\varepsilon_i$ là các sai số độc lập phân phối chuẩn với trung bình bằng 0, và mỗi $a_k$ phải được xác định từ mẫu gồm $n$ quan sát. Thông thường dùng phương pháp bình phương tối thiểu để ước lượng các $a_k$. Dùng ký hiệu ma trận, có thể viết:

$$\hat{\mathbf{a}} = (\mathbf{X}^T \mathbf{X})^{-1} \mathbf{X}^T \mathbf{y} \tag{2}$$
