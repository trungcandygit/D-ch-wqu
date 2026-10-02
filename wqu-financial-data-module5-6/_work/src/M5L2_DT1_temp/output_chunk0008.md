Trong thí nghiệm này, tác giả khảo sát xem trong 12 lớp encoder Transformer, lớp nào cho kết quả phân loại tốt nhất. Lớp phân loại được đặt sau token [CLS] của biểu diễn tương ứng; tác giả cũng thử lấy trung bình của tất cả các lớp. Như bảng 6 cho thấy, lớp cuối cùng đóng góp nhiều nhất vào hiệu năng mô hình trên mọi chỉ số đo được. Điều này có thể do hai yếu tố: 1) khi dùng các lớp cao hơn, mô hình được huấn luyện lớn hơn nên có thể mạnh hơn; 2) các lớp thấp nắm bắt thông tin ngữ nghĩa sâu hơn nên khó tinh chỉnh (fine-tune) thông tin đó cho bài toán phân loại.

## 6.4 Chỉ huấn luyện một tập con các lớp (RQ6)

BERT là mô hình rất lớn: ngay cả trên tập dữ liệu nhỏ, việc tinh chỉnh toàn bộ mô hình cũng tốn nhiều thời gian và tài nguyên tính toán. Do đó, nếu chỉ tinh chỉnh một tập con tham số mà hiệu năng giảm không đáng kể thì cách này có thể được ưu tiên trong một số bối cảnh, đặc biệt khi tập huấn luyện rất lớn. Ở đây tác giả thử nghiệm chỉ tinh chỉnh k lớp encoder cuối.

Kết quả được trình bày ở bảng 7. Chỉ tinh chỉnh lớp phân loại thì hiệu năng không tiến gần được so với tinh chỉnh các lớp khác. Tuy nhiên, chỉ tinh chỉnh lớp cuối đã vượt rõ rệt các phương pháp học máy tiên tiến như HSC. Từ Layer-9 trở đi, hiệu năng gần như không đổi và chỉ bị vượt bởi việc tinh chỉnh toàn bộ mô hình. Kết quả cho thấy để dùng BERT, không bắt buộc phải huấn luyện toàn bộ mô hình tốn kém; có thể đánh đổi hợp lý, giảm nhiều thời gian huấn luyện với mức giảm hiệu năng nhỏ.

## 6.5 Mô hình sai ở đâu?

Với độ chính xác 97% trên tập con của Financial PhraseBank có 100% người gán nhãn đồng thuận, tác giả cho rằng việc xem xét các trường hợp mô hình dự đoán sai nhãn thật là một bài tập thú vị. Vì vậy, phần này trình bày một số ví dụ mô hình dự đoán sai. Theo Malo et al. (2014) [17], phần lớn bất đồng giữa những người gán nhãn nằm ở nhãn tích cực và trung lập (mức đồng thuận khi phân tách tích cực-tiêu cực, tiêu cực-trung lập và tích cực-trung lập lần lượt là 98,7%, 94,2% và 75,2%). Các tác giả quy điều này cho khó khăn khi phân biệt "những lời tô vẽ thường dùng của công ty" với "các phát biểu tích cực thực sự". Tác giả sẽ trình bày ma trận nhầm lẫn để xem FinBERT có gặp tình trạng tương tự hay không.

Ví dụ 1: Pre-tax loss totaled euro 0.3 million , compared to a loss of euro 2.2 million in the first quarter of 2005 .
Giá trị thật: Tích cực; Dự đoán: Tiêu cực

Ví dụ 2: This implementation is very important to the operator , since it is about to launch its Fixed to Mobile convergence service in Brazil
Giá trị thật: Trung lập; Dự đoán: Tích cực

Ví dụ 3: The situation of coated magazine printing paper will continue to be weak .
Giá trị thật: Tiêu cực; Dự đoán: Trung lập

Ví dụ đầu là kiểu lỗi phổ biến nhất: mô hình không so sánh được con số nào lớn hơn, và khi thiếu các từ chỉ hướng như "increased" thì có thể dự đoán trung lập. Tuy vậy, cũng có nhiều trường hợp tương tự mà mô hình vẫn dự đoán đúng. Ví dụ 2 và 3 là các biến thể của cùng một kiểu lỗi: mô hình không phân biệt được một phát biểu trung lập về một tình huống với một phát biểu thể hiện phân cực (polarity) đối với công ty. Ở ví dụ 3, thông tin về hoạt động kinh doanh của công ty có lẽ sẽ giúp ích.

Ma trận nhầm lẫn được trình bày ở hình 4. 73% lỗi xảy ra giữa nhãn tích cực và tiêu cực, trong khi con số này với tiêu cực và tích cực là 5%. Điều này phù hợp với mức đồng thuận giữa người gán nhãn và với lẽ thường: phân biệt tích cực với tiêu cực dễ hơn, nhưng quyết định một phát biểu thể hiện triển vọng tích cực hay chỉ là quan sát khách quan thì khó hơn.

Hình 4: Ma trận nhầm lẫn

## 7 (Kết luận, phần cuối)

...dữ liệu lợi suất thị trường (cả về hướng và biến động) từ tin tức tài chính. FinBERT đủ tốt để trích xuất cảm xúc tường minh, nhưng mô hình hóa thông tin ngầm, vốn không nhất thiết hiển hiện ngay cả với người viết văn bản, sẽ là nhiệm vụ đầy thách thức. Một hướng mở rộng khác là dùng FinBERT cho các tác vụ xử lý ngôn ngữ tự nhiên (NLP) khác trong lĩnh vực tài chính như nhận dạng thực thể có tên hoặc hỏi đáp.

## 8 LỜI CẢM ƠN

Tác giả xin cảm ơn Pengjie Ren và Zulkuf Genc vì sự hướng dẫn xuất sắc, đã tạo cho tác giả sự tự chủ trong việc định hướng nghiên cứu cùng những gợi ý quý giá khi cần. Tác giả cũng cảm ơn nhóm Naspers AI đã tin tưởng giao dự án này và luôn khuyến khích chia sẻ công trình. Tác giả biết ơn NIST đã chia sẻ kho ngữ liệu Reuters TRC-2 và Malo et al. đã công bố rộng rãi Financial PhraseBank xuất sắc.
