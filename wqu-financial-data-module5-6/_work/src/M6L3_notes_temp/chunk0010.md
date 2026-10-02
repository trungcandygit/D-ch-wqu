## **2.5. Demonstration of Calculating GWR Parameters Using Linear Algebra**
In this section, we are going to show how to use linear algebra to obtain parameter estimates for GWR.
First, let's review the GWR estimator for local parameter estimates for location $i$.
<br>
<br>
$$\hat{\beta}(i)=\left[ X'W(i)X \right]^{-1}X'W(i)y$$
<br>
<br>
Let's use the above formula to calculate the parameter estimates for location 1(i will be 0 since Python starts at 0). Since the weight matrix is derived through the optimization search method, we will just pull it out from the model results and use it as input for calculation.

```python
#Pull the information of weight matrix of location 1 from GWR model result
W_1 = gwr_results.W[0]
W_matrix = np.diag(W_1)
```

Next, let's create $X$ matrix. It is the matrix with independent variables as columns. There also needs to be a column of all 1s for intercept estimation. Let's create this matrix.

```python
# Create X matrix with additional column of all 1s.
b_X_1 = np.hstack([np.ones((b_X.shape[0], 1)), b_X])
```

Now, let's calculate the inverse matrix $\left[ X'W(i)X \right]^{-1}$ in the equation first.

```python
inverse_matrix = np.linalg.inv(b_X_1.T@W_matrix@b_X_1)
```

Next, let's calculate the parameter estimates for location 1.

```python
beta_1 = inverse_matrix@b_X_1.T@W_matrix@b_y
beta_1
```

Output:
```
array([[ 3.30479996e+00],
       [ 1.61014298e-03],
       [ 2.06243405e-01],
       [-2.67321919e-02]])
```

Let's compare it with the GWR model results.

```python
gwr_results.params[0]
```

Output:
```
array([ 3.30479996e+00,  1.61014298e-03,  2.06243405e-01, -2.67321919e-02])
```

It turns out both results are the same. This exercise gives us a good idea of how linear algebra is applied to the calculation of a GWR model.
