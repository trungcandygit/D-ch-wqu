### **7.6 Data for U.S. State Borders**
Before we draw Hurricane Irene's path on a map, we would like to add a layer with U.S. state borders to the map. With the state border visualization along with Hurricane Irene's path, we can learn which states were affected by this hurricane. We will pull the state border file from the United States Census Bureau's website. This is a zipped shapefile. We first need to import a package to unzip the file.

```python
# Import a file unzip package
from zipfile import ZipFile
```

```python
# Retrieve US State Shapfile from United States Census Bureau
us_state_url = "	http://www2.census.gov/geo/tiger/TIGER2012/STATE/tl_2012_us_state.zip"

us_state_shape_zip, _ = urllib.request.urlretrieve(us_state_url)

```

```python
# Unzip the zipped shapefile and assign it a new file name "us_state_shape"
with ZipFile(us_state_shape_zip, 'r') as zObject:

    zObject.extractall("us_state_shape")
```

Once we unzip the file, we will use the read_file method from geopandas to read this file as a geodataframe for further data processing.

```python
# Read in our shapefile to a geodataframe
us_state_shape_g = gpd.read_file("us_state_shape")
```

```python
# Check the metadata of the new geodataframe
us_state_shape_g.info()
```

Output:
```
<class 'geopandas.geodataframe.GeoDataFrame'>
RangeIndex: 56 entries, 0 to 55
Data columns (total 15 columns):
 #   Column    Non-Null Count  Dtype   
---  ------    --------------  -----   
 0   REGION    56 non-null     object  
 1   DIVISION  56 non-null     object  
 2   STATEFP   56 non-null     object  
 3   STATENS   56 non-null     object  
 4   GEOID     56 non-null     object  
 5   STUSPS    56 non-null     object  
 6   NAME      56 non-null     object  
 7   LSAD      56 non-null     object  
 8   MTFCC     56 non-null     object  
 9   FUNCSTAT  56 non-null     object  
 10  ALAND     56 non-null     int64   
 11  AWATER    56 non-null     int64   
 12  INTPTLAT  56 non-null     object  
 13  INTPTLON  56 non-null     object  
 14  geometry  56 non-null     geometry
dtypes: geometry(1), int64(2), object(12)
memory usage: 6.7+ KB
```

```python
# Check a few entries of the new geodataframe
us_state_shape_g.head()
```

Output:
```
  REGION DIVISION STATEFP   STATENS GEOID STUSPS        NAME LSAD  MTFCC   
0      4        9      15  01779782    15     HI      Hawaii   00  G4000  \
1      3        7      05  00068085    05     AR    Arkansas   00  G4000   
2      4        8      35  00897535    35     NM  New Mexico   00  G4000   
3      4        8      30  00767982    30     MT     Montana   00  G4000   
4      1        2      36  01779796    36     NY    New York   00  G4000   

  FUNCSTAT         ALAND       AWATER     INTPTLAT      INTPTLON   
0        A   16634247483  11678744699  +19.8097670  -155.5061027  \
1        A  134772564356   2959210006  +34.8955256  -092.4446262   
2        A  314161109357    756438507  +34.4346843  -106.1316181   
3        A  376963571188   3868564895  +47.0511771  -109.6348174   
4        A  122057936950  19238848209  +42.9133974  -075.5962723   

                                            geometry  
0  MULTIPOLYGON (((-155.96333 19.08159, -155.9634...  
1  POLYGON ((-94.46025 34.53838, -94.46026 34.543...  
2  POLYGON ((-109.04616 34.57929, -109.04616 34.5...  
3  POLYGON ((-114.33289 46.66076, -114.33367 46.6...  
4  MULTIPOLYGON (((-79.64546 41.99886, -79.6498 4...
```
