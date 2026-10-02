## **7.1 Load Python Packages**
There are a few packages we will need for this demonstration.

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
# Import packages for this application
# pandas is used to process dataframe and geopandas is used to process geodataframe
# fiona is used to read or write various formats of geospatial data
# urllib is used to pull data on the internet using url
#zipfile is used to unzip a zipped file
import os
import pandas as pd
import geopandas as gpd
import fiona
import urllib.request
import zipfile
```
