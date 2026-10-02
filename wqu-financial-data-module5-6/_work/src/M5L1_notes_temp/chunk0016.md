## **9. Application of NMF for Portfolio Diversification**[¶]{.anchor-link}

In this section, we will explore a simplified example of portfolio diversification using the NMF technique. We will approach this by leveraging NMF\'s ability to extract meaningful features from financial data and providing a systematic way to diversify a portfolio based on underlying factors. This can be done with the following steps:

-   **Correlation Matrix:** We start with the correlation matrix of asset returns, which captures the relationships between different assets.
-   **NMF Decomposition:** NMF decomposes the correlation matrix into factor loadings (\$W\$) and factor scores (\$H\$). The factor loadings represent the contribution of each asset to each factor, while the factor scores represent the importance of each factor over time.
-   **Factor Interpretation:** By analyzing the factor loadings, we can identify groups of assets that exhibit similar behavior and understand the underlying factors that drive asset co-movements.
-   **Diversification:** We can diversify our portfolio by selecting assets that load highly on different factors. This reduces the overall portfolio risk by spreading investments across different sources of risk.
-   **Portfolio Construction:** Based on the factor analysis, we can determine the weights for each asset in our portfolio, ensuring non-negativity and summing to 1.

In the following code snippet, we construct a simplified portfolio of data for five stocks: AAPL, MSFT, GOOG, AMZN, and TSLA. Then, we construct a `returns_df` DataFrame, containing daily returns for the selected assets.

In \[2\]:

``` calibre12
# Download historical data for the tickers
tickers = ['AAPL', 'MSFT', 'GOOG', 'AMZN', 'TSLA', 'NVDA', 'META', 'JPM']
data = yf.download(tickers, start='2022-01-01', end='2023-01-01')['Close']

# 1. Load asset returns data
returns_df = data.pct_change().dropna()
returns_df
```

``` calibre12
YF.download() has changed argument auto_adjust default to True
```

Out\[2\]:

  Ticker       AAPL        AMZN        GOOG        JPM         META        MSFT        NVDA        TSLA
  ------------ ----------- ----------- ----------- ----------- ----------- ----------- ----------- -----------
  Date                                                                                             
  2022-01-04   -0.012691   -0.016916   -0.004535   0.037910    -0.005937   -0.017147   -0.027589   -0.041833
  2022-01-05   -0.026600   -0.018893   -0.046830   -0.018282   -0.036728   -0.038388   -0.057562   -0.053471
  2022-01-06   -0.016693   -0.006711   -0.000744   0.010624    0.025573    -0.007902   0.020794    -0.021523
  2022-01-07   0.000988    -0.004288   -0.003973   0.009908    -0.002015   0.000510    -0.033040   -0.035447
  2022-01-10   0.000116    -0.006570   0.011456    0.000957    -0.011212   0.000732    0.005615    0.030342
  \...         \...        \...        \...        \...        \...        \...        \...        \...
  2022-12-23   -0.002799   0.017425    0.017562    0.004745    0.007855    0.002267    -0.008671   -0.017551
  2022-12-27   -0.013878   -0.025924   -0.020933   0.003504    -0.009827   -0.007414   -0.071354   -0.114089
  2022-12-28   -0.030685   -0.014692   -0.016718   0.005465    -0.010780   -0.010255   -0.006019   0.033089
  2022-12-29   0.028324    0.028844    0.028800    0.005738    0.040132    0.027630    0.040396    0.080827
  2022-12-30   0.002469    -0.002138   -0.002473   0.006606    0.000665    -0.004938   0.000753    0.011164

250 rows × 8 columns

Now that we have the `returns_df` DataFrame, containing daily returns for the selected assets, we can use it in the NMF portfolio diversification code:

In \[3\]:

``` calibre12
# 2. Calculate the correlation matrix
correlation_matrix = returns_df.corr()
correlation_matrix
```

Out\[3\]:

  Ticker   AAPL       AMZN       GOOG       JPM        META       MSFT       NVDA       TSLA
  -------- ---------- ---------- ---------- ---------- ---------- ---------- ---------- ----------
  Ticker                                                                                
  AAPL     1.000000   0.695905   0.790573   0.547907   0.592901   0.824902   0.763022   0.637218
  AMZN     0.695905   1.000000   0.724022   0.501689   0.605782   0.741197   0.709077   0.591533
  GOOG     0.790573   0.724022   1.000000   0.511192   0.681990   0.845283   0.767571   0.556652
  JPM      0.547907   0.501689   0.511192   1.000000   0.393247   0.532507   0.528095   0.364935
  META     0.592901   0.605782   0.681990   0.393247   1.000000   0.625860   0.607685   0.398646
  MSFT     0.824902   0.741197   0.845283   0.532507   0.625860   1.000000   0.787883   0.563946
  NVDA     0.763022   0.709077   0.767571   0.528095   0.607685   0.787883   1.000000   0.680243
  TSLA     0.637218   0.591533   0.556652   0.364935   0.398646   0.563946   0.680243   1.000000

Non-negative matrix factorization (NMF) is fundamentally designed to work with non-negative matrices. This means that the input matrix (\$V\$) and the resulting factor matrices (\$W\$ and \$H\$) are expected to have only non-negative elements. However, in the specific context of portfolio diversification using NMF, the input matrix is often the correlation matrix of asset returns, which can contain negative values representing inverse relationships between assets.

In our example, the correlation matrix has only positive values. But if required, we would consider the following adjustments in certain cases:
