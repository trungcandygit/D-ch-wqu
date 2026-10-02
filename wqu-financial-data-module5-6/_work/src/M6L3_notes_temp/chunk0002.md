# Geographically Weighted Regression (GWR)


|  |  |
|:---|:---|
|**Reading Time** | 2h  |
|**Prior Knowledge** | basic statistics, linear regression, Python |
|**Keywords** | Spatial analysis, regression, GWR, spatial heterogeneity, kernel |

---

*In this lesson, we will be introducing geographically weighted regression as an easy and intuitive way of modeling data that exhibit spatial heterogeneity. We explore the theoretical foundations of GWR, starting with its motivation and how it extends traditional linear regression to account for spatial heterogeneity. In the second half of the notebook, we follow a more hands-on approach with illustrations and a real-world data example in order to complement the theory with the necessary skills one would need in order to use GWR in practice.*

```python
import numpy as np
import matplotlib.pyplot as plt
import seaborn as sns
sns.set()
```
