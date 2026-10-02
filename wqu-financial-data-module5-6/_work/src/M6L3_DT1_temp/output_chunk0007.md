Các phân bố này đáng chú ý. Chẳng hạn, các số hạng chặn (intercept) cho thấy một mô hình không gian rõ rệt, với giá trị cao hơn ở phía tây bắc và đông nam của vùng. Đây là những khu vực ít đô thị hóa hơn, và gợi ý rằng, với các điều kiện khác không đổi (ceteris paribus), tỷ lệ sở hữu ô tô cao hơn gắn với các khu vực nông thôn hơn. Điều này có thể liên quan đến mức độ giao thông công cộng thấp hơn và khả năng tiếp cận dịch vụ kém hơn ở các khu vực đó. Mối quan hệ giữa tỷ lệ sở hữu ô tô và tầng lớp xã hội ở Hình 8 cho thấy, với các điều kiện khác không đổi và cùng một tỷ lệ hộ gia đình thuộc tầng lớp xã hội I, tỷ lệ sở hữu ô tô cao hơn ở các phường hướng ra bờ biển và trong một dải gần rìa phía nam của vùng. Một cách giải thích khả dĩ là tỷ lệ sở hữu ô tô cao hơn ở các phường giàu hơn nhưng không được phục vụ tốt bởi hệ thống giao thông công cộng đường sắt nhẹ của vùng, vốn tập trung vào thành phố Newcastle, xấp xỉ ở trung tâm khu vực nghiên cứu. Phân bố của tham số thất nghiệp cho thấy mối quan hệ này ít âm hơn trong lõi đô thị hóa cao của khu vực nghiên cứu và trong một dải chạy từ tây nam sang đông bắc qua phần phía nam của vùng. Nguyên nhân chưa rõ ràng ngay lập tức. Một ứng dụng quan trọng của GWR là làm công cụ khám phá để điều tra thêm các câu hỏi và phát hiện mà nếu không có thể bị bỏ sót.

**HÌNH 7.** Bản đồ hệ số chặn (intercept) theo phường (các mức: dưới 75; 75-80; 80-85; 85-90; trên 90).

**HÌNH 8.** Bản đồ hệ số Tầng lớp xã hội I theo phường (các mức: dưới 0; 0,0-1,5; 1,5-3,0; 3,0-4,5; trên 4,5).

**HÌNH 9.** Bản đồ hệ số Thất nghiệp nam theo phường (các mức: dưới -1,7; -1,7 đến -1,6; -1,6 đến -1,5; -1,5 đến -1,4; trên -1,4).

**BẢNG 3**
Kiểm định ý nghĩa thống kê cho tính không dừng

| Biến | $s_i$ | giá trị p |
|------|------|------|
| Intercept (hệ số chặn) | 6.34 | 0.40 |
| Tầng lớp xã hội I | 1.66 | 0.04 |
| Thất nghiệp nam | 0.17 | 0.96 |

Trước khi bàn chi tiết hơn về các kết quả này, cần đánh giá ý nghĩa thống kê của các biến thiên không gian trong các ước lượng tham số, được xác định bằng cách tính các thống kê $s_i$ theo phương pháp Monte Carlo đã mô tả ở trên. Kết quả các kiểm định được trình bày ở Bảng 3.

Từ đó có thể thấy hệ số duy nhất biến thiên có ý nghĩa theo không gian là hệ số gắn với tỷ lệ tầng lớp xã hội I trong một phường. Điều này cũng được củng cố bởi việc độ lệch chuẩn của các ước lượng tham số biến thiên theo không gian của biến này (1,66) lớn hơn năm lần sai số chuẩn của ước lượng tham số toàn cục (0,33, như trong Bảng 2). Một cách diễn giải khả dĩ là: dù người thất nghiệp có thể coi trọng khả năng tiếp cận giao thông ở nông thôn hơn ở thành thị, thực tế cho thấy việc duy trì một chiếc ô tô có thể quá tốn kém, nên mức thất nghiệp không ảnh hưởng đến tỷ lệ sở hữu ô tô theo cách khác nhau giữa nông thôn và thành thị. Tuy nhiên, với những người khá giả hơn, sở hữu một hoặc nhiều ô tô thường là lựa chọn khả thi, và lựa chọn này được dùng nhiều hơn ở nông thôn, nơi giao thông công cộng thường kém hơn và có lẽ nhu cầu đi lại bằng ô tô lớn hơn. Rõ ràng có thể có những cách diễn giải khác cho phân tích này, nhưng GWR dường như là một phương tiện hữu ích để khám phá dữ liệu và nhận diện các mô hình địa lý tiềm ẩn, có thể được đưa vào một quy trình mô hình hóa chính thức sau đó.

**HÌNH 10.** Bản đồ sai số chuẩn của hệ số Tầng lớp xã hội I theo phường.

## 5. CÁC VẤN ĐỀ BỔ SUNG VỀ GWR

Bài báo này mô tả một kỹ thuật mới cho phân tích không gian, có tiềm năng làm lộ ra nhiều câu hỏi thú vị về tính bất ổn định theo không gian của các mối quan hệ. Ở đây chúng tôi thảo luận một số vấn đề có thể làm cơ sở cho các nghiên cứu tiếp theo về chủ đề này.
