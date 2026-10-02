Hàm (8) cho phép tính toán hiệu quả, vì với mỗi điểm cần tính hệ số, chỉ một tập con (thường khá nhỏ) các điểm mẫu cần đưa vào mô hình hồi quy. Tuy nhiên, hàm trọng số không gian (8) gặp vấn đề gián đoạn. Khi $i$ thay đổi trong vùng nghiên cứu, các hệ số hồi quy có thể biến đổi đột ngột mỗi khi một điểm mẫu đi vào hoặc ra khỏi vùng đệm tròn quanh $i$, tức vùng xác định dữ liệu được đưa vào hiệu chỉnh cho vị trí $i$. Dù các thay đổi đột ngột của tham số theo không gian có thể thực sự tồn tại, ở đây sự thay đổi của các ước lượng chỉ là hệ quả (artifact) của cách bố trí các điểm mẫu, chứ không phản ánh quá trình nền tảng của hiện tượng đang nghiên cứu. Một cách khắc phục là xác định $w_{ij}$ như một hàm liên tục của $d_{ij}$, khoảng cách giữa $i$ và $j$. Khi đó, từ (5) có thể thấy các ước lượng hệ số sẽ biến thiên liên tục theo $i$. Một lựa chọn hiển nhiên là

$$w_{ij} = \exp(-\beta d_{ij}^2) \qquad (9)$$

sao cho nếu $i$ là điểm có dữ liệu quan sát thì trọng số của dữ liệu đó bằng 1, còn trọng số của các dữ liệu khác giảm theo đường cong Gauss khi khoảng cách giữa $i$ và $j$ tăng. Trong trường hợp này, việc đưa dữ liệu vào quá trình hiệu chỉnh trở nên "phân đoạn". Chẳng hạn, khi hiệu chỉnh mô hình cho điểm $i$, nếu $w_{ij} = 0.5$ thì dữ liệu tại $j$ chỉ đóng góp một nửa trọng số so với dữ liệu tại chính $i$. Với dữ liệu ở rất xa $i$, trọng số gần như bằng không, tức là loại bỏ thực chất các quan sát này khỏi việc ước lượng tham số tại vị trí $i$.

Có thể dung hòa giữa (8) và (9), vừa có tính chất thuận lợi về tính toán là loại mọi điểm cách $i$ quá một khoảng nhất định, vừa có tính chất thuận lợi về phân tích là tính liên tục. Một ví dụ là hàm bisquare:

$$w_{ij} = \left[1 - d_{ij}^2/d^2\right]^2 \ \text{ nếu } d_{ij} < d; \qquad w_{ij} = 0 \ \text{ nếu ngược lại.} \qquad (10)$$

Hàm này loại các điểm ngoài bán kính $d$ nhưng làm thoải dần trọng số của các điểm bên trong bán kính, sao cho $w_{ij}$ là hàm liên tục và khả vi một lần với mọi điểm cách $i$ ít hơn $d$ đơn vị.

Dù dùng hàm trọng số cụ thể nào, ý tưởng cốt lõi của GWR là với mỗi điểm $i$ có một "đỉnh ảnh hưởng" quanh $i$ tương ứng với hàm trọng số, sao cho các quan sát mẫu gần $i$ có ảnh hưởng lớn hơn các quan sát ở xa trong việc ước lượng tham số của $i$. Phương pháp cửa sổ trượt dùng để tạo Hình 1 và được mô tả đầy đủ hơn ở nơi khác (Fotheringham, Charlton, and Brunsdon 1996) sử dụng hàm trọng số bằng 1 nếu các điểm $i$ và $j$ nằm trong hình vuông có các đỉnh $(-d/2,-d/2)$, $(-d/2,d/2)$, $(d/2,d/2)$ và $(d/2,-d/2)$, và bằng 0 trong các trường hợp còn lại. Về bản chất đây là hàm nhân (kernel) "cắt đột ngột" như (8), nhưng có dạng vuông thay vì tròn. Nhìn lại, đây là lựa chọn kernel khá kỳ quặc, mặc dù về tính toán thì nó phù hợp với khung raster.

### 3.2 Hiệu chỉnh hàm trọng số

Một khó khăn của GWR là các tham số ước lượng phần nào phụ thuộc vào hàm trọng số hay hàm nhân (kernel) được chọn. Chẳng hạn trong (8), khi $d$ càng lớn thì nghiệm của mô hình càng gần với OLS, và khi $d$ bằng khoảng cách lớn nhất giữa các điểm trong hệ thống thì hai mô hình trùng nhau. Tương tự, trong (9), khi $\beta$ tiến về 0, trọng số tiến về 1 với mọi cặp điểm, nên các tham số ước lượng trở nên đồng nhất và GWR tương đương OLS. Ngược lại, khi độ suy giảm theo khoảng cách (distance-decay) càng lớn, các ước lượng tham số càng phụ thuộc vào các quan sát ở gần $i$ và do đó có phương sai tăng. Vấn đề là làm thế nào chọn hàm suy giảm phù hợp trong GWR.

Xét việc chọn $\beta$ trong (9). Một khả năng là chọn $\beta$ theo tiêu chí bình phương tối thiểu. Nếu các sai số trong (3) được giả định là Gauss thì điều này cũng thỏa tiêu chí hợp lý cực đại. Rõ ràng cách làm là cực tiểu hóa đại lượng

$$\sum_{i=1}^{n} \left[y_i - \hat{y}_i(\beta)\right]^2 \qquad (11)$$

trong đó $\hat{y}_i(\beta)$ là giá trị khớp của $y_i$ khi dùng độ suy giảm theo khoảng cách $\beta$. Để tìm giá trị khớp của $y_i$, cần ước lượng các $a_{ik}$ tại mỗi điểm mẫu rồi kết hợp chúng với các giá trị $z$ tại các điểm đó. Tuy nhiên, khi cực tiểu hóa tổng bình phương sai số như trên thì gặp một vấn đề. Giả sử $\beta$ rất lớn sao cho trọng số của mọi điểm trừ chính $i$ là không đáng kể. Khi đó các giá trị khớp tại các điểm mẫu sẽ tiến về giá trị thực, nên (11) bằng không. Điều này gợi ý rằng với tiêu chí tối ưu như vậy, $\beta$ tiến tới vô cùng, nhưng rõ ràng trường hợp suy biến này vô ích. Thứ nhất, các tham số của mô hình như vậy không xác định trong trường hợp giới hạn này; thứ hai, các ước lượng sẽ dao động dữ dội trong không gian để cho giá trị khớp tốt cục bộ tại mỗi $i$.

Giải pháp cho vấn đề này là phương pháp kiểm định chéo (cross-validation, CV) do Cleveland (1979) đề xuất cho hồi quy cục bộ và Bowman (1984) cho ước lượng mật độ kernel. Ở đây, ta dùng điểm số có dạng

$$CV = \sum_{i=1}^{n} \left[y_i - \hat{y}_{\neq i}(\beta)\right]^2 \qquad (12)$$

trong đó $\hat{y}_{\neq i}(\beta)$ là giá trị khớp của $y_i$ khi các quan sát tại điểm $i$ bị bỏ ra khỏi quá trình hiệu chỉnh. Cách tiếp cận này có tính chất thuận lợi là chống được hiệu ứng quấn vòng (wrap-around), vì khi $\beta$ rất lớn, mô hình chỉ được hiệu chỉnh trên các mẫu gần $i$ chứ không phải tại chính $i$.
