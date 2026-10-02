# Học các bộ phận của đối tượng bằng phân rã ma trận không âm

Daniel D. Lee* & H. Sebastian Seung*†

\* Bell Laboratories, Lucent Technologies, Murray Hill, New Jersey 07974, Hoa Kỳ

† Department of Brain and Cognitive Sciences, Massachusetts Institute of Technology, Cambridge, Massachusetts 02139, Hoa Kỳ

**Tóm tắt.** Liệu việc nhận thức một chỉnh thể có dựa trên việc nhận thức các bộ phận của nó? Đã có bằng chứng tâm lý học và sinh lý học về các biểu diễn theo bộ phận trong não, và một số lý thuyết tính toán về nhận dạng đối tượng cũng dựa trên các biểu diễn này. Tuy nhiên, người ta biết rất ít về việc não bộ hay máy tính có thể học các bộ phận của đối tượng như thế nào. Bài báo trình bày một thuật toán phân rã ma trận không âm (non-negative matrix factorization, NMF) có khả năng học các bộ phận của khuôn mặt và các đặc trưng ngữ nghĩa của văn bản. Điều này trái với các phương pháp khác như phân tích thành phần chính (PCA) và lượng tử hóa vector (VQ), vốn học các biểu diễn mang tính toàn thể chứ không theo bộ phận. NMF khác biệt ở chỗ sử dụng các ràng buộc không âm; các ràng buộc này dẫn đến biểu diễn theo bộ phận vì chỉ cho phép tổ hợp cộng, không cho phép tổ hợp trừ. Khi NMF được triển khai dưới dạng mạng nơ-ron, biểu diễn theo bộ phận xuất hiện nhờ hai tính chất: tốc độ phát xung của nơ-ron không bao giờ âm, và cường độ khớp thần kinh không đổi dấu.

Các tác giả áp dụng NMF, cùng với PCA và VQ, lên một cơ sở dữ liệu ảnh khuôn mặt. Như Hình 1 cho thấy, cả ba phương pháp đều học cách biểu diễn một khuôn mặt dưới dạng tổ hợp tuyến tính của các ảnh cơ sở, nhưng kết quả khác nhau về chất. VQ tìm ra một cơ sở gồm các nguyên mẫu, mỗi nguyên mẫu là một khuôn mặt hoàn chỉnh. Các ảnh cơ sở của PCA là các "eigenface" (khuôn mặt riêng), một số trông giống phiên bản méo mó của khuôn mặt nguyên vẹn$^6$. Cơ sở của NMF thì khác hẳn: các ảnh của nó là những đặc trưng cục bộ, phù hợp hơn với khái niệm trực giác về các bộ phận của khuôn mặt.

NMF học được một biểu diễn khác biệt đến vậy so với biểu diễn toàn thể của PCA và VQ bằng cách nào? Để trả lời, cần mô tả cả ba phương pháp trong khuôn khổ phân rã ma trận. Cơ sở dữ liệu ảnh được coi là một ma trận $V$ cỡ $n \times m$, trong đó mỗi cột chứa $n$ giá trị điểm ảnh không âm của một trong $m$ ảnh khuôn mặt. Khi đó cả ba phương pháp đều xây dựng một phép phân rã xấp xỉ dạng $V \approx WH$, tức là

$$V_{i\mu} \approx (WH)_{i\mu} = \sum_{a=1}^{r} W_{ia} H_{a\mu} \qquad (1)$$

$r$ cột của $W$ được gọi là các ảnh cơ sở. Mỗi cột của $H$ được gọi là một mã hóa (encoding) và tương ứng một–một với một khuôn mặt trong $V$; mã hóa gồm các hệ số dùng để biểu diễn khuôn mặt đó như một tổ hợp tuyến tính của các ảnh cơ sở. Kích thước của các ma trận nhân tử $W$ và $H$ lần lượt là $n \times r$ và $r \times m$. Hạng $r$ của phép phân rã thường được chọn sao cho $(n+m)r < nm$, nhờ đó tích $WH$ có thể xem là dạng nén của dữ liệu trong $V$.

