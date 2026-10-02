### **8.2 NMF có ràng buộc (Constrained NMF)**

Phân rã ma trận không âm (NMF) có ràng buộc là một biến thể của NMF chuẩn, trong đó các ràng buộc bổ sung được áp đặt lên các ma trận nhân tử (\$W\$ và \$H\$) trong quá trình phân rã. Các ràng buộc này thường dựa trên kiến thức có sẵn về dữ liệu hoặc những tính chất cụ thể mong muốn ở các nhân tử thu được.

**Lý do:** Việc đưa các ràng buộc vào cho phép điều chỉnh NMF phù hợp với từng ứng dụng và đặc điểm dữ liệu. Điều này có thể cải thiện chất lượng của phép phân rã, tăng khả năng diễn giải và bảo đảm kết quả có ý nghĩa hơn trong bối cảnh của bài toán.

**Ví dụ về các ràng buộc:**

-   Ràng buộc tổng bằng một: Ràng buộc này buộc các phần tử trong mỗi hàng của \$H\$ (hoặc mỗi cột của \$W\$) có tổng bằng một. Ràng buộc này thường được dùng trong mô hình hóa chủ đề, khi mỗi hàng của \$H\$ biểu diễn một tài liệu và các phần tử cho biết tỷ trọng của từng chủ đề trong tài liệu đó.
-   Ràng buộc trực giao: Ràng buộc này yêu cầu các cột của \$W\$ (hoặc các hàng của \$H\$) trực giao với nhau. Nó khuyến khích các nhân tử độc lập và biểu diễn những khía cạnh khác nhau của dữ liệu.
-   Ràng buộc thưa: Tương tự NMF thưa, ràng buộc này thúc đẩy tính thưa trong các ma trận nhân tử, dẫn đến kết quả dễ diễn giải hơn và chống nhiễu tốt hơn.
-   Ràng buộc đặc thù theo lĩnh vực: Các ràng buộc dựa trên kiến thức chuyên môn có thể được đưa vào để định hướng phép phân rã. Ví dụ, trong xử lý ảnh, có thể dùng ràng buộc để bảo đảm các nhân tử biểu diễn những đặc trưng ảnh cụ thể như cạnh hoặc kết cấu bề mặt.

**Lợi ích:** NMF có ràng buộc mang lại một số ưu điểm:

-   Phân rã được cải thiện: Các ràng buộc có thể định hướng quá trình phân rã tới những lời giải có ý nghĩa và phù hợp hơn.
-   Khả năng diễn giải được nâng cao: Các ràng buộc giúp các nhân tử thu được dễ diễn giải hơn và dễ liên hệ với dữ liệu gốc.
-   Lời giải được điều chỉnh theo nhu cầu: Các ràng buộc cho phép thích nghi NMF với từng ứng dụng và đặc điểm dữ liệu cụ thể.
-   Kiểm soát tính chất của nhân tử: Các ràng buộc có thể được dùng để áp đặt những tính chất mong muốn lên các nhân tử, chẳng hạn tính thưa, tính trực giao hoặc các mẫu cụ thể.

Về bản chất, NMF có ràng buộc cho phép bạn tùy biến thuật toán NMF theo nhu cầu cụ thể bằng cách đưa kiến thức có sẵn hoặc các tính chất mong muốn vào quá trình phân rã. Điều này có thể dẫn đến những kết quả sâu sắc và phù hợp hơn so với NMF chuẩn.
