## **2.1 Importing the Data Source**
We will use Airbnb rental data from the Prenzlauer Berg (Prenz) neighborhood in Berlin, Germany, as our example data (Oshan et al.). Prenz is a popular destination for tourists. It provides a lot of dining, art, and night life options for visitors. We will use the data to understand what the key drivers are for the Airbnb rental prices in this neighborhood. This dataset is available through a Python package libpysal. Hence, we will need to to install this package first. The other python package we need to install is mgwr. This is the Python package to run GWR. Now let's install these two packages.

```python
pip install libpysal
```

```python
pip install mgwr
```

Now, let's import the Python packages we need for this application.

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

Pysal contains a lot of example datasets for spatial analysis. For more information about the details of example datasets in this package, you can visit this site [Pysal Example Data](https://pysal.org/notebooks/lib/libpysal/Example_Datasets.html#Datasets-for-use-with-libpysal). We can use the following function to take a look at the list of example datasets from Pysal.

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

Now, let's download the Prenz dataset. The title of this dataset on Pysal is called "Berlin," so you can see from the following code that we are downloading the Berlin dataset.

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
