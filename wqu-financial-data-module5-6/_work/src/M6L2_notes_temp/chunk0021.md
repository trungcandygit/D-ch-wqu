We just saw how to display an image on the map. What if we want to interactively display other images in our collection on the map? We will create a new map and add a time series slider on the map to achieve this goal.

```python
image = landsat.toBands()

Map2 = geemap.Map()
Map2.addLayer(image,{},"Time series", False)
Map2.setCenter(lon,lat,8)
Map2.add_time_slider(landsat, parameters, labels = labels, time_interval=1)
Map2
```

We can see the new map has a slider on the lower right side of the map. **A note on using the slider:** Due to some technical issues, please do not use the "Play the time slider" button.

On the slider, you can see the label of the first image (image #0) by the slider bar. If you move your cursor to the dot on the left of the slider bar, you will see the dot turns blue. You can then move the blue dot along the slider bar to see other images. The label will display the image information you are seeing on the map. For example, in image #3, there is heavy cloud cover, with the cloud coverage at 67, so most of what we see is white. If we move to image #5, its cloud coverage is 6, so we can get a better look at Earth's surface.

##**5.7 Select and Zoom in on Cloudless Images**
We have investigated all the images we pulled from the data catalog. Now we would like to select the ones we will use for analysis. We would like to select 3 cloudless images: one from before the fire, one during the fire, and one after the fire. We would also like to zoom in on the area we are interested in for each image. By investigating all 8 images, we can see image #0, image #2, and image #5 fit our selection criteria.

```python
#Select images we want and create a new image collection
img1 = ee.Image(landsat_list.get(0))
img2 = ee.Image(landsat_list.get(2))
img3 = ee.Image(landsat_list.get(5))

landsat_2 = ee.ImageCollection.fromImages([img1, img2, img3])
print('Total number:', landsat_2.size().getInfo())
```

Now we create new labels for a new collection of images. We also update our new visualization parameters.

```python
# Create a new list
landsat_list_2 = landsat_2.toList(landsat_2.size())

# Define a region of interest with a buffer zone
roi = poi.buffer(20000) # meters

# New visualization parameters
parameters_2 = {
                'min': 6000,
                'max': 16000,
                'dimensions': 800,
                'bands': ['SR_B4', 'SR_B3', 'SR_B2'],
                'region':roi
             }

#Create new labels for images
labels_2 = ["Image #"+str(i)+", "+str(ee.Image(landsat_list_2.get(i)).get('DATE_ACQUIRED').getInfo())+", Cloud cover:"+ str(ee.Image(landsat_list_2.get(i)).get('CLOUD_COVER').getInfo()) for i in range(landsat_2.size().getInfo())]
labels_2
```

```python
image2 = landsat_2.toBands()

Map3 = geemap.Map()
Map3.addLayer(image2,{},"Time series", False)
Map3.setCenter(lon,lat,8)
Map3.add_time_slider(landsat_2, parameters_2, labels = labels_2, time_interval=1)
Map3
```

We can see that the upper corner of the middle image does show the fire. However, it is still hard to see the impact of the fire when comparing the first image to the last image. Let's introduce an NDVI index to better study the damage.

##**5.8 Normalized Difference Vegetation Index (NDVI)**
The Normalized Difference Vegetation Index (NDVI) is an index to study plant health. This index is calculated by using reflected light from the red band and near infrared band of satellite images. The higher the index number means the plants are healthier and greener. The lower the index number means the plants are browner and less healthy. The concept is illustrated in Figure 7.
<br>
<br>
**Figure 7. NDVI Illustration**
![alt text](https://drive.google.com/uc?id=1sQF7SKkFZGfL-dSvY_EiubYPBd4_44km)
<br>
<br>
In the following section, we will turn our three images into NDVI images. Each pixel will have an NDVI number. A pixel with a high NDVI number will be painted green. A pixel with a low NDVI number will be painted red. If the NDVI number is in between, the pixel will be painted yellow.



First, let's calculate NDVI numbers for each image.

```python
#Calculate NDVI for each image
img_ndvi_1 = ee.Image(landsat_list_2.get(0)).normalizedDifference(['SR_B5', 'SR_B4'])
img_ndvi_2 = ee.Image(landsat_list_2.get(1)).normalizedDifference(['SR_B5', 'SR_B4'])
img_ndvi_3 = ee.Image(landsat_list_2.get(2)).normalizedDifference(['SR_B5', 'SR_B4'])

landsat_3 = ee.ImageCollection.fromImages([img_ndvi_1, img_ndvi_2, img_ndvi_3])
print('Total number:', landsat_3.size().getInfo())
```

Then, we'll set up the new color palette and NDVI visualization parameters.

```python
# Create a new list
landsat_list_3 = landsat_3.toList(landsat_3.size())

# ndvi palette: red is low, green is high vegetation
palette = ['red', 'yellow', 'green']

ndvi_parameters = {'min': 0,
                   'max': 0.4,
                   'dimensions': 512,
                   'palette': palette,
                   'region': roi}

```

Now let's display the NDVI images.

```python
image3 = landsat_3.toBands()

Map4 = geemap.Map()
Map4.addLayer(image3,{},"Time series", False)
Map4.setCenter(lon,lat,8)
Map4.add_time_slider(landsat_3, ndvi_parameters, labels = labels_2, time_interval=1)
Map4
```

From the above interactive NDVI images, let's focus on the upper middle part of each image. Let's start with image #0.

In image #0, the area contains a mixture of green, yellow, and red. This image was taken before the Camp Fire. In image #1, we can see a big swath of red running across the area from right to left and going down. This image was taken during the Camp Fire. The red area is where the fire was. Now let's look at image #3, which was taken after the Camp Fire. In image #3, we can see a big red area in the upper middle part and some on the upper left side of the image. To summarize, with NDVI images, we can better identify changes in the vegetation on Earth's surface.
