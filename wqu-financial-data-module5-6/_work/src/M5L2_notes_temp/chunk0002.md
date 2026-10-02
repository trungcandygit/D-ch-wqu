# **News Data**

|  |  |
|:---|:---|
| **Reading Time**  |  45 minutes  |
| **Prior Knowledge**  |  Familiarity with Python programming: Basic Python syntax, data manipulation, DataFrames, yfinance, sklearn; <br>Fundamental financial concepts: stocks, market sentiment, risk management, and trading strategies, sentiment analysis  |
| **Keywords**  | Non-negative Matrix Factorization (NMF), Feature Extraction, Parts-based Representation, Sentiment Analysis, <br>Natural Language Processing (NLP), Sentiment Analysis, Topic Modeling, FinBERT, NMF, TF-IDF |

---

*In this lesson, we demonstrate how to use news data and natural language processing (NLP) techniques for financial analysis, specifically for Microsoft. We will explore different news sources, perform sentiment analysis using FinBERT, and use topic modeling (NMF) to uncover hidden themes in the news. The goal is to gain insights that could potentially lead to better-informed financial decisions.*

```python
import torch
```

```python
# Loading libraries

import datetime
import feedparser
import matplotlib.pyplot as plt
import numpy as np
import pandas as pd
import requests
import yfinance as yf

from datetime import datetime, timedelta
from scipy.special import softmax
from sklearn.feature_extraction.text import TfidfVectorizer
from sklearn.decomposition import NMF
from sklearn.preprocessing import MinMaxScaler
from transformers import AutoTokenizer, AutoModelForSequenceClassification

api_key = "5842977bf5f44e3b84ed41f6dcd9e215"  # Replace with your actual News API key

```
