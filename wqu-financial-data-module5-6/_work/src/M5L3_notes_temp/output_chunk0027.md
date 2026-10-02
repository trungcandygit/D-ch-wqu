### **4.2.1 Lấy dữ liệu trong ngày của Netflix**

Bây giờ hãy lấy dữ liệu giá cổ phiếu trong ngày (intraday) của Netflix (NFLX) cho ngày 23 tháng 9 năm 2024 bằng thư viện `yfinance`. Đoạn mã sau tải dữ liệu cổ phiếu trong ngày của Netflix với khoảng thời gian 15 phút cho ngày 23 tháng 9 năm 2024 (bao gồm cả phiên trước và sau giờ giao dịch chính thức), lưu vào tệp CSV, rồi hiển thị dữ liệu:

``` calibre12
# Tải dữ liệu trong ngày bằng yfinance
nflx_intraday = yf.download(
    tickers='NFLX',
    start='2024-09-23',
    end='2024-09-24',
    interval='15m',
    prepost=True, auto_adjust = False)

# Lưu dữ liệu vào tệp CSV
nflx_intraday.to_csv("netflix_intraday_20240923.csv")

# Hiển thị DataFrame
nflx_intraday
```

**Lưu ý quan trọng về tính khả dụng của dữ liệu:** Dữ liệu trong ngày thường chỉ có sẵn từ Yahoo Finance trong vòng 60 ngày gần nhất. Tại thời điểm viết bài, dữ liệu khả dụng cũng đã được tải xuống và lưu thành tệp 'WQUnetflix_intraday_20240923.csv' để truy xuất sau này. Trong trường hợp bạn chạy notebook này khi dữ liệu trong ngày không còn khả dụng, hãy nạp dữ liệu từ tệp 'WQUnetflix_intraday_20240923.csv' đã lưu cục bộ cho phần còn lại của bài học này.

``` calibre12
# Mở DataFrame đã lưu - TÙY CHỌN
nflx_intraday = pd.read_csv('WQU netflix_intraday_20240923.csv')
nflx_intraday.set_index('Datetime', inplace=True)
nflx_intraday
```
