## **2.3 Running the GWR Model**
In this section, we are going to use the Prenz data to build a GWR pricing model. We will use Python package mgwr for demonstration. For our dependent variable, we will use the logarithm of the price to correctly adjust for skewness of the price data. For independent variables, we will use review scores, number of visitors, and number of bathrooms as three independent variables. The linear equation will look like this.
<br>
<br>
**<center>log(price) = intercept + review scores + number of visitors + number of bathrooms</center>**
<br>
<br>
We will also create a list variable, which includes the $u$ and $v$ variables' information described in section 1.

```python
#Create variables for Berlin GWR pricing model
#Take the logarithm of the price variable to correct for skewing
b_y = np.log(prenz['price'].values.reshape((-1, 1)))
b_X = prenz[['review_sco','accommodat','bathrooms']].values
u = prenz['X']
v = prenz['Y']
b_coords = list(zip(u, v))
```

Once we create all the variables we need for the model, our next step is to decide the bandwidth parameter.
<br>
Python package mgwr provides a Sel_BW function to find the optimal bandwidth. We will use Sel_BW's default optimizing routine and model fit criterion to find the bandwidth parameter. The default kernel and distance selections are bisquare kernel and Euclidean distance. The reason that bisquare kernel is selected is because this kernel will give 0 weights to far-away locations whereas Gaussian and exponential will always give non-zero weights to far-away locations.
<br>
Then, Sel_BW will use a default search method based on corrected AIC (AICc) to find the optimal bandwidth parameter. **Corrected AIC (AICc)** is a special AIC that is designed to be used with spatial analysis. AICc includes a function to penalize small bandwidth selection due to more complicated models.
<br>
Okay, now let's find the bandwidth for our model.

```python
#Find bandwidth parameter
selector = Sel_BW(b_coords, b_y, b_X)
bw = selector.search()
print(bw)
```

Output:
```
192.0
```

Once we obtain the bandwidth, we can use it as an input to build our GWR model.

```python
# Build a GWR model and print out model summary
gwr_model = GWR(b_coords, b_y, b_X, bw)
gwr_results = gwr_model.fit()
gwr_results.summary()
```

The global regression result from the above summary is the OLS model result for our Prenz data. It is used as the benchmark model to compare to our GWR model. The OLS model results include the usual model summary we are familiar with.
<br>