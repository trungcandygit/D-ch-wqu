## **4.1 Chuẩn bị dữ liệu**

Chúng ta bắt đầu với bước chuẩn bị dữ liệu. Chúng ta tiền xử lý cột 'Description' bằng hàm `preprocess()` đã giới thiệu ở trên và lưu mỗi mô tả đã xử lý vào một cột mới có tên 'Processed_Description':

```python
# Preprocessing 'Description' column in df
df.loc[:, 'Processed_Description'] = df['Description'].apply(lambda x: preprocess(x))

```

Sau đó, chúng ta sẵn sàng áp dụng kỹ thuật Tần suất từ - Nghịch đảo tần suất văn bản (Term Frequency-Inverse Document Frequency, TF-IDF).
