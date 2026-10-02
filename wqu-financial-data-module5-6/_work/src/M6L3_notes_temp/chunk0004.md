### **1.1 Weighting Scheme (Data-Borrowing Scheme)**

The weighting scheme in GWR is also called a "data-borrowing scheme." This terminology emphasizes an important aspect of GWR: that spatial proximity-borrowing nearby observations-is essential in estimating local regression coefficients.

The weights assigned to each observation are given by spatial kernel functions. The three most common kernels include the:

* **Gaussian Kernel**:

$$
w_{ij} = \exp \left ( -\frac{d^{2}_{ij}}{2b^{2}} \right )
$$

* **Bisquare Kernel**:

$$
w_{ij} = \begin{cases}
     \left ( 1 - \left ( \frac{d_{ij}}{b} \right )^{2} \right )^2 & \text{ if } d_{ij} < b \\
     0 & \text{ otherwise }
\end{cases}
$$

* **Exponential Kernel**:

$$
w_{ij} = \exp \left ( -\frac{d_{ij}}{b} \right )
$$

where

* $w_{ij}$ are the weight for observation $j$ when estimating the model at observation $i$

* $d_{ij}$ is the distance between $i$ and $j$

* $b$ is the bandwidth parameter controlling the decay of weights with distance

**Distance**

The choice of the distance metric between two points is case specific. In many occasions, the Euclidean distance, which measures the straight line between two points, will suffice:

$$
d_{ij} = \sqrt{(u_{i} - u_{j})^{2} + (v_{i} - v_{j})^{2}}
$$

But if the problem requires that grid-like street patterns are taken into account, then one can use the Manhattan distance:

$$
d_{ij} = |u_{i} - u_{j}| + |v_{i} - v_{j}|
$$

If we further assume that the area of interest is large (the curvature of Earth becomes a factor) and/or the landscape includes varied terrains, then geodesic lines or geodesic distance could be more appropriate.

**Bandwidth Parameter**

The Bandwidth $b$ controls the trade-off between bias and variance by controlling the proximity of the points that will be used in the local regressions. A small bandwidth will emphasize local variations, keeping a small number of observations to estimate the parameters. A large bandwidth can reduce the coefficient variance but might as well miss local characteristics due to the "oversmooth" that will be applied by incorporating far-away points in the analysis. The bandwidth is normally selected with cross validation (CV) or Akaike information criterion (AIC).

Let's illustrate what the kernels look like in practice. In the next example, we will use a square "map," which consists of $100 \times 100 = 10,000$ observations. The illustrations include all three kernels and show the differences between using Manhattan and Euclidean distance. For simplicity, the point of interest will be fixed and placed at the center of the map.

```python
# Figure 1
# Create a meshgrid
i_indices = np.arange(100)
j_indices = np.arange(100)
I, J = np.meshgrid(i_indices, j_indices, indexing='ij')

# Manhattan and Euclidean distances
manhattan_distance = np.abs(I - 50) + np.abs(J - 50)
euclidean_distance = np.sqrt((I - 50)**2 + (J - 50)**2)

# Kernel functions
def gaussian_kernel(D, b):
    return np.exp(- (D ** 2) / (2 * b ** 2))

def bisquare_kernel(D, b):
    return ((1 - (D / b) ** 2) ** 2) * (D < b) # Comment this line yourself

def exponential_kernel(D, b):
    return np.exp(- D / b)

# Plotting function
def plot_kernels(D, bandwidth):
    # Compute weights
    W_gaussian = gaussian_kernel(D, bandwidth)
    W_bisquare = bisquare_kernel(D, bandwidth)
    W_exponential = exponential_kernel(D, bandwidth)

    # Set up the plot
    fig, axs = plt.subplots(1, 3, figsize=(18, 6))

    # Gaussian Kernel
    sns.heatmap(W_gaussian, cmap='viridis', ax=axs[0])
    axs[0].set_title(f'Gaussian Kernel (b = {bandwidth})')

    # Bisquare Kernel
    sns.heatmap(W_bisquare, cmap='viridis', ax=axs[1])
    axs[1].set_title(f'Bisquare Kernel (b = {bandwidth})')

    # Exponential Kernel
    sns.heatmap(W_exponential, cmap='viridis', ax=axs[2])
    axs[2].set_title(f'Exponential Kernel (b = {bandwidth})')

    plt.tight_layout()
    plt.show()


# Plot the kernels using manhattan distance
for b in [10, 25, 50]:
    plot_kernels(D = manhattan_distance, bandwidth=b)
```

![](images/img001.png)

![](images/img002.png)

![](images/img003.png)

```python
# Figure 2
# Plot the kernels using Euclidean distance
for b in [10, 25, 50]:
    plot_kernels(D = euclidean_distance, bandwidth=b)
```

![](images/img004.png)

![](images/img005.png)

![](images/img006.png)

In Figures 1 and 2, we observe the effect of the bandwidth in proximity selection. As the bandwidth increases, the area that is used in the local regression increases as well. We can also see that the shape of the area in each distance metric is different. More importantly, the illustrations make clear the differences between the kernels:

* Gaussian: gradual and smooth decay starting from the point of interest

* Bisquare: sharp cut-off that defines the clear borders of influence

* Exponential: rapid decay but with large tails that account for long-distance effects


