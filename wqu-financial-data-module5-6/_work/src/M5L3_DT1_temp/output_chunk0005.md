Với chủ đề "ENV_SOLAR" và văn bản tiếng Tây Ban Nha, Nhóm 1 tương tự trường hợp trước. Các Nhóm 5, 12 và 15 gồm những từ như "solar" (mặt trời), "system" (hệ thống), "electricity" (điện), "law" (luật), "change" (thay đổi), "tax" (thuế) và các tháng (viết bằng tiếng Tây Ban Nha).

Fig. 15. Dùng gói R "topicmodels". Chủ đề "ENV_SOLAR", văn bản tiếng Tây Ban Nha.

Dữ liệu lịch sử về giá điện và nhu cầu điện được lấy từ OMIE [15]. OMIE vận hành thị trường điện của Tây Ban Nha và Bồ Đào Nha (thị trường MIBEL). Dữ liệu dùng trong giai đoạn từ 18/02/2015 đến 28/10/2015 (tương ứng với dữ liệu GDELT). Mục tiêu là đánh giá xem có tồn tại tương quan nào giữa giá hoặc nhu cầu trên thị trường MIBEL với sắc thái trung bình của dư luận, được đánh giá từ dữ liệu GKG. Với giá và nhu cầu, nhóm tác giả lấy logarit tự nhiên. Các biến trong Fig. 13 được hiểu như sau: MeanALLSolar (chủ đề ENV_SOLAR của Tây Ban Nha) không bao gồm các đề cập đến Chính phủ Tây Ban Nha, còn MeanGovSolar thì có. MeanALLFuel và MeanGovFuel được hiểu tương tự (với chủ đề FUELPRICES). LogPrices và LogDemand là logarit của giá trị trung bình theo ngày của giá và nhu cầu (tương ứng) từ dữ liệu lịch sử MIBEL trong cùng giai đoạn.

Fig. 13. Kết quả tương quan.

Mô hình CTM cho phép phân loại tài liệu hoặc tin tức trên truyền thông. Nhóm tác giả cũng cho rằng trong tương lai có thể dùng nó để phân tích tương quan sâu hơn. Mục tiêu cuối cùng là dùng kỹ thuật này trong nghiên cứu sau để phân tích nhân quả giữa thông tin thu thập được (các chỉ số xây dựng từ đó) và biến động của các biến then chốt trên thị trường năng lượng.

Có bằng chứng yếu về tương quan giữa LogPrices và sắc thái trung bình của MeanALLFuel. Kiểm định giả thuyết không rằng hệ số (-0,0708) bằng 0 cho giá trị chuẩn là -1,65, khác 0 có ý nghĩa ở mức 9,9%. Hệ số tương quan âm giữa LogPrices và sắc thái trung bình của MeanGovSolar có p-value là 0,32 khi kiểm định cùng giả thuyết đó.

D. Phân tích tăng tốc (Speedup) và hiệu suất (Efficiency) (khâu lấy văn bản)

Như đã giải thích ở phần phương pháp, việc lấy văn bản từ các URL là giai đoạn tốn nhiều tính toán. Hai hình trình bày so sánh chế độ thực thi tuần tự và song song, tóm tắt hiệu năng theo Speedup và Efficiency dựa trên phương trình (1) và (2). Fig. 16 cho thấy speedup được cải thiện khi dùng mạng các máy trạm. Dù hiệu suất (xét theo mức giảm thời gian thực thi) tăng khi chạy đa nhân, mạng các máy trạm vẫn được ưu tiên hơn.

Fig. 16. So sánh Speedup.

Mã nguồn không đòi hỏi truyền dữ liệu thường xuyên giữa các tiến trình. Vì vậy, khi dùng mạng các máy trạm, chi phí truyền thông không quá lớn và hiệu suất có thể duy trì ở mức ổn định. Ngược lại, với đa nhân, bộ nhớ máy tính phải dùng chung nên ảnh hưởng đến giá trị hiệu suất.

Fig. 17. Phân tích hiệu suất.

Chạy đa nhân có thể giảm thời gian thực thi, tuy nhiên mạng các máy trạm vẫn được ưu tiên.

V. Kết luận và hướng phát triển

Bài báo đã dùng nguồn dữ liệu lớn từ nhiều nơi để phân tích hai vấn đề của thị trường năng lượng. Thứ nhất, phân tích dư luận về chính sách năng lượng của chính phủ Tây Ban Nha bằng GDELT. Thứ hai, phân tích tương quan giữa các biến cảm xúc về chính sách công với giá và nhu cầu thực tế của thị trường năng lượng MIBEL trong cùng giai đoạn. Có hai kết quả đáng nhấn mạnh. Một mặt, phát hiện cảm xúc tiêu cực đối với chính sách năng lượng mặt trời do chính phủ Tây Ban Nha ban hành năm 2015. Mặt khác, tìm thấy tương quan yếu giữa các chỉ số (sắc thái) trong các đề cập từ cơ sở dữ liệu GKG và logarit giá năng lượng trung bình theo ngày. Không tìm thấy tương quan nào với nhu cầu năng lượng trung bình theo ngày.

Còn nhiều hướng mở rộng dùng các cơ sở dữ liệu lớn như trong bài hoặc tương tự. Ở đây chỉ nêu hai khả năng gần với nghiên cứu này. Thứ nhất, mới chỉ xét tiếng Tây Ban Nha và tiếng Anh, trong khi các ngôn ngữ khác có thể quan trọng để xây dựng chỉ số cảm xúc. Thứ hai, mới chỉ trình bày phân tích tương quan giữa các chỉ số với giá và nhu cầu trung bình, nhưng cần một mô hình nhu cầu chính thức có đưa các chỉ số này vào làm biến giải thích để đo chính xác tiềm năng của chúng trong việc giải thích diễn biến của các biến then chốt của thị trường năng lượng.

Lời cảm ơn

Chúng tôi cảm ơn những góp ý rất hữu ích từ một biên tập viên của tạp chí.

References
