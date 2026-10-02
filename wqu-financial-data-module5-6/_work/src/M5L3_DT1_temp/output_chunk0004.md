2. Các worker xử lý phần dữ liệu của mình.
3. Manager thu thập kết quả từ các worker (giai đoạn gather) và kết hợp chúng theo yêu cầu của ứng dụng.

Snow có thể dùng với kết nối socket, Message Passing Interface (MPI), Parallel Virtual Machine (PVM) hoặc NetWorkSpaces [12, 13]. Truyền tải qua socket không cần gói bổ sung nào và có tính di động cao; nhóm tác giả dùng kết nối socket. Snow là ví dụ về hệ thống không chia sẻ bộ nhớ: với mạng các máy trạm, mỗi máy có bộ nhớ riêng, độc lập. Ngược lại, với trường hợp đa lõi trên một máy, bộ nhớ được chia sẻ giữa mọi tiến trình đang chạy. Ở cả hai trường hợp đều phải lưu ý chi phí truyền thông, vốn phụ thuộc vào nhiều yếu tố như ngữ nghĩa của mô hình lập trình, cấu trúc liên kết mạng, cách xử lý và định tuyến dữ liệu, cùng các giao thức phần mềm liên quan. Việc thêm bộ xử lý để giảm thời gian tính toán chỉ cải thiện được thời gian thực thi tổng thể ở mức hạn chế vì chi phí truyền thông không đổi.

Hình 1. Toàn bộ các lượt đề cập đến chủ đề "FUELPRICES" tại Tây Ban Nha.

## IV. Kết quả

### A. Kết quả từ dữ liệu GDELT GKG

Nhóm tác giả phân tích sắc thái (tone) của các lượt đề cập trong cơ sở dữ liệu GKG. Mọi lượt đề cập đều có chung các đặc điểm: tại một thời điểm có nhắc đến Tây Ban Nha như địa điểm; chủ đề "ENV_SOLAR" hoặc "FUELPRICES" được phát hiện trong văn bản; và dòng văn bản chứa một trong các từ: "gobierno", "government", "council", "ministers", "ministry", "ministro", "ministerio" (được hiểu là văn bản đề cập đến Chính phủ Tây Ban Nha). GDELT 2.0 và phiên bản GKG mới còn tương đối mới, nên dữ liệu thỏa các điều kiện này chỉ có từ ngày 18/02/2015 đến 28/10/2015. Do đây là dự án được cập nhật liên tục, để khép lại nghiên cứu, bài viết dùng dữ liệu thu được ở lần truy vấn Google BigQuery cuối cùng vào ngày 28/10/2015.

Các hình dưới đây thể hiện trung bình và độ lệch chuẩn của sắc thái các lượt đề cập. Hai nhóm được hiển thị và so sánh: toàn bộ lượt đề cập (không lọc từ khóa hay ngôn ngữ) và chỉ các lượt đề cập về chính phủ. Cột xanh biểu diễn giá trị trung bình của sắc thái, cột đen biểu diễn thanh sai số. Theo Hình 1 và biểu đồ tần suất ở Hình 3, chỉ số trung bình của các lượt đề cập về giá nhiên liệu và năng lượng gần với 0 khi chưa lọc theo chính phủ. Tuy nhiên, khi lọc theo các từ liên quan đến chính phủ, sắc thái tiêu cực xuất hiện rõ hơn nhiều.

Hình 2. Các lượt đề cập đến chủ đề "FUELPRICES" tại Tây Ban Nha, lọc theo từ khóa (đề cập về chính phủ).

Hình 3. Biểu đồ tần suất - Toàn bộ lượt đề cập đến chủ đề "FUELPRICES" tại Tây Ban Nha.

Hình 4. Biểu đồ tần suất - Các lượt đề cập đến chủ đề "FUELPRICES" tại Tây Ban Nha, lọc theo từ khóa (đề cập về chính phủ).

