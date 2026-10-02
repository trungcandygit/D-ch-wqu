(tiếp theo) ... và [23], trong số những nghiên cứu khác, sử dụng phân bổ Dirichlet tiềm ẩn (Latent Dirichlet allocation, LDA) để phân loại bài báo theo chủ đề và tính các thước đo cảm xúc đơn giản dựa trên phân loại chủ đề đó. Mục tiêu là trích xuất tín hiệu có thể có giá trị dự báo đối với các thước đo hoạt động kinh tế như GDP, thất nghiệp và lạm phát [11]. Kết quả cho thấy cảm xúc kinh tế là bổ sung hữu ích cho các biến dự báo thường dùng để theo dõi và dự báo chu kỳ kinh doanh [7].

Các phương pháp học máy trong tài liệu hiện có nhằm kiểm soát các chỉ số tài chính đo lường rủi ro tín dụng, rủi ro thanh khoản và mức ngại rủi ro gồm các công trình [2,4,8,9,18], cùng nhiều công trình khác. Nỗ lực đưa các mô hình học máy vào lĩnh vực mô hình hóa kinh tế đã tăng nhanh theo cấp số nhân trong những năm gần đây [19,24]. Trong các phương pháp học máy phổ biến, Gradient Boosting machines đã tỏ ra thành công trong nhiều bài toán dự báo thuộc kinh tế và tài chính (xem [5,6,16,28], cùng nhiều công trình khác).

## 3. Dữ liệu

### 3.1. Về GDELT

GDELT là cơ sở dữ liệu toàn cầu về sự kiện, địa điểm và sắc thái do Google duy trì [15]. Đây là nền tảng Dữ liệu lớn (Big Data) mở về tin tức thu thập trên toàn thế giới, chứa dữ liệu có cấu trúc khai thác từ nguồn tin truyền hình, báo in và web bằng hơn 65 ngôn ngữ. GDELT liên kết con người, tổ chức, trích dẫn, địa điểm, chủ đề và cảm xúc gắn với các sự kiện trên thế giới; mô tả hành vi xã hội qua lăng kính truyền thông, nên là nguồn dữ liệu lý tưởng để đo các yếu tố xã hội và kiểm định giả thuyết. Về quy mô, GDELT phân tích hơn 88 triệu bài báo mỗi năm từ hơn 150.000 cơ quan báo chí; dung lượng khoảng 8 TB, tăng thêm 2 TB mỗi năm. GDELT gồm hai bộ dữ liệu chính: "Global Knowledge Graph (GKG)" và "Events Table"; nghiên cứu này dùng bộ thứ nhất. GKG ghi nhận điều đang diễn ra trên thế giới, bối cảnh, những ai liên quan và thế giới cảm nhận ra sao, mỗi ngày; đồng thời cung cấp bản dịch tiếng Anh của thông tin đã mã hóa từ các ngôn ngữ được hỗ trợ. Ngoài ra, các chủ đề được ánh xạ sang các hệ phân loại chủ đề thông dụng trong thực tiễn, như "World Bank (WB) Topical Ontology" (3), hoặc hệ phân loại chủ đề tích hợp của GDELT. GDELT cũng đo hàng nghìn chiều cảm xúc dựa trên các từ điển phổ biến như "Harvard IV-4 Psychosocial Dictionary" (4), "WordNet-Affect dictionary" (5) và "Loughran and McDonald Sentiment Word Lists dictionary" (6), cùng các từ điển khác. Trong ứng dụng này, chúng tôi dùng các trường GKG của GDELT gồm World Bank Topical Ontology (tức các chủ đề WB), toàn bộ chiều cảm xúc (GCAM) và tên cơ quan báo chí.

Chú thích:
- (3) https://vocabulary.worldbank.org/taxonomy.html
- (4) http://www.wjh.harvard.edu/~inquirer/homecat.htm
- (5) http://wndomains.fbk.eu/wnaffect.html
- (6) https://sraf.nd.edu/textualanalysis/resources/

### 3.2. Chênh lệch lợi suất

Chúng tôi trích dữ liệu từ Bloomberg về cấu trúc kỳ hạn của lợi suất trái phiếu chính phủ Ý trong giai đoạn 2/3/2015 đến 31/8/2019. Chênh lệch lợi suất trái phiếu chính phủ (sovereign spread) của Ý so với Đức được tính bằng lợi suất trái phiếu kỳ hạn 10 năm của Ý trừ lợi suất tương ứng của Đức. Chúng tôi cũng trích các nhân tố chuẩn về mức (level), độ dốc (slope) và độ cong (curvature) của cấu trúc kỳ hạn bằng phương pháp Nelson và Siegel [21].

Chúng tôi ước lượng mô hình dự báo chênh lệch tín dụng dùng các nhân tố đường cong lợi suất thông thường cùng các đặc trưng GDELT được chọn, và so sánh với mô hình dự báo cổ điển chỉ dùng mức, độ dốc và độ cong làm biến hồi quy.

## 4. Phương pháp

### 4.1. Quản lý Dữ liệu lớn

Các bộ dữ liệu phi cấu trúc khổng lồ như GDELT cần được lưu trong hệ thống tệp phân tán (DFS) chuyên dụng, kết nối nhiều nút tính toán qua mạng, vốn thiết yếu để xây dựng các đường ống dữ liệu phân lớp và tổng hợp lượng thông tin lớn này. Trong các nền tảng DFS phổ biến, do lượng tài liệu phi cấu trúc khổng lồ từ GDELT, chúng tôi dùng Elasticsearch [12,22] để lưu trữ và tương tác với dữ liệu. Elasticsearch là kho tài liệu phổ biến và hiệu quả; thay vì lưu thông tin thành các hàng dữ liệu dạng cột như cơ sở dữ liệu quan hệ cổ điển, nó lưu các cấu trúc dữ liệu phức tạp được tuần tự hóa thành tài liệu JSON. Được xây dựng trên thư viện tìm kiếm Apache Lucene (7), nó cung cấp tìm kiếm và phân tích thời gian thực cho nhiều loại dữ liệu có cấu trúc hoặc phi cấu trúc.

Elasticsearch có kiến trúc phân tán, cho phép nối nhiều nút Elasticsearch thành một cụm duy nhất. Ngay khi tài liệu được lưu, nó được lập chỉ mục và có thể tìm kiếm đầy đủ gần như theo thời gian thực. Một chỉ mục (index) Elasticsearch có thể xem là tập hợp tài liệu được tối ưu hóa, mỗi tài liệu là tập hợp các trường (field), tức các cặp khóa-giá trị chứa dữ liệu. Chỉ mục thực chất chỉ là nhóm logic gồm một hoặc nhiều phân mảnh (shard) vật lý, mỗi phân mảnh là một chỉ mục tự chứa.

Elasticsearch cũng không cần lược đồ (schema-less): tài liệu có thể được lập chỉ mục mà không cần chỉ định rõ cách xử lý từng trường có thể xuất hiện. Elasticsearch cung cấp REST API đơn giản để quản lý cụm và tương tác với tài liệu đã lưu; có thể gửi yêu cầu API trực tiếp từ dòng lệnh hoặc qua Developer Console trong giao diện web người dùng, gọi là Kibana (8). Các REST API của Elasticsearch hỗ trợ truy vấn có cấu trúc, truy vấn toàn văn và truy vấn phức hợp kết hợp cả hai, dùng ngôn ngữ truy vấn kiểu JSON của Elasticsearch, gọi là Query DSL (9).

Chú thích:
- (7) https://lucene.apache.org/
- (8) Kibana, phiên bản 7.4: https://www.elastic.co/guide/en/kibana/7.4/
