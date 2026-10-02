## **9. Ứng dụng NMF để đa dạng hóa danh mục đầu tư**

Trong phần này, chúng ta sẽ khám phá một ví dụ đơn giản về đa dạng hóa danh mục đầu tư (portfolio diversification) bằng kỹ thuật NMF. Chúng ta tiếp cận bài toán này bằng cách tận dụng khả năng của NMF trong việc trích xuất các đặc trưng có ý nghĩa từ dữ liệu tài chính, đồng thời đưa ra một cách thức có hệ thống để đa dạng hóa danh mục đầu tư dựa trên các nhân tố tiềm ẩn. Việc này có thể thực hiện theo các bước sau:

-   **Ma trận tương quan:** Chúng ta bắt đầu với ma trận tương quan của lợi suất tài sản, ma trận này nắm bắt mối quan hệ giữa các tài sản khác nhau.
-   **Phân rã NMF:** NMF phân rã ma trận tương quan thành các hệ số tải nhân tố (\$W\$) và điểm số nhân tố (\$H\$). Các hệ số tải nhân tố biểu diễn mức đóng góp của từng tài sản vào từng nhân tố, còn điểm số nhân tố biểu diễn mức độ quan trọng của từng nhân tố theo thời gian.
-   **Diễn giải nhân tố:** Bằng cách phân tích các hệ số tải nhân tố, chúng ta có thể xác định các nhóm tài sản có hành vi tương tự nhau và hiểu được các nhân tố tiềm ẩn chi phối sự đồng biến động của các tài sản.
-   **Đa dạng hóa:** Chúng ta có thể đa dạng hóa danh mục đầu tư bằng cách chọn các tài sản có hệ số tải cao trên các nhân tố khác nhau. Điều này làm giảm rủi ro chung của danh mục đầu tư nhờ phân tán khoản đầu tư vào các nguồn rủi ro khác nhau.
-   **Xây dựng danh mục đầu tư:** Dựa trên phân tích nhân tố, chúng ta có thể xác định tỷ trọng của từng tài sản trong danh mục đầu tư, bảo đảm các tỷ trọng không âm và có tổng bằng 1.

Trong đoạn mã sau, chúng ta xây dựng một danh mục dữ liệu đơn giản gồm năm cổ phiếu: AAPL, MSFT, GOOG, AMZN và TSLA. Sau đó, chúng ta tạo một DataFrame `returns_df` chứa lợi suất hằng ngày của các tài sản đã chọn.

In \[2\]:

``` calibre12
# Tải dữ liệu lịch sử cho các mã cổ phiếu
tickers = ['AAPL', 'MSFT', 'GOOG', 'AMZN', 'TSLA', 'NVDA', 'META', 'JPM']
data = yf.download(tickers, start='2022-01-01', end='2023-01-01')['Close']

# 1. Nạp dữ liệu lợi suất tài sản
returns_df = data.pct_change().dropna()
returns_df
```

Out\[2\]:

  Ticker       AAPL        AMZN        GOOG        JPM         META        MSFT        NVDA        TSLA
  ------------ ----------- ----------- ----------- ----------- ----------- ----------- ----------- -----------
  Date                                                                                             
  2022-01-04   -0.012691   -0.016916   -0.004535   0.037910    -0.005937   -0.017147   -0.027589   -0.041833
  2022-01-05   -0.026600   -0.018893   -0.046830   -0.018282   -0.036728   -0.038388   -0.057562   -0.053471
  2022-01-06   -0.016693   -0.006711   -0.000744   0.010624    0.025573    -0.007902   0.020794    -0.021523
  2022-01-07   0.000988    -0.004288   -0.003973   0.009908    -0.002015   0.000510    -0.033040   -0.035447
  2022-01-10   0.000116    -0.006570   0.011456    0.000957    -0.011212   0.000732    0.005615    0.030342
  \...         \...        \...        \...        \...        \...        \...        \...        \...
  2022-12-23   -0.002799   0.017425    0.017562    0.004745    0.007855    0.002267    -0.008671   -0.017551
  2022-12-27   -0.013878   -0.025924   -0.020933   0.003504    -0.009827   -0.007414   -0.071354   -0.114089
  2022-12-28   -0.030685   -0.014692   -0.016718   0.005465    -0.010780   -0.010255   -0.006019   0.033089
  2022-12-29   0.028324    0.028844    0.028800    0.005738    0.040132    0.027630    0.040396    0.080827
  2022-12-30   0.002469    -0.002138   -0.002473   0.006606    0.000665    -0.004938   0.000753    0.011164

250 rows × 8 columns

Bây giờ, khi đã có DataFrame `returns_df` chứa lợi suất hằng ngày của các tài sản đã chọn, chúng ta có thể sử dụng nó trong đoạn mã đa dạng hóa danh mục đầu tư bằng NMF:

In \[3\]:

``` calibre12
# 2. Tính ma trận tương quan
correlation_matrix = returns_df.corr()
correlation_matrix
```

Out\[3\]:

  Ticker   AAPL       AMZN       GOOG       JPM        META       MSFT       NVDA       TSLA
  -------- ---------- ---------- ---------- ---------- ---------- ---------- ---------- ----------
  Ticker                                                                                
  AAPL     1.000000   0.695905   0.790573   0.547907   0.592901   0.824902   0.763022   0.637218
  AMZN     0.695905   1.000000   0.724022   0.501689   0.605782   0.741197   0.709077   0.591533
  GOOG     0.790573   0.724022   1.000000   0.511192   0.681990   0.845283   0.767571   0.556652
  JPM      0.547907   0.501689   0.511192   1.000000   0.393247   0.532507   0.528095   0.364935
  META     0.592901   0.605782   0.681990   0.393247   1.000000   0.625860   0.607685   0.398646
  MSFT     0.824902   0.741197   0.845283   0.532507   0.625860   1.000000   0.787883   0.563946
  NVDA     0.763022   0.709077   0.767571   0.528095   0.607685   0.787883   1.000000   0.680243
  TSLA     0.637218   0.591533   0.556652   0.364935   0.398646   0.563946   0.680243   1.000000

Phân rã ma trận không âm (NMF) về bản chất được thiết kế để làm việc với các ma trận không âm. Điều này có nghĩa là ma trận đầu vào (\$V\$) và các ma trận nhân tố thu được (\$W\$ và \$H\$) được kỳ vọng chỉ chứa các phần tử không âm. Tuy nhiên, trong bối cảnh cụ thể của việc đa dạng hóa danh mục đầu tư bằng NMF, ma trận đầu vào thường là ma trận tương quan của lợi suất tài sản, và ma trận này có thể chứa các giá trị âm biểu diễn mối quan hệ nghịch đảo giữa các tài sản.

Trong ví dụ của chúng ta, ma trận tương quan chỉ có các giá trị dương. Tuy nhiên, nếu cần, trong một số trường hợp chúng ta có thể xem xét các điều chỉnh sau:
