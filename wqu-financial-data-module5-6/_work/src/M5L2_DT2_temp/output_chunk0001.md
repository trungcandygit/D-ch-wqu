# M5L2_DT2

FinBERT: Mô hình ngôn ngữ tiền huấn luyện cho truyền thông tài chính

Yi Yang, Mark Christopher Siy UY, Allen Huang
School of Business and Management, Hong Kong University of Science and Technology
{imyiyang,acahuang}@ust.hk, mcsuy@connect.ust.hk

Tóm tắt (Abstract)

Các mô hình ngôn ngữ tiền huấn luyện theo ngữ cảnh, như BERT (Devlin et al., 2019), đã tạo đột phá ở nhiều tác vụ NLP nhờ huấn luyện trên lượng lớn văn bản chưa gán nhãn. Lĩnh vực tài chính cũng tích lũy rất nhiều văn bản truyền thông tài chính, nhưng chưa có mô hình ngôn ngữ tiền huấn luyện chuyên biệt cho tài chính. Nghiên cứu này đáp ứng nhu cầu đó bằng cách tiền huấn luyện mô hình BERT chuyên ngành tài chính, FinBERT, trên kho ngữ liệu truyền thông tài chính quy mô lớn. Thực nghiệm trên ba tác vụ phân loại cảm xúc tài chính xác nhận FinBERT vượt trội so với mô hình BERT miền tổng quát. Mã nguồn và mô hình tiền huấn luyện được công bố tại https://github.com/yya518/FinBERT. Nhóm tác giả hy vọng đây là nguồn hữu ích cho các nhà thực hành và nhà nghiên cứu NLP tài chính.

1 Giới thiệu

Sự trưởng thành của các kỹ thuật và tài nguyên NLP đang thay đổi mạnh mẽ bức tranh lĩnh vực tài chính. Giới thực hành và nghiên cứu thị trường vốn rất quan tâm đến việc dùng NLP để theo dõi cảm xúc thị trường theo thời gian thực từ tin tức trực tuyến hoặc mạng xã hội, vì cảm xúc có thể làm tín hiệu định hướng cho giao dịch. Về trực giác, nếu có thông tin tích cực về một công ty thì giá cổ phiếu của công ty đó được kỳ vọng tăng, và ngược lại. Chẳng hạn, Bloomberg báo cáo rằng các danh mục giao dịch theo cảm xúc vượt trội đáng kể so với chỉ số chuẩn (benchmark) (Cui et al., 2016). Các nghiên cứu kinh tế học tài chính trước đây cũng cho thấy cảm xúc từ tin tức và mạng xã hội có thể dùng để dự báo lợi suất thị trường và hiệu quả hoạt động của doanh nghiệp (Tetlock, 2007; Tetlock et al., 2008).

Gần đây, tiền huấn luyện không giám sát các mô hình ngôn ngữ trên kho ngữ liệu lớn đã cải thiện đáng kể hiệu năng nhiều tác vụ NLP. Tuy nhiên, các mô hình này được tiền huấn luyện trên kho ngữ liệu tổng quát như Wikipedia, trong khi phân tích cảm xúc là tác vụ phụ thuộc mạnh vào miền dữ liệu. Lĩnh vực tài chính đã tích lũy lượng văn bản truyền thông tài chính và kinh doanh quy mô lớn; do đó, tận dụng thành công của tiền huấn luyện không giám sát cùng khối văn bản này có thể mang lại lợi ích cho nhiều ứng dụng tài chính.

Để lấp khoảng trống này, nhóm tác giả tiền huấn luyện FinBERT, một mô hình BERT chuyên ngành tài chính, trên kho ngữ liệu truyền thông tài chính gồm 4,9 tỷ token, bao gồm báo cáo doanh nghiệp, bản ghi cuộc gọi hội nghị về kết quả kinh doanh (earnings conference call) và báo cáo của nhà phân tích. Bài viết mô tả kho ngữ liệu tài chính và chi tiết tiền huấn luyện FinBERT. Thực nghiệm trên ba tác vụ phân loại cảm xúc tài chính cho thấy FinBERT vượt các mô hình BERT tổng quát. Đóng góp của bài khá rõ ràng: tập hợp kho văn bản quy mô lớn mang tính đại diện nhất cho truyền thông tài chính và kinh doanh, tiền huấn luyện và công bố FinBERT, một tài nguyên mới được chứng minh giúp cải thiện hiệu năng phân tích cảm xúc tài chính.

