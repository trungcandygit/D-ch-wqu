từ mẫu trong mẫu (in-sample) sang ngoài mẫu (out-of-sample), nhưng khoảng chênh lệch này hoàn toàn chấp nhận được, xác nhận khả năng khái quát hóa tốt của mô hình LSTM đã huấn luyện. Mô hình đạt hiệu suất cao hơn ở các phân vị cao (0,9) và thấp (0,1) với tổn thất phân vị có trọng số thấp hơn. Hình 5 minh họa sai số dự báo tuyệt đối trung vị (MAFE, màu cam) so với các quan sát thực của chuỗi thời gian (màu xanh).

![Hình 5](Fig5)

Hình 5. Sai số dự báo tuyệt đối (MAFE) (màu cam) so với quan sát thực (màu xanh).

Hiệu suất của mô hình giảm nhẹ từ cuối tháng 5 đến tháng 7/2018, tương ứng với giai đoạn bất ổn chính trị tại Ý. Thật vậy, ngày 29/5, chênh lệch lợi suất của Ý tăng mạnh, lên tới 250 điểm cơ bản. Nhà đầu tư đặc biệt lo ngại khả năng hình thành chính phủ chống đồng euro và thiếu niềm tin vào việc lập được một chính phủ ổn định. Từ tháng 6 đến tháng 11/2018, hàng loạt tranh luận về các cam kết chi tiêu thâm hụt và khả năng xung đột với các quy tắc tài khóa châu Âu tiếp tục khiến thị trường lo lắng. Chênh lệch lợi suất tăng mạnh vào tháng 10 và 11 với mức khoảng 300 điểm cơ bản. Điều này cũng thể hiện qua hiệu suất của mô hình, vốn giảm đôi chút trong giai đoạn căng thẳng này, nhưng nhìn chung mô hình vẫn xử lý khá tốt. Từ năm 2019, tình hình chính trị Ý bắt đầu cải thiện và chênh lệch lợi suất giảm dần, nhất là sau thỏa thuận với Brussels về thâm hụt ngân sách vào tháng 12/2018. Tuy nhiên, sau đó một số sự kiện đã tác động đến kinh tế Ý, như triển vọng tiêu cực của EU và cuộc bầu cử Nghị viện châu Âu, góp phần làm lãi suất tăng tạm thời. Trong giai đoạn này mô hình hoạt động khá tốt xét theo các tỷ lệ sai số tuyệt đối, cho thấy độ vững (robustness) tốt.

Hình 6 là biểu đồ phân tán giữa các điểm dự báo trung vị ngoài mẫu và các quan sát thực. Ở mức độ nào đó, các điểm trên biểu đồ bám khá sát đường chéo, cho thấy tương quan tốt giữa giá trị dự báo và quan sát thực, hàm ý chất lượng dự báo tốt. Điều này cũng được xác nhận bởi giá trị R-squared chấp nhận được là 0,23 trên các dự báo trung vị ngoài mẫu, đối với một bài toán dự báo nhiều thách thức như vậy. Giá trị R-squared này cho thấy mô hình LSTM giải thích được khá nhiều biến thiên của dữ liệu phản hồi quanh trung vị, gợi ý mức độ gần nhau nhất định giữa dữ liệu dự báo và quan sát thực.

![Hình 6](Fig6)

Hình 6. Biểu đồ phân tán giữa các điểm dự báo trung vị ngoài mẫu và các quan sát thực.

## 6. Kết luận và triển vọng

Bài báo trình bày công việc đang thực hiện về phương pháp xây dựng các chỉ báo kinh tế và tài chính thay thế, nắm bắt cảm xúc của nhà đầu tư và mức độ phổ biến của các chủ đề từ GDELT (Global Data on Events, Location, and Tone), một cơ sở dữ liệu nền tảng mở miễn phí chứa tin tức phát thanh, báo in và web toàn cầu theo thời gian thực. Dự án đang triển khai nhằm tạo ra các phương pháp dự báo cải tiến để phân tích thị trường trái phiếu chính phủ của các nước EU. Chúng tôi đã báo cáo một số kết quả sơ bộ khi áp dụng phương pháp này để dự báo thị trường trái phiếu chính phủ Ý. Trường hợp này cho thấy hiệu suất ban đầu tốt, gợi ý tính hợp lệ của cách tiếp cận. Nhờ sử dụng thông tin trích xuất từ truyền thông tin tức Ý trong GDELT kết hợp với mạng học sâu Long Short-Term Memory được huấn luyện và kiểm định phù hợp theo phương pháp cửa sổ trượt (rolling window), chúng tôi đã thu được kết quả dự báo khá tốt.

Đây là một trong những công trình đầu tiên nghiên cứu hành vi của chênh lệch lợi suất trái phiếu chính phủ và các quyết định danh mục đầu tư tài chính khi có mặt các nhân tố đường cong lợi suất cổ điển và thông tin trích xuất từ tin tức. Chúng tôi tin rằng các thước đo mới này có thể nắm bắt và dự báo các thay đổi trong động lực lãi suất, đặc biệt trong giai đoạn bất ổn. Nhìn chung, bài báo cho thấy cách dùng một cơ sở dữ liệu quy mô lớn như GDELT để xây dựng các chỉ báo tài chính nhằm nắm bắt ý định tương lai của các tác nhân trên thị trường trái phiếu chính phủ.

Chắc chắn cần nghiên cứu thêm theo các hướng đã nêu. Trước hết, chúng tôi sẽ cố gắng cải thiện hiệu suất của mô hình DeepAR đã triển khai bằng cách tinh chỉnh kiến trúc và tối ưu siêu tham số của mô hình LSTM. Ngoài ra, trong nghiên cứu hiện tại chúng tôi đang thử nghiệm các mô hình dự báo khác, từ phương pháp kinh tế truyền thống đến các phương pháp học máy mới, gồm Gradient Boosting Machines và các phương pháp dự báo bằng mạng nơ-ron. Trong phiên bản mở rộng sau này, chúng tôi sẽ so sánh và phân tích kỹ hiệu suất các phương pháp này để khai thác tốt hơn các tác động phi tuyến của các biến phụ thuộc. Khả năng diễn giải của các mô hình học máy, chẳng hạn bằng giá trị Shapley, sẽ là đối tượng nghiên cứu quan trọng trong tương lai nhằm đánh giá chính xác đóng góp của các biến đồng hành khác nhau vào dự báo của mô hình.

**Lời cảm ơn.** Các tác giả cảm ơn các đồng nghiệp tại Centre for Advanced Studies thuộc Joint Research Centre của Ủy ban châu Âu vì sự hướng dẫn và hỗ trợ hữu ích trong quá trình thực hiện nghiên cứu này.

## Tài liệu tham khảo

1. Agrawal, S., Azar, P., Lo, A.W., Singh, T.: Momentum, mean-reversion and social
media: evidence from StockTwits and Twitter. J. Portfolio Manag. 44, 85–95
(2018)
2. Alexandrov, A., et al.: GluonTS: probabilistic time series models in Python. CoRR,
abs/1906.05264 (2019). http://arxiv.org/abs/1906.05264
3. Beber, A., Brandt, M.W., Kavajecz, K.A.: Flight-to-quality or flight-to-liquidity?
Evidence from the Euro-area bond market. Rev. Financ. Stud. 22(3), 925–957
(2009)
4. Benidis, K., et al.: Neural forecasting: introduction and literature overview. CoRR,
