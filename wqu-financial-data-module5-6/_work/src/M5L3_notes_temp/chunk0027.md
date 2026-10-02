### **4.2.1 Get Netflix Intraday Data**[¶]{.anchor-link}

Let\'s now get intraday stock price data for Netflix (NFLX) for September 23, 2024, using the `yfinance` library. The following code snippet downloads Netflix\'s 15-minute interval intraday stock data for September 23, 2024 (including pre- and post-market), saves it to a CSV file, and then displays it:

In \[ \]:

``` calibre12
# Download the intraday data using yfinance
nflx_intraday = yf.download(
    tickers='NFLX',
    start='2024-09-23',
    end='2024-09-24',
    interval='15m',
    prepost=True, auto_adjust = False)

# Save the data to a CSV file
nflx_intraday.to_csv("netflix_intraday_20240923.csv")

# Display DataFrame
nflx_intraday
```

**Important consideration for data availability:** Intraday data is typically available from Yahoo Finance for the past 60 days. As of this writing, available data was also downloaded and saved as \'WQUnetflix_intraday_20240923.csv\' for later retrieval. In case you run this notebook when intraday data is no longer available, please load data from the locally saved \'WQUnetflix_intraday_20240923.csv\' file for the remainder of this lesson.

In \[ \]:

``` calibre12
# Open saved DataFrame - OPTIONAL
nflx_intraday = pd.read_csv('WQU netflix_intraday_20240923.csv')
nflx_intraday.set_index('Datetime', inplace=True)
nflx_intraday
```
