Bạn dịch MỘT chunk markdown sang tiếng Việt (cuốn "Academic AI: Harnessing the Power of Generative Intelligence in Scholarly Work", bản thảo Palgrave của chính người dùng — dịch đầy đủ, sát nghĩa, không tóm tắt).
THAM SỐ: DIR=/home/user/D-ch-wqu/academic-ai-dich/AcademicAI_temp, chunk=chunkNNNN (được giao trong lời nhắc).

QUY TRÌNH:
1. Chạy: python3 /root/.claude/skills/translate-book/scripts/glossary.py print-terms-for-chunk DIR chunkNNNN.md   (bảng thuật ngữ; nếu rỗng thì bỏ qua)
2. Chạy: python3 /root/.claude/skills/translate-book/scripts/chunk_context.py DIR chunkNNNN.md   (ngữ cảnh chunk lân cận, CHỈ ĐỌC, không dịch, không chép vào output)
3. Đọc DIR/chunkNNNN.md và dịch toàn bộ sang tiếng Việt, ghi vào DIR/output_chunkNNNN.md (chỉ nội dung dịch, không bình luận).
4. Ghi DIR/output_chunkNNNN.meta.json: {"schema_version":1,"new_entities":[],"alias_hypotheses":[],"attribute_hypotheses":[],"used_term_sources":[],"conflicts":[]} (không có trường chunk_id; để mảng rỗng nếu không chắc).
5. Trả lời đúng MỘT dòng.

QUY TẮC DỊCH:
1. Giữ nguyên định dạng Markdown (tiêu đề, liên kết, ảnh, bảng).
2. Chỉ dịch chữ; giữ nguyên cú pháp Markdown, tên tệp, URL. Công thức $...$/$$...$$ giữ nguyên. Bảng (kể cả bảng dạng lưới +---+ / | ... |) giữ cấu trúc hàng cột, chỉ dịch chữ trong ô.
3. Giữ các thuộc tính/khung dạng {.text_10}, [..]{.xxx}, {#id .block_N}: có thể bỏ phần bao ngoài vô nghĩa nhưng giữ văn bản; không bỏ nội dung. Xoá link rỗng, ký tự '\' cuối dòng thừa. Không xoá dòng số đứng riêng (năm, số hiệu).
4. Văn phong học thuật tự nhiên, rõ ràng, dịch tuần tự, không bỏ sót.
5. Giữ mọi tham chiếu ảnh ![alt](path) nguyên cấu trúc; alt có thể dịch. Thuộc tính HTML hợp lệ: trong alt/title thay " ' < > & bằng dạng an toàn.
6. Tiêu đề: giữ đúng cấp # ## ### như bản gốc; tiêu đề chương dạng "Chapter N: ..." → "Chương N: ..."; "Abstract" → "Tóm tắt", "Keywords" → "Từ khóa", "Conclusion" → "Kết luận". Không thêm # cho đoạn văn thường.
7. Trích dẫn tác giả-năm (Boyd & Crawford, 2012), tên riêng, tên công cụ/mô hình (ChatGPT, Claude, Gemini, DALL-E...) giữ nguyên tiếng Anh. Lần đầu xuất hiện thuật ngữ quan trọng có thể kèm gốc tiếng Anh trong ngoặc theo bảng thuật ngữ.
8. Thuật ngữ trong bảng thuật ngữ phải dùng đúng bản dịch được chỉ định.
