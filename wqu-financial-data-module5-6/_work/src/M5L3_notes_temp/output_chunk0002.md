# **Các bộ sưu tập dữ liệu tin tức quy mô lớn**

  ----------------------------------- -------------------------------------------------------------------------------------------------------------------------------------------
  **Thời gian đọc**                   60 phút

  **Kiến thức nền tảng**              Lập trình Python cơ bản: cấu trúc dữ liệu, luồng điều khiển, hàm, xử lý tệp, biểu thức chính quy, HTML cơ bản;\
                                      Kỹ thuật tài chính: hiểu biết cơ bản về các khái niệm và ứng dụng của kỹ thuật tài chính để đặt việc sử dụng dữ liệu tin tức vào đúng bối cảnh.

  **Từ khóa**                         WARC (Web ARChive), GDELT (Global Database of Events, Language, and Tone), GKG (Global Knowledge Graph), CSV, Warcio,\
                                      Newspaper3k, Tqdm, Biểu thức chính quy (Regex), Xử lý ngôn ngữ tự nhiên (NLP), Dữ liệu quy mô lớn, Dữ liệu lớn (Big Data)
  ----------------------------------- -------------------------------------------------------------------------------------------------------------------------------------------

------------------------------------------------------------------------

*Trong bài học này, chúng ta tìm hiểu cách tận dụng (leverage) hai bộ dữ liệu tin tức quy mô lớn là Common Crawl News Crawl và GDELT cho các ứng dụng kỹ thuật tài chính. Chúng ta học cách truy cập và xử lý các bài báo thô từ các tệp WARC của Common Crawl, trích xuất những thông tin chính như tiêu đề và nội dung, đồng thời lọc theo ngôn ngữ và từ khóa. Bên cạnh đó, chúng ta học cách làm việc với dữ liệu GKG của GDELT để phân tích các sự kiện tin tức, các thực thể và cảm xúc, bao gồm việc tải xuống, lọc và phân tích điểm Tone của GDELT nhằm thu được những hiểu biết tinh tế về cảm xúc. Chúng ta khám phá mã nguồn và các kỹ thuật cần thiết để khai thác sức mạnh của các bộ dữ liệu này phục vụ nghiên cứu và phân tích tài chính.*

In \[14\]:

``` calibre12
# Loading libraries
import gc
import gzip
import io
import nltk
import pandas as pd
import plotly.graph_objects as go
import re
import requests
import time
import tqdm
import warcio
import yfinance as yf
import zipfile

from datetime import datetime, timedelta
from newspaper import Article
from nltk.corpus import stopwords
from sklearn.decomposition import NMF
from sklearn.feature_extraction.text import TfidfVectorizer
```

Thu thập dữ liệu quy mô lớn là quá trình tập hợp và lưu trữ một lượng dữ liệu khổng lồ từ nhiều nguồn khác nhau. Trong bài học này, chúng ta xem xét hai nguồn: Common Crawl và GDELT. Cả hai sáng kiến đều thu thập dữ liệu quy mô lớn từ một số lượng rất lớn các nguồn tin tức trực tuyến. Chúng sử dụng các kỹ thuật thu thập dữ liệu web (web crawling) cùng các phương pháp khác để thu thập các bài báo từ nhiều trang web và ấn phẩm đa dạng trên toàn thế giới. Việc thu thập dữ liệu rộng khắp này cho phép phân tích toàn diện và đem lại những hiểu biết sâu sắc về mức độ đưa tin toàn cầu. Mặc dù việc thu thập dữ liệu quy mô lớn có những thách thức đi kèm, nhưng những lợi ích về phân tích toàn diện, độ chính xác được cải thiện và khả năng khám phá tri thức mới khiến đây trở thành một cách tiếp cận có giá trị cho phân tích và nghiên cứu tin tức, bao gồm cả các ứng dụng trong kỹ thuật tài chính.
