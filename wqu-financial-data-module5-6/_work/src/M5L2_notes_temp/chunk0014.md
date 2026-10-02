## **4.1 Data Preparation**

We start with data preparation. We preprocess the 'Description' column using the `preprocess()` function introduced earlier and save each processed description in a new column named 'Processed_Description':

```python
# Preprocessing 'Description' column in df
df.loc[:, 'Processed_Description'] = df['Description'].apply(lambda x: preprocess(x))

```

Then, we are ready to apply the Term Frequency-Inverse Document Frequency (TF-IDF) technique.


