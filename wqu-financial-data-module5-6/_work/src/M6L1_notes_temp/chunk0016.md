## **7.5 Converting to a Geodataframe**

Now we have a good dataframe for Hurricane Irene's path. To convert this dataframe to a geospatial dataframe, we need to create a geometry variable, as explained in the previous section. We will use a method from geopandas to create this variable. One of the parameters in the following code is "EPSG:4326", which is the code name for the latitude-longitude system we are familiar with. Remember there are several CRS systems available, but we'll proceed with this commonly used one.

```python
# Create a geolocation variable
geometry = gpd.points_from_xy(irene_2.Longitude, irene_2.Latitude, crs="EPSG:4326")
```

Now let's convert the current pandas dataframe to a geodataframe.

```python
# Convert the current dataframe to a geodataframe with geometry variable
irene_3 = gpd.GeoDataFrame(
    irene_2, geometry=geometry, crs="EPSG:4326"
)
```

Great! Now we have a geodataframe. Let's check out the first five entries in this dataframe.

```python
irene_3.head()
```

Output:
```
         Date_Time  Longitude  Latitude  Wind Speed            geometry
1  08/21/2011/0000      -59.0      15.0        45.0      POINT (-59 15)
2  08/21/2011/0600      -60.6      16.0        45.0    POINT (-60.6 16)
3  08/21/2011/1200      -62.2      16.8        45.0  POINT (-62.2 16.8)
4  08/21/2011/1800      -63.7      17.5        50.0  POINT (-63.7 17.5)
5  08/22/2011/0000      -65.0      17.9        60.0    POINT (-65 17.9)
```

Under the geometry variable in the above geodataframe, we have point shapes and their coordinate pairs on the map. Let's confirm the type of our new dataframe.

```python
type(irene_3)
```

Output:
```
geopandas.geodataframe.GeoDataFrame
```

And let's check our geometry variable.

```python
type(irene_3['geometry'])
```

Output:
```
geopandas.geoseries.GeoSeries
```

The geodataframe basically behaves like the pandas dataframe. Therefore, we can apply the same methods and analysis from pandas to geopandas. Here is one example.

```python
print("Mean wind speed of Hurricane Irene is {} knots and it can go up to {} knots maximum".format(round(irene_2['Wind Speed'].mean(),4),
                                                                                         irene_2['Wind Speed'].max())+".")
```

Output:
```
Mean wind speed of Hurricane Irene is 69.6154 knots and it can go up to 105.0 knots maximum.
```
