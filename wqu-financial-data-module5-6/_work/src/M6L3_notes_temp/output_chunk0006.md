## **2.1 Nhập nguồn dữ liệu**
Ví dụ sử dụng dữ liệu cho thuê Airbnb tại khu Prenzlauer Berg (Prenz) ở Berlin, Đức (Oshan et al.). Prenz là điểm đến du lịch nổi tiếng, có nhiều lựa chọn ăn uống, nghệ thuật và đời sống về đêm. Dữ liệu được dùng để tìm hiểu các yếu tố chính quyết định giá thuê Airbnb trong khu vực này. Bộ dữ liệu có sẵn qua gói Python libpysal, nên cần cài gói này trước. Gói thứ hai cần cài là mgwr, gói Python để chạy GWR. Cài hai gói như sau.

```python
pip install libpysal
```

```python
pip install mgwr
```

Tiếp theo, nhập các gói Python cần thiết cho ứng dụng này.

```python
import pandas as pd
import libpysal as ps
from libpysal.examples import available
from libpysal.examples import load_example
from libpysal.examples import get_path
from mgwr.gwr import GWR, MGWR
from mgwr.sel_bw import Sel_BW
from mgwr.utils import compare_surfaces, truncate_colormap
import geopandas as gp
import folium
```

Pysal chứa nhiều bộ dữ liệu mẫu cho phân tích không gian; chi tiết xem tại [Pysal Example Data](https://pysal.org/notebooks/lib/libpysal/Example_Datasets.html#Datasets-for-use-with-libpysal). Hàm sau cho phép xem danh sách các bộ dữ liệu mẫu của Pysal.

```python
# Check available datasets on Pysal
available()
```

Output:
```
         Name                                        Description  Installed
0       10740  Albuquerque, New Mexico, Census 2000 Tract Dat...       True
1      AirBnB  Airbnb rentals, socioeconomics, and crime in C...      False
2     Atlanta       Atlanta, GA region homicide counts and rates      False
3   Baltimore          Baltimore house sales prices and hedonics      False
4   Bostonhsg               Boston housing and neighborhood data      False
..        ...                                                ...        ...
94        taz           Traffic Analysis Zones in So. California      False
95      tokyo                               Tokyo Mortality data       True
96  us_income  Per-capita income for the lower 48 US states 1...       True
97   virginia                        Virginia counties shapefile       True
98       wmat          Datasets used for spatial weights testing       True

[99 rows x 3 columns]
```

Tiếp theo, tải bộ dữ liệu Prenz. Trên Pysal bộ này có tên "Berlin", nên đoạn mã dưới đây tải bộ dữ liệu Berlin.

```python
#Download Prenz (Berlin) dataset from Pysal
berlin = load_example('berlin')

# Check if the dataset is intalled and ready for analysis
berlin.installed
```

Output:
```
True
```
