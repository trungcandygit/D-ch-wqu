## **4.5 Document-Topic Assignment**

Now, we'll use `W` to assign the most prominent topic to each document. We can do this by finding the topic (column) with the highest weight for each document (row) in `W`:

```python
# Assigns the dominant topic for each document
df['Dominant_Topic'] = W.argmax(axis=1) + 1  # +1 to start topic numbering from 1

```

Here, `W.argmax(axis=1)` finds the index of the maximum value (highest weight) in each row of $W$. This index corresponds to the dominant topic for that document. And `+ 1` adds 1 to the topic index to start topic numbering from 1 instead of 0 (which is the default in Python indexing).

Bar charts can be used to visualize the distribution of topics within individual documents or across the entire corpus. The following bar plot demonstrates average topic distribution across all documents:

```python
# Visualize average topic distribution across all documents
avg_topic_distribution = W.mean(axis=0)

# Define topic labels
topic_labels = ["Windows AI Enhancements", "Data Center Sustainability",
                "Hololens and AR/VR", "AI Industry Competition",
                "Flight Simulator and Gaming"]

# Create bar plot
bars = plt.bar(np.arange(nmf_model.n_components) + 1, avg_topic_distribution, color='skyblue')

# Add bar labels inside bars
for bar, label in zip(bars, topic_labels):
    plt.text(bar.get_x() + bar.get_width() / 2, bar.get_height() / 2, label,
             ha='center', va='center', rotation=90, color='black', fontsize=8)

plt.xticks(np.arange(nmf_model.n_components) + 1)
plt.xlabel("Topic")
plt.ylabel("Average Weight")
plt.title("Average Topic Distribution Across All Documents")
plt.show()

```

This bar plot illustrates the average prevalence of each topic across all documents in the dataset. The height of each bar represents the average weight or importance of that topic across all the documents analyzed. Higher bars indicate topics that are more prominent or discussed more frequently overall.

We can observe that "AI Industry Competition" is the most prevalent topic, followed by "Hololens and AR/VR," based on the heights of their respective bars.

By examining this visualization, we can gain insights into the overall thematic distribution within the dataset. This information will guide further analysis, potentially focusing on documents related to "AI Industry Competition" and "Hololens and AR/VR" for a more in-depth understanding of these dominant themes.
