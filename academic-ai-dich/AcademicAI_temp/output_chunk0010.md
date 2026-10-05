#### 2. Huấn luyện AI tạo sinh: Từ dữ liệu thô đến đầu ra thông minh

Các mô hình AI tạo sinh được huấn luyện qua ba giai đoạn chính:

1.  **Tiền huấn luyện (Pre-training)** -- Các mô hình được tiếp xúc với những tập dữ liệu khổng lồ (ví dụ: sách, bài báo học thuật, Wikipedia và các diễn đàn internet) để học các mẫu ngôn ngữ chung, cú pháp và các liên hệ về mặt thực tế. Trong giai đoạn này, chúng dự đoán những từ bị thiếu trong câu, qua đó cải thiện khả năng tạo ra ngôn ngữ mạch lạc.
2.  **Tinh chỉnh (Fine-tuning)** -- Sau khi tiền huấn luyện, các mô hình được hoàn thiện thêm bằng những tập dữ liệu có mục tiêu, nhằm bảo đảm phù hợp với các trường hợp sử dụng cụ thể. Chẳng hạn, một mô hình AI được tinh chỉnh cho việc viết học thuật có thể được huấn luyện trên các bài báo tạp chí và kỷ yếu hội nghị để nâng cao độ chính xác theo lĩnh vực chuyên môn.
3.  **Học tăng cường từ phản hồi của con người (Reinforcement Learning from Human Feedback, RLHF)** -- Quy trình này nâng cao hiệu suất của AI bằng cách đưa các đánh giá của con người về những phản hồi được tạo ra vào quá trình huấn luyện. Những người huấn luyện xếp hạng các đầu ra do AI tạo ra, củng cố các hành vi mong muốn như độ chính xác về mặt thực tế, tính mạch lạc và các cân nhắc đạo đức.

Ngay cả với những bước huấn luyện này, các mô hình AI tạo sinh vẫn mang tính **ngẫu nhiên (stochastic)**---đầu ra của chúng mang tính xác suất chứ không mang tính tất định. Điều này có nghĩa là cùng một prompt (câu lệnh) có thể cho ra các phản hồi khác nhau mỗi lần, khiến nội dung do AI tạo ra hữu ích cho việc hình thành ý tưởng nhưng thiếu tin cậy về tính nhất quán thực tế nếu không có sự giám sát của con người.
