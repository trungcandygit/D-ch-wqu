### **8.3 Semi-NMF**

Semi-NMF, hay phân rã ma trận bán không âm (semi non-negative matrix factorization), là một biến thể của NMF trong đó ràng buộc không âm được nới lỏng đối với một trong hai ma trận nhân tử (\$W\$ hoặc \$H\$). Điều này có nghĩa là một ma trận có thể chứa cả giá trị dương lẫn giá trị âm, trong khi ma trận còn lại vẫn không âm.

**Lý do:** Thuật toán NMF chuẩn yêu cầu mọi phần tử của các ma trận nhân tử đều không âm. Tuy nhiên, trong một số ứng dụng, các giá trị âm có thể mang ý nghĩa và cung cấp những hiểu biết giá trị. Chẳng hạn, trong phân tích dữ liệu tài chính, lợi suất âm là điều có thể xảy ra và cần được tính đến trong quá trình phân rã. Semi-NMF cho phép phân rã loại dữ liệu có dấu hỗn hợp như vậy, đồng thời vẫn giữ được các lợi ích của NMF về khả năng diễn giải và biểu diễn dựa trên các thành phần.

**Cách hoạt động:** Semi-NMF điều chỉnh hàm mục tiêu và các quy tắc cập nhật của NMF chuẩn để thích ứng với việc nới lỏng ràng buộc không âm. Thuật toán vẫn nhằm tìm hai ma trận (\$W\$ và \$H\$) có tích xấp xỉ ma trận dữ liệu gốc (\$V\$), nhưng một trong hai ma trận giờ đây có thể có các phần tử âm.

**Lợi ích:**

-   Xử lý dữ liệu có dấu hỗn hợp: Semi-NMF cho phép phân rã dữ liệu có cả giá trị dương và âm, điều này rất quan trọng đối với các ứng dụng mà giá trị âm có ý nghĩa.
-   Bảo toàn khả năng diễn giải: Dù cho phép giá trị âm, semi-NMF vẫn giữ được lợi ích của NMF về khả năng diễn giải và biểu diễn dựa trên các thành phần.
-   Tính linh hoạt: Phương pháp này linh hoạt hơn NMF chuẩn nhờ có thể đáp ứng nhiều loại dữ liệu hơn.

**Những điểm cần lưu ý:**

-   Khi sử dụng semi-NMF, điều quan trọng là phải chọn ma trận nhân tử nào (\$W\$ hay \$H\$) được phép có giá trị âm, dựa trên ứng dụng cụ thể và cách diễn giải các nhân tử.
-   Cách diễn giải các nhân tử có thể khác đôi chút so với NMF chuẩn do sự xuất hiện của các giá trị âm. Cần cân nhắc cẩn thận ý nghĩa của các giá trị âm trong bối cảnh của bài toán.

Tóm lại, semi-NMF là một mở rộng có giá trị của NMF, cho phép phân rã dữ liệu có dấu hỗn hợp mà vẫn giữ lại nhiều lợi ích của NMF chuẩn. Phương pháp này linh hoạt hơn và có thể mang lại hiểu biết sâu sắc về những dữ liệu mà giá trị âm có ý nghĩa.
