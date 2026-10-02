# M5L3_DT1

International Journal of Interactive Multimedia and Artificial Intelligence, Vol. 3, Nº6

# Sử dụng dữ liệu GDELT để đánh giá niềm tin đối với chính sách năng lượng của Chính phủ Tây Ban Nha

Diego J. Bodas-Sagi, José M. Labeaga
Universidad Francisco de Vitoria, Universidad Nacional de Educación a Distancia (UNED), Tây Ban Nha

**Tóm tắt** — Nhu cầu ngày càng tăng đối với điện năng giá phải chăng, đáng tin cậy, có nguồn cung trong nước và ít phát thải carbon là một mối quan tâm lớn, chịu tác động của nhiều nguyên nhân, trong đó có các ưu tiên chính sách công. Các mục tiêu chính sách và công nghệ mới đang thay đổi thiết kế thị trường điện bán buôn. Việc phân tích các khía cạnh khác nhau của thị trường năng lượng ngày càng được giới học thuật, nhà quản lý doanh nghiệp và nhà hoạch định chính sách chú ý. Một số mối quan tâm mang tính toàn cầu, gắn với diễn biến của biến đổi khí hậu; những mối quan tâm khác mang tính khu vực hoặc quốc gia và thể hiện rõ ở các nước như Tây Ban Nha, nơi phụ thuộc nhiều vào nguồn năng lượng nhập khẩu nhưng có tiềm năng lớn về năng lượng tái tạo trong nước. Một trường hợp điển hình là chính sách năng lượng mặt trời của Tây Ban Nha: chuỗi cải cách quy định từ năm 2010 đã cắt giảm doanh thu của các nhà máy phát điện tái tạo hiện hữu và chấm dứt hệ thống hỗ trợ trước đây dành cho các nguồn tái tạo mới. Thay đổi chính sách này đã làm biến đổi cơ cấu thị trường năng lượng và ảnh hưởng đến các quyết định đầu tư. Trong bài báo này, nhóm tác giả phân tích dư luận về chính sách năng lượng của Chính phủ Tây Ban Nha bằng Global Database of Events, Language, and Tone (GDELT). Dự án GDELT gồm hơn một phần tư tỷ bản ghi sự kiện thuộc hơn 300 danh mục, bao phủ toàn thế giới từ năm 1979 đến nay, cùng một mạng lưới khổng lồ kết nối mọi cá nhân, tổ chức, địa điểm và chủ đề với cơ sở dữ liệu sự kiện này. Mục tiêu là xây dựng các chỉ báo cảm xúc từ nguồn thông tin này và cuối cùng đánh giá xem các chỉ số tích cực và tiêu cực có ảnh hưởng đến diễn biến của các biến số thị trường chủ chốt như giá và nhu cầu hay không.

thiết kế thị trường. Một trường hợp điển hình là chính sách năng lượng mặt trời của Tây Ban Nha. Chuỗi cải cách quy định từ năm 2010 đã cắt giảm doanh thu của các nhà máy phát điện tái tạo hiện hữu và chấm dứt hệ thống hỗ trợ trước đây cho các nguồn tái tạo mới. Thay đổi này đã gây ra nhiều khiếu nại từ các tổ chức khác nhau và làm biến đổi cơ cấu thị trường năng lượng. Cuối cùng, Sắc lệnh Hoàng gia tháng 10/2015 đã tác động mạnh đến thị trường năng lượng mặt trời.

**Từ khóa** — Big Query, GDELT, dư luận, năng lượng, điện.

Phần còn lại của bài báo được cấu trúc như sau: trước hết là tóm lược về Dự án GDELT và mối liên hệ với mô hình dữ liệu lớn (Big Data). Mục 3 trình bày các công cụ, phương pháp và kỹ thuật được sử dụng. Kết quả được thảo luận ở mục 4. Bài báo kết thúc bằng một số hàm ý chính sách và hướng nghiên cứu tiếp theo.

## I. Giới thiệu

Chính sách công đóng vai trò then chốt trong việc điều tiết mối quan hệ giữa doanh nghiệp, nhà đầu tư và xã hội. Tầm quan trọng của chính sách công đối với nhà đầu tư dài hạn đã tăng trong những năm gần đây do [1]:

- Cải cách pháp luật khu vực tài chính sau khủng hoảng tài chính toàn cầu.
- Nhu cầu của chính phủ đối với nhà đầu tư như một nguồn tăng trưởng dài hạn.
- Tác động ngày càng lớn của các yếu tố môi trường, xã hội và quản trị đến khả năng mang lại lợi nhuận dài hạn của nhà đầu tư.

Thị trường năng lượng là một trường hợp then chốt để nghiên cứu tác động của chính sách công. Nhu cầu về điện năng giá phải chăng, đáng tin cậy, có nguồn cung trong nước và ít phát thải carbon đang tăng lên. Nhu cầu này "một phần do các ưu tiên chính sách công đang thay đổi, đặc biệt là giảm tác động của dịch vụ điện đến sức khỏe và môi trường… Các thị trường được thiết kế tốt khuyến khích những giải pháp hiệu quả về kinh tế, thúc đẩy đổi mới và giảm thiểu hệ quả ngoài ý muốn" [2]. Các mục tiêu chính sách và công nghệ mới đang thay đổi thiết kế thị trường bán buôn.

Phân tích dư luận về các biện pháp cụ thể của chính phủ có thể là một thành phần hữu ích cho các quyết định dài hạn của các tác nhân. Dư luận có thể ảnh hưởng đến nhà hoạch định chính sách ở nhiều giai đoạn của quá trình ra quyết định, và nhận thức của công chúng có thể tác động đến thiết kế các chương trình hay biện pháp chính sách. Các tác nhân trong mọi thị trường cũng có thể chịu ảnh hưởng bởi nhận thức tích cực và tiêu cực về doanh nghiệp. Trong mọi trường hợp, đại diện công quyền có thể quan tâm đến tình hình dư luận khi áp dụng các biện pháp có thể làm méo mó thị trường.

Trong bài báo này, nhóm tác giả phân tích dư luận về chính sách năng lượng của Chính phủ Tây Ban Nha bằng Global Database of Events, Language, and Tone (GDELT). Dự án GDELT [3] gồm hơn một phần tư tỷ bản ghi sự kiện thuộc hơn 300 danh mục, bao phủ toàn thế giới từ năm 1979 đến nay. Mục tiêu là xây dựng các chỉ báo cảm xúc từ nguồn thông tin này và cuối cùng đánh giá xem các chỉ số tích cực và tiêu cực có ảnh hưởng đến diễn biến của các biến số thị trường chủ chốt như giá và nhu cầu hay không. Nhóm tác giả không cố đánh giá quan hệ nhân quả từ các chỉ báo cảm xúc đến các biến số thị trường, mà chỉ nhằm phát hiện sự tồn tại của tương quan giữa các biến số đó.
