## **6. Thách thức và hạn chế của phân rã ma trận không âm (NMF)**

Phân rã ma trận không âm (NMF) có một số thách thức và hạn chế:

**Tính không duy nhất của nghiệm:** Phép phân rã NMF vốn không duy nhất, nghĩa là có thể tồn tại nhiều cặp ma trận nhân tử (\$W\$ và \$H\$) mà khi nhân với nhau đều xấp xỉ ma trận dữ liệu gốc (\$V\$) tốt như nhau. Điều này xuất phát từ việc thường có nhiều cách biểu diễn cùng một dữ liệu bằng các tổ hợp nhân tử không âm khác nhau.

> -   Hệ quả: Tính không duy nhất này gây khó khăn cho việc diễn giải kết quả của NMF, vì các nghiệm khác nhau có thể dẫn đến những cách diễn giải khác nhau về các nhân tử tiềm ẩn. Nó cũng khiến việc so sánh kết quả giữa các lần chạy khác nhau của thuật toán, hoặc khi dùng các chiến lược khởi tạo khác nhau, trở nên khó khăn.
> -   Giải pháp: Các kỹ thuật như chính quy hóa (regularization), vốn bổ sung ràng buộc hoặc hình phạt vào hàm mục tiêu, có thể giúp giảm bớt vấn đề không duy nhất bằng cách khuyến khích các nghiệm có những tính chất cụ thể, chẳng hạn như tính thưa hoặc tính trực giao.

**Độ nhạy với khởi tạo:** Hiệu năng của các thuật toán NMF có thể nhạy với giá trị khởi tạo của các ma trận nhân tử (\$W\$ và \$H\$). Các chiến lược khởi tạo khác nhau có thể khiến thuật toán hội tụ về các cực tiểu cục bộ khác nhau, dẫn đến các nghiệm khác nhau.

> -   Hệ quả: Độ nhạy với khởi tạo này làm cho kết quả của NMF kém khả năng tái lập hơn và có thể dẫn đến các nghiệm dưới tối ưu.
> -   Giải pháp: Thử nhiều phương pháp khởi tạo khác nhau, chẳng hạn khởi tạo ngẫu nhiên, NNDSVD (phân rã giá trị suy biến kép không âm - Non-negative Double Singular Value Decomposition), hoặc tận dụng kiến thức có sẵn về dữ liệu, có thể giúp giảm nhẹ vấn đề này và có khả năng cải thiện chất lượng nghiệm.

**Xác định số lượng nhân tử tối ưu:** Chọn đúng số lượng nhân tử (hay thành phần) là một bước then chốt trong NMF. Quá ít nhân tử có thể không nắm bắt được hết thông tin quan trọng trong dữ liệu, dẫn đến mất thông tin và giảm độ chính xác. Quá nhiều nhân tử có thể dẫn đến quá khớp (overfitting), khi đó mô hình nắm bắt nhiễu hoặc các mẫu không liên quan trong dữ liệu, làm giảm khả năng khái quát hóa sang dữ liệu mới.

> -   Hệ quả: Việc chọn số lượng nhân tử không phù hợp có thể ảnh hưởng đáng kể đến hiệu năng và khả năng diễn giải của mô hình NMF.
> -   Giải pháp: Các kỹ thuật lựa chọn mô hình, chẳng hạn kiểm định chéo (cross-validation), phân tích silhouette, hoặc dùng chuyên môn lĩnh vực để đánh giá khả năng diễn giải của các nhân tử, có thể giúp định hướng việc chọn số lượng nhân tử tối ưu.

**Yêu cầu dữ liệu không âm:** NMF về cơ bản được thiết kế để làm việc với dữ liệu không âm. Thuật toán giả định rằng ma trận dữ liệu đầu vào (\$V\$) và các ma trận nhân tử kết quả (\$W\$ và \$H\$) chỉ có các phần tử không âm. Lý do là ràng buộc không âm đóng vai trò thiết yếu để bảo đảm các nhân tử có thể diễn giải được như những tổ hợp cộng tính của các đặc trưng ban đầu.

> -   Hệ quả: Hạn chế này giới hạn khả năng áp dụng NMF vào các tập dữ liệu mà giá trị âm không có ý nghĩa, hoặc có thể được chuyển thành biểu diễn không âm.
> -   Giải pháp: Với dữ liệu có giá trị âm, có thể cân nhắc các kỹ thuật như dịch chuyển (cộng một hằng số vào mọi phần tử), co giãn (nhân với một hằng số dương), hoặc dùng các phương pháp phân rã ma trận khác có thể xử lý dữ liệu có dấu hỗn hợp.

**Thách thức về khả năng diễn giải:** Mặc dù NMF thường được xem là dễ diễn giải hơn các kỹ thuật giảm chiều dữ liệu khác như PCA, việc diễn giải các nhân tử kết quả vẫn có thể mang tính chủ quan và đòi hỏi chuyên môn lĩnh vực. Các nhân tử biểu diễn những đặc trưng hoặc mẫu tiềm ẩn trong dữ liệu, và ý nghĩa của chúng không phải lúc nào cũng rõ ràng ngay lập tức.

> -   Hệ quả: Việc diễn giải các nhân tử NMF đòi hỏi phân tích cẩn thận và xem xét bối cảnh của dữ liệu cũng như ứng dụng cụ thể.
> -   Giải pháp: Các kỹ thuật như trực quan hóa các hệ số tải của nhân tử (factor loadings), xem xét các đặc trưng đóng góp nhiều nhất cho từng nhân tử, và dùng kiến thức lĩnh vực để liên hệ các nhân tử với các khái niệm trong thế giới thực có thể hỗ trợ việc diễn giải.

**Chi phí tính toán:** Các thuật toán NMF có thể tốn kém về mặt tính toán, đặc biệt với các tập dữ liệu lớn hoặc số lượng nhân tử cao. Bản chất lặp của thuật toán và nhu cầu cập nhật các ma trận nhân tử nhiều lần có thể dẫn đến thời gian tính toán đáng kể.

> -   Hệ quả: Chi phí tính toán của NMF có thể là một yếu tố hạn chế đối với các ứng dụng quy mô lớn hoặc khi cần phân tích theo thời gian thực.
> -   Giải pháp: Sử dụng các thuật toán hiệu quả, chẳng hạn những thuật toán dựa trên các phép toán ma trận thưa, có thể giúp giảm gánh nặng tính toán. Ngoài ra, các kỹ thuật như NMF trực tuyến (online NMF), vốn cập nhật phép phân rã theo từng bước khi có dữ liệu mới đến, có thể dễ xử lý hơn về mặt tính toán đối với dữ liệu dòng (streaming).
