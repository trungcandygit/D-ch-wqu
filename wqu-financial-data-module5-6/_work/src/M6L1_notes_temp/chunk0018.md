### **7.7 Geospatial Data Visualization**
Now we have a file for Hurricane Irene's path and a file for U.S. state borders. They are also both in geodataframe forms. We can put all the information in one map for visualization. We will use the folium package to draw the map and add the U.S. state borders and the hurricane's path to the map.

```python
pip install folium
```

```python
# Import a mapping library
import folium
```

Great! Now it's time to put the information on a map.

```python
# Draw Hurricane Irene's path and other infomation to a map

# First, create a basemap
map = folium.Map(location=[30,-102], zoom_start=4, control_scale=True)

# Then add the first layer of US state borders to the map
folium.GeoJson(us_state_shape_g).add_to(map)

# Then add the hurricane travel path to the map. We use a red dot to represent the hurricane's location at a specific date/time. Then we add an information box and a popup box. If you hoover your mouse cursor to the red dot, the map will show you date/time linked to the location and the wind speed.
folium.GeoJson(irene_3,
               marker=folium.Circle(radius=2000, fill_color="red", fill_opacity=0.4, color="red", weight=5),
              tooltip=folium.GeoJsonTooltip(fields=["Date_Time","Wind Speed"]),
              popup=folium.GeoJsonPopup(fields=["Date_Time","Wind Speed"]),).add_to(map)

map
```

Output:
```
<folium.folium.Map at 0x73b5d8373dd0>
```

Voila! We just created a map overlayed with U.S. state borders and Hurricane Irene's path. In the upper left corner of the map, there is an icon you can use to zoom in and out. We see U.S. state borders in solid blue lines on the map. Hurricane Irene's path is represented by a series of red dots on the map. When you hover your cursor over one of the red dots, an information box will show up, providing date/time and wind speed information. With this map, we can see Hurricane Irene went through most of the northern states along the east coast of the U.S. Wind speed was at its strongest when the hurricane was passing through between the Dominican Republic and the Bahamas. The wind speed slowed down significantly after landfall.
