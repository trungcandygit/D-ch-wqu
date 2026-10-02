Dịch file markdown sang TIẾNG VIỆT (tuyệt đối không ra tiếng Trung). Quy tắc (theo skill translate-book):
1. Giữ nguyên định dạng Markdown (tiêu đề, liên kết, ảnh). Chỉ dịch chữ.
2. Công thức toán ($...$, $$...$$) giữ nguyên từng ký tự. Bảng giữ nguyên hàng/cột, chỉ dịch chữ trong ô.
3. Khối code (```...```) và output giữ nguyên; chỉ dịch comment tiếng Anh nếu có và alt/tiêu đề biểu đồ nằm trong chuỗi chữ thì giữ nguyên. Không dịch tên biến/hàm.
4. Xóa liên kết rỗng, ký tự thừa (ví dụ [¶](#...){.anchor-link}, dấu \ cuối dòng, số trang/đầu trang/chân trang của bản in PDF, ngày giờ in trình duyệt). Không xóa số là nội dung.
5. Chỉ xuất bản dịch, không bình luận. Dịch tự nhiên, rõ ràng, theo đúng thứ tự, không bỏ sót.
6. Giữ mọi tham chiếu ảnh ![alt](path) nguyên vẹn (có thể dịch alt).
7. Giữ cấp tiêu đề (#, ##, ###...). Không thêm tiêu đề thừa.
8. Tên riêng, tên tác giả, tên mô hình/bộ dữ liệu (FinBERT, GDELT, NMF, GWR, Landsat, BERT...) giữ nguyên tiếng Anh. Thuật ngữ lần đầu có thể kèm tiếng Anh trong ngoặc.
9. Thuật ngữ phải theo bảng thuật ngữ được cấp (thống nhất với sách module 3-4).
10. Không đưa vào bản dịch các log lỗi, traceback, warning, lỗi đăng nhập/API nếu còn sót.
11. Phần "neighbor context" chỉ để tham khảo, không dịch, không chép vào output.
Văn phong: học thuật, tiếng Việt chuẩn, giống sách module 3-4 (ví dụ: "phân tích cảm xúc", "kho ngữ liệu", "nhúng từ", "độ chính xác", "độ bao phủ").
Ngoài file dịch, ghi thêm output_chunkNNNN.meta.json: {"schema_version":1,"new_entities":[],"alias_hypotheses":[],"attribute_hypotheses":[],"used_term_sources":[],"conflicts":[]} (để mảng rỗng nếu không chắc, KHÔNG có trường chunk_id).

QUY TRÌNH CHO SUBAGENT (mỗi agent đúng một chunk):
a) Chạy: python3 /root/.claude/skills/translate-book/scripts/glossary.py print-terms-for-chunk <DIR> <chunk>.md  -> bảng thuật ngữ bắt buộc.
b) Chạy: python3 /root/.claude/skills/translate-book/scripts/chunk_context.py <DIR> <chunk>.md -> ngữ cảnh liền kề (chỉ tham khảo).
c) Đọc <DIR>/<chunk>.md, DỊCH ĐẦY ĐỦ, SÁT NGUYÊN BẢN sang tiếng Việt (không tóm tắt, không bỏ câu), ghi <DIR>/output_<chunk>.md và <DIR>/output_<chunk>.meta.json.
d) Với bài đọc trích từ PDF: bỏ đầu trang/chân trang/số trang/ngày in; phần Tài liệu tham khảo (References) giữ nguyên bản gốc không dịch; công thức/bảng vỡ do trích PDF thì dựng lại bằng LaTeX $...$ hoặc bảng markdown. Bỏ video YouTube.
e) Với lesson note (thư mục *_notes_temp): dịch đầy đủ phần chữ, giữ nguyên code Python, chỉ giữ output có ích; xóa log lỗi/traceback/warning/lỗi đăng nhập hay API.
f) Chỉ trả lời MỘT dòng khi xong.

KIỂU DỊCH:
- Thư mục *_notes_temp (lesson note của trường, tài liệu được cấp): dịch đầy đủ phần chữ.
- Thư mục *_DT*_temp (bài đọc của bên thứ ba): viết bản tiếng Việt súc tích bám sát cấu trúc nguồn: giữ mọi tiêu đề/mục, định nghĩa, công thức, số liệu, bảng, chú thích hình, kết luận; diễn đạt lại ngắn gọn thay vì dịch từng câu; chỉ trích nguyên văn ngắn khi cần.
