# M5L2_DT2

FinBERT: Mô hình ngôn ngữ tiền huấn luyện cho truyền thông tài chính

Yi Yang, Mark Christopher Siy UY, Allen Huang
School of Business and Management, Hong Kong University of Science and Technology
{imyiyang,acahuang}@ust.hk, mcsuy@connect.ust.hk

arXiv:2006.08097v2 [cs.CL] 9 Jul 2020

## Tóm tắt

Các mô hình ngôn ngữ tiền huấn luyện theo ngữ cảnh, như BERT (Devlin et al., 2019), đã tạo bước đột phá trong nhiều tác vụ NLP nhờ huấn luyện trên lượng lớn văn bản chưa gán nhãn. Lĩnh vực tài chính cũng tích lũy nhiều văn bản truyền thông tài chính, nhưng chưa có mô hình ngôn ngữ tiền huấn luyện chuyên biệt cho tài chính. Nhóm tác giả đáp ứng nhu cầu này bằng cách tiền huấn luyện FinBERT, một mô hình BERT chuyên biệt cho miền tài chính, trên kho ngữ liệu truyền thông tài chính quy mô lớn. Thực nghiệm trên ba tác vụ phân loại cảm xúc tài chính cho thấy FinBERT vượt trội so với BERT miền tổng quát. Mã nguồn và mô hình tiền huấn luyện có tại https://github.com/yya518/FinBERT, hy vọng hữu ích cho các nhà thực hành và nghiên cứu về NLP tài chính.

## 1 Giới thiệu

Sự trưởng thành của kỹ thuật và tài nguyên NLP đang thay đổi mạnh mẽ lĩnh vực tài chính. Các nhà thực hành và nghiên cứu thị trường vốn rất quan tâm đến việc dùng NLP để theo dõi cảm xúc thị trường theo thời gian thực từ tin tức trực tuyến hoặc mạng xã hội, vì cảm xúc có thể là tín hiệu định hướng cho giao dịch. Theo trực giác, nếu có thông tin tích cực về một công ty thì giá cổ phiếu của công ty đó được kỳ vọng tăng, và ngược lại. Chẳng hạn, Bloomberg báo cáo rằng các danh mục giao dịch theo cảm xúc vượt trội đáng kể so với chỉ số chuẩn (Cui et al., 2016). Nghiên cứu kinh tế tài chính trước đây cũng cho thấy cảm xúc từ tin tức và mạng xã hội có thể dùng để dự báo lợi suất thị trường và hiệu quả hoạt động của doanh nghiệp (Tetlock, 2007; Tetlock et al., 2008).

Gần đây, tiền huấn luyện không giám sát các mô hình ngôn ngữ trên kho ngữ liệu lớn đã cải thiện đáng kể hiệu năng của nhiều tác vụ NLP. Tuy nhiên, các mô hình này được tiền huấn luyện trên kho ngữ liệu tổng quát như Wikipedia, trong khi phân tích cảm xúc là tác vụ phụ thuộc mạnh vào miền. Lĩnh vực tài chính đã tích lũy lượng lớn văn bản truyền thông tài chính và kinh doanh, nên kết hợp tiền huấn luyện không giám sát với nguồn văn bản này có thể mang lại lợi ích cho nhiều ứng dụng tài chính.

Để lấp khoảng trống đó, nhóm tác giả tiền huấn luyện FinBERT, mô hình BERT chuyên biệt cho tài chính, trên kho ngữ liệu truyền thông tài chính gồm 4,9 tỷ token, bao gồm báo cáo doanh nghiệp, bản ghi cuộc họp báo cáo thu nhập (earnings call) và báo cáo của nhà phân tích. Bài viết mô tả kho ngữ liệu và chi tiết tiền huấn luyện FinBERT. Thực nghiệm trên ba tác vụ phân loại cảm xúc tài chính cho thấy FinBERT vượt trội các mô hình BERT tổng quát. Đóng góp của nhóm khá rõ ràng: tổng hợp kho ngữ liệu quy mô lớn, mang tính đại diện nhất cho truyền thông tài chính và kinh doanh; tiền huấn luyện và công bố FinBERT, một tài nguyên mới đã được chứng minh cải thiện hiệu năng phân tích cảm xúc tài chính.

