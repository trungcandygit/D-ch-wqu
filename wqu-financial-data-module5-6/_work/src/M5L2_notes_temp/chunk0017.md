## **4.4 Topic Extraction and Interpretation**

Let's now examine the top words in each topic to understand the theme of the topic. The goal is to understand the themes or subjects represented by each of the five topics extracted by NMF.

Recall that the $H$ matrix stores the weight of each word in each topic. We want to identify the words with the highest weights for each topic, as these words are most representative of the topic's theme. For each topic, we'll display the top $n$ words with the highest weights. This will give us a glimpse into the subject matter of the topic. Based on the top words, we'll try to assign a meaningful label or interpretation to each topic. This requires domain knowledge and careful consideration of the context of the financial news articles.

```python
# Retrieves the names of the features (words)
feature_names = vectorizer.get_feature_names_out()

# Extract top words
n_top_words = 10  # Top 10 words
for topic_idx, topic in enumerate(H):
    print(f"\nTopic {topic_idx + 1}:")
    print(" ".join([feature_names[i]
                    for i in topic.argsort()[:-n_top_words - 1:-1]]))

```

We can also plot top words for each topic for better visualization. In the following code snippet, we plot the top 10 words for each topic as bar subplots:

```python
# Set figure size
fig, axes = plt.subplots(1, nmf_model.n_components, figsize=(16, 6), sharex=True)
axes = axes.flatten()  # Convert to 1D array for easier indexing

# Plot bar subplots for each topic
for topic_idx, topic in enumerate(H):
    top_features_ind = topic.argsort()[:-n_top_words - 1:-1]
    top_features = [feature_names[i] for i in top_features_ind]
    weights = topic[top_features_ind]

    ax = axes[topic_idx]
    ax.barh(top_features, weights, height=0.5, fill='blue')
    ax.set_title(f'Topic {topic_idx + 1}', fontdict={'fontsize': 14})
    ax.invert_yaxis()
    ax.tick_params(axis='both', which='major', labelsize=12)

# Set figure attributes (title)
fig.suptitle('Top words in topics in NMF model', fontsize=20, y=0.98)
fig.tight_layout(h_pad=2.0)
plt.show()

```

The code snippet's main purpose is to display the top words for each topic extracted by NMF. This helps in interpreting the topics and understanding the themes or subjects they represent.

As of this writing, get the following top words for each topic (you might get different results as News API will have another set of news articles by the time you run this code):

 - **Topic 1: Microsoft Windows and AI Features**

   - Top Words: `copilot, plus, feature, new, pcs, features, search, voice, ai, windows`
   - Interpretation: This topic appears to be related to new features and enhancements in Microsoft Windows, particularly those involving AI and voice search capabilities. Copilot, a potential new AI assistant, is also a prominent theme.

 - **Topic 2: Microsoft's Data Centers and Energy Initiatives**

   - Top Words: `data, energy, centers, power, nuclear, ai, tech, run, microsoft, carbon`
   - Interpretation: This topic seems to focus on Microsoft's data centers and their energy consumption. It might involve discussions about power sources, including nuclear energy, and initiatives to reduce carbon emissions. The use of AI technology in data centers is also a possible theme.

 - **Topic 3: Microsoft's AR/VR Efforts (Hololens)**

   - Top Words: `microsoft, windows, hololens, headsets, according, vr, update, production, uploadvr, 11`
   - Interpretation: This topic likely revolves around Microsoft's augmented and virtual reality efforts, specifically focusing on the Hololens headset. It might involve updates on Hololens production, new features, or partnerships with VR-related platforms like UploadVR.

 - **Topic 4: AI Competition (Microsoft, OpenAI, Google)**

   - Top Words: `openai, google, ai, microsoft, stay, date, financial, way, competition, amid`
   - Interpretation: This topic centers on the competition in the field of artificial intelligence, primarily involving Microsoft, OpenAI, and Google. It might discuss financial aspects, strategic partnerships, and the overall landscape of the AI race.

 - **Topic 5: Microsoft Flight Simulator and Gaming**

   - Top Words: `flight, game, simulator, microsoft, 2024, test, based, reboot, 2020, office`
   - Interpretation: This topic seems to be related to Microsoft Flight Simulator, a popular flight simulation game. It might involve discussions about updates, new features, testing phases, or potential releases in the future. The inclusion of "office" is a bit unusual and might require further context to understand its relevance.


Based on these interpretations, here's a suggested set of labels for the topics:

 1. Windows AI Enhancements
 2. Data Center Sustainability
 3. Hololens and AR/VR
 4. AI Industry Competition
 5. Flight Simulator and Gaming

These labels provide a concise and informative representation of the themes captured by each topic. Remember that topic interpretation can be subjective, so they can be adjusted based on your specific understanding of the data and context.

By carefully analyzing the top words and considering the broader context, we can gain valuable insights into the main themes being discussed in financial news articles related to Microsoft.
