### **4.2.2 Netflix Intraday Data in Conjunction with Average Tone in News**[¶]{.anchor-link}

In previous code, we get intraday data for stock price data for Netflix. Please note the `prepost=True` parameter, which indicates whether to include pre-market and post-market data. In our case, we include pre- and post-market data. As you can see, the Volume column displays zeros before 9:30 AM (market open) and after 4:00 PM (market close). Yahoo uses the exchange\'s native time zone. For Netflix, it is NASDAQ located in New York City. On September 23 in New York, we observe Eastern Daylight Time (EDT), which is 4 hours behind the UTC timezone. Let\'s convert Datetime column values in the `nflx_intraday` DataFrame to UTC timezone:

In \[ \]:

``` calibre12
# Convert Datetime to UTC timezone
nflx_intraday.index = pd.to_datetime(nflx_intraday.index).tz_localize('America/New_York').tz_convert('UTC')
nflx_intraday
```

Let\'s now plot a candlestick chart. The candlestick charts are considered a valuable tool in financial technical analysis for several reasons. Their visual clarity in illustrating price action, ability to signal reversals, and widespread acceptance make them a valuable tool for financial technical analysis and informed trading decisions. The following code generates both the candlestick chart for `nflx_intraday` and the `tone_df` data on the same interactive plot. The code uses Plotly\'s graphing library, which enables us to interactively explore the visualization. We can zoom into a section of the visualization or hover over individual candlesticks/bars to glean precise values of stock price/volume at a specific time:

In \[ \]:

``` calibre12
# Create candlestick trace
candlestick_trace = go.Candlestick(x=nflx_intraday.index,
                                 open=nflx_intraday['Open'],
                                 high=nflx_intraday['High'],
                                 low=nflx_intraday['Low'],
                                 close=nflx_intraday['Close'],
                                 name='Netflix Price')

# Create tone trace
tone_trace = go.Scatter(x=tone_df['Timestamp'],
                        y=tone_df['AvgTone'],
                        mode='lines',
                        name='Average Tone',
                        line=dict(color='blue', width=1),
                        yaxis='y2')  # Assign to secondary y-axis

# Create figure with both traces
fig = go.Figure(data=[candlestick_trace, tone_trace])

# Update layout with secondary y-axis
fig.update_layout(title_text='Netflix Price and Average Tone',
                  yaxis_title='Price (USD)',
                  yaxis2=dict(title='Average Tone',
                              overlaying='y',
                              side='right'))
fig.show()
```

This code generates a chart with both the Netflix intraday candlestick chart and the average tone data plotted together, allowing us to visually analyze the relationship between price movements and sentiment changes.

Each candlestick represents the price movement of Netflix stock during a specific time interval. The green candlestick indicates a price increase during that interval. The bottom of the green candlestick represents the opening price, the top represents the closing price, and the lines (wicks) extending from the body represent the high and low prices during that interval. The red candlestick indicates a price decrease during that interval. The top of the red candlestick represents the opening price, the bottom represents the closing price, and the wicks represent the high and low prices.

The layout is updated to include a secondary y-axis on the right side (`yaxis2`) and set titles for both y-axes. The primary y-axis on the left represents the price (USD) of Netflix stock, and the secondary y-axis represents average tone values. Using separate y-axes allows for a clear and meaningful representation of both datasets without distorting their respective values. Now we can visually compare the price movements of Netflix stock with the changes in average sentiment over time. This can help to identify potential relationships or correlations between price and sentiment.

By observing the patterns and trends in the candlestick prices and the tone line, we can explore potential correlations and insights:

-   Positive Tone and Price: When the Tone line is high (positive sentiment) and the candlesticks are green (price increase), it could suggest that positive news coverage is having a favorable impact on Netflix\'s stock price. We can observe an abundance of news that is mostly positive in tone a few hours prior to market opening from about 10 AM. This could potentially explain green candlesticks at the opening time at 13:30.
-   Negative Tone and Price: Conversely, a low Tone line (negative sentiment) coinciding with red candlesticks (price decrease) could indicate that negative news is influencing the stock negatively.
-   Divergence: We can also observe that there are instances where the Tone line and candlestick patterns diverge. This might warrant further investigation. For example, positive news sentiment (high Tone) but a declining stock price (red candlesticks) could raise questions about other market factors at play.
