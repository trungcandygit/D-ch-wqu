# Hồi quy trọng số địa lý (GWR)


|  |  |
|:---|:---|
|**Thời gian đọc** | 2 giờ  |
|**Kiến thức nền** | thống kê cơ bản, hồi quy tuyến tính, Python |
|**Từ khóa** | Phân tích không gian, hồi quy, GWR, tính không đồng nhất không gian, hàm nhân (kernel) |

---

*Bài học này giới thiệu hồi quy trọng số địa lý (GWR) như một cách đơn giản, trực quan để mô hình hóa dữ liệu có tính không đồng nhất không gian. Chúng ta tìm hiểu nền tảng lý thuyết của GWR, bắt đầu từ động cơ ra đời và cách GWR mở rộng hồi quy tuyến tính truyền thống để xét đến tính không đồng nhất không gian. Ở nửa sau của notebook, chúng ta thực hành với các minh họa và một ví dụ dữ liệu thực tế, nhằm bổ sung cho lý thuyết những kỹ năng cần thiết để áp dụng GWR trong thực tế.*

```python
import numpy as np
import matplotlib.pyplot as plt
import seaborn as sns
sns.set()
```
