## **1. Phân rã ma trận không âm là gì?**

Phân rã ma trận không âm (non-negative matrix factorization, NMF) là một kỹ thuật giảm chiều dữ liệu, trong đó một ma trận không âm được phân rã thành hai ma trận không âm nhỏ hơn. Kỹ thuật này thường được dùng trong phân tích dữ liệu, học máy và các hệ thống gợi ý. Hãy xem lại các tài liệu đọc bắt buộc rồi quay lại với phần còn lại của bài học này.

Định nghĩa toán học của phân rã ma trận không âm (NMF) như sau:

Cho một ma trận không âm \$V\$ có kích thước \$m \\times n\$, NMF tìm hai ma trận không âm:

-   \$W\$ có kích thước \$m \\times k\$ (\$m\$ hàng, \$k\$ cột, trong đó \$k\$ là số chiều sau khi giảm);
-   \$H\$ có kích thước \$k \\times n\$;

sao cho: \$\$V \\approx W \* H\$\$

Trong đó:

-   \$\*\$ ký hiệu phép nhân ma trận
-   Phép xấp xỉ \$\\approx\$ thường được đo bằng một hàm chi phí, chẳng hạn chuẩn Frobenius: \$\\lVert V - W \* H \\rVert \^2\$

Ràng buộc: Mọi phần tử của \$W\$ và \$H\$ phải là số thực không âm, tức là \$W\$ ≥ 0, \$H\$ ≥ 0

Nói đơn giản, ta muốn tìm hai ma trận (\$W\$ và \$H\$) sao cho khi nhân với nhau, kết quả xấp xỉ sát ma trận dữ liệu gốc (\$V\$). Các phần tử của \$W\$ và \$H\$ phải không âm (lớn hơn hoặc bằng không).

Hạng phân rã (factorization rank) trong NMF, thường ký hiệu là \$k\$, biểu thị số lượng nhân tố hay thành phần mà ta muốn trích xuất từ dữ liệu. Về bản chất, nó quyết định số chiều của biểu diễn đã giảm chiều.

**Quy tắc cập nhật lặp:** Có nhiều cách để tìm \$W\$ và \$H\$. Các thuật toán NMF thường dùng quy tắc cập nhật lặp để tinh chỉnh các ma trận \$W\$ và \$H\$ cho đến khi hội tụ. Các quy tắc này nhằm cực tiểu hóa sự khác biệt giữa ma trận gốc \$V\$ và tích \$W \* H\$. Một quy tắc cập nhật phổ biến là quy tắc cập nhật nhân (multiplicative update rule), được suy ra từ việc cực tiểu hóa chuẩn Frobenius:

\$\$W\_{ia} \\leftarrow W\_{ia} \* \\frac{(V \* H\^T)\_{ia}}{(W \* H \* H\^T)\_{ia}}\$\$

\$\$H\_{aj} \\leftarrow H\_{aj} \* \\frac{(W\^T \* V)\_{aj}}{(W\^T \* W \* H)\_{aj}}\$\$

Trong đó:

-   \$W\_{ia}\$ biểu diễn phần tử ở hàng thứ \$i\$ và cột thứ \$a\$ của ma trận \$W\$.
-   \$H\_{aj}\$ biểu diễn phần tử ở hàng thứ \$a\$ và cột thứ \$j\$ của ma trận \$H\$.
-   \$V\$, \$W\$ và \$H\$ là các ma trận như đã định nghĩa trong bài toán NMF.
-   \$H\^T\$ và \$W\^T\$ lần lượt là ma trận chuyển vị của \$H\$ và \$W\$.
-   \$\*\$ và phép chia lần lượt biểu thị phép nhân và phép chia theo từng phần tử.

Quá trình lặp tiếp tục cho đến khi thỏa mãn một tiêu chí hội tụ. Tiêu chí này có thể dựa trên:

-   Sự chênh lệch của hàm chi phí: Thuật toán dừng khi mức thay đổi của hàm chi phí (ví dụ chuẩn Frobenius) giữa hai lần lặp liên tiếp nhỏ hơn một ngưỡng định trước.
-   Số lần lặp tối đa: Thuật toán kết thúc sau một số lần lặp cố định, ngay cả khi hàm chi phí chưa hội tụ hoàn toàn.

Về mặt toán học, sự hội tụ có thể được biểu diễn như sau:

\$\$\\lVert V - W\^{(t+1)} \* H\^{(t+1)} \\rVert \^2 - \\lVert V - W\^{(t)} \* H\^{(t)} \\rVert \^2 \< \\varepsilon\$\$

Trong đó:

-   \$W\^{(t)}\$ và \$H\^{(t)}\$ biểu diễn các ma trận \$W\$ và \$H\$ tại lần lặp \$t\$.
-   \$\\varepsilon\$ là một giá trị dương nhỏ biểu thị ngưỡng hội tụ.

Nói đơn giản, thuật toán dừng khi sai khác về sai số xấp xỉ giữa hai lần lặp liên tiếp trở nên đủ nhỏ.
