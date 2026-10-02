## **3. Ví dụ minh họa đơn giản**

Hãy minh họa cách thủ tục NMF vận hành bằng một ví dụ đơn giản nhỏ này. Xét ma trận dữ liệu $V$ kích thước 4x5 như sau:

$$V = \begin{pmatrix} 1 & 2 & 3 & 4 & 5 \\ 6 & 7 & 8 & 9 & 10 \\ 11 & 12 & 13 & 14 & 15 \\ 16 & 17 & 18 & 19 & 20 \\ \end{pmatrix}$$

Chúng ta muốn phân rã ma trận này thành hai ma trận nhỏ hơn, $W$ (4x2) và $H$ (2x5), sao cho $V ≈ W * H$. Chúng ta khởi tạo $W^{(0)}$ (ma trận đặc trưng tại $t=0$) và $H^{(0)}$ (ma trận hệ số tại $t=0$) bằng các giá trị không âm ngẫu nhiên:

$$W^{(0)} = \begin{pmatrix} 0.2 & 0.5 \\ 0.8 & 0.3 \\ 0.6 & 0.9 \\ 0.4 & 0.7 \\ \end{pmatrix}, \quad H^{(0)} = \begin{pmatrix} 0.7 & 0.1 & 0.4 & 0.6 & 0.2 \\ 0.3 & 0.6 & 0.2 & 0.4 & 0.8 \\ \end{pmatrix}$$

Bây giờ, chúng ta cập nhật lặp $W^{(t)}$ và $H^{(t)}$ bằng các quy tắc cập nhật nhân để cực tiểu hóa sự chênh lệch giữa $V$ và $W^{(t)} * H^{(t)}$. Sau một vài vòng lặp, chúng ta có thể thu được các ma trận đã cập nhật như sau:

$$W = \begin{pmatrix} 0.9618 & 0. \\ 1.9262 & 1.0167 \\ 2.8902 & 2.0347 \\ 3.8542 & 3.0527 \\ \end{pmatrix}, \quad H = \begin{pmatrix} 1.0413 & 2.0823 & 3.1232 & 4.1642 & 5.19 \\ 3.9269 & 2.9399 & 1.9529 & 0.966 & 0. \\ \end{pmatrix}$$

Giá trị cuối cùng của ma trận đặc trưng $W$ và ma trận hệ số $H$ biểu diễn các nhân tử phân rã của ma trận gốc $V$. Lưu ý rằng các giá trị cụ thể trong các ma trận có thể khác đôi chút tùy thuộc vào phép tính thực tế. Bằng cách nhân $W$ và $H$, chúng ta thu được một xấp xỉ của $V$:

$$W * H = \begin{pmatrix} 1.0015 & 2.0028 & 3.004 & 4.0052 & 4.9919 \\ 5.9983 & 6.9999 & 8.0017 & 9.0034 & 9.9972 \\ 10.9996 & 12. & 13.0004 & 14.0008 & 15.0002 \\ 16.0009 & 17. & 17.9992 & 18.9983 & 20.0032 \\ \end{pmatrix}$$

Ma trận kết quả này là một xấp xỉ của ma trận gốc $V$. Sự chênh lệch giữa $V$ và $W * H$ biểu diễn sai số tái tạo.

$$V - W * H = \begin{pmatrix} -0.0015 & -0.0028 & -0.004 & -0.0052 & 0.0081 \\ 0.0017 & 0.0001 & -0.0017 & -0.0034 & 0.0028 \\ 0.0004 & 0. & -0.0004 & -0.0008 & -0.0002 \\ -0.0009 & -0. & 0.0008 & 0.0017 & -0.0032 \\ \end{pmatrix}$$

Mục tiêu của NMF là tìm $W$ và $H$ sao cho cực tiểu hóa sai số tái tạo này, đồng thời giữ cho mọi phần tử của $W$ và $H$ đều không âm.

Ví dụ số rất đơn giản này cho thấy NMF có thể phân rã một ma trận dữ liệu lớn hơn thành các ma trận nhỏ hơn, nắm bắt cấu trúc tiềm ẩn và các mối quan hệ của nó.