Để dùng dữ liệu này cho các kiểm định, trước hết cần kiểm tra các chỉ số có phân phối chuẩn hay không. Hình 5 và 6 trình bày biểu đồ Q-Q, tức biểu đồ xác suất, là phương pháp đồ thị so sánh hai phân phối xác suất bằng cách vẽ các phân vị của chúng theo nhau. Ở đây, biểu đồ Q-Q được dùng để so sánh dữ liệu với phân phối chuẩn có trung bình và độ lệch chuẩn theo mẫu. Về mặt hình thức, kiểm định Shapiro-Wilk [14] cho phép bác bỏ tính chuẩn. Ở mọi mẫu dữ liệu, giá trị trung bình gần 0 còn độ lệch chuẩn nằm trong khoảng 0,7 đến 1,7. Phân phối chuẩn đối xứng quanh trung bình, nhưng ở đây không như vậy: theo các hình, có một số giá trị dương cực đoan cân bằng với các giá trị âm xuất hiện thường xuyên hơn, nên sắc thái trung bình gần bằng 0.

Hình 5. Biểu đồ Q-Q - Toàn bộ lượt đề cập đến chủ đề "FUELPRICES" tại Tây Ban Nha.

Hình 6. Biểu đồ Q-Q - Các lượt đề cập đến chủ đề "FUELPRICES" tại Tây Ban Nha, lọc theo từ khóa.

Tiếp theo, nhóm thực hiện bài tập tương tự nhưng lọc trong GDELT một chủ đề khác là môi trường và năng lượng mặt trời (chủ đề "ENV_SOLAR") và phân tích sắc thái theo cách tương tự. Chỉ số cảm xúc cho thấy một số thông điệp có sắc thái tiêu cực khi không lọc theo các từ liên quan đến chính phủ; tuy nhiên, khi lọc theo các từ này, sắc thái tiêu cực xuất hiện rõ hơn.

Hình 7. Toàn bộ lượt đề cập đến chủ đề "ENV_SOLAR" tại Tây Ban Nha.

Hình 8. Các lượt đề cập đến chủ đề "ENV_SOLAR" tại Tây Ban Nha, lọc theo từ khóa (đề cập về chính phủ).

Hình 9. Biểu đồ tần suất - Toàn bộ lượt đề cập đến chủ đề "ENV_SOLAR" tại Tây Ban Nha.

Hình 10. Biểu đồ tần suất - Các lượt đề cập đến chủ đề "ENV_SOLAR" tại Tây Ban Nha, lọc theo từ khóa (đề cập về chính phủ).

Hình 11. Biểu đồ Q-Q - Toàn bộ lượt đề cập đến chủ đề "ENV_SOLAR" tại Tây Ban Nha.

Hình 12. Biểu đồ Q-Q - Các lượt đề cập đến chủ đề "ENV_SOLAR" tại Tây Ban Nha, lọc theo từ khóa.

Dù biểu đồ cho thấy khác biệt, kiểm định chuẩn Shapiro-Wilk không đưa ra nghi ngờ nào về tính chuẩn. Tuy nhiên, sắc thái trung bình tuy gần 0 nhưng mang dấu âm.

### B. Phân tích tương quan: giá và nhu cầu

Sắc thái do MeanALLFuel thu thập không khác 0 một cách có ý nghĩa ở các mức chuẩn. Dư luận có thể ảnh hưởng yếu, ở một mức độ nào đó, đến giá nhiên liệu và gián tiếp đến nhu cầu nhiên liệu trong ngắn hạn.

### C. Kết quả của thuật toán CTM

Phần này trình bày kết quả khi dùng thuật toán CTM để khám phá và tương quan hóa các chủ đề. Cần lưu ý thuật toán chỉ được áp dụng cho văn bản tiếng Tây Ban Nha. Gói R "topicmodels" cho phép hiển thị các đồ thị trong Hình 14. Với chủ đề "FUELPRICES" và văn bản tiếng Tây Ban Nha, cụm Group 1 tương ứng với các thẻ HTML hoặc những từ chưa được loại bỏ đúng cách, hoặc từ tiếng Anh xuất hiện trong các văn bản mà gói R "textcat" đã phân loại là tiếng Tây Ban Nha. Mặt khác, các cụm Group 3 và 6 liên quan đến các từ như (dịch từ tiếng Tây Ban Nha) "sàn chứng khoán", "thị trường", "chính phủ", "thu nhập", "châu Âu", "nhà nước", "quốc hội"..., còn "khí đốt", "giá", "tăng trưởng" và các địa danh Tây Ban Nha như "Madrid" hay "Barcelona" là những từ nằm trong các nhóm còn lại.

Hình 14. Dùng gói R "topicmodels". Chủ đề "FUELPRICES", văn bản tiếng Tây Ban Nha.