Sự khác biệt giữa PCA, VQ và NMF xuất phát từ các ràng buộc khác nhau đặt lên các ma trận nhân tử $W$ và $H$.

- **VQ:** mỗi cột của $H$ bị ràng buộc là một vector đơn vị (unary), tức một phần tử bằng 1 và các phần tử còn lại bằng 0. Nói cách khác, mỗi khuôn mặt (cột của $V$) được xấp xỉ bằng đúng một ảnh cơ sở (cột của $W$). Một mã hóa đơn như vậy của một khuôn mặt cụ thể được minh họa cạnh cơ sở VQ trong Hình 1. Biểu diễn đơn này buộc VQ học các ảnh cơ sở là những khuôn mặt nguyên mẫu.
- **PCA:** ràng buộc các cột của $W$ trực chuẩn và các hàng của $H$ trực giao với nhau. Điều này nới lỏng ràng buộc đơn của VQ, cho phép biểu diễn phân tán, trong đó mỗi khuôn mặt được xấp xỉ bằng tổ hợp tuyến tính của toàn bộ các ảnh cơ sở (eigenface)$^6$. Mã hóa phân tán của một khuôn mặt được minh họa cạnh các eigenface trong Hình 1. Dù eigenface có ý nghĩa thống kê là các hướng có phương sai lớn nhất, nhiều eigenface không có cách diễn giải trực quan rõ ràng. Nguyên nhân là PCA cho phép các phần tử của $W$ và $H$ mang dấu tùy ý; vì các eigenface được dùng trong những tổ hợp tuyến tính thường kéo theo sự triệt tiêu phức tạp giữa số dương và số âm, nhiều eigenface riêng lẻ mất đi ý nghĩa trực giác.
- **NMF:** không cho phép phần tử âm trong $W$ và $H$. Khác với ràng buộc đơn của VQ, ràng buộc không âm cho phép kết hợp nhiều ảnh cơ sở để biểu diễn một khuôn mặt, nhưng chỉ cho phép tổ hợp cộng, vì mọi phần tử khác không của $W$ và $H$ đều dương. Trái với PCA, không thể có phép trừ. Vì vậy, các ràng buộc không âm phù hợp với trực giác về việc ghép các bộ phận thành một chỉnh thể, và đó chính là cách NMF học được biểu diễn theo bộ phận.

Như Hình 1 cho thấy, cơ sở và các mã hóa của NMF chứa một tỷ lệ lớn hệ số bằng 0, nên cả ảnh cơ sở lẫn mã hóa ảnh đều thưa. Các ảnh cơ sở thưa vì chúng không mang tính toàn cục, và chứa nhiều phiên bản của miệng, mũi và các bộ phận khác của khuôn mặt, mỗi phiên bản ở một vị trí hoặc hình dạng khác nhau. Sự đa dạng của cả khuôn mặt được tạo ra bằng cách kết hợp các bộ phận này. Dù mỗi bộ phận đều được ít nhất một khuôn mặt sử dụng, một khuôn mặt bất kỳ không dùng hết mọi bộ phận sẵn có. Kết quả là mã hóa ảnh phân tán thưa, khác với mã hóa đơn của VQ và mã hóa phân tán hoàn toàn của PCA$^{7-9}$.

*Hình 1.* So sánh khuôn mặt gốc với các biểu diễn của NMF, PCA và VQ: mỗi khuôn mặt được xấp xỉ bằng tích của ma trận cơ sở và vector mã hóa ($\times$ ... $=$ ...).

Các tác giả triển khai NMF bằng các quy tắc cập nhật cho $W$ và $H$ nêu trong Hình 2. Việc lặp các quy tắc cập nhật này hội tụ đến một cực đại địa phương của hàm mục tiêu $F = \sum_{i=1}^{n}\sum_{\mu=1}^{m}$
