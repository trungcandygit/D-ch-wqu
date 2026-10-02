# **1. Geographically Weighted Regression**

Geographically weighted regression is an extension of the traditional linear regression that accounts for **spatial heterogeneity** in relationships between variables. This type of regression allows coefficients to vary geographically, capturing the differences in relationship between different points in space. In short, it is a regression that takes into account the location of the dependent variable on the map and assumes that its relation with the independent variables can very well be different from those of a different point on the map.

In order to achieve the above results, the GWR framework performs as many linear regressions as the number of data points on a map. Each of those regressions is a weighted linear regression (WLS) where the weights play the role of a decaying factor: the further one point is from where the WLS takes place, the less important that point becomes.

The first thing that becomes clear is that the coefficients of the GWR will not be constant across the map. On the contrary, for each point, we will end up with a unique set of coefficients, along with an intercept and an error term. But this is exactly the strength of this framework: that it allows for a thorough understanding of how relationships between variables change across space.

Let's start by formulating a traditional linear regression. In the context of GWR, we can refer to the traditional linear regression as *"global"* since the latter approach assumes global (constant) coefficients. The LR formula is:

**Traditional Linear Regression**

$$
y_{i} = \beta_{0} + \sum_{k = 1}^{p} \beta_{i} \cdot x_{ik} + \epsilon_{i}
$$

where

* $y$ is the dependent variable
* $\beta_{i}$ are the coefficients (assumed constant across all observations)
* $x_{ik}$ are the $k$ independent variables and
* $\epsilon_{i}$ are the errors


**Geographically Weighted Regression**

In GWR, we allow the coefficients to vary by location; thus, they become a function of space: $\beta(u, v)$, where $(u,v)$ are the coordinates.

$$
y_{i} = \beta_{0}(u_{i}, v_{i}) + \sum_{k=1}^{p}\beta_{k}(u_{i}, v_{i})x_{ik} + \epsilon{i}
$$

The above notation hides an important inconvenience: for each point on the map, we only have a single (or maybe a few) observations. This means that it is not possible to reliably estimate the coefficients at each point using the OLS estimator. In order to account for this, we make use of a spatial weighting scheme that encodes the influence of the points to the point of interest. Naturally, the faraway points are assigned a smaller weight than the ones closer. The end result is a diagonal weight matrix $W$ that contains values that range from 0 to 1.

What we actually changed by using a weight matrix here is that for each point on the map, we will estimate $\beta{i}$ using all the available observations weighted in terms of proximity to the point of interest. The estimation of the coefficients can now be given by:

$$
\hat \beta(u_{i}, v_{i}) = [X^{T} W(u_{i}, v_{i}) X]^{-1} X^{T} W(u_{i}, v_{i}) y
$$

It follows that the predicted value of each observation is given by:

$$
\hat y_{i} = X_{i} [X^{T} W(u_{i}, v_{i}) X]^{-1} X^{T} W(u_{i}, v_{i}) y
$$

If we set:

$$
S_{i} = X_{i} [X^{T} W(u_{i}, v_{i}) X]^{-1} X^{T} W(u_{i}, v_{i}) \text{ and } C_{i} = [X^{T} W(u_{i}, v_{i}) X]^{-1} X^{T} W(u_{i}, v_{i})
$$

the local covariance matrix $V_{i}$ of the parameter estimates becomes:

$$
V_{i} = C_{i} C^{T}_{i} \hat \sigma^{2}
$$

where $\hat \sigma^{2}$ is the estimated standard deviation of the error term, which is defined as:

$$
\hat \sigma^{2} = \frac{\sum (y_{i} - \hat y_{i})^{2}}{m - tr(S)}
$$

Let's now check the weighting scheme.
