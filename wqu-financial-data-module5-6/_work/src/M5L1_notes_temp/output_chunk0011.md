### **8.1 NMF thưa (Sparse NMF)**

Phân rã ma trận không âm (NMF) thưa là một biến thể của thuật toán NMF chuẩn, trong đó áp đặt tính thưa lên các ma trận nhân tử \$W\$ và \$H\$. Điều này có nghĩa là thuật toán khuyến khích nhiều phần tử của các ma trận này bằng không.

**Lý do:** Tính thưa thường được mong muốn trong NMF vì một số lý do sau:

-   Khả năng diễn giải: Các ma trận nhân tử thưa dễ diễn giải hơn vì chúng làm nổi bật các đặc trưng quan trọng nhất và giảm độ phức tạp của mô hình.
-   Lựa chọn đặc trưng: Tính thưa có thể đóng vai trò như một hình thức lựa chọn đặc trưng, xác định các đặc trưng phù hợp nhất để biểu diễn dữ liệu.
-   Giảm nhiễu: Bằng cách tập trung vào một tập đặc trưng nhỏ hơn, NMF thưa có thể giúp giảm ảnh hưởng của nhiễu trong dữ liệu.

**Phương pháp:** Tính thưa trong NMF thường đạt được bằng cách thêm các số hạng điều chuẩn (regularization) kích thích tính thưa vào hàm mục tiêu của NMF. Các số hạng này phạt các phần tử khác không trong các ma trận nhân tử, khuyến khích chúng tiến về không. Các kỹ thuật điều chuẩn phổ biến gồm:

-   Điều chuẩn L1: Thêm một khoản phạt tỷ lệ với tổng giá trị tuyệt đối của các phần tử trong các ma trận nhân tử.
-   Điều chuẩn L2: Thêm một khoản phạt tỷ lệ với tổng bình phương giá trị của các phần tử trong các ma trận nhân tử.
-   Các ràng buộc thưa khác: Có thể dùng nhiều ràng buộc khác để thực thi tính thưa, chẳng hạn giới hạn số phần tử khác không trong mỗi hàng hoặc cột của các ma trận nhân tử.

**Lợi ích:** NMF thưa mang lại nhiều lợi ích so với NMF chuẩn:

-   Cải thiện khả năng diễn giải: Các ma trận nhân tử thưa dễ hiểu hơn và dễ liên hệ với các đặc trưng gốc.
-   Lựa chọn đặc trưng tốt hơn: Tính thưa giúp xác định các đặc trưng phù hợp nhất để biểu diễn dữ liệu.
-   Giảm nhiễu: Bằng cách tập trung vào một tập đặc trưng nhỏ hơn, NMF thưa có thể giúp giảm ảnh hưởng của nhiễu.
-   Tăng khả năng khái quát hóa: Các mô hình thưa thường khái quát hóa tốt hơn trên dữ liệu mới vì ít bị quá khớp hơn.
