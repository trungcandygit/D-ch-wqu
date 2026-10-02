# M5L3_DT2

# Trích xuất thông tin từ cơ sở dữ liệu GDELT để phân tích thị trường trái phiếu chính phủ EU

Sergio Consoli, Luca Tiozzo Pezzoli và Elisa Tosetti

Trung tâm Nghiên cứu Chung (Joint Research Centre), Ủy ban châu Âu, Ispra, Ý; Khoa Quản lý, Đại học Ca' Foscari Venezia, Ý.

**Tóm tắt.** Bài viết giới thiệu tổng quan một dự án đang triển khai nhằm xây dựng phương pháp tạo các chỉ báo kinh tế và tài chính phản ánh cảm xúc của nhà đầu tư và mức độ phổ biến của các chủ đề, hữu ích cho việc phân tích thị trường trái phiếu chính phủ của các nước EU. Các chỉ báo thay thế này được lấy từ cơ sở dữ liệu Global Data on Events, Location, and Tone (GDELT), một kho lưu trữ thời gian thực, mã nguồn mở, quy mô lớn về xã hội loài người trên toàn cầu phục vụ nghiên cứu mở; GDELT theo dõi tin tức phát thanh, báo in và web trên thế giới, tạo nên một nền tảng mở miễn phí để tính toán trên toàn bộ truyền thông thế giới. Sau phần tổng quan về phương pháp đang phát triển, bài trình bày một số kết quả sơ bộ với trường hợp nước Ý. Kết quả cho thấy phương pháp bước đầu dự báo tốt thị trường trái phiếu chính phủ Ý, sử dụng thông tin trích xuất từ GDELT và mạng bộ nhớ dài-ngắn hạn sâu (Long Short-Term Memory) được huấn luyện và kiểm định theo cửa sổ trượt để nắm bắt tốt tính phi tuyến của dữ liệu.

**Từ khóa:** dữ liệu lớn, chênh lệch lợi suất trái phiếu chính phủ, GDELT, học máy, xây dựng đặc trưng.

## 1. Giới thiệu và kiến thức nền

Các chính sách kinh tế và tài khóa do tổ chức quốc tế, chính phủ và ngân hàng trung ương hoạch định phụ thuộc nhiều vào dự báo kinh tế, đặc biệt trong giai đoạn bất ổn như đại dịch COVID-19 lan rộng toàn cầu [30]. Tuy nhiên, độ chính xác của các mô hình dự báo và dự báo nhanh (nowcasting) vẫn còn nhiều hạn chế, vì các nền kinh tế hiện đại chịu nhiều cú sốc khiến việc dự báo trở nên cực kỳ khó, cả ngắn hạn lẫn trung - dài hạn.

Trong bối cảnh đó, công nghệ dữ liệu lớn (Big Data) mới có tiềm năng cao để cải thiện dự báo và dự báo nhanh cho nhiều ứng dụng kinh tế - tài chính. Trong dự án đang triển khai, nhóm tác giả thiết kế phương pháp trích xuất các chỉ báo kinh tế - tài chính thay thế, phản ánh cảm xúc nhà đầu tư, mức độ phổ biến của chủ đề và các sự kiện kinh tế, chính trị, từ Global Database of Events, Language and Tone (GDELT) [17], một cơ sở dữ liệu tin tức lớn và mới. GDELT là kho lưu trữ thời gian thực, mã nguồn mở, quy mô lớn về xã hội loài người, theo dõi tin phát thanh, báo in và web trên thế giới. Các chỉ báo dựa trên tin tức trích từ GDELT có thể được dùng làm đặc trưng thay thế để bổ sung cho mô hình dự báo và dự báo nhanh khi phân tích thị trường trái phiếu chính phủ của các nước EU.

Quy mô rất lớn của GDELT khiến không thể dùng cơ sở dữ liệu quan hệ và đòi hỏi giải pháp quản trị dữ liệu lớn chuyên biệt để phân tích trong thời gian hợp lý. Ở đây, sau khi dữ liệu GDELT được thu thập từ web bằng REST API tự xây dựng, nhóm dùng Elasticsearch [13,24] để lưu trữ và truy vấn dữ liệu. Elasticsearch là hệ quản trị dữ liệu lớn NoSQL phổ biến và hiệu quả, có công cụ tìm kiếm dựa trên thư viện Lucene để biến đổi, lưu trữ và truy vấn dữ liệu hiệu quả.

Sau khi dữ liệu GDELT được lưu vào hạ tầng Elasticsearch, một quy trình chọn đặc trưng sẽ chọn các biến có tiềm năng dự báo cao hơn để phân tích thị trường trái phiếu chính phủ của nước EU đang nghiên cứu. Các biến được chọn phản ánh, trong số khác, cảm xúc nhà đầu tư, các sự kiện kinh tế - chính trị và mức độ phổ biến của các chủ đề tin tức về nước đó. Những biến bổ sung này được đưa vào các mô hình dự báo và dự báo nhanh kinh tế nhằm cải thiện hiệu quả. Nghiên cứu hiện nay thử nghiệm nhiều mô hình, từ mô hình kinh tế truyền thống đến các phương pháp học máy mới như Gradient Boosting Machines và mạng nơ-ron hồi quy (RNN), vốn đã tỏ ra thành công trong nhiều bài toán dự báo kinh tế - tài chính (xem [4,6-8,16,18,29] và các tài liệu khác).

Chú thích: GDELT: https://blog.gdeltproject.org/ ; API: https://blog.gdeltproject.org/gdelt-2-0-our-global-world-in-realtime/ ; Lucene: https://lucene.apache.org/.

## 2. Các nghiên cứu liên quan

Sự gia tăng mạnh gần đây của chênh lệch lợi suất trái phiếu chính phủ ở các nước khu vực đồng euro đã làm dấy lên tranh luận sôi nổi về các yếu tố quyết định và nguồn rủi ro của chênh lệch này. Theo truyền thống, các yếu tố như mức độ tín nhiệm, rủi ro thanh khoản của trái phiếu chính phủ và mức ngại rủi ro toàn cầu được xem là những nhân tố chính tác động đến chênh lệch lợi suất trái phiếu chính phủ [3,22]. Tuy nhiên, các nghiên cứu gần đây chỉ ra vai trò quan trọng của cảm xúc nhà đầu tư tài chính trong việc dự đoán diễn biến lãi suất [19,26]. Một bài báo sớm sử dụng biến cảm xúc tính từ các bài báo của Wall Street Journal là [26]; công trình này cho thấy mức bi quan cao là chỉ báo đáng kể cho sự hội tụ của giá cổ phiếu về giá trị cơ bản
