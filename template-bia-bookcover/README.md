# Template bìa sách (bookcover.cls) — dùng lại cho các Module

Nguồn: `Bookcover_cls___Full_Bleed_Book_Cover_with_Crop_Marks.zip` (lớp `bookcover`, in đủ bìa sau + gáy + bìa trước, có tràn lề và dấu cắt).

## Thư mục
| Mục | Ý nghĩa |
|---|---|
| `bookcover.cls` | Lớp LaTeX của template (không sửa) |
| `UserManual.pdf`, `documentation.tex` | Tài liệu gốc của template |
| `example.tex`, `CoverExample.pdf` | Ví dụ gốc |
| `bia-module2/` | Bìa WQU Financial Data — Module 2 (khổ A4, đỏ/xám nhạt) |
| `tach-bia-truoc.py` | Tách mặt bìa trước A4 từ tờ in để chèn làm trang đầu của sách |

## Làm bìa cho module khác
1. `cp -R bia-module2 bia-module3`, đổi tên `bia-module2.tex` thành `bia-module3.tex`.
2. Sửa trong file `.tex`: `pages` (số trang sách, quyết định độ dày gáy), và các dòng `\def\booktitle`, `\booksubtitle`, `\bookedition`, `\bookauthors`, `\bookpublisher`, `\bookdescription`, `\bookisbn`, `\spine...`.
3. Biên dịch **bằng LuaLaTeX, chạy đúng 2 lượt** (lượt 1 chưa vẽ nền/nội dung, chỉ lượt 2 mới ra đủ; XeLaTeX không tìm thấy font TeX Gyre Adventor theo tên):
   ```
   cd bia-module3 && for i in 1 2; do TEXINPUTS=..: lualatex bia-module3.tex; done
   rm -f *.aux *.log
   ```
   Kết quả `bia-module3.pdf` là tờ in đầy đủ (gửi nhà in). Tờ có kích thước 480 x 330 mm.
4. Tách bìa trước A4 cho sách (tham số thứ 3 là độ dày gáy mm = số trang x 0,10 / 2 với giấy 75 g):
   ```
   python3 tach-bia-truoc.py bia-module3/bia-module3.pdf ../wqu-financial-data-module3/gfx/cover.pdf 6.5
   ```
   `main-...tex` chèn `gfx/cover.pdf` bằng `\includepdf` như trước.

## Ghi chú
- Màu: đổi `colorFront`, `colorBack`, `colorSpine` (mã hex) và hai dòng `\definecolor{teal}`, `\definecolor{gold}` cho khớp.
- Khổ trang phải khớp sách: `width`/`height` (mm). Nếu tràn tờ in thì tăng `paperwidth`/`paperheight`.
- Số trang thay đổi thì đổi `pages` rồi chạy lại cả hai bước 3 và 4.
