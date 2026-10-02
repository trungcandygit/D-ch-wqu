Cuối cùng, chúng tôi áp dụng thuật toán Mô hình chủ đề tương quan (Correlated Topics Models, CTM) [7], dựa trên thuật toán Phân bổ Dirichlet ẩn (Latent Dirichlet Allocation, LDA) [8], lên các từ trong các đề cập, tin tức hoặc tài liệu viết bằng tiếng Tây Ban Nha. Phần còn lại của tập dữ liệu không được đưa vào phần nghiên cứu này. Chúng tôi không trộn lẫn các ngôn ngữ, vì những từ có nghĩa tương tự nhưng thuộc các ngôn ngữ khác nhau có thể rơi vào các chủ đề khác nhau do cách viết khác nhau. Việc đánh giá các ngôn ngữ khác được để lại cho nghiên cứu tương lai. Gói R "topicmodels" [9] cho phép chạy các thuật toán LDA và CTM.

LDA cho phép khám phá các chủ đề trong các tập dữ liệu lớn được mô tả thông qua chủ đề. LDA không cần dữ liệu có nhãn (học không giám sát) và dùng một thủ tục ngẫu nhiên để sinh vectơ trọng số chủ đề. LDA biểu diễn tài liệu như hỗn hợp của các chủ đề, mỗi chủ đề sinh ra các từ với những xác suất nhất định; đây là mô hình túi từ (bag-of-words). Vì vậy, LDA có thể dùng cho mô hình hóa và phân loại tài liệu. Tuy nhiên, LDA không mô hình hóa trực tiếp được tương quan giữa sự xuất hiện của các chủ đề, trong khi đôi khi sự hiện diện của một chủ đề có tương quan với chủ đề khác (ví dụ: "kinh tế" và "kinh doanh"). CTM rất giống LDA, ngoại trừ việc tỷ trọng chủ đề được rút từ phân phối chuẩn logistic thay vì phân phối Dirichlet. Áp dụng gói R "topicmodels" lên tập dữ liệu, chúng tôi thu được danh sách từ cho mỗi chủ đề và đồng thời kiểm tra tương quan giữa các chủ đề thu được.

A. Lấy văn bản của các tài liệu

Như đã nêu, lấy văn bản của tài liệu là giai đoạn tốn nhiều tính toán vì phải xử lý các thẻ HTML và trích xuất văn bản. Công việc gồm các bước sau:

1. Trước hết, truy cập tài liệu qua URL của nó.
2. Phát hiện ngôn ngữ văn bản bằng gói R "textcat" [10]. Nếu tài liệu viết bằng tiếng Tây Ban Nha hoặc tiếng Anh thì tải văn bản về và xác nhận văn bản chứa một trong các từ sau: "gobierno", "government", "council", "ministers", "ministry", "ministro", "ministerio". Nếu không, coi như văn bản không đề cập đến Chính phủ Tây Ban Nha. Lưu ý rằng vị trí Tây Ban Nha được tham chiếu trong văn bản theo siêu dữ liệu GKG.
3. Với mọi văn bản đã tải, làm sạch bằng cách loại bỏ thẻ HTML và từ dừng (stop-words, tiếng Tây Ban Nha và tiếng Anh) để cải thiện độ chính xác và hiệu năng; bước này làm giảm kích thước văn bản. Từ dừng là những từ phổ biến nhất trong một ngôn ngữ, nhưng với mục tiêu của nghiên cứu thì chúng không bổ sung giá trị cho phân tích chủ đề.

Nghiên cứu đã thử cả chế độ thực thi tuần tự và song song. Thuật toán song song, trái với thuật toán tuần tự truyền thống, là thuật toán có thể thực thi từng phần trên nhiều thiết bị xử lý hay bộ xử lý khác nhau, rồi ghép lại ở cuối để có kết quả đúng.

Lợi ích của kiểu song song hóa này là một khi đã biết cấu trúc chương trình, chỉ cần thay đổi đôi chút để chương trình chạy trên nhiều bộ xử lý, khác với thuật toán phân tán vốn phải thiết lập trước cấu trúc truyền thông tối ưu, thường kéo theo những thay đổi lớn đối với chương trình.

Hai sơ đồ song song hóa được đánh giá. Sơ đồ thứ nhất tận dụng nhiều lõi trong một máy tính. Sơ đồ thứ hai dùng kiến trúc chủ-tớ (master-slave) [11]: một bộ xử lý duy nhất chạy thuật toán chính (master) và giao nhiệm vụ lấy văn bản cho một nhóm bộ xử lý (slave). Các slave chịu trách nhiệm xử lý URL, lấy văn bản và gửi kết quả về tiến trình trung tâm.

Trong mọi trường hợp, nếu có $p$ bộ xử lý thì tập dữ liệu gốc được chia thành $p$ phần, mỗi bộ xử lý chỉ xử lý một phần. Trong mọi thí nghiệm, chúng tôi dùng máy tính Pentium V bốn lõi, RAM 8 GB, hệ điều hành Centos 6.4. Tốc độ băng thông Internet khoảng 20 Mbps (tốc độ tải xuống). Hiệu năng thường được đo bằng hệ số tăng tốc (Speedup, Sp) và hiệu suất (Efficiency, Ep):

$$S_p = T_1 / T_p \tag{1}$$

$$E_p = S_p / p \tag{2}$$

trong đó $p$ là số bộ xử lý, $T_1$ là thời gian thực thi của thuật toán tuần tự và $T_p$ là thời gian thực thi của bản cài đặt song song trên $p$ bộ xử lý.

Gói Simple Network of Workstations (snow) [12] cho phép thực thi mã song song trong R. Gói yêu cầu tải mã, tải thư viện snow, tạo cụm snow (hoặc chạy ở chế độ cục bộ bằng CPU đa lõi) và chạy mã, theo đúng thứ tự này. Thư viện snow có thể dùng để khởi chạy các tiến trình R mới (worker) trên máy. Gói snow theo mô hình phân tán/thu thập (scatter/gather), hoạt động như sau:

1. Manager chia dữ liệu thành các phần và phân phát cho các worker (giai đoạn scatter).

[Kết quả] ... cho thấy cảm xúc của các tin tức liên quan đến chính sách năng lượng mặt trời là tiêu cực trong giai đoạn này. Cần nhớ rằng vào tháng 10/2015 chính phủ ban hành cái gọi là "thuế mặt trời" ("impuesto al sol"), điều chỉnh việc tiêu thụ của những người tiêu dùng tự sản xuất điện bằng hệ thống quang điện. Các thảo luận trên truyền thông không bắt đầu vào thời điểm công bố Sắc lệnh Hoàng gia ngày 9/10/2015 mà đã diễn ra trước đó vài tháng, ngay khi các tác nhân biết ý định của chính phủ. Vì vậy không lạ khi cảm xúc của các tác nhân sản xuất tin tức là tiêu cực.

Mặt khác, khi đưa từ "government" vào làm biến kiểm soát để xây dựng chỉ số cảm xúc, giá trị trung bình như trình bày ở các hình 2 và 4 còn tiêu cực hơn. Như vậy, các tác nhân (nhà sản xuất, người tiêu dùng, v.v.) thể hiện rõ phản ứng tiêu cực đối với giá nhiên liệu và năng lượng, và chúng tôi gắn điều này với các quy định trên thị trường năng lượng liên quan đến các biến đó. Ý kiến của các nước châu Âu xung quanh và của các cơ quan có thẩm quyền của EU cũng tiêu cực đối với quy định này.

2. Các worker xử lý phần dữ liệu của mình.
