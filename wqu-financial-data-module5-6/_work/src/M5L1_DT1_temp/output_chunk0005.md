các bộ phận có xu hướng xuất hiện cùng nhau. Điều này tạo ra các phụ thuộc phức tạp giữa các biến ẩn mà những thuật toán giả định tính độc lập trong các mã hóa không thể nắm bắt. Một cách ứng dụng ICA khác là biến đổi các ảnh cơ sở của PCA để làm cho chính các ảnh (thay vì các mã hóa) độc lập thống kê ở mức cao nhất có thể18. Cách này cho một cơ sở không toàn cục; tuy nhiên, trong biểu diễn này mọi ảnh cơ sở đều được dùng theo các tổ hợp triệt tiêu lẫn nhau để biểu diễn một khuôn mặt, nên các mã hóa không thưa. Ngược lại, biểu diễn NMF có cả cơ sở lẫn mã hóa đều thưa một cách tự nhiên, tức là nhiều thành phần bằng đúng 0. Tính thưa ở cả cơ sở và mã hóa là điều then chốt cho một biểu diễn dựa trên các bộ phận.

Thuật toán ở Hình 2 thực hiện đồng thời học và suy luận: vừa học một tập ảnh cơ sở, vừa suy ra giá trị của các biến ẩn từ các biến quan sát. Mặc dù mô hình sinh ở Hình 3 là tuyến tính, phép tính suy luận lại phi tuyến do các ràng buộc không âm. Phép tính này tương tự phép tái tạo cực đại hợp lý (maximum likelihood) trong chụp cắt lớp phát xạ19 và phép giải chập (deconvolution) ảnh thiên văn bị mờ20,21.

Theo mô hình sinh ở Hình 3, các biến quan sát được sinh ra từ các biến ẩn bởi một mạng nơ-ron gồm các kết nối kích thích. Để mạng suy ra biến ẩn từ biến quan sát, cần bổ sung các kết nối phản hồi ức chế. Việc học NMF khi đó được thực hiện qua tính dẻo của các kết nối synap. Thảo luận đầy đủ về một mạng như vậy nằm ngoài phạm vi bài báo này; ở đây chỉ nêu một hệ quả của các ràng buộc không âm: các synap hoặc là kích thích hoặc là ức chế, nhưng không đổi dấu. Hơn nữa, tính không âm của các biến ẩn và biến quan sát tương ứng với thực tế sinh lý rằng tần số phát xung của nơ-ron không thể âm. Chúng tôi đề xuất rằng các ràng buộc một phía lên hoạt động nơ-ron và cường độ synap trong não có thể quan trọng đối với việc hình thành các biểu diễn phân tán thưa, dựa trên các bộ phận, phục vụ tri giác.

**Hình 4.** Phân rã ma trận không âm (NMF) khám phá các đặc trưng ngữ nghĩa của m = 30.991 bài viết trong bách khoa toàn thư Grolier. Với mỗi từ trong từ vựng cỡ n = 15.276, số lần xuất hiện được đếm trong từng bài và dùng để lập ma trận V cỡ 15.276 × 30.991. Mỗi cột của V chứa số đếm từ của một bài; mỗi hàng chứa số đếm của một từ trong các bài khác nhau. Ma trận được phân rã xấp xỉ thành dạng WH bằng thuật toán ở Hình 2. Phía trên bên trái: bốn trong r = 200 đặc trưng ngữ nghĩa (các cột của W). Vì đây là các vectơ rất nhiều chiều, mỗi đặc trưng ngữ nghĩa được biểu diễn bằng danh sách tám từ có tần suất cao nhất trong đặc trưng đó; độ đậm của chữ cho biết tần suất tương đối của từ trong đặc trưng. Bên phải: tám từ xuất hiện nhiều nhất và số lần xuất hiện trong mục "Constitution of the United States". Vectơ đếm từ này được xấp xỉ bằng một chồng chập gán trọng số cao cho hai đặc trưng ngữ nghĩa phía trên và không gán gì cho hai đặc trưng phía dưới, như bốn ô tô bóng ở giữa (hoạt động của H) cho thấy. Phía dưới hình là hai đặc trưng ngữ nghĩa chứa từ "lead" với tần suất cao; căn cứ vào các từ khác trong đặc trưng, NMF phân biệt được hai nghĩa khác nhau của "lead".

| Đặc trưng ngữ nghĩa | Tám từ hàng đầu |
|---|---|
| 1 | court, government, council, culture, supreme, constitutional, rights, justice |
| 2 | president, served, governor, secretary, senate, congress, presidential, elected |
| 3 | flowers, leaves, plant, perennial, flower, plants, growing, annual |
| 4 | disease, behaviour, glands, contact, symptoms, skin, pain, infection |

Mục bách khoa "Constitution of the United States": president (148), congress (124), power (120), united (104), constitution (81), amendment (71), government (57), law (49).

Hai đặc trưng chứa "lead": (a) metal process method paper ... glass copper lead steel; (b) person example time people ... rules lead leads law.

## Phương pháp

Các ảnh khuôn mặt dùng ở Hình 1 là ảnh chính diện căn chỉnh thủ công trên lưới 19 × 19. Với mỗi ảnh, cường độ thang xám trước hết được co giãn tuyến tính sao cho trung bình và độ lệch chuẩn của điểm ảnh bằng 0,25, rồi cắt về khoảng [0,1]. NMF được thực hiện bằng thuật toán lặp ở Hình 2, bắt đầu từ các điều kiện ban đầu ngẫu nhiên cho W và H. Thuật toán hội tụ phần lớn sau chưa đến 50 vòng lặp; kết quả trình bày là sau 500 vòng lặp, mất vài giờ tính toán trên máy Pentium II. PCA được thực hiện bằng chéo hóa ma trận VV^T; hiển thị 49 vectơ riêng ứng với các trị riêng lớn nhất. VQ được thực hiện bằng thuật toán k-means, bắt đầu từ các điều kiện ban đầu ngẫu nhiên cho W và H.

Trong ứng dụng phân tích ngữ nghĩa ở Hình 4, từ vựng được xác định là 15.276 từ thường gặp nhất trong cơ sở dữ liệu các bài viết Grolier, sau khi loại 430 từ phổ biến nhất như "the" và "and". Vì hầu hết các từ chỉ xuất hiện trong tương đối ít bài, ma trận đếm từ V cực kỳ thưa, giúp tăng tốc thuật toán. Kết quả trình bày là sau 50 lần lặp các quy tắc cập nhật ở Hình 2, bắt đầu từ các điều kiện ban đầu ngẫu nhiên cho W và H.

Nhận ngày 24 tháng 5; chấp nhận ngày 6 tháng 8 năm 1999.

1. Palmer, S. E. Hierarchical structure in perceptual representation. Cogn. Psychol. 9, 441–474 (1977).
2. Wachsmuth, E., Oram, M. W. & Perrett, D. I. Recognition of objects and their component parts:
responses of single units in the temporal cortex of the macaque. Cereb. Cortex 4, 509–522 (1994).
3. Logothetis, N. K. & Sheinberg, D. L. Visual object recognition. Annu. Rev. Neurosci. 19, 577–621
(1996).
