### **4.2.2 Dữ liệu trong ngày của Netflix kết hợp với Tone trung bình trong tin tức**

Trong đoạn mã trước, chúng ta đã lấy dữ liệu giá cổ phiếu trong ngày (intraday) của Netflix. Lưu ý tham số `prepost=True`, cho biết có bao gồm dữ liệu trước giờ mở cửa và sau giờ đóng cửa thị trường hay không. Trong trường hợp này, chúng ta bao gồm cả dữ liệu trước và sau phiên giao dịch. Như bạn có thể thấy, cột Volume hiển thị giá trị bằng không trước 9:30 sáng (thị trường mở cửa) và sau 4:00 chiều (thị trường đóng cửa). Yahoo sử dụng múi giờ gốc của sàn giao dịch. Với Netflix, đó là NASDAQ đặt tại thành phố New York. Vào ngày 23 tháng 9 tại New York, thời gian áp dụng là Giờ mùa hè miền Đông (EDT), chậm hơn múi giờ UTC 4 giờ. Hãy chuyển đổi các giá trị của cột Datetime trong DataFrame `nflx_intraday` sang múi giờ UTC:

In \[ \]:

``` calibre12
# Chuyển đổi Datetime sang múi giờ UTC
nflx_intraday.index = pd.to_datetime(nflx_intraday.index).tz_localize('America/New_York').tz_convert('UTC')
nflx_intraday
```

Bây giờ hãy vẽ biểu đồ nến. Biểu đồ nến được xem là công cụ hữu ích trong phân tích kỹ thuật tài chính vì nhiều lý do. Khả năng minh họa rõ ràng diễn biến giá, khả năng báo hiệu đảo chiều và mức độ được chấp nhận rộng rãi khiến chúng trở thành công cụ có giá trị cho phân tích kỹ thuật tài chính và các quyết định giao dịch có cơ sở. Đoạn mã sau tạo cả biểu đồ nến cho `nflx_intraday` lẫn dữ liệu `tone_df` trên cùng một biểu đồ tương tác. Mã sử dụng thư viện đồ họa Plotly, cho phép chúng ta khám phá trực quan hóa một cách tương tác. Chúng ta có thể phóng to một phần của biểu đồ hoặc di chuột qua từng cây nến/thanh để xem chính xác giá trị giá cổ phiếu/khối lượng tại một thời điểm cụ thể:

In \[ \]:

``` calibre12
# Tạo trace biểu đồ nến
candlestick_trace = go.Candlestick(x=nflx_intraday.index,
                                 open=nflx_intraday['Open'],
                                 high=nflx_intraday['High'],
                                 low=nflx_intraday['Low'],
                                 close=nflx_intraday['Close'],
                                 name='Netflix Price')

# Tạo trace tone
tone_trace = go.Scatter(x=tone_df['Timestamp'],
                        y=tone_df['AvgTone'],
                        mode='lines',
                        name='Average Tone',
                        line=dict(color='blue', width=1),
                        yaxis='y2')  # Gán cho trục y thứ cấp

# Tạo figure với cả hai trace
fig = go.Figure(data=[candlestick_trace, tone_trace])

# Cập nhật bố cục với trục y thứ cấp
fig.update_layout(title_text='Netflix Price and Average Tone',
                  yaxis_title='Price (USD)',
                  yaxis2=dict(title='Average Tone',
                              overlaying='y',
                              side='right'))
fig.show()
```

Đoạn mã này tạo ra một biểu đồ gồm cả biểu đồ nến trong ngày của Netflix và dữ liệu tone trung bình được vẽ cùng nhau, cho phép chúng ta phân tích trực quan mối quan hệ giữa biến động giá và sự thay đổi của cảm xúc.

Mỗi cây nến biểu diễn biến động giá cổ phiếu Netflix trong một khoảng thời gian cụ thể. Nến xanh cho biết giá tăng trong khoảng thời gian đó. Đáy của thân nến xanh là giá mở cửa, đỉnh là giá đóng cửa, và các đường (bấc nến) kéo dài từ thân nến biểu diễn giá cao nhất và thấp nhất trong khoảng thời gian đó. Nến đỏ cho biết giá giảm trong khoảng thời gian đó. Đỉnh của thân nến đỏ là giá mở cửa, đáy là giá đóng cửa, và các bấc nến biểu diễn giá cao nhất và thấp nhất.

Bố cục được cập nhật để thêm một trục y thứ cấp ở bên phải (`yaxis2`) và đặt tiêu đề cho cả hai trục y. Trục y chính bên trái biểu diễn giá (USD) của cổ phiếu Netflix, còn trục y thứ cấp biểu diễn các giá trị tone trung bình. Việc dùng các trục y riêng biệt cho phép biểu diễn rõ ràng và có ý nghĩa cả hai tập dữ liệu mà không làm sai lệch giá trị của từng tập. Giờ đây chúng ta có thể so sánh trực quan biến động giá cổ phiếu Netflix với sự thay đổi của cảm xúc trung bình theo thời gian. Điều này có thể giúp xác định các mối quan hệ hoặc tương quan tiềm năng giữa giá và cảm xúc.

Bằng cách quan sát các mô hình và xu hướng trong giá nến và đường tone, chúng ta có thể khám phá các tương quan và hiểu biết tiềm năng:

-   Tone tích cực và giá: Khi đường Tone ở mức cao (cảm xúc tích cực) và các cây nến có màu xanh (giá tăng), điều đó có thể cho thấy mức độ đưa tin tích cực đang tác động thuận lợi đến giá cổ phiếu Netflix. Chúng ta có thể quan sát thấy lượng tin tức có tone chủ yếu tích cực xuất hiện dồi dào vài giờ trước khi thị trường mở cửa, từ khoảng 10 giờ sáng. Điều này có thể giải thích cho các cây nến xanh tại thời điểm mở cửa lúc 13:30.
-   Tone tiêu cực và giá: Ngược lại, đường Tone thấp (cảm xúc tiêu cực) trùng với các cây nến đỏ (giá giảm) có thể cho thấy tin tức tiêu cực đang tác động bất lợi đến cổ phiếu.
-   Phân kỳ: Chúng ta cũng có thể quan sát thấy có những trường hợp đường Tone và mô hình nến phân kỳ. Điều này có thể đáng để điều tra thêm. Ví dụ, cảm xúc tin tức tích cực (Tone cao) nhưng giá cổ phiếu giảm (nến đỏ) có thể đặt ra câu hỏi về các yếu tố thị trường khác đang tác động.
