# Học các bộ phận của đối tượng bằng phân rã ma trận không âm

Daniel D. Lee & H. Sebastian Seung (Bell Laboratories, Lucent Technologies; Massachusetts Institute of Technology)

Việc nhận thức cái toàn thể có dựa trên nhận thức các bộ phận của nó hay không? Đã có bằng chứng tâm lý học và sinh lý học về biểu diễn dựa trên bộ phận trong não, và một số lý thuyết tính toán về nhận dạng đối tượng cũng dựa vào các biểu diễn này. Tuy nhiên, người ta biết rất ít về cách não hay máy tính học được các bộ phận của đối tượng. Bài báo trình bày một thuật toán phân rã ma trận không âm (NMF) có khả năng học các bộ phận của khuôn mặt và các đặc trưng ngữ nghĩa của văn bản. Điều này trái với các phương pháp khác như phân tích thành phần chính (PCA) và lượng tử hóa vector (VQ), vốn học các biểu diễn toàn thể chứ không phải dựa trên bộ phận. NMF khác biệt ở chỗ dùng các ràng buộc không âm. Các ràng buộc này dẫn đến biểu diễn dựa trên bộ phận vì chỉ cho phép tổ hợp cộng, không cho phép tổ hợp trừ. Khi NMF được cài đặt như một mạng nơ-ron, biểu diễn dựa trên bộ phận xuất hiện nhờ hai tính chất: tần số phát xung của nơ-ron không bao giờ âm và cường độ synapse không đổi dấu.

## So sánh NMF, PCA và VQ trên ảnh khuôn mặt

Các tác giả áp dụng NMF, PCA và VQ cho một cơ sở dữ liệu ảnh khuôn mặt. Như Hình 1 cho thấy, cả ba phương pháp đều biểu diễn một khuôn mặt như tổ hợp tuyến tính của các ảnh cơ sở, nhưng kết quả khác nhau về chất:
- VQ tìm ra cơ sở gồm các nguyên mẫu, mỗi nguyên mẫu là một khuôn mặt hoàn chỉnh.
- Cơ sở của PCA là các "eigenface" (mặt riêng), một số trông như phiên bản méo của khuôn mặt toàn thể.
- Cơ sở của NMF hoàn toàn khác: các ảnh là những đặc trưng cục bộ, phù hợp hơn với quan niệm trực giác về các bộ phận của khuôn mặt.

## Khung phân rã ma trận

Cơ sở dữ liệu ảnh được coi là ma trận V kích thước n × m, mỗi cột chứa n giá trị điểm ảnh không âm của một trong m ảnh khuôn mặt. Cả ba phương pháp đều xây dựng phân rã xấp xỉ V ≈ WH, tức:

$$V_{i\mu} \approx (WH)_{i\mu} = \sum_{a=1}^{r} W_{ia} H_{a\mu} \quad (1)$$

(Công thức gốc bị vỡ do trích PDF; chỉ số cột thứ hai là chỉ số ảnh, ký hiệu m trong bản gốc.)

- r cột của W gọi là các ảnh cơ sở (basis images).
- Mỗi cột của H gọi là một mã hóa (encoding), tương ứng một-một với một khuôn mặt trong V; đó là các hệ số để biểu diễn khuôn mặt bằng tổ hợp tuyến tính của các ảnh cơ sở.
- Kích thước của W và H lần lượt là n × r và r × m. Hạng r thường được chọn sao cho $(n+m)r < nm$, nên tích WH có thể xem là dạng nén của dữ liệu trong V.

Sự khác biệt giữa PCA, VQ và NMF đến từ các ràng buộc khác nhau áp lên W và H:
- **VQ**: mỗi cột của H bị ràng buộc là vector đơn vị (unary), một phần tử bằng 1, các phần tử còn lại bằng 0. Nghĩa là mỗi khuôn mặt (cột của V) được xấp xỉ bằng đúng một ảnh cơ sở (cột của W). Mã hóa đơn này buộc VQ học các ảnh cơ sở là các khuôn mặt nguyên mẫu.
- **PCA**: ràng buộc các cột của W trực chuẩn và các hàng của H trực giao với nhau. Điều này nới lỏng ràng buộc của VQ, cho phép biểu diễn phân tán, trong đó mỗi khuôn mặt được xấp xỉ bằng tổ hợp tuyến tính của mọi ảnh cơ sở (eigenface). Dù eigenface có ý nghĩa thống kê là các hướng có phương sai lớn nhất, nhiều eigenface không có cách diễn giải trực quan rõ ràng, vì PCA cho phép các phần tử của W và H mang dấu tùy ý; các tổ hợp tuyến tính liên quan đến sự triệt tiêu phức tạp giữa số dương và số âm, nên từng eigenface thường thiếu ý nghĩa trực giác.
- **NMF**: không cho phép phần tử âm trong W và H. Khác với ràng buộc unary của VQ, ràng buộc không âm cho phép kết hợp nhiều ảnh cơ sở để biểu diễn một khuôn mặt, nhưng chỉ cho tổ hợp cộng vì mọi phần tử khác không đều dương; khác PCA, không có phép trừ. Vì vậy ràng buộc không âm phù hợp với quan niệm trực giác về việc ghép các bộ phận thành một tổng thể, và đó là cách NMF học biểu diễn dựa trên bộ phận.

## Tính thưa của NMF

Như Hình 1 cho thấy, cơ sở và mã hóa của NMF chứa tỷ lệ lớn các hệ số bằng 0, nên cả ảnh cơ sở lẫn mã hóa ảnh đều thưa. Ảnh cơ sở thưa vì chúng không toàn cục và chứa nhiều phiên bản của miệng, mũi và các bộ phận khác ở những vị trí hoặc hình dạng khác nhau; sự đa dạng của một khuôn mặt được tạo ra bằng cách kết hợp các bộ phận này. Mỗi bộ phận được ít nhất một khuôn mặt sử dụng, nhưng không khuôn mặt nào dùng toàn bộ các bộ phận, tạo ra mã hóa ảnh phân tán thưa, trái với mã hóa unary của VQ và mã hóa phân tán đầy đủ của PCA.

(Hình 1: so sánh Original, NMF, PCA, VQ; mỗi khuôn mặt = ảnh cơ sở × mã hóa.)

## Quy tắc cập nhật và hàm mục tiêu

Các tác giả cài đặt NMF với quy tắc cập nhật cho W và H nêu trong Hình 2. Lặp các quy tắc này hội tụ đến một cực đại cục bộ của hàm mục tiêu

$$F = \sum_{i=1}^{n}\sum_{\mu=1}^{m}\left[V_{i\mu}\log (WH)_{i\mu} - (WH)_{i\mu}\right]$$

(Phần đầu công thức bị vỡ do trích PDF; phần còn lại tiếp tục ở chunk sau.)
