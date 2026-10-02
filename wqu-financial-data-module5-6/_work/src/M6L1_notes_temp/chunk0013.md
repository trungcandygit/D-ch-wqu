## **7.2 Data for Hurricane Irene**
The hurricane path data is in a PDF file. As such, we need to download the tabula package to handle PDF files.

```python
pip install tabula-py

```

```python
# Import tabula package for PDF handling
import tabula
```

Next, let's retrieve the PDF file from the National Hurricane Center website.

```python
# Retrieve PDF file from NHC website
url = "https://www.nhc.noaa.gov/data/tcr/AL092011_Irene.pdf"

irene_pdf, _ = urllib.request.urlretrieve(url)
```

Then, we will use a method from the tabula package to convert a PDF file to a csv file.

```python
# Convert PDF file to csv file, and then a pandas dataframe
tabula.convert_into(irene_pdf, "irene.csv", output_format="csv", stream=True, pages = 9)
irene_1 = pd.read_csv("irene.csv")
irene_1
```

From the last code output, we can see that the second row does not contain data values. They are measurement units/information for each variable. For example, the measurement unit for wind speed is knots (kt). Also, the last row does not have any data values. We are going to drop these two rows.

```python
# Drop rows with measurement units or no data values
irene_1.drop([0,40], inplace = True)
irene_1
```

Next, let's convert numeric variables to float types.

```python
# Correct data types for numeric variables
convert_dict = {'Date/Time': str,
                'Latitude': float,
                'Longitude': float,
                'Pressure': float,
                'Wind Speed': float
                }

irene_1 = irene_1.astype(convert_dict)
print(irene_1.dtypes)

```

Output:
```
Date/Time      object
Latitude      float64
Longitude     float64
Pressure      float64
Wind Speed    float64
Unnamed: 5     object
dtype: object
```
