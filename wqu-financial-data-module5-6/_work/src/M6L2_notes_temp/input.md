# **Satellite Imagery**

##### MODULE 6 | LESSON 2

## Required Readings

Required Readings for this program are open access, which means you can access them at no cost. The link provided in the citation will take you directly to the reading or to a page where you can download it.

1. NASA. "Remote Sensing." _NASA EarthData_. https://www.earthdata.nasa.gov/learn/backgrounders/remote-sensing#spectral-resolution

- **Required pages:** Whole webpage
- **Estimated reading time:** 30 minutes
<br>
2. NASA Goddard. "9 Things about Landsat 9." *YouTube*, uploaded 26 Sept. 2021, https://www.youtube.com/watch?v=DGE-N8_LQBo.

- **Required pages:** Whole video
- **Estimated reading time:** 6 minutes


##### MODULE 6 | LESSON 2

# **Satellite Imagery**

|  |  |
|:---|:---|
|**Reading Time** |60 minutes|
|**Prior Knowledge** |Basic Python|
|**Keywords** |Remote sensing, Electromagnetic spectrum, Spatial resolution
 |
|  |  |

## **1. Introduction**

In this lesson, we are going to introduce a type of data that we have not touched upon yet: **satellite imagery**. Traditionally, satellite images are the type of data used in natural sciences or the defense sector. However, in recent years, more and more financial analysts have been using satellite images to conduct analyses, hoping to gain extra insights on top of traditional financial analysis to make better financial decisions. The content in this lesson draws from the information in your required readings. We'll first introduce the basics of satellite imagery. Then, we will briefly talk about some applications of satellite images in financial analysis. Finally, we will use Google Earth Engine (GEE) to access some satellite images and provide examples of how we can use satellite images for analysis.

## **2. Financial Application of Satellite Imagery**

In this section, we are going to talk about how to incorporate satellite images as part of data for financial analysis.
<br>
One of the most famous cases of using satellite images for financial analysis is to use satellite images to count the number of cars in and out of Walmart stores' parking lots over a period of time. Financial analysts use this piece of information as a proxy of foot traffic to gauge the sales of the store during a specific period of time. This leads to the first application of using satellite images.
<br>
<br>
### **2.1 Monitoring Economic Activities of a Location**
The Walmart parking lot example is a classic application of satellite imagery. Another example is to use satellite images to monitor container ship traffic at a major canal or a major port to identify possible supply chain obstacles. We can also use satellite images to monitor factory sites to evaluate potential production levels of a certain time. We can also monitor a mining site to track commodity production.
<br>
<br>
### **2.2 Tracking Crop Yield**
We can use satellite images to study if a given crop, like wheat or corn, is healthy or not. From this information, financial analysts can estimate if the market is going to have an oversupply of a crop or a shortage of a crop and trade on this information. We usually would use a combination of infrared bands to conduct this analysis.
<br>
<br>
###**2.3 Investigating Damages of Natural Disasters**
Insurance companies now use satellite images to access damages from a flood or a wildfire. This method of gathering damage information is more effective than traditional methods of visiting the damage sites. First, the traditional method may require several months to gather data, but using satellite images only takes a few hours. Secondly, many damage sites are usually not accessible after a disaster, so the traditional method is not possible.
With this new satellite image technology, insurance companies are able to process insurance claims faster and in more cost-effective ways.
<br>
<br>
###**2.4 Constraints of Using Satellite Imagery for Financial Analysis**
Currently, for the general public, there are a few issues when it comes to using satellite images for investment analysis.
<br>
<br>
&nbsp;&nbsp;&nbsp;(A) The temporal resolutions for public available satellite images can be long. For example, Landsat 9 has a temporal resolution of 8 days. Many commercial satellites offer satellite images with short temporal resolution, like a day. However, they are expensive.
<br>
&nbsp;&nbsp;&nbsp;(B) Processing large amount of satellite images requires powerful computing infrastructure, which individuals usually don't have.
<br>
&nbsp;&nbsp;&nbsp;(C) Processing raw satellite images and converting them into usable images requires special training.
<br>
<br>
Due to these constraints in using satellite images for analysis, there are many companies that now offer service to access their analytical platforms for satellite images with a subscription. These companies collect public and private satellite images, process them, and then upload them to their platforms. Their platforms generally incorporate machine learning capabilities for analysis. However, the fees to access these platforms are high, so only hedge funds or big investment companies can access them. Take the example of using retail parking lot car traffic as an indicator for stock trading. It is still a profitable trading strategy, but only hedge funds will have access to this information.


## **3. The Basics of Satellite Imagery**

### **3.1 Remote Sensing**

Before talking about satellite images, we need to introduce a few concepts. The first is remote sensing. **Remote sensing** is the activity of using Earth observation satellites or airplanes equipped with sensors to obtain images and other information about the Earth's surface from above.   