2 Các nghiên cứu liên quan

Tiền huấn luyện không giám sát các mô hình ngôn ngữ trên kho ngữ liệu lớn, như BERT (Devlin et al., 2019), ELMo (Peters et al., 2018), ULM-Fit (Howard và Ruder, 2018), XLNet và GPT (Radford et al., 2019), đã cải thiện đáng kể hiệu năng nhiều tác vụ xử lý ngôn ngữ tự nhiên, từ phân loại câu đến hỏi đáp. Khác với nhúng từ (word embeddings) truyền thống (Mikolov et al., 2013; Pennington et al., 2014), vốn biểu diễn mỗi từ bằng một vector duy nhất, các mô hình ngôn ngữ này trả về embedding theo ngữ cảnh cho từng token, có thể đưa vào các tác vụ hạ nguồn.

Các mô hình ngôn ngữ đã công bố được huấn luyện trên kho ngữ liệu miền tổng quát như tin tức và Wikipedia. Dù có thể dễ dàng tinh chỉnh (fine-tune) mô hình cho tác vụ hạ nguồn, nhiều bằng chứng cho thấy tiền huấn luyện trên kho ngữ liệu miền chuyên biệt quy mô lớn còn cải thiện hiệu năng hơn so với chỉ tinh chỉnh mô hình tổng quát. Vì vậy, nhiều mô hình BERT chuyên ngành đã được huấn luyện và công bố: BioBERT (Lee et al., 2019) tiền huấn luyện mô hình biểu diễn ngôn ngữ y sinh trên kho ngữ liệu y sinh quy mô lớn; ClinicalBERT (Huang et al., 2019) áp dụng BERT cho ghi chú lâm sàng để dự đoán tái nhập viện, còn Alsentzer et al. (2019) áp dụng BERT cho ghi chú lâm sàng và tóm tắt xuất viện; SciBERT (Beltagy et al., 2019) huấn luyện BERT chuyên ngành khoa học trên kho ấn phẩm khoa học đa lĩnh vực lớn nhằm cải thiện các tác vụ NLP khoa học. Nhóm tác giả là những người đầu tiên tiền huấn luyện và công bố mô hình BERT chuyên ngành tài chính.

3 Kho ngữ liệu tài chính

Nhóm tác giả tập hợp kho ngữ liệu miền tài chính quy mô lớn, mang tính đại diện nhất cho truyền thông tài chính và kinh doanh.

Báo cáo doanh nghiệp 10-K và 10-Q. Văn bản quan trọng nhất trong truyền thông tài chính và kinh doanh là báo cáo doanh nghiệp. Tại Hoa Kỳ, Ủy ban Chứng khoán và Giao dịch (SEC) yêu cầu mọi công ty niêm yết nộp báo cáo thường niên (Form 10-K) và báo cáo quý (Form 10-Q). Các tài liệu này cung cấp cái nhìn toàn diện về hoạt động kinh doanh và tình hình tài chính của công ty. Luật và quy định cấm công ty đưa ra tuyên bố sai lệch trọng yếu trong 10-K. Form 10-K và 10-Q được công bố công khai và có thể truy cập từ website của SEC.[1]

Nhóm tác giả thu thập 60.490 Form 10-K và 142.622 Form 10-Q của các công ty thuộc Russell 3000 trong giai đoạn 1994-2019 từ website SEC. Chỉ giữ các phần văn bản, như Mục 1 (Business) trong 10-K, Mục 1A (Risk Factors) trong cả 10-K và 10-Q, và Mục 7 (Management's Discussion and Analysis) trong 10-K.

[1] http://www.sec.gov/edgar.shtml
