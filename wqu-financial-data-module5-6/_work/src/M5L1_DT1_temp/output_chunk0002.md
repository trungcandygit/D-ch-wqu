# Học các bộ phận của đối tượng bằng phân rã ma trận không âm

Daniel D. Lee & H. Sebastian Seung

Bell Laboratories, Lucent Technologies, Murray Hill, New Jersey 07974, Hoa Kỳ; Department of Brain and Cognitive Sciences, Massachusetts Institute of Technology, Cambridge, Massachusetts 02139, Hoa Kỳ

## Tóm tắt

Việc nhận thức tổng thể có dựa trên nhận thức các bộ phận của nó hay không? Đã có bằng chứng tâm lý học và sinh lý học về các biểu diễn dựa trên bộ phận (parts-based) trong não, và một số lý thuyết tính toán về nhận dạng đối tượng cũng dựa trên các biểu diễn này. Tuy nhiên, người ta còn biết rất ít về cách não hoặc máy tính có thể học các bộ phận của đối tượng. Bài báo trình bày một thuật toán phân rã ma trận không âm (NMF) có khả năng học các bộ phận của khuôn mặt và các đặc trưng ngữ nghĩa của văn bản. Điều này trái với các phương pháp khác như phân tích thành phần chính (PCA) và lượng tử hóa vectơ (VQ), vốn học các biểu diễn toàn thể chứ không dựa trên bộ phận. NMF khác biệt ở chỗ dùng các ràng buộc không âm. Các ràng buộc này dẫn đến biểu diễn dựa trên bộ phận vì chỉ cho phép tổ hợp cộng, không cho phép tổ hợp trừ. Khi NMF được cài đặt dưới dạng mạng nơ-ron, biểu diễn dựa trên bộ phận xuất hiện nhờ hai tính chất: tần số phát xung của nơ-ron không bao giờ âm và cường độ synap không đổi dấu.

## So sánh NMF, PCA và VQ trên ảnh khuôn mặt

Các tác giả áp dụng NMF, PCA và VQ lên một cơ sở dữ liệu ảnh khuôn mặt. Như Hình 1 cho thấy, cả ba phương pháp đều biểu diễn một khuôn mặt dưới dạng tổ hợp tuyến tính của các ảnh cơ sở, nhưng kết quả khác nhau về chất:

- VQ tìm ra cơ sở gồm các nguyên mẫu, mỗi nguyên mẫu là một khuôn mặt hoàn chỉnh.
- Cơ sở của PCA là các "eigenface" (khuôn mặt riêng), một số trông giống phiên bản méo của khuôn mặt hoàn chỉnh.
- Cơ sở của NMF khác hẳn: các ảnh của nó là những đặc trưng cục bộ, tương ứng tốt hơn với quan niệm trực giác về các bộ phận của khuôn mặt.

## Khung phân rã ma trận

Để hiểu vì sao NMF học được biểu diễn khác biệt như vậy, ta mô tả cả ba phương pháp trong cùng khung phân rã ma trận. Cơ sở dữ liệu ảnh được coi là ma trận V kích thước n × m, mỗi cột chứa n giá trị điểm ảnh không âm của một trong m ảnh khuôn mặt. Cả ba phương pháp xây dựng phép phân rã xấp xỉ có dạng V ≈ WH, hay

$$V_{i\mu} \approx (WH)_{i\mu} = \sum_{a=1}^{r} W_{ia} H_{a\mu} \quad (1)$$

- r cột của W gọi là các ảnh cơ sở.
- Mỗi cột của H gọi là một mã hóa (encoding), tương ứng một-một với một khuôn mặt trong V; đó là các hệ số dùng để biểu diễn khuôn mặt bằng tổ hợp tuyến tính của các ảnh cơ sở.
- Kích thước của W và H lần lượt là n × r và r × m. Hạng r thường được chọn sao cho (n + m)r < nm, nên tích WH có thể xem là dạng nén của dữ liệu trong V.

Sự khác biệt giữa PCA, VQ và NMF đến từ các ràng buộc khác nhau áp lên W và H:

- **VQ**: mỗi cột của H bị ràng buộc là vectơ đơn phân (unary), một phần tử bằng 1 và các phần tử còn lại bằng 0. Nói cách khác, mỗi khuôn mặt (cột của V) được xấp xỉ bằng đúng một ảnh cơ sở (cột của W). Ràng buộc này buộc VQ học các ảnh cơ sở là khuôn mặt nguyên mẫu (Hình 1 minh họa mã hóa đơn phân bên cạnh cơ sở VQ).
- **PCA**: các cột của W phải trực chuẩn và các hàng của H phải trực giao với nhau. Điều này nới lỏng ràng buộc đơn phân của VQ, cho phép biểu diễn phân tán, trong đó mỗi khuôn mặt được xấp xỉ bằng tổ hợp tuyến tính của mọi ảnh cơ sở (eigenface). Dù eigenface có ý nghĩa thống kê là các hướng có phương sai lớn nhất, nhiều eigenface không có cách diễn giải trực quan rõ ràng, vì PCA cho phép các phần tử của W và H mang dấu tùy ý. Do các eigenface được dùng trong những tổ hợp tuyến tính thường kéo theo sự triệt tiêu phức tạp giữa số dương và số âm, nhiều eigenface riêng lẻ không có ý nghĩa trực giác.
- **NMF**: không cho phép phần tử âm trong W và H. Khác với ràng buộc đơn phân của VQ, ràng buộc không âm cho phép kết hợp nhiều ảnh cơ sở để biểu diễn một khuôn mặt; nhưng chỉ cho phép tổ hợp cộng, vì mọi phần tử khác không của W và H đều dương. Khác với PCA, không có phép trừ. Vì vậy, ràng buộc không âm phù hợp với trực giác về việc ghép các bộ phận thành một tổng thể, và đó chính là cách NMF học biểu diễn dựa trên bộ phận.

## Tính thưa của cơ sở và mã hóa NMF

Như Hình 1 cho thấy, cơ sở và mã hóa của NMF chứa một tỷ lệ lớn hệ số triệt tiêu, nên cả ảnh cơ sở lẫn mã hóa ảnh đều thưa. Ảnh cơ sở thưa vì chúng không toàn cục, mà chứa nhiều phiên bản của miệng, mũi và các bộ phận khác của khuôn mặt, các phiên bản này nằm ở vị trí hoặc dạng khác nhau. Sự biến thiên của một khuôn mặt hoàn chỉnh được tạo ra bằng cách kết hợp các bộ phận khác nhau này. Mọi bộ phận đều được ít nhất một khuôn mặt sử dụng, nhưng một khuôn mặt bất kỳ không dùng hết các bộ phận sẵn có. Kết quả là mã hóa ảnh phân tán thưa, trái với mã hóa đơn phân của VQ và mã hóa phân tán hoàn toàn của PCA (các tài liệu tham khảo 7–9).

*Hình 1: so sánh ảnh gốc, VQ, PCA và NMF; mỗi khuôn mặt gốc bằng tích của ảnh cơ sở và mã hóa tương ứng (V ≈ WH).*

## Thuật toán

Các tác giả cài đặt NMF bằng các quy tắc cập nhật cho W và H nêu ở Hình 2. Việc lặp các quy tắc cập nhật này hội tụ đến một cực đại cục bộ của hàm mục tiêu F (công thức 2, trình bày tiếp ở phần sau).
