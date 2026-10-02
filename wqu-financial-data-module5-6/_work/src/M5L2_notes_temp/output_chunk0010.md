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

Kết quả của đoạn code chứa các điểm số cảm xúc. Cách diễn giải cảm xúc như sau:

 - Xác suất càng cao thì cảm xúc càng mạnh. Ví dụ, nếu `positive: 0.85`, điều đó cho thấy bài báo thể hiện cảm xúc tích cực mạnh.
 - Hãy tìm cảm xúc chiếm ưu thế. Nhóm có xác suất cao nhất thường đại diện cho cảm xúc tổng thể của bài báo.
 - Hãy xem xét ngữ cảnh. Ngay cả khi điểm số cảm xúc cao, vẫn cần đọc nội dung bài báo để hiểu các sắc thái và những khía cạnh cụ thể tạo nên cảm xúc đó.

Bằng cách phân tích điểm số cảm xúc cùng với nội dung bài báo, chúng ta có thể rút ra những hiểu biết về cảm xúc chung đối với Microsoft như được phản ánh trong tin tức. Thông tin này có thể hữu ích để hiểu nhận thức của thị trường, xác định các xu hướng tiềm năng và đưa ra các quyết định có cơ sở.
