# **3. Coordinate Reference Systems**
A **coordinate reference system (CRS)** is a coordinate system to describe location information on Earth's surface (Awati, 2022). There are various CRS system frames you can use, but the most popular approach is using latitude and longitude to form a grid system on Earth's surface.
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**Latitude** lines are horizontal lines across the Earth to show how far a location is away from the equator with respect to the directions of north and south. The 0 degree line of latitude is located at the equator. It divides Earth into the Northern Hemisphere above the equator and the Southern Hemisphere below the equator.
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**Longitude** lines are vertical lines across the Earth to show how far a location is away from the prime meridian with respect to directions of west and east. The 0 degree line of longitude is located at the prime meridian. It divides the Earth into the Eastern Hemisphere and the Western Hemisphere. Figure 1 demonstrates this coordinate system.
<br>
<br>
**Figure 1. Earth's Latitude and Longitude Coordinate System**
![latitude and longitude.jpg](images/img002.jpeg)

_Source: TechTarget_
<br>
When referencing a location on a CRS, the general consensus is to start first with latitude and then longitude in the form of (latitude, longitude). There are two ways to present latitude-longitude information. The first method is degrees, minutes, and seconds (DMS). For example, the coordinates using DMS for New York are (40° 43' 50.1960'' N, 73° 56' 6.8712'' W). The ° denotes degree. The ' denotes minute, and the '' denotes second. The second method is decimal degrees (DD). The coordinates using DD for New York are (40.730610, -73.935242).
<br>
There are two main differences between DMS and DD. The first difference is that DMS and DD use different symbols to represent the direction information of a location. DMS uses characters to describe which hemisphere the location is in (N vs S; W vs E). DD uses + and - signs to describe the hemisphere location. In the DMS method, New York's direction coordinates are (N, W). In the DD method, New York's direction coordinates are (+,-). We can use Figure 1 to understand how the DD method assigns +/- signs. On the left part of the figure, we can see that if a location is in the Northern Hemisphere, the latitude sign is +. If the location is in the south, the latitude sign is -. The concept is the same when applied to longitude.
<br>
The second difference is that DMS is in degrees and DD is in decimals. We can easily convert between the two methods. To convert DMS to DD, first we keep the degree number. Then, we divide the minute number by 60 and divide the second number by 3600. We then add the results of the two divisions and add them back to the degree number. The final number will be the number in DD. Sometimes, which hemisphere the data is in is indicated by the variable name or header, and the values of data points are all positive in the table. In this case, we need to manually adjust the values of the data points to properly represent the hemisphere location in the DD method.
<br>
In Python, we will use the DD method to present coordinate information. You can easily find the DD coordinates for a place in Google Maps.
<br>