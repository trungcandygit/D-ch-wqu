các bộ phận có khả năng xuất hiện cùng nhau. Điều này dẫn đến những phụ thuộc phức tạp giữa các biến ẩn mà các thuật toán giả định tính độc lập trong các phép mã hóa không thể nắm bắt được. Một ứng dụng thay thế của ICA là biến đổi các ảnh cơ sở của PCA, nhằm làm cho các ảnh, thay vì các phép mã hóa, độc lập thống kê ở mức cao nhất có thể^18. Điều này tạo ra một cơ sở không mang tính toàn cục; tuy nhiên, trong biểu diễn này, mọi ảnh cơ sở đều được dùng trong các tổ hợp triệt tiêu lẫn nhau để biểu diễn một khuôn mặt riêng lẻ, và do đó các phép mã hóa không thưa. Ngược lại, biểu diễn NMF chứa cả cơ sở lẫn phép mã hóa đều thưa một cách tự nhiên, theo nghĩa nhiều thành phần bằng đúng không. Tính thưa ở cả cơ sở lẫn các phép mã hóa là yếu tố then chốt đối với một biểu diễn dựa trên các bộ phận.

Thuật toán ở Hình 2 thực hiện đồng thời cả học lẫn suy luận. Nghĩa là, nó vừa học một tập các ảnh cơ sở, vừa suy ra giá trị của các biến ẩn từ các biến quan sát được. Mặc dù mô hình sinh ở Hình 3 là tuyến tính, phép tính suy luận lại phi tuyến do các ràng buộc không âm. Phép tính này tương tự như phép tái tạo hợp lý cực đại trong chụp cắt lớp phát xạ^19, và phép giải chập các ảnh thiên văn bị mờ^20,21.

Theo mô hình sinh ở Hình 3, các biến quan sát được được sinh ra từ các biến ẩn bởi một mạng nơ-ron chứa các kết nối kích thích. Một mạng nơ-ron suy ra các biến ẩn từ các biến quan sát được đòi hỏi phải bổ sung các kết nối phản hồi ức chế. Khi đó, việc học NMF được hiện thực hóa thông qua tính dẻo của các kết nối synapse. Việc thảo luận đầy đủ về một mạng như vậy nằm ngoài phạm vi của bức thư này. Ở đây chúng tôi chỉ nêu ra

court
government
council
culture
supreme
constitutional
rights
justice

president
served
governor
secretary
senate
congress
presidential
elected

flowers
leaves
plant
perennial
flower
plants
growing
annual

disease
behaviour
glands
contact
symptoms
skin
pain
infection

Mục bách khoa toàn thư:
'Constitution of the
United States'

×

≈

president (148)
congress (124)
power (120)
united (104)
constitution (81)
amendment (71)
government (57)
law (49)

metal process method paper ... glass copper lead steel
person example time people ... rules lead leads law

Hình 4 Phân rã ma trận không âm (NMF) khám phá các đặc trưng ngữ nghĩa của m = 30.991 bài viết từ bách khoa toàn thư Grolier. Với mỗi từ trong một từ vựng có kích thước n = 15.276, số lần xuất hiện được đếm trong từng bài viết và được dùng để hình thành ma trận V có kích thước 15.276 × 30.991. Mỗi cột của V chứa số lần đếm từ của một bài viết cụ thể, trong khi mỗi hàng của V chứa số lần đếm của một từ cụ thể trong các bài viết khác nhau. Ma trận được phân rã xấp xỉ về dạng WH bằng thuật toán mô tả ở Hình 2. Phía trên bên trái, bốn trong số r = 200 đặc trưng ngữ nghĩa (các cột của W). Vì chúng là các vectơ có số chiều rất cao, mỗi đặc trưng ngữ nghĩa được biểu diễn bằng danh sách tám từ có tần suất cao nhất trong đặc trưng đó. Độ đậm của chữ biểu thị tần suất tương đối của mỗi từ trong một đặc trưng. Bên phải, tám từ xuất hiện thường xuyên nhất và số lần đếm của chúng trong mục bách khoa toàn thư về 'Constitution of the United States'. Vectơ đếm từ này được xấp xỉ bằng một phép chồng chất gán trọng số cao cho hai đặc trưng ngữ nghĩa phía trên và không gán trọng số nào cho hai đặc trưng phía dưới, như được thể hiện bởi bốn ô vuông tô bóng ở giữa biểu thị các hoạt động của H. Phần dưới của hình cho thấy hai đặc trưng ngữ nghĩa chứa từ 'lead' với tần suất cao. Xét theo các từ khác trong các đặc trưng, hai nghĩa khác nhau của 'lead' được NMF phân biệt.

hệ quả của các ràng buộc không âm, đó là các synapse hoặc là kích thích hoặc là ức chế, nhưng không đổi dấu. Hơn nữa, tính không âm của các biến ẩn và biến quan sát được tương ứng với thực tế sinh lý rằng tần số phát xung của các nơ-ron không thể âm. Chúng tôi đề xuất rằng các ràng buộc một phía đối với hoạt động thần kinh và cường độ synapse trong não có thể quan trọng đối với việc phát triển các biểu diễn dựa trên các bộ phận, phân bố thưa, phục vụ cho tri giác. M

## Phương pháp

Các ảnh khuôn mặt dùng trong Hình 1 gồm các ảnh nhìn chính diện được căn chỉnh thủ công trong một lưới 19 × 19. Với mỗi ảnh, các cường độ thang xám trước tiên được co giãn tuyến tính sao cho trung bình và độ lệch chuẩn của điểm ảnh bằng 0,25, rồi được cắt về khoảng [0,1]. NMF được thực hiện bằng thuật toán lặp mô tả ở Hình 2, bắt đầu từ các điều kiện ban đầu ngẫu nhiên cho W và H. Thuật toán hội tụ phần lớn sau chưa đến 50 lần lặp; các kết quả hiển thị là sau 500 lần lặp, mất vài giờ tính toán trên một máy tính Pentium II. PCA được thực hiện bằng cách chéo hóa ma trận VV^T. Hiển thị 49 vectơ riêng có trị riêng lớn nhất. VQ được thực hiện thông qua thuật toán k-means, bắt đầu từ các điều kiện ban đầu ngẫu nhiên cho W và H.

Trong ứng dụng phân tích ngữ nghĩa ở Hình 4, từ vựng được định nghĩa là 15.276 từ thường gặp nhất trong cơ sở dữ liệu các bài viết bách khoa toàn thư Grolier, sau khi loại bỏ 430 từ phổ biến nhất, chẳng hạn như 'the' và 'and'. Vì hầu hết các từ chỉ xuất hiện trong tương đối ít bài viết, ma trận đếm từ V cực kỳ thưa, điều này giúp tăng tốc thuật toán. Các kết quả hiển thị là sau khi các quy tắc cập nhật ở Hình 2 được lặp 50 lần, bắt đầu từ các điều kiện ban đầu ngẫu nhiên cho W và H.

Nhận ngày 24 tháng 5; chấp nhận ngày 6 tháng 8 năm 1999.

1. Palmer, S. E. Hierarchical structure in perceptual representation. Cogn. Psychol. 9, 441–474 (1977).
2. Wachsmuth, E., Oram, M. W. & Perrett, D. I. Recognition of objects and their component parts:
responses of single units in the temporal cortex of the macaque. Cereb. Cortex 4, 509–522 (1994).
3. Logothetis, N. K. & Sheinberg, D. L. Visual object recognition. Annu. Rev. Neurosci. 19, 577–621
(1996).
