## **3.3 Điểm phân tích cảm xúc kết hợp với giá cổ phiếu**

Hãy xem xét ví dụ sau để thấy cách sử dụng điểm phân tích cảm xúc kết hợp với giá cổ phiếu của Microsoft, đồng thời lưu ý các hạn chế về độ chính xác của phân tích cảm xúc và nhu cầu sử dụng thêm các công cụ phân tích khác.

Trong ví dụ này, chúng ta sẽ trực quan hóa xu hướng của cảm xúc và giá. Chúng ta sẽ vẽ điểm cảm xúc cùng với giá cổ phiếu lịch sử. Điều này có thể giúp nhận diện bằng mắt thường những tương quan tiềm năng giữa các thay đổi về cảm xúc và biến động giá.

```python
# Fetch Microsoft stock data for the same date range
msft = yf.download("MSFT", start=df_grouped.index.min(), end=df_grouped.index.max())

# Scale the Microsoft price data
scaler = MinMaxScaler()
scaled_stock_price = scaler.fit_transform(msft[['Close']])

# Plot scaled price plot
fig, ax = plt.subplots(figsize=(16, 6))
ax.plot(msft.index, scaled_stock_price, color='blue', label='MSFT Adj Close Price (Scaled)')

# Plot the sentiment data
width = 0.2  # Adjust the width as needed
ax.bar(df_grouped.index - pd.DateOffset(days=width), df_grouped['avg_negative'], width=width, label='Negative', color='red')
ax.bar(df_grouped.index, df_grouped['avg_neutral'], width=width, label='Neutral', color='orange')
ax.bar(df_grouped.index + pd.DateOffset(days=width), df_grouped['avg_positive'], width=width, label='Positive', color='green')

# Set plot attributes (labels, ticks, title, legend, gridlines)
ax.set_xlabel('Date')
ax.set_title('Sentiment Analysis and Stock Price of Microsoft (scaled)')
ax.set_ylabel('Value (Sentiment and Stock Price)')
ax.legend()
ax.grid(True, axis='y', linestyle='--')
plt.show()

```

Giờ đây biểu đồ cũng hiển thị giá cổ phiếu của Microsoft cùng với các cột điểm cảm xúc. Lưu ý rằng giá cổ phiếu đã được chuẩn hóa tỷ lệ, và chúng ta thực hiện việc này bằng MinMaxScaler. MinMaxScaler từ `sklearn.preprocessing` đưa dữ liệu về một khoảng giá trị xác định, thường là từ 0 đến 1. Nó thực hiện điều này bằng cách áp dụng công thức sau:

$$X_{\text{scaled}} = \frac{(X - X_{min})}{(X_{max} - X_{min})}$$

Trong đó:

 - $X$ là dữ liệu gốc;
 - $X_{\text{scaled}}$ là dữ liệu đã chuẩn hóa tỷ lệ;
 - $X_{min}$ là giá trị nhỏ nhất của mỗi đặc trưng (cột) trong $X$;
 - $X_{max}$ là giá trị lớn nhất của mỗi đặc trưng (cột) trong $X$;

Điều này có nghĩa là điểm dữ liệu có giá trị lớn nhất trong dữ liệu gốc sẽ được chuẩn hóa thành 1. Điểm dữ liệu có giá trị nhỏ nhất trong dữ liệu gốc sẽ được chuẩn hóa thành 0. Và tất cả các điểm dữ liệu còn lại sẽ được chuẩn hóa theo tỷ lệ giữa 0 và 1 dựa trên vị trí tương đối của chúng trong khoảng giá trị của dữ liệu gốc.

Mặc dù giá cổ phiếu đã chuẩn hóa không cho thấy các giá trị giá thực tế, nó vẫn biểu diễn biến động giá cổ phiếu theo cách đã được chuẩn hóa, cho phép chúng ta tập trung vào các xu hướng và mô hình, đồng thời so sánh chúng với các đặc trưng đã chuẩn hóa khác. Khi vẽ giá cổ phiếu đã chuẩn hóa cùng với điểm cảm xúc, về bản chất chúng ta đang so sánh các xu hướng và mô hình của cả hai đặc trưng theo thời gian. Chúng ta có thể quan sát xem cảm xúc tích cực có xu hướng trùng với các biến động giá tăng hay không, cảm xúc tiêu cực có trùng với các biến động giảm hay không, hoặc liệu có bất kỳ mối quan hệ thú vị nào khác.
