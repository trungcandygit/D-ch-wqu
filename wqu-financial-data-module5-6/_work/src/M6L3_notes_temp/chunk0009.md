## **2.4 Examining the Model Results**
The next block of the summary is the GWR model result. First, it tells us the kernel (bisquare) and the bandwidth (192) selected for this model. It also provides a lot of model diagnostic information. For example, the adjusted R<sup>2</sup> for OLS model is 0.271 while the adjusted R<sup>2</sup> for GWR model is 0.391. GWR model provides a better model fit than OLS model.

Next is the parameter estimation result. In the GWR model, each location will have a set of parameter estimates for independent variables. In our case, we will have 2,203 parameter estimates for each independent variable. In the above summary, X0 is the intercept, X1 is review scores, X2 is the number of accommodated visitors, and X3 is the number of bathrooms. Each of these variables has 2,203 parameter estimates. Hence, the summary shows the mean, standard deviation, min, median, and max of the parameter estimates for each independent variable. If we want to investigate the details of the estimated parameters, we can use the following Python code. It will show you the set of estimated parameters for each location. Let's look at the estimated parameters for the first five locations.

```python
# Show estimated parameters for
gwr_results.params[0:5]
```

Output:
```
array([[ 3.30479996e+00,  1.61014298e-03,  2.06243405e-01,
        -2.67321919e-02],
       [ 3.43635569e+00, -4.51930353e-04,  1.95844944e-01,
         5.37474550e-02],
       [ 3.27912291e+00,  2.92768647e-03,  2.12363255e-01,
        -8.10919052e-02],
       [ 2.88779932e+00,  5.06056110e-03,  2.45744327e-01,
         4.65164479e-02],
       [ 2.89309002e+00,  3.06784769e-03,  1.67282256e-01,
         3.42487452e-01]])
```

We know that GWR builds a regression for each location. Hence, each location also has its own R<sup>2</sup>. Let's take a look at the R<sup>2</sup>s for the first 10 locations.

```python
gwr_results.localR2[0:10]
```

Output:
```
array([[0.39583113],
       [0.41660429],
       [0.35650484],
       [0.43641022],
       [0.44784271],
       [0.41771337],
       [0.42162229],
       [0.41387561],
       [0.36649332],
       [0.46269692]])
```

We can also create a graph to show the R<sup>2</sup>s for all locations.

```python
#Show local model fit (R squared) for all locations
prenz['R2'] = gwr_results.localR2
prenz.plot('R2', legend = True)
ax = plt.gca()
ax.get_xaxis().set_visible(False)
ax.get_yaxis().set_visible(False)
plt.title("Local Model Fit")
plt.show()
```

![](images/img007.png)

From the above "Local Model Fit" graph, we can see that the two light regions on the left have the highest concentration of locations with R<sup>2</sup>s over 0.5. However, in the area left of center in the neighborhood, there are many locations with R<sup>2</sup>s that are less than 0.2.
