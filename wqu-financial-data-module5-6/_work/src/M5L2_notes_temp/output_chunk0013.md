# **4. Kịch bản: Mô hình hóa chủ đề của tin tức tài chính**

Giờ đây, chúng ta sẽ sử dụng dữ liệu từ News API để khám phá các chủ đề tiềm ẩn trong các bài báo tài chính liên quan đến Microsoft và phân tích cảm xúc gắn với từng chủ đề.

**Mô hình hóa chủ đề** (topic modeling) là một kỹ thuật học máy không giám sát dùng để khám phá các cấu trúc chủ đề hay các chủ đề tiềm ẩn trong một tập hợp văn bản (còn gọi là **kho ngữ liệu**, corpus). Kỹ thuật này nhằm tự động nhận diện các nhóm từ thường xuyên xuất hiện cùng nhau trong các văn bản, đại diện cho những chủ đề hoặc nội dung nền tảng. Các thuật toán mô hình hóa chủ đề thường hoạt động dựa trên giả định rằng mỗi văn bản là sự pha trộn của một số ít chủ đề, và mỗi chủ đề được đặc trưng bởi một phân phối của các từ. Mục tiêu là học các phân phối chủ đề này cùng với việc gán chủ đề cho từng văn bản.

Các thuật ngữ chính:

 - **Văn bản (Document):** Một đơn vị văn bản đơn lẻ, chẳng hạn như một bài báo, một bài đăng blog hoặc một tweet.
 - **Kho ngữ liệu (Corpus):** Một tập hợp các văn bản.
 - **Chủ đề (Topic):** Một cấu trúc chủ đề tiềm ẩn trong kho ngữ liệu, được biểu diễn bằng một phân phối của các từ.
 - **Phân phối văn bản-chủ đề (Document-Topic Distribution):** Xác suất hoặc trọng số của từng chủ đề trong mỗi văn bản.
 - **Phân phối chủ đề-từ (Topic-Word Distribution):** Xác suất hoặc trọng số của từng từ trong mỗi chủ đề.

Phân rã ma trận không âm (NMF) là một kỹ thuật mạnh mẽ để khám phá các chủ đề tiềm ẩn trong dữ liệu văn bản. Khi áp dụng vào tin tức tài chính, chúng ta có thể phát hiện các chủ đề chính đang được thảo luận về Microsoft. Việc kết hợp mô hình hóa chủ đề với phân tích cảm xúc giúp hiểu sâu hơn về cảm xúc gắn với các chủ đề khác nhau. Điều này có thể giúp xác định những lĩnh vực mà công ty nhận được nhận định tích cực hoặc tiêu cực. Những hiểu biết thu được từ phân tích này có thể hỗ trợ các quyết định đầu tư, quản trị rủi ro và chiến lược quan hệ công chúng.

**Các bước triển khai:**

 - **Chuẩn bị dữ liệu:** Chúng ta sẽ sử dụng DataFrame `df` hiện có chứa dữ liệu News API, chọn cột 'Description' làm dữ liệu văn bản để phân tích. Chúng ta sẽ tiền xử lý dữ liệu văn bản (loại bỏ từ dừng, dấu câu, rút gọn gốc từ/chuẩn hóa từ vựng).

 - **Tạo ma trận văn bản-thuật ngữ (TDM):** Sau đó, chúng ta sẽ tạo ma trận văn bản-thuật ngữ bằng TF-IDF (Term Frequency-Inverse Document Frequency). Ma trận này biểu diễn tần suất hoặc mức độ quan trọng của từng từ trong mỗi văn bản.

 - **Áp dụng NMF:** Chúng ta áp dụng NMF lên ma trận văn bản-thuật ngữ để phân rã thành hai ma trận: ma trận $W$ biểu diễn mức độ quan trọng của từng chủ đề trong mỗi văn bản và ma trận $H$ biểu diễn mức độ quan trọng của từng từ trong mỗi chủ đề.

 - **Trích xuất và diễn giải chủ đề:** Truy cập ma trận chủ đề-từ ($H$) để xem xét các từ hàng đầu của từng chủ đề. Xác định các từ có trọng số cao nhất trong mỗi hàng của $H$ để hiểu nội dung của từng chủ đề. Dựa trên các từ hàng đầu, chúng ta đặt tên có ý nghĩa cho các chủ đề để dễ diễn giải.

 - **Gán chủ đề cho văn bản:** Lấy ma trận văn bản-chủ đề ($W$) để gán chủ đề chiếm ưu thế cho các văn bản. Với mỗi văn bản, chúng ta tìm chủ đề có trọng số cao nhất trong hàng tương ứng của $W$. Cách này gán chủ đề nổi bật nhất cho mỗi văn bản.
