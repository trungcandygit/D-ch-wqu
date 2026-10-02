```
         Date                                                URL     Source  \
0  2024-09-27                                https://removed.com  [Removed]   
1  2024-10-09                                https://removed.com  [Removed]   
2  2024-10-10  https://www.theverge.com/2024/10/10/24266333/a...  The Verge   
3  2024-10-01  https://www.theverge.com/2024/10/1/24258337/mi...  The Verge   
4  2024-10-01  https://www.wired.com/story/mustafa-suleyman-i...      Wired   

          Author                                              Title  \
0            NaN                                          [Removed]   
1            NaN                                          [Removed]   
2  Kylie Robison  Agents are the future AI companies promise — a...   
3     Tom Warren    Microsoft is using AI to improve Windows search   
4    Will Knight  Microsoft’s AI Boss Wants to Bring ‘Emotional ...   

                                         Description  \
0                                          [Removed]   
1                                          [Removed]   
2  OpenAI, Google, and Microsoft believe autonomo...   
3  Microsoft is improving its Windows search acro...   
4  Microsoft AI CEO Mustafa Suleyman is overseein...   

                                             Content  
0                                          [Removed]  
1                                          [Removed]  
2  Illustration by Cath Virginia / The Verge | Ph...  
3  Illustration by Alex Castro / The Verge\r\n\n ...  
4  We don't save any of the material with Copilot...
```

```python
# Remove rows with "[Removed]" or None in Description
df = df[df['Description'] != '[Removed]']
df = df.dropna(subset=['Description'])

# Apply sentiment scoring to the 'description' column and create new columns
df.loc[:, 'Sent_positive'] = df['Description'].apply(lambda x: get_sentiment(x)['positive'])
df.loc[:, 'Sent_negative'] = df['Description'].apply(lambda x: get_sentiment(x)['negative'])
df.loc[:, 'Sent_neutral'] = df['Description'].apply(lambda x: get_sentiment(x)['neutral'])
df

```

The code output contains sentiment scores. This is how to interpret sentiment:

 - Higher probability indicates stronger sentiment. For example, if `positive: 0.85`, it suggests a strong positive sentiment expressed in the article.
 - Look for dominant sentiment. The category with the highest probability usually represents the overall sentiment of the article.
 - Consider the context. Even with high sentiment scores, it's important to read the article content to understand the nuances and specific aspects driving the sentiment.

By analyzing the sentiment scores alongside the article content, we can gain insights into the overall sentiment toward Microsoft as reported in the news. This information can be valuable for understanding market perception, identifying potential trends, and making informed decisions.
