các yếu tố cổ điển vào mô hình. Do lợi suất trái phiếu chính phủ là quá trình có tính dai dẳng cao và không dừng, nhóm tác giả dùng sai phân logarit để thu được chuỗi dừng gồm các thay đổi hằng ngày, đóng vai trò biến mục tiêu dự báo (Hình 1). Bài toán dự báo này cực kỳ khó vì chuỗi mục tiêu hành xử gần giống bước ngẫu nhiên (random walk). Dữ liệu thiếu do cuối tuần và ngày lễ được loại bỏ khỏi chuỗi thời gian mục tiêu, còn lại 468 điểm dữ liệu.

Hình 1. Sai phân logarit của chênh lệch lợi suất trái phiếu chính phủ Ý so với Đức, tức lợi suất trái phiếu Ý kỳ hạn 10 năm trừ lợi suất trái phiếu Đức tương ứng.

Với nghiên cứu tình huống Ý, nhóm tác giả cũng trích xuất thông tin tin tức từ GKG trong GDELT, lấy từ khoảng 20 tờ báo của Ý xuất bản trong giai đoạn phân tích. Sau bước chọn lọc, thu được tổng cộng 18.986 bài báo, với 2.978 GCAM, 1.996 chủ đề (Themes) và 155 địa điểm. Áp dụng quy trình chọn đặc trưng nêu trên, nhóm trích xuất được 31 chiều từ từ điển tâm lý xã hội General Inquirer Harvard IV, 61 chiều từ Roget's Thesaurus, 7 chiều từ Martindale Regressive Imagery và 3 chiều từ từ điển Affective Norms for English Words (ANEW). Sau khâu xây dựng đặc trưng, còn lại tổng cộng 45 biến, gồm 9 chủ đề, 34 GCAM và 2 địa điểm. Các chủ đề được chọn gồm những chủ đề WB như Lạm phát, Chính phủ, Ngân hàng trung ương, Thuế và Chính sách, vốn là những vấn đề quan trọng được báo chí thảo luận khi đề cập đến lãi suất. Ngoài ra, các đặc trưng GCAM được chọn gồm sự lạc quan, bi quan hay mức độ kích thích (arousal), phản ánh trạng thái cảm xúc của thị trường. Hình 2 cho thấy các biến đồng biến có tương quan cao nhất với mục tiêu.

Hình 2. Sai phân logarit của chênh lệch lợi suất trái phiếu chính phủ Ý so với Đức, tức lợi suất trái phiếu Ý kỳ hạn 10 năm trừ lợi suất trái phiếu Đức tương ứng.

Nhiều nghiên cứu cho thấy trong các giai đoạn căng thẳng, quan hệ phi tuyến phức tạp giữa các biến giải thích ảnh hưởng đến hành vi của biến mục tiêu mà các mô hình tuyến tính đơn giản không nắm bắt được. Vì vậy, trong thực nghiệm này nhóm dùng mạng bộ nhớ dài-ngắn hạn sâu (LSTM) [15] để mô hình hóa tốt tính phi tuyến và đánh giá sức dự báo của các biến GDELT được chọn. LSTM được triển khai dựa trên mô hình DeepAR trong Gluon Time Series (GluonTS) [2]^9, một thư viện mã nguồn mở cho mô hình hóa chuỗi thời gian xác suất, tập trung vào các phương pháp học sâu và giao tiếp với Apache MXNet^10. DeepAR là mô hình LSTM hoạt động trong khuôn khổ xác suất: dự báo không chỉ giới hạn ở dự báo điểm mà là dự báo xác suất theo phân phối dự báo do người dùng định nghĩa (ở đây phân phối t-Student được chọn bằng thực nghiệm). Thực nghiệm dùng 2 lớp RNN, mỗi lớp 40 ô LSTM, tốc độ học 0,001. Số epoch huấn luyện là 500, với hàm mất mát huấn luyện là log-hợp lý âm.

^9 Xem tại: https://gluon-ts.mxnet.io/#gluonts-probabilistic-time-series-modeling.
^10 Xem tại: https://mxnet.apache.org/.

Các biến huấn luyện được co giãn bền vững (robust scaling) bằng các thống kê ít nhạy với ngoại lai: trừ trung vị khỏi mỗi chuỗi thời gian rồi co giãn theo khoảng tứ phân vị. Ngoài ra, nhóm dùng kỹ thuật ước lượng cửa sổ trượt, với mẫu ước lượng đầu tiên bắt đầu từ đầu tháng 3 đến tháng 5/2017. Với mỗi cửa sổ, dự báo trước một bước được tính toán. Toàn bộ thực nghiệm chạy song song vài giờ trên 40 lõi 2,10 GHz của máy chủ Intel(R) Xeon(R) E7 64-bit có tổng cộng 1 TB RAM dùng chung.

Hình 3. Dự báo trung vị (xanh lá) và quan sát của chuỗi mục tiêu (xanh dương) trong toàn bộ giai đoạn dự báo.

Hình 3 thể hiện quan sát của chuỗi thời gian mục tiêu (đường xanh dương) cùng dự báo trung vị (đường xanh lá đậm) và khoảng tin cậy (xanh lá nhạt). Để dễ thấy chênh lệch giữa chuỗi quan sát và chuỗi dự báo, Hình 4 vẽ lại cùng đồ thị trên khoảng thời gian ngắn hơn (50 ngày). Phân tích định tính cho thấy mô hình dự báo nắm bắt khá tốt mức dao động và biến động của chuỗi thời gian.

Nhóm cũng tính một số thước đo đánh giá thông dụng [21]: sai số tỷ lệ tuyệt đối trung bình (MASE), sai số phần trăm tuyệt đối trung bình đối xứng (sMAPE), căn sai số bình phương trung bình (RMSE) và các hàm mất mát phân vị có trọng số (wQuantileLoss), tức mất mát log-hợp lý âm theo phân vị có trọng số theo mật độ. Kết quả trong mẫu và ngoài mẫu được trình bày ở Bảng 1. Đúng như kỳ vọng, kết quả xấu đi khi chuyển

Hình 4. Dự báo xác suất (xanh lá) và quan sát của chuỗi mục tiêu (xanh dương) cho 50 ngày đầu của giai đoạn kiểm tra. Đường xanh lá liền là trung vị của các dự báo xác suất, còn các vùng xanh lá nhạt hơn biểu thị khoảng tin cậy cao hơn.

Bảng 1. Kết quả dự báo của mô hình LSTM theo các thước đo sai số MASE, sMAPE, RMSE và wQuantileLoss.

| Thước đo | LSTM: Trong mẫu | LSTM: Ngoài mẫu |
|---|---|---|
| MASE | 0.112 | 0.682 |
| sMAPE | 0.130 | 1.148 |
| RMSE | 0.493 | 0.885 |
| wQuantileLoss[0.1] | 0.050 | 0.869 |
| wQuantileLoss[0.3] | 0.115 | 0.899 |
| wQuantileLoss[0.5] | 0.151 | 0.914 |
| wQuantileLoss[0.7] | 0.121 | 0.923 |
| wQuantileLoss[0.9] | 0.047 | 0.907 |
