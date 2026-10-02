## **7.2 Dữ liệu về cơn bão Irene**
Dữ liệu về đường đi của cơn bão nằm trong một tệp PDF. Do đó, chúng ta cần cài đặt gói tabula để xử lý các tệp PDF.

```python
pip install tabula-py

```

```python
# Import tabula package for PDF handling
import tabula
```

Tiếp theo, hãy lấy tệp PDF từ trang web của Trung tâm Bão Quốc gia Hoa Kỳ (National Hurricane Center, NHC).

```python
# Retrieve PDF file from NHC website
url = "https://www.nhc.noaa.gov/data/tcr/AL092011_Irene.pdf"

irene_pdf, _ = urllib.request.urlretrieve(url)
```

Sau đó, chúng ta sẽ dùng một phương thức của gói tabula để chuyển tệp PDF thành tệp csv.

```python
# Convert PDF file to csv file, and then a pandas dataframe
tabula.convert_into(irene_pdf, "irene.csv", output_format="csv", stream=True, pages = 9)
irene_1 = pd.read_csv("irene.csv")
irene_1
```

Từ kết quả của đoạn mã trước, ta thấy hàng thứ hai không chứa giá trị dữ liệu. Đó là các đơn vị đo lường/thông tin của từng biến. Ví dụ, đơn vị đo của tốc độ gió là hải lý/giờ (knot, kt). Ngoài ra, hàng cuối cùng cũng không có giá trị dữ liệu nào. Chúng ta sẽ loại bỏ hai hàng này.

```python
# Drop rows with measurement units or no data values
irene_1.drop([0,40], inplace = True)
irene_1
```

Tiếp theo, hãy chuyển các biến số sang kiểu số thực (float).

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

Kết quả:
```
Date/Time      object
Latitude      float64
Longitude     float64
Pressure      float64
Wind Speed    float64
Unnamed: 5     object
dtype: object
```