The sensors on a satellite measure **electromagnetic radiation (EMR)**, which is first emitted by the sun. Once it reaches Earth's surface, it is then reflected back to the sensors on the satellite. Figure 1 below demonstrates the path of EMR movement.
<br>
<br>
**Figure 1: Illustration of How a Satellite Measures EMR Reflected from Earth's Surface**
![alt text](https://drive.google.com/uc?id=1yxfc54aY2juMY-IF7NgYX_iMIjOcGd-w)
<br>
Adapted from: NASA EarthData. "What Is Remote Sensing?" 10 December 2024. https://www.earthdata.nasa.gov/learn/backgrounders/remote-sensing.
<br>
<br>

### **3.2 Electromagnetic Spectrum**

EMR is a type of energy that travels in waves. However, these waves are not homogeneous; they have different wavelengths. The wavelength of a wave is measured as the distance between two wave tops. If one wave has a shorter wavelength than the other waves, then this wave has a higher frequency because the wave moves up and down and then up again faster.
<br>
We group waves with similar wavelengths into a band called a **spectrum**. Figure 2 below shows how we group waves into different spectrums or bands by their wavelengths.
<br>
<br>
**Figure 2: Electromagnetic Radiation Spectrum**
![alt text](https://drive.google.com/uc?id=1Jx4zOsCkevauG28Y6GWObSbzZCkeGt5V)

Adapted from: NASA EarthData. "What Is Remote Sensing?" 10 December 2024. https://www.earthdata.nasa.gov/learn/backgrounders/remote-sensing.
<br>
<br>
Figure 2 represents the whole spectrum of electromagnetic radiation. However, in general, Earth observation satellites don't collect data across the whole sprectrum. Satellites usually only collect information from infrared bands and bands visible to the human eye. The information from these bands provides enough data for us to investigate activities happening on Earth's surface.

All electromagnetic radiation is light, but only certain wavelengths can be detected by the human eye. This is known as the visible light spectrum. All the colors that humans can see are combinations of three primary colors: red, green, and blue (RGB). Each of these primary colors represents a band.

Photos taken from cameras are also a combination of these three primary colors. These combinations can reveal different levels of information on Earth, and they are very insightful for researchers. We will only use a few combinations in this lesson. For those who are interested in learning more about combinations, there is plenty of information on the internet.
<br>
Satellites that collect information from multiple bands are called multispectral satellites. Each satellite can construct its own band system. For example, a popular satellite for which the public can access satellite images for free is the United States' Landsat satellites. Figure 3 below shows the band structure for the U.S. Landsat 8 satellite.
<br>
<br>
**Figure 3: Band Structure for U.S. Landsat 8 Satellite**
![alt text](https://drive.google.com/uc?id=1sXQ24--aneTmfoCb8W4T__hMVrsKhK8B)

Adapted from: USGS. "What Are the Band Designations for the Landsat Satellites?" 31 May 2024. https://www.usgs.gov/faqs/what-are-band-designations-landsat-satellites

<br>
<br>
According to Figure 3, if we want to generate a satellite image that looks like a photo taken from a camera, we will need to extract images from band 4 (red), band 3 (green), and band 2 (blue) and combine them together into a regular photo-like image. Figure 4 below demonstrates this concept.

**Figure 4: Color Bands For Photo-Like Image**
![alt text](https://drive.google.com/uc?id=1RDcDcA7tBkD6MkKRmXpQX3XUJehaDp8w)

Adapted from: Humboldt State Geospatial Online. "Natural and False Color Composites." 2014. https://gsp.humboldt.edu/olm/Courses/GSP_216/lessons/composites.html
<br>
<br>
### **3.3 Spatial Resolution**
When a satellite collects information from an observation area, it divides the area into a matrix or a grid. Each cell in the matrix is called a **pixel**. A cell is a square. If the cell is square that is 30 meters x 30 meters, then the resolution is 30 meters. The number represents the size of a pixel. Figure 5 demonstrates this concept.

**Figure 5: Spatial Resolution**
![alt text](https://drive.google.com/uc?id=1tYbEt25rjMQjFv5IYpPOxQVVlMdQv6NS)

<br>
From Figure 5, we can see that if the size of a pixel is smaller, say 10 meters instead of 30 meters, more pixels can fit into one area. This means that the image will have a higher resolution. In a pixel, the satellite will measure the EMR intensity of the band where the pixel is located and assign a number to the pixel. If the digital images of a band from a satellite have higher resolutions, it means there are more pixels in the images and more data in the images as well. When we read an image with higher resolution, the image will look more refined, and the lines and curves will be smooth. When we read an image with lower resolution, the image will look pixelated or more like a mosaic. Figure 6 demonstrates this difference.

**Figure 6: Images of the Same Location with Different Resolutions**
![alt text](https://drive.google.com/uc?id=1YCq95lR6vsfYLjdSdB15XMdYjkBA9BYs)
<br>
<br>
From Figure 6, we can see the photo on the left has a resolution of 30 meters. We can observe a lot of details of the location from this photo, like roads and properties. However, the photo on the right has a resolution of 300 meters. The photo looks like a mosaic—we can only see the vague shape of the location and can only identify different color blocks of geographical features like water and land.
<br>
Let's go back to Figure 3 to check the resolution construct for satellite Landsat 8. The right column of the figure shows the resolution setup for each band on Landsat 8. Resolutions for most bands are 30 meters. However, Band 8 has a resolution of 15 meters, whereas Band 10 and Band 11 have resolutions of 100 meters. From these, we can see different bands can have different resolutions within a satellite.
<br>
<br>
### **3.4 Popular Satellites to Provide Images**
The Landsat series from the U.S. and Sentinel 2 from the European Space Agency are the two most popular satellite systems that provide satellite images for research. The most current satellite for the Landsat series is Landsat 9. There are other Landsat satellites in operation as well, like Landsat 8 and Landsat 7. Sentinel 2 has a pair of satellites working currently.
<br>
Satellites orbit the Earth to collect data. Because they orbit the Earth at a different speed than the speed of Earth's rotation, they don't collect data from the same spot every day. Landsat 8 and Landsat 9 combined collect information from the same spot every 8 days. The pair of Sentinel 2 satellites collect information from the same spot every 5 days. The number of days it takes a satellite to collect information from the same spot multiple times is called **temporal resolution**.
<br> Please watch the video from the Required Readings list to get more information about Landsat series satellites.
<br>
<br>
### **3.5 Summary of the Basics of Satellite Imagery**
Let's summarize what we've learned so far. We know that a satellite records reflected energy of different wavelengths based on its band structure from Earth's surface. For each band, the collected data will be stored in a pixel of a matrix of the observation area at a certain time and be created as a digital image of the observation area. Digital images of different bands can be combined for the purposes of research and analysis. Therefore, it is important to know which band or combination of bands provides appropriate images for your research. If your research focuses on identifying objects on Earth's surface, you will also need high-resolution images for this task.
<br>
Now we have a basic understanding of satellite imagery. In the next section, we will briefly talk about current trends in using satellite imagery to conduct financial analysis.

## **4. Satellite Imagery Application: Google Earth Engine**
In this section, we are going to use the Google Earth Engine (GEE) platform to retrieve satellite images and do some analysis. Google Earth Engine is a platform that we can use to conduct analysis for satellite images and other geospatial data. The GEE team has collected and processed publicly available historical satellite images from popular satellites and stores them in its Earth Engine data catalog. Hence, we don't need to spend time and effort to collect and process raw historical satellite images. GEE has a code editor user interface that allows users to retrieve and analyze satellite images. It also has a Python API. In this lesson, we will use the Python API to retrieve images and conduct analysis. We will use the video from UCLA Office of Research Computing (UCLA 2022) to demonstrate this application.
<br>
<br>
### **4.1 Scenario: 2018 Northern California Camp Fire**
On Thursday, November 8, 2018, a faulty electric transmission line caught fire in Butte County, California, in the United States. Due to strong downslope wind, the fire spread quickly and burned around 153,000 acres of land. It did not stop until November 25, 2018. The Camp Fire was the most expensive natural disaster in 2018. In this section, we are going to look at the satellite images before the fire, during the fire, and after the fire. We will also do one analysis to investigate the vegetation conditions before and after the fire.
<br>
<br>
### **4.2 Set Up Google Earth Engine**
Before using Google Earth Engine, please read the file linked below. This file outlines how to set up a Google Earth Engine account step by step.

https://docs.google.com/document/d/1xZwsOHp49aCQFsPzvP0Kd8SJGmwMZA9Q/edit?usp=drive_link&ouid=103990088807346702419&rtpof=true&sd=true

<br>
<br>

# **5. Python API Demonstration on Google Colab**



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

## **6. Conclusion**
In this lesson, we first learned the basics of remote sensing, the method to obtain satellite images. We then went through the fundamentals of satellite images, including the electromagnetic spectrum, spatial resolution, and commonly used satellites. We then introduced some use cases for applying satellite images to finance analyses. We finished the lesson by using Google Earth Engine's Python API to pull some satellite images and conducted some analysis. We learned to use NDVI images to investigate the vegetation damage after the 2018 Camp Fire in California.

###**References**
* NASA EarthData. "Remote Sensing." 10 December 2024. https://www.earthdata.nasa.gov/learn/backgrounders/remote-sensing.

* UCLA Office of Advanced Research Computing. "Introduction to Remote Sensing With Python." *YouTube*, 9 Feb 2022, https://www.youtube.com/watch?v=gi4UdFsayoM.