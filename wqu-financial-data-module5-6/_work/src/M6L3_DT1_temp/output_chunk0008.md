5.1 Độ biến thiên của các ước lượng hệ số

Mọi phương pháp phân tích không gian cho ra kết quả cục bộ có thể lập bản đồ đều chịu hiệu ứng biên, và GWR cũng không ngoại lệ. Chẳng hạn, với hàm nhân (kernel) "cắt đột ngột" như (8), các điểm gần biên vùng nghiên cứu thường có ít điểm mẫu trong bán kính d quanh điểm i, vì một phần vòng tròn lấy mẫu nằm ngoài vùng nghiên cứu. Do đó, việc hiệu chỉnh mô hình hồi quy tại những điểm này chịu sai số lấy mẫu lớn hơn. Các hàm nhân khác cũng gặp hiện tượng tương tự dù tinh tế hơn: tổng các trọng số đóng vai trò tương tự n và thay đổi theo vị trí từng điểm, nên những vùng chỉ gần vài điểm mẫu sẽ có sai số lấy mẫu lớn hơn. Có thể tính sai số chuẩn của các ước lượng hệ số trong mô hình GWR và lập bản đồ chúng để đánh giá độ tin cậy của từng ước lượng. Ở Hình 10, sai số chuẩn của hệ số Social Class I trong ví dụ trên được vẽ thành bản đồ; bản đồ cho thấy rõ sai số chuẩn không đồng đều và lớn hơn ở các phường (ward) thuộc phía nam vùng nghiên cứu.

Thách thức cho nghiên cứu tương lai là tìm cách trực quan hóa đồng thời các ước lượng hệ số và độ tin cậy của chúng, đo bằng sai số chuẩn này.

5.2 Kiểm định giả thuyết lưu động (Roving Hypothesis Tests)

Từ phần trên, với mỗi điểm có thể tính một ước lượng hệ số và một sai số chuẩn. Lấy ước lượng chia cho sai số chuẩn sẽ được một thống kê t giả (pseudo t). Trong hồi quy bình phương tối thiểu thông thường, thống kê này là cơ sở để kiểm định hệ số có khác 0 một cách có ý nghĩa hay không, tức kiểm định sự phụ thuộc giữa một biến độc lập và biến phụ thuộc. Với GWR, sẽ có một thống kê như vậy tại mọi điểm trong vùng nghiên cứu. Việc khái quát hóa kiểm định phụ thuộc này là hướng hấp dẫn, vì nó cho phép xác định khu vực nào biến này ảnh hưởng đến biến kia và khu vực nào không.

Rõ ràng cần cân nhắc kỹ vấn đề này, đặc biệt là những cạm bẫy của kiểm định ý nghĩa thống kê nhiều lần; tuy vậy, sẽ hữu ích nếu phát triển được một phương tiện, chính thức hoặc không chính thức, để khảo sát bản chất không gian của các mối phụ thuộc.

5.3 Biến thiên không gian của các hàm trọng số

Trong các phương pháp GWR đã đề xuất đến nay, hàm trọng số sau khi hiệu chỉnh được giả định là không đổi trên toàn vùng nghiên cứu. Tuy nhiên, đôi khi giả định này không hợp lý. Chẳng hạn trong các ứng dụng kinh tế, cơ cấu giá có thể phụ thuộc vào thị trường địa phương, nhưng phạm vi của khái niệm "địa phương" có thể khác nhau theo vùng: phạm vi địa lý của thị trường London có thể rộng hơn của Newcastle. Khi đó, cách tiếp cận GWR hợp lý hơn là dùng hàm trọng số biến thiên theo không gian, sao cho $p_i$ được ước lượng thay vì $\beta$. Dù phức tạp về tính toán, kết quả sẽ mang nhiều thông tin, không chỉ về bản chất mối quan hệ giữa các thuộc tính mà còn về cách các địa điểm tương tác với nhau.

5.4 Các mở rộng của GWR

Ý tưởng dùng dữ liệu có trọng số địa lý để tạo thống kê cục bộ không chỉ áp dụng cho kỹ thuật hồi quy. Nhiều kỹ thuật thống kê khác cho phép gán trọng số cho từng biến, và bất kỳ kỹ thuật nào trong số đó cũng có thể được điều chỉnh để thích ứng địa lý như hồi quy đã làm với GWR. Một ví dụ đơn giản: có thể tính độ lệch chuẩn của một tập quan sát với trọng số gán cho từng quan sát. Độ lệch chuẩn trọng số địa lý (GWSD) tại điểm i được định nghĩa bằng cách áp dụng sơ đồ trọng số kernel quanh i vào việc tính độ lệch chuẩn mẫu, tạo ra một bề mặt phủ vùng nghiên cứu thể hiện độ biến thiên cục bộ của biến được lập bản đồ. Cũng có thể tạo các thống kê tự tương quan không gian cục bộ theo cách này từ phiên bản GWR của mô hình Ord (Ord 1975). Về cơ bản, bất kỳ mô hình nào có thể gán trọng số đều có thể được gán trọng số địa lý.

6. KẾT LUẬN

Một cách diễn giải GWR là xem nó như một phép biến đổi rời rạc, chẳng hạn biến đổi Fourier. Biến đổi Fourier thường dùng với dữ liệu chuỗi thời gian để xem nội dung tần số; chuỗi được quan sát càng dài thì càng thấy được nhiều thành phần tần số thấp, nên số phần tử dữ liệu trong chuỗi Fourier tăng theo kích thước chuỗi thời gian. Do đó, thay vì dùng
