## **3.3 Sentiment Analysis Scores in Conjunction with Stock Price**

Let's consider the following example to see how we can use sentiment analysis scores in conjunction with Microsoft's stock price, keeping in mind the caveats about sentiment analysis accuracy and the need for other analysis tools.

In this example, we will visualize sentiment and price trends. We'll plot sentiment scores alongside historical stock prices. This can help to visually identify potential correlations between sentiment shifts and price movements.

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

Now the plot also shows Microsoft's stock price along with sentiment score bars. Please note that the stock price has been scaled, and we did this using MinMaxScaler. The MinMaxScaler from `sklearn.preprocessing` scales data to a specific range, typically between 0 and 1. It does this by applying the following formula:

$$X_{\text{scaled}} = \frac{(X - X_{min})}{(X_{max} - X_{min})}$$

Where:

 - $X$ is the original data;
 - $X_{\text{scaled}}$ is the scaled data;
 - $X_{min}$ is the minimum value of each feature (column) in $X$;
 - $X_{max}$ is the maximum value of each feature (column) in $X$;

This means that the data point with the maximum value in the original data will be scaled to 1. The data point with the minimum value in the original data will be scaled to 0. And all other data points will be scaled proportionally between 0 and 1 based on their relative position within the original data range.

While the scaled stock price doesn't show the actual price values, it still represents the stock price movement in a normalized way, allowing us to focus on the trends and patterns and compare them with other scaled features. When we plot the scaled stock price alongside the sentiment scores, we're essentially comparing the trends and patterns of both features over time. We can observe whether positive sentiment tends to coincide with upward price movements, negative sentiment with downward movements, or if there are any other interesting relationships.
