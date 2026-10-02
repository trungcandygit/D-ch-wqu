các bộ phận thường xuất hiện cùng nhau. Điều này tạo ra các phụ thuộc phức tạp giữa các biến ẩn mà những thuật toán giả định tính độc lập trong phần mã hóa không thể nắm bắt được. Một ứng dụng khác của ICA là biến đổi các ảnh cơ sở của PCA sao cho chính các ảnh, thay vì phần mã hóa, độc lập về mặt thống kê ở mức cao nhất có thể[18]. Cách này cho ra một cơ sở không mang tính toàn cục; tuy nhiên, trong biểu diễn đó mọi ảnh cơ sở đều được dùng theo các tổ hợp triệt tiêu lẫn nhau để biểu diễn một khuôn mặt cụ thể, nên phần mã hóa không thưa. Ngược lại, biểu diễn NMF có cả cơ sở lẫn phần mã hóa đều thưa một cách tự nhiên, theo nghĩa nhiều thành phần bằng đúng 0. Tính thưa ở cả cơ sở lẫn phần mã hóa là điều then chốt đối với biểu diễn theo bộ phận.

Thuật toán ở Hình 2 thực hiện đồng thời cả học lẫn suy luận: nó vừa học một tập ảnh cơ sở, vừa suy ra giá trị của các biến ẩn từ các biến quan sát được. Mặc dù mô hình sinh ở Hình 3 là tuyến tính, phép tính suy luận lại phi tuyến do các ràng buộc không âm. Phép tính này tương tự phương pháp tái dựng hợp lý cực đại trong chụp cắt lớp phát xạ[19] và phép giải chập (deconvolution) các ảnh thiên văn bị nhòe[20,21].

Theo mô hình sinh ở Hình 3, các biến quan sát được sinh ra từ các biến ẩn qua một mạng nơ-ron gồm các kết nối kích thích. Một mạng nơ-ron suy ra biến ẩn từ biến quan sát được cần bổ sung thêm các kết nối phản hồi ức chế. Khi đó, việc học NMF được thực hiện thông qua tính dẻo của các khớp thần kinh. Phần bàn luận đầy đủ về một mạng như vậy nằm ngoài phạm vi của bức thư này. Ở đây chúng tôi chỉ nêu một hệ quả của các ràng buộc không âm: khớp thần kinh hoặc là kích thích hoặc là ức chế và không đổi dấu. Hơn nữa, tính không âm của các biến ẩn và biến quan sát được tương ứng với thực tế sinh lý rằng tần suất phát xung của nơ-ron không thể âm. Chúng tôi đề xuất rằng các ràng buộc một phía đối với hoạt động thần kinh và cường độ khớp thần kinh trong não có thể đóng vai trò quan trọng trong việc hình thành các biểu diễn phân tán thưa, theo bộ phận, phục vụ nhận thức tri giác.

**Hình 4** Phân rã ma trận không âm (NMF) khám phá các đặc trưng ngữ nghĩa từ $m = 30{,}991$ bài viết của bộ bách khoa toàn thư Grolier. Với mỗi từ trong bộ từ vựng cỡ $n = 15{,}276$, số lần xuất hiện được đếm trong từng bài viết và dùng để lập ma trận $V$ kích thước $15{,}276 \times 30{,}991$. Mỗi cột của $V$ chứa số đếm từ của một bài viết, còn mỗi hàng của $V$ chứa số đếm của một từ trong các bài viết khác nhau. Ma trận được phân rã xấp xỉ thành dạng $V \approx WH$ bằng thuật toán mô tả ở Hình 2. Phía trên bên trái là bốn trong số $r = 200$ đặc trưng ngữ nghĩa (các cột của $W$). Vì là các vectơ số chiều rất cao, mỗi đặc trưng ngữ nghĩa được biểu diễn bằng danh sách tám từ có tần suất cao nhất trong đặc trưng đó; độ đậm của chữ cho biết tần suất tương đối của từng từ trong đặc trưng. Bên phải là tám từ xuất hiện nhiều nhất cùng số lần xuất hiện trong mục bách khoa "Constitution of the United States" (Hiến pháp Hoa Kỳ). Vectơ số đếm từ này được xấp xỉ bằng một chồng chập gán trọng số cao cho hai đặc trưng ngữ nghĩa phía trên và không gán trọng số nào cho hai đặc trưng phía dưới, như bốn ô tô bóng ở giữa biểu thị hoạt động của $H$. Phần dưới của hình cho thấy hai đặc trưng ngữ nghĩa chứa từ "lead" với tần suất cao. Xét theo các từ khác trong các đặc trưng, NMF đã phân biệt được hai nghĩa khác nhau của "lead".

