## **Phân rã ma trận không âm (Non-Negative Matrix Factorization)**

  ----------------------------------- ------------------------------------------------------------------------------------------------------------------------------
  **Thời gian đọc**                   50 phút

  **Kiến thức nền tảng**              Hiểu biết cơ bản về đại số tuyến tính và thống kê: ma trận và vectơ; giá trị riêng và vectơ riêng; thống kê cơ bản;\
                                      Quen thuộc với lập trình Python: cú pháp Python cơ bản, xử lý dữ liệu và các phép toán số học;\
                                      Các khái niệm tài chính cơ bản: lợi suất tài sản và tương quan; đa dạng hóa danh mục đầu tư; phân tích cảm xúc

  **Từ khóa**                         Phân rã ma trận không âm (NMF), giảm chiều dữ liệu, trích xuất đặc trưng, biểu diễn theo thành phần (parts-based representation),\
                                      tính thưa (sparsity), khả năng diễn giải, NMF thưa (Sparse NMF), NMF có ràng buộc (Constrained NMF), Semi-NMF, Convex NMF, NMF trực tuyến (Online NMF), phân tích cảm xúc,\
                                      Phân tích thành phần chính (PCA), Phân rã giá trị suy biến (SVD), Phân tích thành phần độc lập (ICA),\
                                      hệ số tải nhân tố (factor loadings), điểm số nhân tố (factor scores)
  ----------------------------------- ------------------------------------------------------------------------------------------------------------------------------

------------------------------------------------------------------------

*Trong bài học này, chúng ta tìm hiểu phân rã ma trận không âm (NMF), một kỹ thuật phân rã một ma trận không âm thành hai ma trận không âm nhỏ hơn. Kỹ thuật này thường được dùng để giảm chiều dữ liệu, trích xuất đặc trưng và mô hình hóa chủ đề. Bài học cung cấp cái nhìn tổng quan toàn diện về NMF, các biến thể và ứng dụng của nó, với trọng tâm là kỹ thuật tài chính, đặc biệt là đa dạng hóa danh mục đầu tư.*

In \[1\]:

``` calibre12
# Loading libraries
import pandas as pd
import yfinance as yf

from sklearn.decomposition import NMF
```
