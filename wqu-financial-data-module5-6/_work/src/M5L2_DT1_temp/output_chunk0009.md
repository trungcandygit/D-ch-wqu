REFERENCES
[1] Basant Agarwal and Namita Mittal. 2016. Machine Learning Approach for
Sentiment Analysis. Springer International Publishing, Cham, 21–45. https:
//doi.org/10.1007/978-3-319-25343-5_3
[2] Oscar Araque, Ignacio Corcuera-Platas, J. Fernando Sánchez-Rada, and Carlos A.
Iglesias. 2017. Enhancing deep learning sentiment analysis with ensemble techniques in social applications. Expert Systems with Applications 77 (jul 2017),
236–246. https://doi.org/10.1016/j.eswa.2017.02.002
[3] Jacob Devlin, Ming-Wei Chang, Kenton Lee, and Kristina Toutanova. 2018. BERT:
Pre-training of Deep Bidirectional Transformers for Language Understanding.
(2018). https://doi.org/arXiv:1811.03600v2 arXiv:1810.04805
[4] Li Guo, Feng Shi, and Jun Tu. 2016. Textual analysis and machine leaning: Crack
unstructured data in finance and accounting. The Journal of Finance and Data
Science 2, 3 (sep 2016), 153–170. https://doi.org/10.1016/J.JFDS.2017.02.001
[5] Jeremy Howard and Sebastian Ruder. 2018. Universal Language Model Finetuning for Text Classification. (jan 2018). arXiv:1801.06146 http://arxiv.org/abs/
1801.06146
[6] Neel Kant, Raul Puri, Nikolai Yakovenko, and Bryan Catanzaro. 2018. Practical Text Classification With Large Pre-Trained Language Models. (2018).
arXiv:1812.01207 http://arxiv.org/abs/1812.01207
[7] Mathias Kraus and Stefan Feuerriegel. 2017. Decision support from financial
disclosures with deep neural networks and transfer learning. Decision Support Systems 104 (2017), 38–48. https://doi.org/10.1016/j.dss.2017.10.001 arXiv:1710.03954
[8] Srikumar Krishnamoorthy. 2018. Sentiment analysis of financial news articles
using performance indicators. Knowledge and Information Systems 56, 2 (aug
2018), 373–394. https://doi.org/10.1007/s10115-017-1134-1
[9] Xiaodong Li, Haoran Xie, Li Chen, Jianping Wang, and Xiaotie Deng. 2014. News
impact on stock price return via sentiment analysis. Knowledge-Based Systems
69 (oct 2014), 14–23. https://doi.org/10.1016/j.knosys.2014.04.022
[10] Bing Liu. 2012. Sentiment Analysis and Opinion Mining. Synthesis Lectures on
Human Language Technologies 5, 1 (may 2012), 1–167. https://doi.org/10.2200/
s00416ed1v01y201204hlt016
[11] Tim Loughran and Bill Mcdonald. 2011. When Is a Liability Not a Liability?
Textual Analysis, Dictionaries, and 10-Ks. Journal of Finance 66, 1 (feb 2011),
35–65. https://doi.org/10.1111/j.1540-6261.2010.01625.x
[12] Tim Loughran and Bill Mcdonald. 2016. Textual Analysis in Accounting and
Finance: A Survey. Journal of Accounting Research 54, 4 (2016), 1187–1230.
https://doi.org/10.1111/1475-679X.12123
[13] Bernhard Lutz, Nicolas Pröllochs, and Dirk Neumann. 2018. Sentence-Level
Sentiment Analysis of Financial News Using Distributed Text Representations and
Multi-Instance Learning. Technical Report. arXiv:1901.00400 http://arxiv.org/
abs/1901.00400
[14] Macedo Maia, Andrï£¡ Freitas, and Siegfried Handschuh. 2018. FinSSLx: A Sentiment Analysis Model for the Financial Domain Using Text Simplification. In 2018
IEEE 12th International Conference on Semantic Computing (ICSC). IEEE, 318–319.
https://doi.org/10.1109/ICSC.2018.00065
[15] Macedo Maia, Siegfried Handschuh, André Freitas, Brian Davis, Ross Mcdermott,
Manel Zarrouk, Alexandra Balahur, and Ross Mc-Dermott. 2018. Companion of
the The Web Conference 2018 on The Web Conference 2018, {WWW} 2018, Lyon
, France, April 23-27, 2018. ACM. https://doi.org/10.1145/3184558
[16] Burton G Malkiel. 2003. The Efficient Market Hypothesis and Its Critics. Journal of Economic Perspectives 17, 1 (feb 2003), 59–82. https://doi.org/10.1257/

