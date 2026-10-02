 - Hạn chế từ nhà xuất bản: Một số nhà xuất bản tin tức có thể chọn giới hạn việc phân phối toàn bộ nội dung bài viết qua API. Họ có thể chỉ cung cấp tiêu đề, bản tóm tắt hoặc nội dung một phần. Trong những trường hợp đó, News API có thể thay phần nội dung không khả dụng bằng "[Removed]".
 - Chính sách của News API: Bản thân News API có thể có các chính sách nhằm ngăn việc thu thập (scraping) hoặc phân phối lại toàn văn bài viết. Họ có thể chủ ý xóa hoặc cắt bớt nội dung để tuân thủ quy định về bản quyền hoặc thỏa thuận với nhà xuất bản.
 - Lọc nội dung: Trong một số trường hợp, News API có thể áp dụng bộ lọc nội dung để loại bỏ nội dung nhạy cảm hoặc không phù hợp. Điều này cũng có thể khiến "[Removed]" xuất hiện thay cho nội dung bị lọc.

Đáng tiếc là không có cách trực tiếp nào để lấy lại nội dung đã bị xóa thông qua News API. Chúng ta cần truy cập toàn văn bài viết trên website của nguồn gốc, nếu có.

News API cho phép **lọc các bài viết tin tức theo danh mục (category)**. Chúng ta có thể chỉ định tham số category trong yêu cầu API để lấy tin từ một danh mục cụ thể, chẳng hạn business, entertainment, general, health, science, sports và technology.

Những lưu ý quan trọng:
 - Mức độ khả dụng của danh mục: Việc một số danh mục có khả dụng hay không có thể thay đổi tùy theo gói News API và khu vực địa lý mà chúng ta nhắm tới.
 - Mức độ liên quan: Danh mục business là điểm khởi đầu tốt cho tin tức tài chính, nhưng cũng có thể bao gồm các bài viết không thực sự liên quan đến tài chính. Chúng ta có thể cần lọc thêm kết quả theo từ khóa hoặc các tiêu chí khác để tinh chỉnh phần lựa chọn.
 - Ngôn ngữ và quốc gia: Chúng ta có thể tinh chỉnh thêm việc tìm kiếm bằng cách chỉ định các tham số language và country để lấy tin từ một khu vực cụ thể và bằng một ngôn ngữ cụ thể.

Đáng tiếc là News API không hỗ trợ trực tiếp việc tìm kiếm đồng thời nhiều danh mục bằng tham số category. Chúng ta chỉ có thể chỉ định một danh mục mỗi lần. Tuy nhiên, có thể đạt kết quả tương tự bằng cách gửi các yêu cầu API riêng cho từng danh mục rồi kết hợp các kết quả lại.

Một hạn chế đáng kể của việc tìm kiếm theo danh mục là NEWS API hiện không hỗ trợ tham số category trên endpoint `https://newsapi.org/v2/everything`. Thay vào đó, chúng ta nên dùng endpoint `https://newsapi.org/v2/top-headlines`. Endpoint này cho phép lọc theo danh mục. Tuy nhiên, endpoint này có một số hạn chế so với `/everything`:
 - Số bài viết giới hạn: Endpoint trả về một số lượng bài viết giới hạn (thường là 20-30 tiêu đề hàng đầu) cho một truy vấn và danh mục nhất định. Nó không nhằm mục đích truy xuất tin tức toàn diện.
 - Tập trung vào tin mới: Endpoint chủ yếu tập trung vào tin tức gần đây và có thể không bao gồm các bài viết cũ hơn.
 - Hạn chế về nguồn: Endpoint chỉ lấy bài viết từ một tập hợp giới hạn các nguồn tin phổ biến và nổi tiếng, do đó có thể bỏ sót các ấn phẩm nhỏ hơn.
