## **5.1 Load the Necessary Libraries for This Demonstration**#

We will use Google Colab to access Python API for GEE for this demonstration.

```python
# pandas to handle tabular data and geopandas to handle geospatial data
import pandas as pd
import geopandas as gpd

# earth engine
import ee

# Google earth engine map
import geemap

# allow images to display in the notebook
from IPython.display import Image
```

##**5.2 Access to Google Earth Engine**###
We will use the following code to access Google Earth Engine's API. Please replace 'ee-si-learning-001' with your own project ID. Your Project ID was created when you registered for Google Earth Engine. During the authentication process, a dialogue box will appear. It will ask you to select the Google account you used to register for Google Earth Engine. Please click that account. Then, there will be some information along with a "continue" button on the lower right side of the dialogue box. Please click the "continue" button. Then, there will be another message, and you will need to go through and hit the "continue" button to finish the authentication process. There will be two continue buttons to hit in total.

```python
# Start Google Earth Engine authentication process
ee.Authenticate()

# Initialize Google Earth Engine with the project ID you set up during the account set up step
ee.Initialize(project='[REPLACE PROJECT ID]')

```

##**5.3 Set Up Filter Parameters**###
Define the location of interest using latitude and longitude coordinates as well as a start and end period to pull satellite images. We can use Google Maps to find latitude and longitude coordinates for Butte County in California. Since the fire started on November 8, 2018, we will pull the images from October 2018 to December 2018.

```python
# coordinates of the Camp Fire
lat =  39.444012
lon = -121.833619

# point of interest as an ee.Geometry
poi = ee.Geometry.Point(lon,lat)

# start date of range to filter for
start_date = '2018-10-01'

# end date
end_date = '2019-01-31'

```

##**5.4 Retrieve Images from Google Earth Engine Data Catalog**
We will retrieve the images from Landsat 8. The following link from Google Earth Engine provides information about this image collection from Landsat 8. It also provides the Python code snippet to pull the images shown in the following code.
<br>
https://developers.google.com/earth-engine/datasets/catalog/LANDSAT_LC08_C02_T1_L2


```python
# get the satellite data
landsat = ee.ImageCollection("LANDSAT/LC08/C02/T1_L2")\
            .filterBounds(poi)\
            .filterDate(start_date,end_date)
```

##**5.5 Check the Image Information**
Now we have downloaded the images. Let's review some information.
First, let's take a look at how many images we got from the selection period. Landsat 8's temporal resolution is 16 days. Our selection period is 3 months. Hence, we should get at least 6 images. ((3*30)/16 = 5.6)

```python
# Check how many images we get during the selection period.
print('Total number:', landsat.size().getInfo())
```

Next, we use the first image we pulled to see what information we can get.

```python
landsat.first().getInfo()
```

One key element in satellite imagery is how much of the image is covered by clouds. An image with heavy cloud coverage will not provide much information for our analysis. We usually would like the cloud coverage of an image to be around or below 0.05. Let's take a look the scale of cloud coverage in the first image.

```python
landsat.first().get('CLOUD_COVER').getInfo()
```

We can see the cloud coverage of the first image is 0.05, which is good. Now let's check when the first image was taken.

```python
landsat.first().get('DATE_ACQUIRED').getInfo()
```

The next thing we can check is the band names we get.

```python
landsat.first().bandNames().getInfo()
```

We see from the above code results that there are more than 11 bands we learned from the previous section. The band names with 'ST_' are all under one band. They are sub-bands for the Aerosol band.

##**5.6  Visualize Images**
We are now ready to see the images we pulled. First, let's create labels for images to be used in the following visualization.

```python
# put the images in a list
landsat_list = landsat.toList(landsat.size());

#Create labels for images
labels = ["Image #"+str(i)+", "+str(ee.Image(landsat_list.get(i)).get('DATE_ACQUIRED').getInfo())+", Cloud cover:"+ str(ee.Image(landsat_list.get(i)).get('CLOUD_COVER').getInfo()) for i in range(landsat.size().getInfo())]
labels
```

From the image labels, we can see we have 8 images from image 0 to image 7. We also see the dates they were taken on and their cloud coverage index.

Now let's define some parameters to display the images. We will use red, green, and blue bands to compose an image that resembles a photo. We will also define the pixel dimensions to show in our image. Last, we set the brightness by assigning min and max values. Assign values to min and max is a trial-and-error process. You need to play around with the number to get the appropriate brightness for images.

```python
parameters = {
                'min': 7000,
                'max': 16000,
                'dimensions': 800, # square size in pixels
                'bands': ['SR_B4', 'SR_B3', 'SR_B2'] # bands to display (r,g,b)
             }
```

Now let's use geemap to display the first image overlayed on a map.

```python
Map = geemap.Map()

first_image = landsat.first()

Map.addLayer(first_image, parameters, "First_Image")
Map.setCenter(lon,lat,8)
Map
```

From the above map, you can see the first image from our image collection. This is the image shot on November 7, 2018. You can move your cursor onto the map and move the map around. You can zoom in and out of the image by clicking the "+" or "-" icon on the left side of the map.
<br>
<br>