KẾT LUẬN VÀ HƯỚNG PHÁT TRIỂN

Trong bài báo này, nhóm tác giả triển khai BERT cho lĩnh vực tài chính bằng cách tiếp tục tiền huấn luyện (pre-training) trên một kho ngữ liệu tài chính, rồi tinh chỉnh (fine-tune) cho phân tích cảm xúc (FinBERT). Theo hiểu biết của các tác giả, đây là ứng dụng đầu tiên của BERT trong tài chính và là một trong số ít công trình thử nghiệm việc tiền huấn luyện bổ sung trên kho ngữ liệu chuyên ngành. Trên cả hai bộ dữ liệu được sử dụng, kết quả đạt mức tốt nhất hiện nay (state-of-the-art) với biên độ đáng kể; ở tác vụ phân loại, độ chính xác tăng 15% so với mức tốt nhất trước đó.

Ngoài BERT, các tác giả còn triển khai các mô hình ngôn ngữ tiền huấn luyện khác như ELMo và ULMFit để so sánh. ULMFit, sau khi được tiền huấn luyện bổ sung trên kho ngữ liệu tài chính, cũng vượt mức tốt nhất trước đó ở tác vụ phân loại, nhưng với mức cải thiện nhỏ hơn BERT. Các kết quả này cho thấy hiệu quả của mô hình ngôn ngữ tiền huấn luyện đối với tác vụ hạ nguồn như phân tích cảm xúc, nhất là khi tập dữ liệu có nhãn nhỏ. Toàn bộ bộ dữ liệu gồm hơn 3000 mẫu, nhưng FinBERT vẫn vượt mức tốt nhất trước đó dù tập huấn luyện chỉ có 500 mẫu. Đây là kết quả quan trọng, vì các kỹ thuật học sâu cho NLP vốn bị coi là quá "khát dữ liệu" (data-hungry), điều dường như không còn đúng nữa.

Nhóm tác giả đã tiến hành nhiều thí nghiệm với BERT để khảo sát ảnh hưởng của việc tiền huấn luyện bổ sung và các chiến lược huấn luyện khác nhau. Chưa thể kết luận rằng tiền huấn luyện bổ sung trên kho ngữ liệu chuyên ngành tốt hơn đáng kể so với không làm như vậy trong trường hợp này. Giả thuyết của các tác giả là BERT vốn đã hoạt động đủ tốt trên bộ dữ liệu này nên tiền huấn luyện bổ sung không còn nhiều dư địa cải thiện. Các tác giả cũng nhận thấy các chế độ tốc độ học (learning rate) tinh chỉnh các tầng cao mạnh hơn các tầng thấp cho kết quả tốt hơn và hiệu quả hơn trong việc ngăn hiện tượng quên thảm khốc (catastrophic forgetting). Một kết luận khác là có thể đạt hiệu năng tương đương với thời gian huấn luyện ít hơn nhiều bằng cách chỉ tinh chỉnh 2 tầng cuối của BERT.

Phân tích cảm xúc tài chính tự nó không phải là mục tiêu; giá trị của nó nằm ở mức độ hỗ trợ được các quyết định tài chính. Một hướng mở rộng công trình này là sử dụng trực tiếp FinBERT với thị trường chứng khoán
