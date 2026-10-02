## **2.2 RSS Feeds: Google News RSS**

An alternative way of getting news updates is to subscribe to an RSS feed. RSS stands for Really Simple Syndication or Rich Site Summary. It's a standardized web feed format that allows users to subscribe to updates from websites or blogs. These updates are typically delivered as news headlines, article summaries, or other content changes. Many well-known financial news sources provide RSS feeds. Some examples include the *Wall Street Journal*, Bloomberg, Reuters, *Financial Times*, Seeking Alpha, The Motley Fool, Benzinga, etc.

In this lesson, we explore using Google News RSS to access news articles from Google News in a structured format that can be easily processed by machines. While not strictly an API, we can parse Google News RSS feeds for free using libraries like `feedparser` Python library designed to parse syndicated feeds, most commonly RSS and Atom feeds. It can handle various feed formats and variations, making it a versatile tool for extracting information from different sources.

In the following code, we define the RSS feed URL and extract article information (title, link, publication date, etc.) for the query term "Microsoft":

```python
# Define RSS feed URL and retrieve feed
query = "Microsoft"
rss_url = f"https://news.google.com/rss/search?q={query}t&hl=en-US&gl=US&ceid=US:en"
feed = feedparser.parse(rss_url)

for entry in feed.entries:
    print("Published:", entry.published)
    print("Title:", entry.title)
    print("Link:", entry.link)
    print("-" * 30)
```

Output:
```
Published: Mon, 01 Dec 2025 08:00:00 GMT
Title: Tech Moves: Expedia names first AI chief; Textio founder joins Microsoft; T-Mobile exec departs - GeekWire
Link: https://news.google.com/rss/articles/CBMiwAFBVV95cUxNdnhialhuOVhIZzVGQWVnb2d1UmVNTEFTbWw3Z1RwVGNENnhCMThxc085Yl8zYVNmT20tWnRFb1pTTW5rV2lLOTBJVnpXRVVrRk51RDJXeFVIalFjeC01Mmt1NE45VlZGT3VlN1FFV3c1UHBZczdOLWZvSUxMajFpeUFNVmh6bjBVZUVKQkRvWUFmeC16ZC1IUzl5V05iYXlFYThBRnlQWHBOWkplbHRlWDZvMHZLVDJ3Yk5QdGVkbW8?oc=5
------------------------------
Published: Thu, 11 Sep 2025 07:00:00 GMT
Title: Innovation Leader at Microsoft to Direct New AI Institute - The Catholic University of America
Link: https://news.google.com/rss/articles/CBMikgFBVV95cUxNUGpua3hrcFdjLWpHT3RtTkNGc0hJZF96U3RMWFZLa0JjQ0wtVUV0QS1CZHpXdE1VVVM4MzIxd1ptVnNvd0lyeFRodjlkeHhTQ09ZQkZVV2x4c1NjZzZiQm14bUxQSm5pcVNhY2Q0ZWpLamd1ODhia0J5QWZFb0U2QjduTnJxOHk0SzhHd0RqdU93Zw?oc=5
------------------------------
Published: Tue, 13 Aug 2024 07:00:00 GMT
Title: Kudo adds AI speech translation for Microsoft Teams - Inavate
Link: https://news.google.com/rss/articles/CBMiogFBVV95cUxPNXpORnZlU0c5d08xOFBxQzFDRHRzeDVZQjVJTEdaX3BoVDhNMVBnZ0p1cnJRR1lydU9uVmhCc0RtbG51bHVWMzJoX051eHh6WHVNckMwa3lxZC1qdzBUb0xzbGhJS1NLSEtnbEw2bDRUNlp3VmFyQ3RtdlRmanBtVFZIY0lOZFVVTjZ5OTRXLWNqLTduWUxKNks4bGJpN0xOOEE?oc=5
------------------------------
Published: Mon, 11 Oct 2021 07:00:00 GMT
Title: Azure AI empowers organizations to serve users in more than 100 languages - Microsoft Source
Link: https://news.google.com/rss/articles/CBMilAFBVV95cUxQSk9JVDhKQTM1cDB5Sm5XdTg4NVhpejB6a0NJdkVoYzBFaFJlRmM5QXdkZ0pJZVBJNUhSc3pTczNENGlJUXdhTXgyTlJ6eER5a2w3czlKMXBlUGNOOUpFalJrLVhnTHNLd3ZyMVl0cmUtdWlfdG82enVCanMtQTQ4cFZqT3FkSklLQU1wWmxjR0YzNnZ3?oc=5
------------------------------
Published: Wed, 06 May 2015 07:00:00 GMT
Title: Secret T-shirt message explains why Microsoft skipped Windows 9 - businessinsider.com
Link: https://news.google.com/rss/articles/CBMihAFBVV95cUxPMHJGREdockM1d3J0R1hoMnByMDM5MmJGWm1MWV9MXzVJc1Y5QjBqRU1Vb3BrNHlHbk0xUjUxM3I2U3lRS1JfcktrbjZ3bXJZVU9LNkc2UkZlTkhNbGlNZWZNSTNtQm45bVd5SzhJWVJkaFFwbFFrWFRzSXRFUHZyQ2ZWN2s?oc=5
------------------------------
```

As you can see here, we have more news titles than we get from `yfinance`. But again, Google News RSS also has its advantages and limitations:

**Advantages of Google News RSS:**
 - Free Access: You can access and parse Google News RSS feeds without any API keys or subscription fees.
 - Wide Range of Topics: Google News covers a vast array of news categories and topics.
 - Fresh Content: RSS feeds are updated frequently, so you get access to the latest news articles.

**Limitations:**
 - No Fine-grained Control: You can't filter articles by specific criteria like date range or news source within the RSS feed itself.
 - Potential Rate Limiting: Google might impose rate limits on how frequently you can access their RSS feeds.
 - No Historical Data: RSS feeds typically provide only recent articles, not a historical archive.

**Use Cases:**
 - Staying Updated on Specific Topics: Subscribe to RSS feeds for topics relevant to your interests or investments.
 - Building Simple News Aggregators: Create a basic news aggregator that displays articles from various Google News RSS feeds.
 - Sentiment Analysis and Text Mining: Extract text from news articles for sentiment analysis or other text-based research.

Overall, Google News RSS is a valuable resource for accessing free news data, especially for smaller projects, personal use, or when you need a quick overview of recent news on specific topics.
