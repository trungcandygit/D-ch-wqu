# **5. Vector Data**
In the previous section, we showed how we can present a location using a CRS. So far, we've only talked about a point location, which means a dot on the latitude-longitude coordinate system. Apart from a point shape, we can also include line shapes and polygon shapes with a CRS. Figure 3 demonstrates examples of a point shape, a line shape, and a polygon shape.    
<br>
**Figure 3. Point, Line, and Polygon Shapes**
![vector data.jpg](images/img001.jpeg)
<br>
The above three shapes in Figure 3 consist of points and lines. The points are called vertices. The location of each vertex can be represented by a latitude-longitude coordinate pair. By having shape information and vertex coordinate information, we can identify the geospatial location of a feature on a latitude-longitude coordinate system. In vector data, we store the shape information and coordinate information in a variable called **geometry**. It is this geometry variable that differentiates geospatial data from traditional tabular data.
<br> In terms of vector geospatial data format, there are two common data formats: **GeoJSON** and **Shapefile**. The required readings will give a very short introduction to these two data formats.
<br>