Nội dung trong hình:

- Bốn đặc trưng ngữ nghĩa (mỗi đặc trưng là một danh sách tám từ):
  - court, government, council, culture, supreme, constitutional, rights, justice
  - president, served, governor, secretary, senate, congress, presidential, elected
  - flowers, leaves, plant, perennial, flower, plants, growing, annual
  - disease, behaviour, glands, contact, symptoms, skin, pain, infection
- Mục bách khoa "Constitution of the United States" (số lần xuất hiện): president (148), congress (124), power (120), united (104), constitution (81), amendment (71), government (57), law (49)
- Hai đặc trưng chứa "lead":
  - metal process method paper ... glass copper lead steel
  - person example time people ... rules lead leads law

## Phương pháp

Các ảnh khuôn mặt dùng trong Hình 1 gồm các ảnh nhìn chính diện, căn chỉnh thủ công trong lưới $19 \times 19$. Với mỗi ảnh, cường độ thang xám trước hết được co giãn tuyến tính sao cho trung bình và độ lệch chuẩn của điểm ảnh đều bằng 0,25, rồi cắt về khoảng $[0,1]$. NMF được thực hiện bằng thuật toán lặp mô tả ở Hình 2, bắt đầu từ các điều kiện ban đầu ngẫu nhiên cho $W$ và $H$. Thuật toán hội tụ phần lớn sau chưa đến 50 vòng lặp; kết quả trình bày là sau 500 vòng lặp, mất vài giờ tính toán trên máy Pentium II. PCA được thực hiện bằng cách chéo hóa ma trận $VV^T$; hiển thị 49 vectơ riêng có trị riêng lớn nhất. VQ được thực hiện bằng thuật toán k-means, bắt đầu từ các điều kiện ban đầu ngẫu nhiên cho $W$ và $H$.

Trong ứng dụng phân tích ngữ nghĩa ở Hình 4, bộ từ vựng được xác định là 15.276 từ xuất hiện thường xuyên nhất trong cơ sở dữ liệu các bài viết của bách khoa toàn thư Grolier, sau khi loại bỏ 430 từ phổ biến nhất như "the" và "and". Do hầu hết các từ chỉ xuất hiện trong tương đối ít bài viết, ma trận số đếm từ $V$ cực kỳ thưa, giúp thuật toán chạy nhanh hơn. Kết quả trình bày là sau 50 lần lặp các quy tắc cập nhật ở Hình 2, bắt đầu từ các điều kiện ban đầu ngẫu nhiên cho $W$ và $H$.

Nhận ngày 24 tháng 5; chấp nhận đăng ngày 6 tháng 8 năm 1999.

## Tài liệu tham khảo

1. Palmer, S. E. Hierarchical structure in perceptual representation. Cogn. Psychol. 9, 441–474 (1977).
2. Wachsmuth, E., Oram, M. W. & Perrett, D. I. Recognition of objects and their component parts: responses of single units in the temporal cortex of the macaque. Cereb. Cortex 4, 509–522 (1994).
3. Logothetis, N. K. & Sheinberg, D. L. Visual object recognition. Annu. Rev. Neurosci. 19, 577–621 (1996).
