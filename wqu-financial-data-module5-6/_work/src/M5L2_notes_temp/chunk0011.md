## **3.2 Visualizing Sentiment Scores**

We can now visualize sentiment scores. But before doing this, note that there are multiple articles on some days. Directly summing up the sentiment scores when there are multiple articles on the same day can lead to inflated values and spikes in the plot. To address this, we should normalize the sentiment scores by the number of articles on each day before plotting. By normalizing the sentiment scores, the plot should now show a more accurate representation of the overall sentiment trend without being affected by the number of articles on each day. The spikes should be reduced, and the plot will be more interpretable.

In the following code snippet we group articles by date and aggregate to get both the sum and count of articles for each date. Then, we divide the sum of each sentiment score by the count of articles for that date to get the average sentiment for the day. This normalizes the scores and prevents inflation due to varying numbers of articles. Then, we use the normalized sentiment scores for visualization.


```python
# Group by date and calculate average sentiment scores
df_grouped = df.groupby('Date').agg(['sum', 'count'])  # Get sum and count

# Create new columns for normalized sentiment scores
df_grouped['avg_positive'] = df_grouped['Sent_positive']['sum'] / df_grouped['Sent_positive']['count']  # Normalize positive
df_grouped['avg_negative'] = df_grouped['Sent_negative']['sum'] / df_grouped['Sent_negative']['count']  # Normalize negative
df_grouped['avg_neutral'] = df_grouped['Sent_neutral']['sum'] / df_grouped['Sent_neutral']['count']  # Normalize neutral

# Convert df_grouped.index to DatetimeIndex
df_grouped.index = pd.to_datetime(df_grouped.index)

# Plot the sentiment data
fig, ax = plt.subplots(figsize=(16, 6))
width = 0.2
ax.bar(df_grouped.index - pd.DateOffset(days=width), df_grouped['avg_positive'], width=width, label='Positive', color='green')
ax.bar(df_grouped.index, df_grouped['avg_neutral'], width=width, label='Neutral', color='orange')
ax.bar(df_grouped.index + pd.DateOffset(days=width), df_grouped['avg_negative'], width=width, label='Negative', color='red')

# Set plot attributes (labels, ticks, title, legend, gridlines)
ax.set_xlabel('Date')
ax.set_ylabel('Average Sentiment')
ax.set_title('Sentiment Analysis of News Articles')
ax.legend()
ax.grid(True, axis='y', linestyle='--')
plt.show()

```

![](images/img001.png)

The resulting plot is a bar chart visualizing the average sentiment of news articles over time. There are three bars for each date, representing the three sentiment categories: positive (green), negative (red), and neutral (orange). The height of each bar indicates the magnitude of the average sentiment score for that category on the corresponding date. Taller bars indicate stronger sentiment.

The plot allows us to observe trends in sentiment over time. We can see how the average sentiment changes across dates, whether it's becoming more positive, negative, or staying neutral. By comparing the heights of the bars for each category, we can identify periods of stronger positive or negative sentiment. For example, if on a particular date, the red bar (negative) is much taller than the green bar (positive), it suggests that the news articles for that date were generally more negative in sentiment. Conversely, a taller green bar would indicate more positive sentiment.
