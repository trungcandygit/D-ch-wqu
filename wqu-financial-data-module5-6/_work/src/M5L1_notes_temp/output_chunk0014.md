### **8.4 NMF lồi (Convex NMF)**

Phân rã ma trận không âm lồi (convex NMF) là một biến thể của NMF, trong đó các ràng buộc lồi được áp đặt lên phép phân rã. Điều này có nghĩa là các ma trận nhân tử (\$W\$ và \$H\$) bị giới hạn nằm trong một tập lồi.

**Lập luận:** Việc đưa các ràng buộc lồi vào NMF có thể mang lại nhiều lợi ích:

-   Tính duy nhất: NMF lồi có thể giúp giải quyết vấn đề không duy nhất vốn có của NMF chuẩn. Bằng cách giới hạn không gian nghiệm trong một tập lồi, phương pháp này có thể làm giảm số nghiệm khả dĩ và có khả năng dẫn đến một nghiệm duy nhất hoặc ổn định hơn.
-   Cải thiện hội tụ: Các ràng buộc lồi có thể cải thiện tính chất hội tụ của thuật toán NMF, giúp thuật toán nhiều khả năng tìm được nghiệm tốt một cách hiệu quả.
-   Khả năng diễn giải tốt hơn: Trong một số trường hợp, các ràng buộc lồi có thể dẫn đến các nhân tử dễ diễn giải hơn nhờ khuyến khích chúng biểu diễn những đặc trưng hoặc mẫu hình cụ thể trong dữ liệu.

**Phương pháp:** Các ràng buộc lồi trong NMF thường được áp đặt bằng cách giới hạn các ma trận nhân tử nằm trong một tập lồi. Điều này có thể thực hiện thông qua nhiều phương pháp khác nhau, chẳng hạn:

-   Bao lồi (Convex Hull): Các ma trận nhân tử bị ràng buộc nằm trong bao lồi của một tập các điểm dữ liệu hoặc đặc trưng.
-   Ràng buộc đa diện (Polytope Constraints): Các ma trận nhân tử bị giới hạn nằm trong một đa diện cụ thể được xác định bởi một tập các bất đẳng thức tuyến tính.
-   Các ràng buộc lồi khác: Có thể sử dụng nhiều ràng buộc lồi khác, chẳng hạn giới hạn các ma trận nhân tử là nửa xác định dương hoặc có các cấu trúc thưa cụ thể.

**Lợi ích:** NMF lồi mang lại nhiều ưu điểm so với NMF chuẩn:

-   Khả năng đạt tính duy nhất: Phương pháp này có thể giúp giải quyết vấn đề không duy nhất của NMF chuẩn, dẫn đến các nghiệm ổn định và đáng tin cậy hơn.
-   Cải thiện hội tụ: Các ràng buộc lồi có thể cải thiện tính chất hội tụ của thuật toán NMF.
-   Tăng khả năng diễn giải: Trong một số trường hợp, các ràng buộc lồi có thể dẫn đến các nhân tử dễ diễn giải hơn.

**Các lưu ý:**

-   Việc lựa chọn các ràng buộc lồi phù hợp có vai trò then chốt đối với thành công của NMF lồi. Các ràng buộc cần phù hợp với ứng dụng cụ thể và đặc điểm của dữ liệu.
-   Việc áp đặt các ràng buộc lồi có thể làm tăng độ phức tạp tính toán của thuật toán NMF. Tuy nhiên, các thuật toán hiệu quả đã được phát triển để giải quyết thách thức này.

Tóm lại, NMF lồi là một biến thể có giá trị của NMF, kết hợp các ràng buộc lồi nhằm cải thiện tính duy nhất, khả năng hội tụ và khả năng diễn giải của phép phân rã. Đây là một công cụ mạnh mẽ cho nhiều tác vụ phân tích dữ liệu và học máy.
