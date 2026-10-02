## **2.2 Visualizing the Data**
Okay, we have installed the dataset. Let's take a look at what's inside.

```python
# Check file lists from the installed dataset
berlin.get_file_list()
```

Output:
```
['/usr/local/lib/python3.10/dist-packages/libpysal/examples/berlin/prenzlauer.zip',
 '/usr/local/lib/python3.10/dist-packages/libpysal/examples/berlin/README.md',
 '/usr/local/lib/python3.10/dist-packages/libpysal/examples/berlin/prenz_bound.zip']
```

From the file lists, we see one file is "prenzlauer.zip" file. This file contains the dataset we need for analysis. The other file is "prenz_bound.zip" file. This file will be used to draw the boundaries for Prenz neighborhood. We are going to use the "get_path" function from the Pysal package and the "read.file" function from the geopandas package to convert these two files into geo-dataframes.

```python
# Convert two zipped files to geo dataframes
prenz = gp.read_file(berlin.get_path('prenzlauer.zip'))
prenz_bound = gp.read_file(berlin.get_path('prenz_bound.zip'))
```

Let's double-check the types of the two converted files.

```python
# Check the type of Prenz dataset
type(prenz)
```

Output:
```
geopandas.geodataframe.GeoDataFrame
```

```python
# Check the type of Prenz_bound dataset
type(prenz)
```

Output:
```
geopandas.geodataframe.GeoDataFrame
```

Great! We can confirm that both datasets are geo-datasets. Now let's see what both datasets look like.

```python
prenz.head()
```

Output:
```
   accommodat  review_sco  bedrooms  bathrooms  beds  price             X  \
0           2       100.0       1.0        1.0   1.0   35.0  1.494450e+06   
1           2        90.0       1.0        1.0   1.0   23.0  1.494354e+06   
2           2        93.0       1.0        1.0   1.0   38.0  1.494406e+06   
3           2       100.0       1.0        1.0   1.0   50.0  1.494271e+06   
4           2       100.0       1.0        1.0   1.0   80.0  1.493982e+06   

              Y                         geometry  
0  6.899036e+06  POINT (1494450.105 6899036.141)  
1  6.899121e+06  POINT (1494353.555 6899120.594)  
2  6.898809e+06  POINT (1494405.897 6898808.518)  
3  6.898655e+06  POINT (1494270.517 6898655.223)  
4  6.899397e+06  POINT (1493982.078 6899397.385)
```

```python
# Find out number of rental properties in the dataset
len(prenz)
```

Output:
```
2203
```

The above code shows the first five rows of the data from the Prenz dataset. It also tells us that there are data for 2,203 rental properties in the dataset. Here is a brief description of each variable:

- **accommodat**: Number of visitors the rental can accommodate
- **review_sco**: Cumulative review score from the last visitor who stayed at the rental
- **bedrooms**: Number of bedrooms
- **bathrooms**: Number of bathrooms
- **beds**: Number of beds available
- **price**: Price of the rental
- **X**: Latitude of the rental location
- **Y**: Longitude of the rental location
- **geometry**: Geographic location of the rental

We learned from the previous lesson that the key feature of a geo-dataset is to contain the geographical variable "geometry" to provide the location information for a feature. Because the geographical locations of rentals are point information, we only get one coordinate pair showing latitude and longitude.
<br>
Now, let's also take a look at the prenz_bound geo dataset.



```python
prenz_bound.head()
```

Output:
```
       neighbourh                                           geometry
0  Helmholtzplatz  POLYGON ((1496989.669 6899662.266, 1497008.148...
```

As explained before, the prenz_bound dataset provides geolocation information to draw the boundaries of the Prenz neighborhood. In this dataset, we can see it provides geolocation information for several points on the map. By connecting all these geolocation points, we can form a region (polygon). This is why we only have a row of data in the prenz_bound dataset.
<br>
Before running any analysis, let's first draw the rental locations of our dataset on a map.

```python
# Draw Rental Properties of Prenz on a map

# First, create a basemap
map = folium.Map(location=[52.542986,13.427986], zoom_start=13.5, control_scale=True)

# Then add the Prenz neighborhood borders to the map
folium.GeoJson(prenz_bound).add_to(map)

# Then add the Airbnb rental locations to the map. We will use a red dot to represent the location of one airbnb rental.
folium.GeoJson(prenz,
               marker=folium.Circle(radius=10, fill_color="red", fill_opacity=0.4, color="red", weight=1)).add_to(map)

map
```

Output:
```
<folium.folium.Map at 0x7e6897fc5000>
```
