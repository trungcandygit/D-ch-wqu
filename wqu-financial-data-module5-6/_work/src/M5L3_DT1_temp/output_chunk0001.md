# M5L3_DT1

International Journal of Interactive Multimedia and Artificial Intelligence, Vol. 3, Nº6

# Dùng dữ liệu GDELT để đánh giá niềm tin vào chính sách năng lượng của Chính phủ Tây Ban Nha

Diego J. Bodas-Sagi, José M. Labeaga
Universidad Francisco de Vitoria, Universidad Nacional de Educación a Distancia (UNED), Tây Ban Nha

**Tóm tắt** — Nhu cầu ngày càng tăng về điện giá phải chăng, đáng tin cậy, có nguồn trong nước và phát thải carbon thấp là mối quan tâm lớn, chịu tác động của nhiều nguyên nhân, trong đó có các ưu tiên chính sách công. Mục tiêu chính sách và công nghệ mới đang thay đổi thiết kế thị trường bán buôn. Việc phân tích các khía cạnh của thị trường năng lượng ngày càng được giới học thuật, nhà quản lý doanh nghiệp và nhà hoạch định chính sách quan tâm. Một số mối lo mang tính toàn cầu, gắn với diễn biến biến đổi khí hậu; số khác mang tính khu vực hoặc quốc gia, thể hiện rõ ở những nước như Tây Ban Nha, vốn phụ thuộc nhiều vào nguồn năng lượng nước ngoài nhưng có tiềm năng năng lượng tái tạo nội địa lớn. Chính sách năng lượng mặt trời của Tây Ban Nha là một trường hợp tiêu biểu: chuỗi cải cách quy định từ năm 2010 đã làm giảm doanh thu của các nhà phát điện tái tạo hiện hữu và chấm dứt cơ chế hỗ trợ trước đây cho các nguồn tái tạo mới. Thay đổi này làm biến đổi cơ cấu thị trường năng lượng và ảnh hưởng đến quyết định đầu tư. Bài báo phân tích dư luận về chính sách năng lượng của Chính phủ Tây Ban Nha bằng Global Database of Events, Language, and Tone (GDELT). Dự án GDELT gồm hơn một phần tư tỷ bản ghi sự kiện thuộc hơn 300 danh mục, bao phủ toàn thế giới từ năm 1979 đến nay, cùng một mạng lưới khổng lồ liên kết mọi cá nhân, tổ chức, địa điểm và chủ đề với cơ sở dữ liệu sự kiện này. Mục tiêu của nhóm tác giả là xây dựng các chỉ số cảm xúc từ nguồn thông tin này và sau cùng đánh giá liệu các chỉ số tích cực và tiêu cực có ảnh hưởng đến diễn biến của các biến thị trường chủ chốt như giá và nhu cầu hay không.

**Từ khóa** — Big Query, GDELT, dư luận, năng lượng, điện.

## I. Giới thiệu

Chính sách công đóng vai trò then chốt trong điều tiết quan hệ giữa doanh nghiệp, nhà đầu tư và xã hội. Tầm quan trọng của chính sách công đối với nhà đầu tư dài hạn tăng lên trong những năm gần đây do [1]:

- Cải cách lập pháp khu vực tài chính sau khủng hoảng tài chính toàn cầu.
- Nhu cầu của chính phủ đối với nhà đầu tư như một nguồn tăng trưởng dài hạn.
- Tác động ngày càng lớn của các yếu tố môi trường, xã hội và quản trị đối với khả năng mang lại lợi suất dài hạn của nhà đầu tư.

Thị trường năng lượng là một trường hợp then chốt để nghiên cứu tác động của chính sách công. Nhu cầu về điện giá phải chăng, đáng tin cậy, có nguồn trong nước và phát thải carbon thấp đang tăng, "một phần do các ưu tiên chính sách công thay đổi, đặc biệt là giảm tác động của dịch vụ điện đến sức khỏe và môi trường… Thị trường được thiết kế tốt khuyến khích các giải pháp hiệu quả về kinh tế, thúc đẩy đổi mới và giảm thiểu hệ quả ngoài ý muốn" [2].

Mục tiêu chính sách và công nghệ mới đang thay đổi thiết kế thị trường bán buôn. Chính sách năng lượng mặt trời của Tây Ban Nha là một trường hợp tiêu biểu: chuỗi cải cách quy định từ năm 2010 đã giảm doanh thu của các nhà phát điện tái tạo hiện hữu và chấm dứt cơ chế hỗ trợ trước đây cho các nguồn tái tạo mới. Thay đổi này dẫn đến nhiều khiếu nại từ các tổ chức khác nhau và làm biến đổi cơ cấu thị trường năng lượng. Cuối cùng, Sắc lệnh Hoàng gia tháng 10/2015 đã tác động mạnh đến thị trường năng lượng mặt trời.

Phân tích dư luận về các biện pháp cụ thể của chính phủ có thể là một thành phần hữu ích cho một số quyết định dài hạn của các tác nhân. Dư luận có thể ảnh hưởng đến nhà hoạch định chính sách ở nhiều giai đoạn của quá trình ra quyết định, và nhận thức của công chúng có thể tác động đến thiết kế chương trình chính trị hay biện pháp chính sách. Các tác nhân trên thị trường cũng có thể chịu ảnh hưởng bởi nhận thức tích cực và tiêu cực về doanh nghiệp. Dù thế nào, đại diện công quyền có thể quan tâm đến tình hình dư luận khi áp dụng những biện pháp có thể làm méo mó thị trường.

Bài báo phân tích dư luận về chính sách năng lượng của Chính phủ Tây Ban Nha bằng Global Database of Events, Language, and Tone (GDELT). Dự án GDELT [3] gồm hơn một phần tư tỷ bản ghi sự kiện thuộc hơn 300 danh mục, bao phủ toàn thế giới từ năm 1979 đến nay. Mục tiêu là xây dựng các chỉ số cảm xúc từ nguồn thông tin này và sau cùng đánh giá liệu các chỉ số tích cực và tiêu cực có ảnh hưởng đến diễn biến của các biến thị trường chủ chốt như giá và nhu cầu hay không. Nhóm tác giả không nhằm đánh giá quan hệ nhân quả từ các chỉ số cảm xúc đến biến thị trường, mà chỉ phát hiện sự tồn tại của tương quan giữa các biến đó.

Phần còn lại của bài báo được bố cục như sau: trước hết là tóm tắt ngắn về Dự án GDELT và mối liên hệ với mô hình Dữ liệu lớn (Big Data). Mục 3 giải thích các công cụ, phương pháp và kỹ thuật được dùng. Kết quả được thảo luận ở mục 4. Bài báo kết thúc bằng một số hàm ý chính sách và gợi ý cho nghiên cứu tiếp theo.
