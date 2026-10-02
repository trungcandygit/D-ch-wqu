# M5L3_DT3

# Sử dụng bộ dữ liệu GDELT để phân tích thị trường trái phiếu chính phủ Ý

Sergio Consoli, Luca Tiozzo Pezzoli và Elisa Tosetti
European Commission, Joint Research Centre, Directorate A-Strategy, Work Programme and Resources, Scientific Development Unit, Via E. Fermi 2749, 21027 Ispra, VA, Italy
sergio.consoli@ec.europa.eu

**Tóm tắt.** GDELT (Global Data on Events, Location, and Tone) là cơ sở dữ liệu quy mô lớn, thời gian thực về xã hội loài người toàn cầu, phục vụ nghiên cứu mở; nó theo dõi tin tức phát thanh, báo in và báo mạng trên thế giới, tạo thành một nền tảng mở miễn phí để tính toán trên toàn bộ truyền thông thế giới. Trước hết, nhóm tác giả mô tả một trình thu thập dữ liệu (crawler) lấy siêu dữ liệu của GDELT theo thời gian thực và lưu vào hệ thống quản lý dữ liệu lớn dựa trên Elasticsearch, một công cụ tìm kiếm phổ biến và hiệu quả dựa trên thư viện Lucene. Sau đó, bằng cách khai thác và xử lý thông tin chi tiết của từng bản tin được mã hóa trong GDELT, nhóm xây dựng các chỉ báo phản ánh cảm xúc của nhà đầu tư, hữu ích cho việc phân tích thị trường trái phiếu chính phủ Ý. Dùng phân tích hồi quy và mô hình Gradient Boosting của học máy, nhóm nhận thấy các đặc trưng trích xuất từ GDELT cải thiện dự báo chênh lệch lợi suất trái phiếu chính phủ so với hồi quy cơ sở chỉ gồm các biến hồi quy truyền thống. Mức cải thiện về độ khớp đặc biệt rõ trong giai đoạn khủng hoảng chính phủ từ tháng 5 đến tháng 12/2018.

**Từ khóa:** chênh lệch lợi suất trái phiếu chính phủ · học máy · quản lý dữ liệu lớn · hồi quy phân vị · xây dựng đặc trưng (feature engineering) · GDELT

## 1. Giới thiệu

Sự bùng nổ của công nghệ tính toán và thông tin trong thập kỷ qua đã tạo ra lượng dữ liệu khổng lồ ở nhiều lĩnh vực, gọi là dữ liệu lớn (Big Data). Trong kinh tế và tài chính, việc khai thác các dữ liệu này đưa nghiên cứu và thực tiễn kinh doanh lại gần nhau, vì dữ liệu sinh ra từ hoạt động kinh tế thường ngày có thể dùng cho các hệ thống kinh tế học nhanh, liên tục cải thiện và cá nhân hóa mô hình. Việc ứng dụng công nghệ khoa học dữ liệu vào kinh tế và tài chính mang lại lợi ích cho cả nhà khoa học lẫn người làm nghề, cải thiện dự báo và dự báo tức thời (nowcasting) trong nhiều loại ứng dụng.

Cụ thể, đợt tăng mạnh gần đây của chênh lệch lợi suất trái phiếu chính phủ ở các nước khu vực đồng Euro đã làm dấy lên tranh luận sôi nổi về các yếu tố quyết định và nguồn rủi ro của chênh lệch lợi suất trái phiếu chính phủ. Theo truyền thống, các yếu tố như mức độ tín nhiệm, rủi ro thanh khoản của trái phiếu chính phủ và mức ngại rủi ro toàn cầu được xem là nhân tố chính tác động đến chênh lệch lợi suất [2,20]. Tuy nhiên, văn liệu gần đây chỉ ra vai trò quan trọng của cảm xúc nhà đầu tư tài chính trong việc dự đoán diễn biến lãi suất [17,25].

Bài báo khai thác một cơ sở dữ liệu tin tức mã nguồn mở mới là Global Database of Events, Language and Tone (GDELT)¹ [15] để xây dựng các chỉ báo tài chính dựa trên tin tức, liên quan đến các sự kiện kinh tế và chính trị của một nhóm nước khu vực đồng Euro. Như mô tả ở Mục 3.1, do quy mô của GDELT khiến việc dùng cơ sở dữ liệu quan hệ để phân tích trong thời gian hợp lý là không khả thi, Mục 4.1 trình bày hạ tầng quản lý dữ liệu lớn dùng để lưu trữ và tương tác với dữ liệu. Sau khi dữ liệu GDELT được thu thập từ Web bằng các REST API² tùy biến, nhóm biến đổi và lưu chúng một cách hiệu quả vào hệ thống quản lý dữ liệu lớn dựa trên Elasticsearch, một công cụ tìm kiếm NoSQL phổ biến và hiệu quả (Mục 4.1).

Tiếp theo, quy trình xây dựng đặc trưng được áp dụng lên thông tin chi tiết mã hóa trong GDELT (Mục 4.2) nhằm chọn các biến hữu ích nhất, phản ánh, trong số khác, cảm xúc của nhà đầu tư và mức độ phổ biến của các chủ đề tin tức, phục vụ phân tích thị trường trái phiếu chính phủ Ý. Mục 4.3 mô tả mô hình Gradient Boosting được dùng để phân tích thị trường này. Phân tích thực nghiệm ở Mục 4.4 cho thấy mô hình học máy sử dụng các chỉ báo GDELT đã xây dựng có ích trong dự báo chênh lệch lợi suất trái phiếu chính phủ và bất ổn tài chính, phù hợp với các nghiên cứu trước.

## 2. Các nghiên cứu liên quan

Các bài báo tin tức là nguồn thông tin mới được bổ sung vào dữ liệu chuẩn dùng để mô hình hóa các biến kinh tế và tài chính. Một nghiên cứu sớm là [25], dùng cảm xúc từ một chuyên mục của Wall Street Journal để chỉ ra rằng mức bi quan cao là yếu tố dự báo đáng kể cho sự hội tụ của giá cổ phiếu về giá trị cơ bản. Tiếp sau đó, nhiều bài báo khác tìm hiểu vai trò của tin tức trong dự báo, chẳng hạn các thông báo của doanh nghiệp, lợi suất cổ phiếu và biến động. Ví dụ, trong tài chính có các công trình gần đây áp dụng phân tích cảm xúc ngữ nghĩa từ mạng xã hội, vi blog tài chính và tin tức để cải thiện dự đoán thị trường chứng khoán (ví dụ [1,7]). Tuy nhiên, các cách tiếp cận này thường bị hạn chế do phạm vi nguồn tài chính lịch sử sẵn có hẹp. Gần đây tin tức cũng được dùng trong kinh tế vĩ mô. Chẳng hạn, [13] xem xét nội dung thông tin trong các tuyên bố của Cục Dự trữ Liên bang Mỹ và định hướng mà chúng cung cấp về diễn biến chính sách tiền tệ trong tương lai. Các bài báo khác ([26,27] và [23], trong số

¹ Trang web GDELT: https://blog.gdeltproject.org/.
² Xem https://blog.gdeltproject.org/gdelt-2-0-our-global-world-in-realtime/.
