# **Dữ liệu tin tức**

|  |  |
|:---|:---|
| **Thời gian đọc**  |  45 phút  |
| **Kiến thức nền tảng**  |  Quen thuộc với lập trình Python: cú pháp Python cơ bản, xử lý dữ liệu, DataFrame, yfinance, sklearn; <br>Các khái niệm tài chính cơ bản: cổ phiếu, cảm xúc thị trường, quản trị rủi ro, chiến lược giao dịch, phân tích cảm xúc  |
| **Từ khóa**  | Phân rã ma trận không âm (NMF), trích xuất đặc trưng, biểu diễn theo bộ phận (parts-based representation), phân tích cảm xúc, <br>xử lý ngôn ngữ tự nhiên (NLP), phân tích cảm xúc, mô hình hóa chủ đề, FinBERT, NMF, TF-IDF |

---

*Trong bài học này, chúng ta trình bày cách sử dụng dữ liệu tin tức và các kỹ thuật xử lý ngôn ngữ tự nhiên (NLP) cho phân tích tài chính, cụ thể là đối với Microsoft. Chúng ta sẽ khám phá các nguồn tin tức khác nhau, thực hiện phân tích cảm xúc bằng FinBERT, và sử dụng mô hình hóa chủ đề (NMF) để khám phá các chủ đề ẩn trong tin tức. Mục tiêu là thu được những hiểu biết có thể giúp đưa ra các quyết định tài chính sáng suốt hơn.*

```python
import torch
```

```python
# Loading libraries

import datetime
import feedparser
import matplotlib.pyplot as plt
import numpy as np
import pandas as pd
import requests
import yfinance as yf

from datetime import datetime, timedelta
from scipy.special import softmax
from sklearn.feature_extraction.text import TfidfVectorizer
from sklearn.decomposition import NMF
from sklearn.preprocessing import MinMaxScaler
from transformers import AutoTokenizer, AutoModelForSequenceClassification

api_key = "5842977bf5f44e3b84ed41f6dcd9e215"  # Replace with your actual News API key

```