## 2 Các nghiên cứu liên quan

Gần đây, tiền huấn luyện không giám sát trên kho ngữ liệu lớn, như BERT (Devlin et al., 2019), ELMo (Peters et al., 2018), ULM-Fit (Howard và Ruder, 2018), XLNet và GPT (Radford et al., 2019), đã cải thiện đáng kể hiệu năng nhiều tác vụ xử lý ngôn ngữ tự nhiên, từ phân loại câu đến hỏi đáp. Khác với nhúng từ (word embeddings) truyền thống (Mikolov et al., 2013; Pennington et al., 2014), trong đó mỗi từ chỉ có một vector biểu diễn, các mô hình ngôn ngữ này trả về embedding theo ngữ cảnh cho từng token để đưa vào các tác vụ hạ nguồn.

Các mô hình đã công bố được huấn luyện trên kho ngữ liệu miền tổng quát như tin tức và Wikipedia. Dù có thể dễ dàng tinh chỉnh (fine-tune) mô hình cho tác vụ hạ nguồn, đã có bằng chứng rằng tiền huấn luyện trên kho ngữ liệu miền quy mô lớn còn cải thiện hiệu năng hơn so với chỉ tinh chỉnh mô hình tổng quát. Vì vậy, nhiều mô hình BERT chuyên biệt theo miền đã được huấn luyện và công bố: BioBERT (Lee et al., 2019) tiền huấn luyện mô hình biểu diễn ngôn ngữ cho miền y sinh trên kho ngữ liệu y sinh lớn; ClinicalBERT (Huang et al., 2019) áp dụng BERT vào ghi chú lâm sàng cho bài toán dự đoán tái nhập viện, và Alsentzer et al. (2019) áp dụng BERT vào ghi chú lâm sàng và tóm tắt xuất viện; SciBERT (Beltagy et al., 2019) huấn luyện BERT cho miền khoa học trên kho ấn phẩm khoa học đa lĩnh vực lớn nhằm cải thiện các tác vụ NLP khoa học hạ nguồn. Nhóm tác giả là những người đầu tiên tiền huấn luyện và công bố mô hình BERT chuyên biệt cho tài chính.

## 3 Kho ngữ liệu tài chính

Nhóm tác giả tổng hợp kho ngữ liệu miền tài chính lớn, mang tính đại diện nhất cho truyền thông tài chính và kinh doanh.

**Báo cáo doanh nghiệp 10-K và 10-Q.** Dữ liệu văn bản quan trọng nhất trong truyền thông tài chính và kinh doanh là báo cáo doanh nghiệp. Tại Hoa Kỳ, Ủy ban Chứng khoán và Giao dịch (SEC) bắt buộc mọi công ty niêm yết nộp báo cáo năm (Form 10-K) và báo cáo quý (Form 10-Q). Các tài liệu này cung cấp cái nhìn toàn diện về hoạt động kinh doanh và tình hình tài chính của công ty; luật và quy định cấm công ty đưa ra phát biểu sai lệch trọng yếu trong 10-K. Form 10-K và 10-Q được công khai và truy cập được trên website của SEC.¹

Nhóm thu thập từ website SEC 60.490 Form 10-K và 142.622 Form 10-Q của các công ty thuộc Russell 3000 trong giai đoạn 1994-2019, chỉ giữ các phần văn bản như Mục 1 (Business) trong 10-K, Mục 1A (Risk Factors) trong cả 10-K và 10-Q, và Mục 7 (Management's Discussion and Analysis) trong 10-K.

¹ http://www.sec.gov/edgar.shtml
