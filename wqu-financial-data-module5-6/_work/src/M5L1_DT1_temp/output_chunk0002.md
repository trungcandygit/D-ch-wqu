# Học các bộ phận của vật thể bằng phân rã ma trận không âm

Daniel D. Lee & H. Sebastian Seung

Bell Laboratories, Lucent Technologies, Murray Hill, New Jersey, Hoa Kỳ; Khoa Khoa học Não và Nhận thức, Massachusetts Institute of Technology, Cambridge, Massachusetts, Hoa Kỳ.

## Tóm tắt

Nhận thức về toàn thể có dựa trên nhận thức về các bộ phận của nó hay không? Đã có bằng chứng tâm lý học và sinh lý học về các biểu diễn dựa trên bộ phận trong não, và một số lý thuyết tính toán về nhận dạng vật thể cũng dựa vào các biểu diễn như vậy. Tuy nhiên, người ta biết rất ít về việc não hay máy tính có thể học các bộ phận của vật thể như thế nào. Bài báo trình bày một thuật toán phân rã ma trận không âm có khả năng học các bộ phận của khuôn mặt và các đặc trưng ngữ nghĩa của văn bản. Điều này trái với các phương pháp khác như phân tích thành phần chính (PCA) và lượng tử hóa vector (VQ), vốn học các biểu diễn toàn thể chứ không phải biểu diễn dựa trên bộ phận. Phân rã ma trận không âm khác biệt ở chỗ sử dụng các ràng buộc không âm. Các ràng buộc này dẫn đến biểu diễn dựa trên bộ phận vì chỉ cho phép các tổ hợp cộng, không cho phép tổ hợp trừ. Khi được cài đặt dưới dạng mạng nơ-ron, các biểu diễn dựa trên bộ phận xuất hiện nhờ hai tính chất: tần số phát xung của nơ-ron không bao giờ âm và cường độ synap không đổi dấu.

## Áp dụng NMF cho ảnh khuôn mặt

Các tác giả áp dụng NMF cùng với PCA và VQ cho một cơ sở dữ liệu ảnh khuôn mặt. Như Hình 1 cho thấy, cả ba phương pháp đều học cách biểu diễn một khuôn mặt như một tổ hợp tuyến tính của các ảnh cơ sở, nhưng kết quả khác nhau về chất:
- VQ tìm ra cơ sở gồm các nguyên mẫu, mỗi nguyên mẫu là một khuôn mặt hoàn chỉnh.
- Các ảnh cơ sở của PCA là "eigenface" (khuôn mặt riêng), một số trông như phiên bản méo của khuôn mặt hoàn chỉnh.
- Cơ sở của NMF hoàn toàn khác: các ảnh là những đặc trưng cục bộ, phù hợp hơn với quan niệm trực giác về các bộ phận của khuôn mặt.

## Khung phân rã ma trận

Để hiểu vì sao NMF học được biểu diễn như vậy, ta mô tả cả ba phương pháp trong khung phân rã ma trận. Cơ sở dữ liệu ảnh được coi là ma trận $n \times m$ V, mỗi cột chứa $n$ giá trị điểm ảnh không âm của một trong $m$ ảnh khuôn mặt. Cả ba phương pháp đều xây dựng phép phân rã xấp xỉ dạng V ≈ WH, tức là

$$V_{i\mu} \approx (WH)_{i\mu} = \sum_{a=1}^{r} W_{ia} H_{a\mu} \qquad (1)$$

- $r$ cột của W gọi là các ảnh cơ sở.
- Mỗi cột của H gọi là một mã hóa (encoding), tương ứng một-một với một khuôn mặt trong V; nó gồm các hệ số dùng để biểu diễn khuôn mặt đó như tổ hợp tuyến tính của các ảnh cơ sở.
- Kích thước của W và H lần lượt là $n \times r$ và $r \times m$. Hạng $r$ thường được chọn sao cho $(n+m)r < nm$, nên tích WH có thể xem là dạng nén của dữ liệu V.

## Sự khác biệt giữa VQ, PCA và NMF

Sự khác biệt xuất phát từ các ràng buộc khác nhau đặt lên W và H.

- **VQ:** mỗi cột của H bị ràng buộc là vector đơn vị (unary): một phần tử bằng 1, các phần tử còn lại bằng 0. Nghĩa là mỗi khuôn mặt (cột của V) được xấp xỉ bằng đúng một ảnh cơ sở (cột của W). Biểu diễn đơn này buộc VQ học các ảnh cơ sở là các khuôn mặt nguyên mẫu (Hình 1).
- **PCA:** các cột của W trực chuẩn và các hàng của H trực giao với nhau. Điều này nới lỏng ràng buộc đơn của VQ, cho phép biểu diễn phân tán, trong đó mỗi khuôn mặt được xấp xỉ bằng tổ hợp tuyến tính của mọi ảnh cơ sở (eigenface). Dù eigenface có ý nghĩa thống kê là các hướng có phương sai lớn nhất, nhiều eigenface không có cách diễn giải trực quan rõ ràng, vì PCA cho phép các phần tử của W và H mang dấu tùy ý; các tổ hợp liên quan đến sự triệt tiêu phức tạp giữa số dương và số âm nên từng eigenface thường thiếu ý nghĩa trực giác.
- **NMF:** không cho phép phần tử âm trong W và H. Khác với ràng buộc đơn của VQ, ràng buộc không âm cho phép kết hợp nhiều ảnh cơ sở để biểu diễn một khuôn mặt, nhưng chỉ cho phép tổ hợp cộng vì các phần tử khác không đều dương; khác PCA, không có phép trừ. Vì vậy ràng buộc không âm phù hợp với quan niệm trực giác về việc ghép các bộ phận thành một toàn thể, và đó là cách NMF học biểu diễn dựa trên bộ phận.

## Tính thưa của biểu diễn NMF

Như Hình 1 cho thấy, cơ sở và mã hóa của NMF chứa tỷ lệ lớn các hệ số bằng 0, nên cả ảnh cơ sở lẫn mã hóa ảnh đều thưa. Các ảnh cơ sở thưa vì chúng không toàn cục và chứa nhiều phiên bản của miệng, mũi và các bộ phận khác, ở các vị trí hoặc hình dạng khác nhau; sự đa dạng của cả khuôn mặt được tạo ra bằng cách kết hợp các bộ phận này. Mỗi bộ phận đều được ít nhất một khuôn mặt sử dụng, nhưng một khuôn mặt bất kỳ không dùng hết các bộ phận. Kết quả là mã hóa ảnh phân tán thưa, trái với mã hóa đơn của VQ và mã hóa phân tán hoàn toàn của PCA.

## Cài đặt

NMF được cài đặt bằng các quy tắc cập nhật cho W và H nêu ở Hình 2. Lặp các quy tắc cập nhật này hội tụ tới một cực đại địa phương của hàm mục tiêu $F = \sum_{i=1}^{n}\sum_{\mu=1}^{m}\left[V_{i\mu}\log(WH)_{i\mu} - (WH)_{i\mu}\right]$ (phương trình 2, tiếp ở phần sau).
