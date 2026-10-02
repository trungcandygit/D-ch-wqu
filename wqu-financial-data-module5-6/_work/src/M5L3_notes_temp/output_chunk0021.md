## **3.3 Lấy các thành phần Tone trong dữ liệu GDELT**

Chúng ta có thể dùng cột `V2Tone` để lọc các bài báo theo cảm xúc, nhận diện xu hướng sắc thái tin tức theo thời gian, hoặc phân tích bối cảnh cảm xúc xung quanh các sự kiện hay thực thể cụ thể. Cột này chứa một tập giá trị biểu diễn cảm xúc và sắc thái cảm xúc của bài báo hoặc nguồn truyền thông trực tuyến tương ứng. Các giá trị trong cột `V2Tone` thường được phân tách bằng dấu phẩy và bao gồm:

-   Tone: Biểu diễn sắc thái tổng thể, giá trị càng cao thì càng tích cực. Được biểu diễn dưới dạng số thực dấu phẩy động. Giá trị này được tính bằng Positive Score trừ Negative Score.
-   Positive Score: Cung cấp thông tin chi tiết hơn về cảm xúc. Có thể dùng để nhận diện các bài báo có cảm xúc tích cực mạnh. Đây là thước đo cảm xúc tích cực được thể hiện, là một số thực dấu phẩy động nằm trong khoảng từ 0 đến 100. Điểm 0 cho biết không có cảm xúc tích cực. Giá trị càng cao thì cảm xúc tích cực càng mạnh, trong đó 100 là mức cảm xúc tích cực mạnh nhất có thể có trong bài báo.
-   Negative Score: Cung cấp thông tin chi tiết hơn về cảm xúc. Có thể dùng để nhận diện các bài báo có cảm xúc tiêu cực mạnh. Đây là thước đo cảm xúc tiêu cực được thể hiện, là một số thực dấu phẩy động nằm trong khoảng từ 0 đến 100. Điểm 0 cho biết bài báo không có cảm xúc tiêu cực. Giá trị càng cao thì cảm xúc tiêu cực càng mạnh, trong đó 100 là mức cảm xúc tiêu cực mạnh nhất trong bài báo.
-   Polarity: Chỉ báo cho biết văn bản phân cực hay mang tính cảm xúc mạnh đến mức nào. Được suy ra từ một thuật toán phức tạp có xét đến nhiều đặc trưng ngôn ngữ và yếu tố ngữ cảnh.
-   Activity Reference Density: Thước đo mật độ các từ liên quan đến hoạt động hoặc hành động trong văn bản.
-   Self Direction: Thước đo mức độ văn bản tập trung vào tác giả hay vào chủ thể được nói đến.
-   WordCount: Số từ được phân tích sắc thái trong bài báo (giá trị số nguyên).

Đoạn mã sau chuyển dữ liệu GDELT sang định dạng dễ sử dụng hơn cho phân tích cảm xúc. Chúng ta lấy cột `V2Tone`, sau đó tách và chuyển đổi các thành phần cảm xúc liên quan từ cột này. Nhờ vậy bạn có thể dễ dàng làm việc với dữ liệu Tone và phân tích chúng ở các bước tiếp theo.

In \[ \]:

``` calibre12
# Split V2Tone into separate columns
netflix_news[['Tone', 'Positive Score', 'Negative Score', 'Polarity', 'Activity', 'Self Direction', 'WordCount']] = netflix_news['V2Tone'].str.split(',', expand=True)

# Convert numeric columns to appropriate data types
numeric_columns = ['Tone', 'Positive Score', 'Negative Score', 'Polarity', 'Activity', 'Self Direction']
netflix_news[numeric_columns] = netflix_news[numeric_columns].astype(float).round(3)
netflix_news[['Tone', 'Positive Score', 'Negative Score', 'Polarity', 'Activity', 'Self Direction', 'WordCount']]
```

Từ kết quả của đoạn mã này, chúng ta có thể rút ra các nhận xét sau:

-   Tone tiêu cực chiếm ưu thế: Nhiều bài báo có giá trị "Tone" âm hơn, cho thấy văn bản nhìn chung có khuynh hướng tiêu cực hoặc phê phán.
-   Cảm xúc tinh tế: Các giá trị "Positive Score" và "Negative Score" vẫn tương đối thấp, cho thấy cảm xúc được thể hiện có thể mang tính sắc thái hoặc gián tiếp hơn là tích cực hay tiêu cực một cách mạnh mẽ.
-   Mối quan hệ giữa Polarity và Tone: Có vẻ như trong tập dữ liệu cụ thể này, ngay cả những bài báo có Tone âm vẫn có thể mang hướng cảm xúc tổng thể tích cực, được phản ánh qua Polarity. Điều này nhấn mạnh tầm quan trọng của việc xem xét đồng thời cả Tone và Polarity để có bức tranh đầy đủ về cảm xúc được thể hiện trong văn bản. Trong khi Tone có thể cho thấy sắc thái nhìn chung tiêu cực hoặc phê phán, Polarity dương gợi ý rằng có thể tồn tại những yếu tố tích cực tiềm ẩn hoặc một cảm xúc tinh tế hơn được truyền tải trong các bài báo đó.
-   Activity cao hơn ở các bài báo ngắn hơn: Có vẻ tồn tại xu hướng "Activity Reference Density" cao hơn ở các bài báo có "WordCount" nhỏ. Điều này có thể cho thấy các bài báo ngắn thường dùng ngôn ngữ thiên về hành động hơn hoặc mô tả nhiều sự kiện hơn.
-   Self Direction đa dạng: Các giá trị "Self Direction" biến thiên, cho thấy một số bài báo tập trung nhiều hơn vào góc nhìn của tác giả, trong khi những bài khác khách quan hơn hoặc tập trung vào các sự kiện bên ngoài.

**Thông tin này có thể giúp ích như thế nào:** Bằng cách phân tích cẩn thận kết quả này kết hợp với các thông tin khác và chuyên môn lĩnh vực, các kỹ sư tài chính có thể thu được hiểu biết về cảm xúc thị trường đối với Netflix và xây dựng các chiến lược đầu tư và quản trị rủi ro. Một số cách diễn giải khả dĩ của các kết quả trên là:

-   Thay đổi và thích ứng chủ động: Kết quả có thể phản ánh một giai đoạn thay đổi hoặc chuyển đổi đáng kể của Netflix. Tin tức có thể phê phán những quyết định hoặc thách thức cụ thể (Tone âm) nhưng cũng ghi nhận những nỗ lực chủ động của công ty trong việc thích ứng, đổi mới hoặc phản ứng với diễn biến thị trường (Polarity và Activity dương).
-   Bối cảnh cạnh tranh: Cảm xúc trái chiều có thể phản ánh bối cảnh cạnh tranh của ngành phát trực tuyến. Các bài báo có thể thảo luận về Netflix trong mối quan hệ với các đối thủ cạnh tranh, làm nổi bật cả thách thức lẫn cơ hội.
-   Sự thận trọng của nhà đầu tư: Tone âm có thể cho thấy mức độ thận trọng hoặc hoài nghi nhất định của nhà đầu tư, ngay cả khi có những diễn biến tích cực. Điều này có thể gợi ý rằng Netflix cần giải quyết các mối lo ngại hoặc cải thiện tính minh bạch để duy trì niềm tin của nhà đầu tư.

Tập trung vào các khía cạnh Tone và Polarity, sau đây là một số kết luận tiềm năng từ góc độ kỹ thuật tài chính:
