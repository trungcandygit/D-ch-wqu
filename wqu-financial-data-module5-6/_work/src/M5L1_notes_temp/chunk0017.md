-   **Shifting:** we can shift the correlation matrix by adding 1 to all elements, ensuring all values are between 0 and 2. This might slightly alter the interpretation of the factor loadings but won\'t significantly affect the overall diversification strategy.
-   **Absolute Values:** Another option is to use the absolute values of the correlation coefficients, focusing on the strength of the relationships rather than their direction. This might be useful when we want to identify groups of assets with strong co-movements regardless of whether they are positive or negative.

Next, we apply NMF to break down the correlation matrix into two smaller matrices:

In \[4\]:

``` calibre12
# 3. Apply NMF
n_components = 5  # Number of factors to extract
model = NMF(n_components=n_components, init='random', random_state=0)
W = model.fit_transform(correlation_matrix)  # Factor loadings
H = model.components_  # Factor scores
```

Here, we use the `NMF()` function from the `sklearn.decomposition` module in the scikit-learn library.

-   `n_components` specifies the number of (or components) to extract from the data. In the context of portfolio diversification, these factors represent underlying drivers of asset co-movements. In this specific case, setting n_components = 5 assumes that there are likely around 5 major underlying factors driving the co-movements of the assets in the portfolio. This is a reasonable starting point, but we should experiment with different values to find the optimal number for our specific data and investment goals. Choosing the right number of components is often an iterative process involving domain expertise, experimentation, and model evaluation.
-   `init='random'` specifies the initialization method for the factor matrices (\$W\$ and \$H\$). `'random'` initializes them with random non-negative values.
-   `random_state=0` sets a random seed for reproducibility.

The next step involves analyzing the factor loadings (\$W\$) obtained from the NMF decomposition to understand the underlying factors driving asset co-movements and using this information to diversify the portfolio. We can access the factor loadings (\$W\$) using the variable `W` obtained in this step:

In \[5\]:

``` calibre12
# Convert W to a pandas DataFrame for easier analysis
W_df = pd.DataFrame(W, index=returns_df.columns)
W_df
```

Out\[5\]:

           0          1          2              3          4
  -------- ---------- ---------- -------------- ---------- ----------
  Ticker                                                   
  AAPL     0.464388   0.268745   2.308214e-01   0.780431   0.083933
  AMZN     0.667705   0.000000   1.201896e-01   0.276369   0.499711
  GOOG     0.458127   0.178795   1.562598e-01   0.803559   0.246556
  JPM      0.251893   0.864869   1.182338e-07   0.396028   0.208776
  META     0.003509   0.265379   2.902255e-01   0.680854   0.639626
  MSFT     0.550908   0.165173   1.144742e-01   0.780761   0.174299
  NVDA     0.406847   0.266952   3.439407e-01   0.672617   0.173926
  TSLA     0.310220   0.169135   6.282613e-01   0.296556   0.046811

The factor loadings matrix (\$W\$) provides insights into how much each asset contributes to each factor.

-   Rows: Represent the assets in your portfolio.
-   Columns: Represent the extracted factors.
-   Values: Indicate the strength of the relationship between an asset and a factor. Higher values suggest a stronger contribution of the asset to that factor.

To interpret the factors, we need to examine the assets that load highly on each factor. For each factor, we need to identify the assets with the highest loadings. These assets are most strongly associated with that factor.

In \[6\]:

``` calibre12
# Identify top contributing assets for each factor
n_top_assets = 3
for factor_num in range(W_df.shape[1]):
    print(f"\nFactor {factor_num + 1}:")
    top_assets = W_df.iloc[:, factor_num].nlargest(n_top_assets)
    print(top_assets)
```

``` calibre12
Factor 1:
Ticker
AMZN    0.667705
MSFT    0.550908
AAPL    0.464388
Name: 0, dtype: float64

Factor 2:
Ticker
JPM     0.864869
AAPL    0.268745
NVDA    0.266952
Name: 1, dtype: float64

Factor 3:
Ticker
TSLA    0.628261
NVDA    0.343941
META    0.290226
Name: 2, dtype: float64

Factor 4:
Ticker
GOOG    0.803559
MSFT    0.780761
AAPL    0.780431
Name: 3, dtype: float64

Factor 5:
Ticker
META    0.639626
AMZN    0.499711
GOOG    0.246556
Name: 4, dtype: float64
```

This output shows the top 3 contributing assets for each factor and their loadings. Remember that we can adjust `n_top_assets` and the interpretation of factors based on our specific data and investment goals. For now, we keep the top 3 contributing assets. We can now use this information to interpret the factors and develop a diversification strategy. Based on the top contributing assets for each factor, we can attempt to interpret their economic or financial meaning:
