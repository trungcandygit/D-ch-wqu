Theo Malo và cộng sự (2014) [17], phần lớn bất đồng giữa các người gán nhãn nằm ở cặp nhãn tích cực và trung lập (mức đồng thuận khi phân tách tích cực-tiêu cực, tiêu cực-trung lập và tích cực-trung lập lần lượt là 98,7%, 94,2% và 75,2%). Các tác giả cho rằng nguyên nhân là khó phân biệt "lối nói hoa mỹ thường dùng của doanh nghiệp" với "các phát biểu tích cực thực sự". Bài báo trình bày ma trận nhầm lẫn để kiểm tra xem FinBERT có gặp tình trạng tương tự hay không.

Trong thí nghiệm về lớp, bài báo khảo sát lớp nào trong 12 lớp bộ mã hóa Transformer cho kết quả phân loại tốt nhất, bằng cách đặt lớp phân loại lên các biểu diễn token [CLS] của từng lớp; đồng thời thử lấy trung bình của tất cả các lớp. Như bảng 6 cho thấy, lớp cuối cùng đóng góp nhiều nhất vào hiệu năng mô hình ở mọi chỉ số đo. Điều này có thể phản ánh hai yếu tố: 1) khi dùng các lớp cao hơn, mô hình được huấn luyện lớn hơn nên có thể mạnh hơn; 2) các lớp thấp nắm bắt thông tin ngữ nghĩa sâu hơn nên khó tinh chỉnh (fine-tune) thông tin đó cho bài toán phân loại.

## 6.4. Chỉ huấn luyện một tập con các lớp (RQ6)

BERT là mô hình rất lớn. Ngay cả trên tập dữ liệu nhỏ, tinh chỉnh toàn bộ mô hình cũng đòi hỏi nhiều thời gian và sức mạnh tính toán. Vì vậy, nếu chỉ tinh chỉnh một tập con tham số mà hiệu năng giảm nhẹ thì có thể là lựa chọn đáng ưu tiên trong một số bối cảnh, nhất là khi tập huấn luyện rất lớn. Ở đây, bài báo thử nghiệm chỉ tinh chỉnh k lớp bộ mã hóa cuối cùng.

Kết quả được trình bày ở bảng 7. Chỉ tinh chỉnh lớp phân loại thì không đạt hiệu năng gần với việc tinh chỉnh các lớp khác. Tuy nhiên, chỉ tinh chỉnh lớp cuối cùng đã vượt dễ dàng các phương pháp học máy hiện đại như HSC. Từ Layer-9 trở đi, hiệu năng gần như không đổi và chỉ bị việc tinh chỉnh toàn bộ mô hình vượt qua. Kết quả này cho thấy để tận dụng BERT, không bắt buộc phải huấn luyện toàn bộ mô hình tốn kém; có thể đánh đổi hợp lý để giảm mạnh thời gian huấn luyện với mức giảm hiệu năng nhỏ.

## 6.5. Mô hình sai ở đâu?

Với độ chính xác 97% trên tập con của Financial PhraseBank có 100% đồng thuận giữa người gán nhãn, bài báo cho rằng việc xem xét các trường hợp mô hình dự đoán sai nhãn thật là một bài tập thú vị. Do đó, phần này trình bày một số ví dụ mô hình dự đoán sai.

Ví dụ 1: Pre-tax loss totaled euro 0.3 million , compared to a loss of euro 2.2 million in the first quarter of 2005 .
Giá trị thật: Tích cực; Dự đoán: Tiêu cực

Ví dụ 2: This implementation is very important to the operator , since it is about to launch its Fixed to Mobile convergence service in Brazil
Giá trị thật: Trung lập; Dự đoán: Tích cực

Ví dụ 3: The situation of coated magazine printing paper will continue to be weak .
Giá trị thật: Tiêu cực; Dự đoán: Trung lập

Ví dụ đầu tiên thực ra là kiểu lỗi phổ biến nhất. Mô hình không thực hiện được phép so sánh con số nào lớn hơn, và khi thiếu các từ chỉ hướng như "increased" thì có thể dự đoán trung lập. Tuy vậy, cũng có nhiều trường hợp tương tự mà mô hình dự đoán đúng. Ví dụ 2 và 3 là các biến thể của cùng một kiểu lỗi: mô hình không phân biệt được phát biểu trung lập về một tình huống với phát biểu mang phân cực (polarity) đối với công ty. Ở ví dụ thứ ba, thông tin về hoạt động kinh doanh của công ty có lẽ sẽ giúp ích.

Ma trận nhầm lẫn được trình bày ở hình 4. 73% số lỗi xảy ra giữa nhãn tích cực và trung lập, trong khi con số này là 5% giữa tiêu cực và tích cực. Điều này nhất quán với cả mức đồng thuận giữa người gán nhãn lẫn lẽ thường: phân biệt tích cực với tiêu cực dễ hơn, còn xác định một phát biểu thể hiện triển vọng tích cực hay chỉ là quan sát khách quan thì khó hơn.

Hình 4: Ma trận nhầm lẫn

## 7. Kết luận (đoạn cuối)

... dữ liệu lợi suất thị trường (cả về hướng lẫn biến động) trên tin tức tài chính. FinBERT đủ tốt để trích xuất các cảm xúc tường minh, nhưng mô hình hóa thông tin ẩn, vốn không nhất thiết hiển nhiên ngay cả với người viết văn bản, sẽ là nhiệm vụ đầy thách thức. Một hướng mở rộng khác là dùng FinBERT cho các tác vụ xử lý ngôn ngữ tự nhiên (NLP) khác như nhận dạng thực thể có tên hoặc hỏi đáp trong lĩnh vực tài chính.

## 8. Lời cảm ơn

Tác giả xin bày tỏ lòng biết ơn tới Pengjie Ren và Zulkuf Genc vì sự hướng dẫn xuất sắc: họ vừa để tác giả tự chủ định hướng nghiên cứu, vừa đưa ra những góp ý quý giá khi cần. Tác giả cũng cảm ơn nhóm Naspers AI đã tin tưởng giao dự án này và luôn khuyến khích chia sẻ công trình; biết ơn NIST đã chia sẻ kho ngữ liệu Reuters TRC-2, và Malo và cộng sự đã công bố công khai Financial PhraseBank xuất sắc.
