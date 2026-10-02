#!/usr/bin/env python3
"""Tách mặt bìa trước (khổ A4, không dấu cắt/tràn lề) từ tờ in bookcover.

Dùng:  python3 tach-bia-truoc.py bia-module2/bia-module2.pdf ../wqu-financial-data-module2/gfx/cover.pdf
Tham số hình học phải khớp với các option trong file .tex của bìa
(mặc định bên dưới khớp bia-module2.tex: A4, bleed 10, groove 8, pages 130 -> gáy 6.5 mm).
"""
import sys, pymupdf

src, dst = sys.argv[1], sys.argv[2]
W, H = 210.0, 297.0            # khổ trang (mm)  = option width, height
BLEED, GROOVE = 10.0, 8.0      # option bleed, groove
SPINE = float(sys.argv[3]) if len(sys.argv) > 3 else 6.5   # mm: pages*0.10/2 (grammage 75)
MM = 72 / 25.4

doc = pymupdf.open(src)
pw, ph = doc[0].rect.width / MM, doc[0].rect.height / MM      # kích thước tờ in (mm)
total_w = 2 * BLEED + 2 * W + 2 * GROOVE + SPINE
left = (pw - total_w) / 2
top = (ph - (H + 2 * BLEED)) / 2
x0 = left + BLEED + W + GROOVE + SPINE + GROOVE               # mép trái của mặt trước
y0 = top + BLEED
clip = pymupdf.Rect(x0 * MM, y0 * MM, (x0 + W) * MM, (y0 + H) * MM)

# Render vùng bìa trước ở 300 dpi rồi gói thành PDF 1 trang A4.
# (Cắt vector bằng CropBox/form XObject bị render trắng khi pdfLaTeX \includepdf nhúng vào sách.)
pix = doc[0].get_pixmap(clip=clip, dpi=300)
out = pymupdf.open()
page = out.new_page(width=W * MM, height=H * MM)
page.insert_image(page.rect, pixmap=pix)
out.save(dst, garbage=4, deflate=True)
print("đã ghi", dst)
