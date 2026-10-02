# Học các bộ phận của đối tượng bằng phân rã ma trận không âm

Daniel D. Lee và H. Sebastian Seung (Bell Laboratories, Lucent Technologies; Massachusetts Institute of Technology)

Việc nhận thức tổng thể có dựa trên nhận thức các bộ phận của nó hay không? Đã có bằng chứng tâm lý học và sinh lý học về các biểu diễn theo bộ phận trong não, và một số lý thuyết tính toán về nhận dạng đối tượng cũng dựa trên các biểu diễn này. Tuy nhiên, người ta còn biết rất ít về cách não bộ hay máy tính học được các bộ phận của đối tượng. Bài báo trình bày một thuật toán phân rã ma trận không âm (NMF) có khả năng học các bộ phận của khuôn mặt và các đặc trưng ngữ nghĩa của văn bản. Điều này trái với các phương pháp khác như phân tích thành phần chính (PCA) và lượng tử hóa vectơ (VQ), vốn học các biểu diễn toàn thể chứ không theo bộ phận. NMF khác biệt ở chỗ sử dụng các ràng buộc không âm; các ràng buộc này chỉ cho phép tổ hợp cộng, không cho phép tổ hợp trừ, nên dẫn đến biểu diễn theo bộ phận. Khi NMF được cài đặt dưới dạng mạng nơ-ron, biểu diễn theo bộ phận xuất hiện nhờ hai tính chất: tốc độ phát xung của nơ-ron không bao giờ âm và cường độ synap không đổi dấu.

## Áp dụng NMF, PCA và VQ cho ảnh khuôn mặt

Các tác giả áp dụng NMF, PCA và VQ cho một cơ sở dữ liệu ảnh khuôn mặt. Như Hình 1 cho thấy, cả ba phương pháp đều biểu diễn một khuôn mặt dưới dạng tổ hợp tuyến tính của các ảnh cơ sở, nhưng kết quả khác nhau về chất:

- VQ tìm ra một cơ sở gồm các nguyên mẫu, mỗi nguyên mẫu là một khuôn mặt hoàn chỉnh.
- Các ảnh cơ sở của PCA là các "eigenface" (khuôn mặt riêng), một số trông như phiên bản méo của khuôn mặt nguyên vẹn.
- Cơ sở NMF hoàn toàn khác: các ảnh là những đặc trưng cục bộ, phù hợp hơn với quan niệm trực giác về các bộ phận của khuôn mặt.

## Khung phân rã ma trận

Để hiểu vì sao NMF học được biểu diễn khác với PCA và VQ, ta mô tả cả ba phương pháp trong khung phân rã ma trận. Cơ sở dữ liệu ảnh được coi là ma trận $n \times m$ $V$, mỗi cột chứa $n$ giá trị điểm ảnh không âm của một trong $m$ ảnh khuôn mặt. Cả ba phương pháp đều xây dựng phân rã xấp xỉ dạng $V \approx WH$, tức là

$$V_{i\mu} \approx (WH)_{i\mu} = \sum_{a=1}^{r} W_{ia} H_{a\mu} \tag{1}$$

$r$ cột của $W$ được gọi là các ảnh cơ sở. Mỗi cột của $H$ được gọi là một mã hóa (encoding), tương ứng một-một với một khuôn mặt trong $V$; mã hóa gồm các hệ số dùng để biểu diễn khuôn mặt đó như tổ hợp tuyến tính của các ảnh cơ sở. Kích thước của các thừa số $W$ và $H$ lần lượt là $n \times r$ và $r \times m$. Hạng $r$ thường được chọn sao cho $(n+m)r < nm$, nhờ đó tích $WH$ có thể xem là dạng nén của dữ liệu trong $V$.

## Khác biệt giữa VQ, PCA và NMF

Sự khác biệt giữa ba phương pháp bắt nguồn từ các ràng buộc khác nhau áp đặt lên $W$ và $H$:

- **VQ:** mỗi cột của $H$ bị ràng buộc là vectơ đơn vị một phần tử (một phần tử bằng 1, các phần tử còn lại bằng 0). Nói cách khác, mỗi khuôn mặt (cột của $V$) được xấp xỉ bằng đúng một ảnh cơ sở (cột của $W$). Mã hóa đơn phân này (minh họa cạnh cơ sở VQ ở Hình 1) buộc VQ học các ảnh cơ sở là khuôn mặt nguyên mẫu.
- **PCA:** các cột của $W$ bị ràng buộc trực chuẩn và các hàng của $H$ trực giao với nhau. Điều này nới lỏng ràng buộc đơn phân của VQ, cho phép biểu diễn phân tán, trong đó mỗi khuôn mặt được xấp xỉ bằng tổ hợp tuyến tính của mọi ảnh cơ sở (eigenface). Dù eigenface có ý nghĩa thống kê là các hướng có phương sai lớn nhất, nhiều eigenface không có cách diễn giải trực quan rõ ràng, vì PCA cho phép các phần tử của $W$ và $H$ mang dấu bất kỳ. Do các eigenface được dùng trong những tổ hợp thường có sự triệt tiêu phức tạp giữa số dương và số âm, nhiều eigenface riêng lẻ không có ý nghĩa trực quan.
- **NMF:** không cho phép phần tử âm trong $W$ và $H$. Khác với ràng buộc đơn phân của VQ, ràng buộc không âm cho phép kết hợp nhiều ảnh cơ sở để biểu diễn một khuôn mặt, nhưng chỉ cho phép tổ hợp cộng vì các phần tử khác không của $W$ và $H$ đều dương. Khác với PCA, không có phép trừ nào xảy ra. Vì vậy, ràng buộc không âm phù hợp với quan niệm trực giác về việc ghép các bộ phận thành một tổng thể, và đó chính là cách NMF học biểu diễn theo bộ phận.

## Tính thưa của biểu diễn NMF

Hình 1 cho thấy cơ sở và các mã hóa của NMF chứa tỷ lệ lớn các hệ số triệt tiêu, nên cả ảnh cơ sở lẫn mã hóa ảnh đều thưa. Các ảnh cơ sở thưa vì chúng không mang tính toàn cục và chứa nhiều phiên bản của miệng, mũi và các bộ phận khác của mặt, ở các vị trí hoặc hình dạng khác nhau; sự biến thiên của cả khuôn mặt được tạo ra bằng cách kết hợp các bộ phận khác nhau này. Mọi bộ phận đều được ít nhất một khuôn mặt sử dụng, nhưng một khuôn mặt bất kỳ không dùng hết các bộ phận sẵn có. Kết quả là mã hóa ảnh phân tán thưa, trái với mã hóa đơn phân của VQ và mã hóa phân tán hoàn toàn của PCA.

## Quy tắc cập nhật

Các tác giả cài đặt NMF với các quy tắc cập nhật cho $W$ và $H$ nêu ở Hình 2. Việc lặp các quy tắc này hội tụ đến một cực đại cục bộ của hàm mục tiêu $F$ (công thức được nêu tiếp ở phần sau).
