## **7.1 Tải các gói Python**
Chúng ta sẽ cần một số gói cho phần minh họa này.

```python
!pip install fiona
```

```python
!pip install geopandas
```

```python
pip install install-jdk
```

```python
import jdk
from jdk.enums import OperatingSystem, Architecture

jdk.install('11', operating_system=OperatingSystem.LINUX)
```

Output:
```
'/root/.jdk/jdk-11.0.25+9'
```

```python
import os
jdk_version = 'jdk-11.0.25+9' #change with your version 
os.environ['JAVA_HOME'] = '/root/.jdk/jdk-11.0.25+9'
os.environ['PATH'] = f"{os.environ.get('PATH')}:{os.environ.get('JAVA_HOME')}/bin"
```

```python
# Nhập các gói cho ứng dụng này
# pandas dùng để xử lý dataframe và geopandas dùng để xử lý geodataframe
# fiona dùng để đọc hoặc ghi nhiều định dạng dữ liệu không gian địa lý
# urllib dùng để lấy dữ liệu trên internet bằng url
# zipfile dùng để giải nén tệp zip
import os
import pandas as pd
import geopandas as gpd
import fiona
import urllib.request
import zipfile
```
