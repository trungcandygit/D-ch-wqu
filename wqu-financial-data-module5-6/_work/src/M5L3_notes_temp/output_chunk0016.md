## **2.2 GDELT so với News Crawl**

Cả GDELT và News Crawl đều là các bộ dữ liệu mã nguồn mở tập trung vào phân tích tin tức. Cả hai đều cung cấp lượng lớn dữ liệu tin tức từ nhiều nguồn khác nhau. Cả hai đều cho phép phân tích các xu hướng và mẫu hình của tin tức. Cả hai đều được công khai và có thể dùng cho nghiên cứu và phân tích. Tuy nhiên, giữa chúng có một số khác biệt quan trọng:

  ------------------------------------------------------------------------------------------------------------------------------------------------
  Đặc trưng               News Crawl                                                 GDELT
  ----------------------- ---------------------------------------------------------- -------------------------------------------------------------
  Nguồn dữ liệu           Chủ yếu là các bài báo được thu thập qua\                  Các bài báo, bài đăng trên mạng xã hội\
                          nguồn cấp RSS và sơ đồ trang web (sitemap).                và các phương tiện truyền thông trực tuyến khác.

  Định dạng dữ liệu       HTML thô của các trang web (tệp WARC)                      CSV, JSON, GKG (Global Knowledge Graph)

  Trọng tâm               Cung cấp toàn bộ nội dung của các bài báo để phân tích.    Trích xuất sự kiện, thực thể và cảm xúc từ dữ liệu tin tức.

  Loại phân tích hỗ trợ   Khai phá văn bản, xử lý ngôn ngữ tự nhiên (NLP),\          Phát hiện sự kiện, phân tích cảm xúc,\
                          mô hình hóa chủ đề.                                        phân tích không gian địa lý và phân tích mạng lưới.

  Tần suất cập nhật       Cập nhật nhiều lần mỗi ngày.                               Cập nhật theo thời gian thực hoặc gần thời gian thực\
                                                                                     (mỗi 15 phút đối với GKG).

  Quy mô dữ liệu          Lớn (khoảng 600.000 bài báo mỗi ngày).                     Rất lớn (xử lý 100 triệu bài báo và bài đăng mỗi ngày).

  Khung thời gian         Dữ liệu có sẵn trong vài năm gần đây.                      Dữ liệu có sẵn từ năm 1979 đến nay.

  Ngôn ngữ                Hỗ trợ nhiều ngôn ngữ.                                     Hỗ trợ hơn 65 ngôn ngữ.

  Điểm mạnh               Truy cập được toàn bộ nội dung bài báo,\                   Dữ liệu đã được tiền xử lý, hiệu quả cho các tác vụ phân tích cụ thể,\
                          linh hoạt cho các phân tích tùy chỉnh.                     phân tích toàn diện về sự kiện và cảm xúc.

  Điểm yếu                Cần tiền xử lý nhiều hơn,\                                 Hạn chế trong việc truy cập nội dung gốc của bài báo,\
                          dữ liệu ít có cấu trúc hơn.                                có khả năng tồn tại thiên lệch trong thu thập dữ liệu.
  ------------------------------------------------------------------------------------------------------------------------------------------------

Những khác biệt chính giữa dữ liệu News Crawl và GDELT có thể được tóm tắt như sau:

-   Định dạng dữ liệu: News Crawl chủ yếu cung cấp toàn bộ nội dung HTML của các bài báo. Điều này có nghĩa là bạn nhận được trọn vẹn trang web như nó hiển thị trực tuyến. GDELT cung cấp dữ liệu ở nhiều định dạng như CSV, JSON và GKG. Việc lựa chọn định dạng phụ thuộc vào nhu cầu cụ thể và các công cụ dùng để phân tích. Nhiều định dạng của GDELT mang lại sự linh hoạt cho các kiểu phân tích khác nhau, trong khi HTML thô của News Crawl đòi hỏi xử lý nhiều hơn nhưng cho phép truy cập toàn bộ nội dung trang web.
-   Phân tích: GDELT cung cấp phân tích về sự kiện, sắc thái (tone) và cảm xúc. News Crawl cung cấp dữ liệu thô để bạn tự thực hiện phân tích của mình.
-   Tần suất cập nhật: GDELT được cập nhật theo thời gian thực hoặc gần thời gian thực. News Crawl cập nhật ít thường xuyên hơn, chỉ nhiều lần mỗi ngày.

Các bộ dữ liệu GDELT được công khai và chủ yếu lưu trữ trên Google Cloud Storage. Vị trí cụ thể và phương thức truy cập có thể khác nhau tùy theo bộ dữ liệu và định dạng. GDELT cung cấp nhiều bộ dữ liệu khác nhau. Global Knowledge Graph (GKG), Events và Mentions là các bộ dữ liệu chính của GDELT. Các bộ dữ liệu và công cụ bổ sung có thể được sử dụng kết hợp với các bộ dữ liệu chính để hiểu toàn diện hơn về các sự kiện toàn cầu, mức độ đưa tin và diễn ngôn công chúng. Nên khám phá toàn bộ các sản phẩm của GDELT trên trang web của họ để xem bộ dữ liệu và công cụ nào phù hợp nhất với nhu cầu của chúng ta <https://www.gdeltproject.org/data.html#rawdatafiles>. Trang web của GDELT cung cấp hướng dẫn và tài liệu chi tiết về cách truy cập dữ liệu.
