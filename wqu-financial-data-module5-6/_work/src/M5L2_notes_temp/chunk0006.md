## **2.3 News API**

Although not a Python package, News API provides a straightforward way to fetch news data. It offers a free tier with limited requests per day. This might be sufficient for small-scale projects or learning purposes. You will need to sign up for a free API key on the NewsAPI website before using it.

News API is a cloud-based REST API that provides programmatic access to a vast collection of news articles from thousands of sources around the world.
It aggregates news from reputable publishers, news agencies, blogs, and other online media outlets.

**Compared to `yfinance` and Google News RSS:**
 - More Articles: You can potentially retrieve a much larger number of news articles with News API.
 - Customization: You have much finer control over the news data you fetch through search and filtering options.
 - Additional Features: Sentiment analysis and various API endpoints add more analytical capabilities.

**Limitations:**
 - Cost: While it offers a free tier with limited requests, you'll need a paid subscription for larger-scale usage or access to all features.
 - Rate Limits: Even with paid plans, there are rate limits on how many requests you can make within a given time period.

**Use Cases:**
 - News Monitoring and Analysis: Track news trends, identify emerging topics, and analyze media coverage for specific companies, industries, or events.
 - Sentiment Analysis: Gauge public sentiment toward brands, products, or political figures.
 - Market Research: Gather insights on consumer behavior, competitor activity, and industry trends.
 - Content Curation: Build news aggregators or personalized news feeds.
 - Algorithmic Trading: Incorporate news sentiment and events into trading strategies.

Overall, News API is a more powerful and versatile tool for news data analysis compared to `yfinance` and Google News RSS. It's a great option if you need a larger dataset, more customization, and additional features like sentiment analysis. However, it does come with a cost for more extensive usage.

For the remainder of this lesson, we will explore some of the News API features. First, we need to sign up and get an API key.

 - Sign Up: Create a free account on the News API website: https://newsapi.org/pricing, selecting the free Developer pricing plan. Sign up as an individual. The free tier offers limited requests per day and allows you to search news articles (with a 24-hour delay) up to a month old, but this should suffice for learning purposes.
 - Get Your API Key: As soon as you sign up, you'll be greeted with your unique API key that you'll need to include in your requests.
 - On the greeting page, you will also find a link to the "Getting Started Guide." Please take some time to explore the API documentation for detailed information on endpoints, parameters, and response formats.

In this lesson, we will explore some basic functionality and experiment with different queries and filters to tailor the results to our specific needs.

The following is the example code that fetches news articles related to "Microsoft" from News API, saves them in DataFrame, and handles potential errors during the process. Do not forget to get your own API key. Then, please navigate to the top of this lesson and replace `API_KEY` with your actual API key in the code cell at the top of this notebook. Please rerun that code cell and then proceed with the following code cell below:

```python
# Define News API variables
query = "Microsoft"
url = f"https://newsapi.org/v2/everything?q={query}&apiKey={api_key}&language=en"
response = requests.get(url)

# Get news data
results = []
if response.status_code == 200:
    news_data = response.json()
    for article in news_data['articles']:
        results.append({
            'Date': article['publishedAt'][:10],  # Extract date
            'URL': article['url'],
            'Source': article['source']['name'],
            'Author': article['author'],
            'Title': article['title'],
            'Description': article['description'],
            'Content': article['content']
        })
else:
    print("Error fetching news:", response.status_code)

# Create DataFrame
df = pd.DataFrame(results)
df

```

We can also save the dataset locally in a news_data.csv file. Saving News API data to a CSV file is beneficial because of the limitations on data availability for certain time periods, particularly with the free plan. It is highly probable that the remainder code in this lesson will output different results when you run it. Thus, referring to news_data.csv might be beneficial.

```python
# Save News dataset
df.to_csv('news_data.csv', index=False)
```

`if response.status_code == 200:` This line checks if the value of `response.status_code` is equal to 200. In the context of HTTP requests, a status code of 200 typically indicates a successful request.

If the condition in the if statement is true (i.e., the status code is 200), this line executes and the code execution will move to next line. `response.json()` in the following line is a method that attempts to parse the response content as JSON (JavaScript Object Notation). JSON is a common data format used for data exchange on the web. The parsed JSON data is then assigned to the variable `news_data`.

The code output saves article metadata for each news item: information like publication date (publishedAt), source (source), author (author), title (title), description (description), content (content), and URL (url) provide context for the sentiment analysis.

Note the "[Removed]" in the Content column of dataframe. This is likely due to content restrictions imposed by the news source or by News API itself. The reasoning behind this is as follows:
