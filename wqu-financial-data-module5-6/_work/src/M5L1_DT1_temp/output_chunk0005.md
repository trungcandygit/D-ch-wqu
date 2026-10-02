các bộ phận thường xuất hiện cùng nhau. Điều này tạo ra các phụ thuộc phức tạp giữa các biến ẩn mà những thuật toán giả định tính độc lập trong phần mã hóa không thể nắm bắt được. Một ứng dụng khác của ICA là biến đổi các ảnh cơ sở của PCA để làm cho bản thân các ảnh, chứ không phải phần mã hóa, độc lập thống kê ở mức cao nhất có thể^18. Cách này cho một cơ sở không toàn cục; tuy nhiên, trong biểu diễn đó mọi ảnh cơ sở đều được dùng theo các tổ hợp triệt tiêu lẫn nhau để biểu diễn một khuôn mặt, nên phần mã hóa không thưa. Ngược lại, biểu diễn NMF có cả cơ sở lẫn phần mã hóa đều thưa một cách tự nhiên, tức là nhiều thành phần bằng đúng 0. Tính thưa ở cả cơ sở lẫn phần mã hóa là điều then chốt cho biểu diễn theo bộ phận.

Thuật toán ở Hình 2 thực hiện đồng thời cả học và suy luận: vừa học một tập ảnh cơ sở, vừa suy ra giá trị của các biến ẩn từ các biến quan sát. Mặc dù mô hình sinh ở Hình 3 là tuyến tính, phép tính suy luận lại phi tuyến do các ràng buộc không âm. Phép tính này tương tự việc tái dựng hợp lý cực đại trong chụp cắt lớp phát xạ^19 và khử nhòe (deconvolution) ảnh thiên văn bị mờ^20,21.

Theo mô hình sinh ở Hình 3, các biến quan sát được sinh ra từ các biến ẩn bởi một mạng nơ-ron chứa các kết nối kích thích. Một mạng nơ-ron suy ra biến ẩn từ biến quan sát cần bổ sung các kết nối phản hồi ức chế. Khi đó, việc học NMF được hiện thực qua tính dẻo của các kết nối synapse. Thảo luận đầy đủ về một mạng như vậy nằm ngoài phạm vi của bức thư này; ở đây chỉ nêu một hệ quả của các ràng buộc không âm: synapse hoặc là kích thích hoặc là ức chế, nhưng không đổi dấu. Hơn nữa, tính không âm của các biến ẩn và biến quan sát tương ứng với thực tế sinh lý rằng tốc độ phát xung của nơ-ron không thể âm. Chúng tôi đề xuất rằng các ràng buộc một phía lên hoạt động nơ-ron và độ mạnh synapse trong não có thể quan trọng cho việc hình thành các biểu diễn thưa, phân tán, theo bộ phận phục vụ tri giác.

court government council culture supreme constitutional rights justice

president served governor secretary senate congress presidential elected

flowers leaves plant perennial flower plants growing annual

disease behaviour glands contact symptoms skin pain infection

Mục bách khoa toàn thư: 'Constitution of the United States'

president (148), congress (124), power (120), united (104), constitution (81), amendment (71), government (57), law (49)

metal process method paper ... glass copper lead steel
person example time people ... rules lead leads law

**Hình 4** Phân rã ma trận không âm (NMF) khám phá các đặc trưng ngữ nghĩa của m = 30.991 bài viết từ bách khoa toàn thư Grolier. Với mỗi từ trong bộ từ vựng cỡ n = 15.276, số lần xuất hiện được đếm trong từng bài và dùng để lập ma trận V cỡ 15.276 × 30.991. Mỗi cột của V chứa số lần xuất hiện của các từ trong một bài viết, còn mỗi hàng chứa số lần xuất hiện của một từ trong các bài khác nhau. Ma trận được phân rã xấp xỉ thành dạng WH bằng thuật toán mô tả ở Hình 2. Trên trái: bốn trong số r = 200 đặc trưng ngữ nghĩa (các cột của W). Vì là các vectơ số chiều rất cao, mỗi đặc trưng ngữ nghĩa được biểu diễn bằng danh sách tám từ có tần suất cao nhất trong đặc trưng đó; độ đậm của chữ thể hiện tần suất tương đối của từng từ trong đặc trưng. Phải: tám từ thường gặp nhất và số lần xuất hiện của chúng trong mục 'Constitution of the United States'. Vectơ đếm từ này được xấp xỉ bằng một chồng chập cho trọng số cao với hai đặc trưng ngữ nghĩa phía trên và không có trọng số với hai đặc trưng phía dưới, như bốn ô tô bóng ở giữa biểu thị hoạt động của H. Phần dưới của hình cho thấy hai đặc trưng ngữ nghĩa chứa từ 'lead' với tần suất cao. Xét theo các từ khác trong đặc trưng, NMF phân biệt được hai nghĩa khác nhau của 'lead'.

## Phương pháp

Các ảnh khuôn mặt dùng ở Hình 1 gồm các ảnh nhìn thẳng, được căn chỉnh thủ công trong lưới 19 × 19. Với mỗi ảnh, cường độ xám trước hết được co giãn tuyến tính sao cho trung bình và độ lệch chuẩn của điểm ảnh đều bằng 0,25, rồi cắt về khoảng [0,1]. NMF được thực hiện bằng thuật toán lặp mô tả ở Hình 2, bắt đầu từ các điều kiện ban đầu ngẫu nhiên cho W và H. Thuật toán hội tụ phần lớn sau chưa đến 50 vòng lặp; kết quả trình bày là sau 500 vòng lặp, mất vài giờ tính toán trên máy Pentium II. PCA được thực hiện bằng cách chéo hóa ma trận VV^T; hiển thị 49 vectơ riêng ứng với các trị riêng lớn nhất. VQ được thực hiện bằng thuật toán k-means, bắt đầu từ các điều kiện ban đầu ngẫu nhiên cho W và H.

Trong ứng dụng phân tích ngữ nghĩa ở Hình 4, bộ từ vựng gồm 15.276 từ thường gặp nhất trong cơ sở dữ liệu các bài viết Grolier, sau khi loại 430 từ phổ biến nhất như 'the' và 'and'. Vì phần lớn các từ chỉ xuất hiện trong tương đối ít bài, ma trận đếm từ V cực kỳ thưa, giúp thuật toán chạy nhanh hơn. Kết quả trình bày là sau khi các quy tắc cập nhật ở Hình 2 được lặp 50 lần, bắt đầu từ các điều kiện ban đầu ngẫu nhiên cho W và H.

Nhận ngày 24 tháng 5; chấp nhận ngày 6 tháng 8 năm 1999.

1. Palmer, S. E. Hierarchical structure in perceptual representation. Cogn. Psychol. 9, 441–474 (1977).
2. Wachsmuth, E., Oram, M. W. & Perrett, D. I. Recognition of objects and their component parts:
responses of single units in the temporal cortex of the macaque. Cereb. Cortex 4, 509–522 (1994).
3. Logothetis, N. K. & Sheinberg, D. L. Visual object recognition. Annu. Rev. Neurosci. 19, 577–621
(1996).
