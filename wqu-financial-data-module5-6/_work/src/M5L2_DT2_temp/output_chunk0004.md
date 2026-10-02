độ chính xác 0,872, cao hơn mô hình BERT uncased 4,4% và cao hơn mô hình BERT cased 15,4%. Trên bộ dữ liệu FiQA, mô hình tốt nhất là FinBERT-FinVocab uncased đạt độ chính xác 0,844, cải thiện 15,6% so với BERT uncased và 29,2% so với BERT cased. Cuối cùng, trên bộ dữ liệu AnalystTone, FinBERT-FinVocab uncased tốt nhất cải thiện lần lượt 4,3% và 5,5% so với BERT uncased và cased. Nhìn chung, như kỳ vọng, việc tiền huấn luyện trên kho ngữ liệu tài chính là hiệu quả và nâng cao các tác vụ phân loại cảm xúc tài chính ở khâu hạ nguồn. Trên thị trường tài chính, nơi việc nắm bắt chính xác tín hiệu cảm xúc có tầm quan trọng hàng đầu, nhóm tác giả cho rằng mức cải thiện chung của FinBERT cho thấy tính hữu dụng thực tiễn của mô hình.

**FinVocab so với BaseVocab.** Nhóm tác giả đánh giá tầm quan trọng của bộ từ vựng chuyên ngành tài chính bằng cách tiền huấn luyện các mô hình FinBERT với BaseVocab và FinVocab. Ở cả mô hình uncased lẫn cased, FinBERT-FinVocab đều vượt bản dùng BaseVocab tương ứng. Tuy nhiên, mức cải thiện khá nhỏ trên PhraseBank và AnalystTone; chỉ trên FiQA mới có cải thiện đáng kể (0,844 so với 0,796). Với độ lớn của mức cải thiện này, nhóm cho rằng từ vựng chuyên ngành tuy hữu ích, nhưng FinBERT được lợi nhiều nhất từ việc tiền huấn luyện trên kho ngữ liệu giao tiếp tài chính.

**Cased so với Uncased.** Theo Devlin et al. (2019), nhóm dùng cả mô hình cased và uncased cho mọi tác vụ. Kết quả thực nghiệm cho thấy mô hình uncased tốt hơn mô hình cased ở tất cả các tác vụ, nhất quán với các nghiên cứu trước về mô hình BERT cho lĩnh vực khoa học và y sinh.

**Đóng góp của từng kho ngữ liệu.** Nhóm cũng huấn luyện riêng các mô hình FinBERT trên từng kho ngữ liệu trong ba kho tài chính. Hiệu năng của các mô hình FinBERT (phiên bản cased) trên các tác vụ được trình bày ở Bảng 3. FinBERT huấn luyện trên toàn bộ kho ngữ liệu đạt hiệu năng tổng thể tốt nhất, cho thấy việc kết hợp thêm các kho ngữ liệu giao tiếp tài chính có thể nâng chất lượng mô hình ngôn ngữ. Trong ba bộ dữ liệu, Analyst Reports cho kết quả tốt trên cả ba tác vụ dù chỉ có 1,1 tỷ token từ. Nghiên cứu trước cho thấy báo cáo doanh nghiệp như 10-K và 10-Q chứa nhiều nội dung dư thừa, và một lượng đáng kể khối lượng văn bản trong báo cáo 10-K là do quyền tùy nghi của ban quản lý trong cách đáp ứng các yêu cầu công bố thông tin bắt buộc (Cazier và Pfeiffer, 2016). Điều này có gợi ý rằng dữ liệu Analyst Reports chứa nhiều thông tin hơn báo cáo doanh nghiệp và bản ghi các cuộc họp báo cáo thu nhập (earnings call)? Nhóm để lại cho nghiên cứu tương lai.

Bảng 3: Hiệu năng của tiền huấn luyện trên các kho ngữ liệu tài chính khác nhau.

## 6 Kết luận

Trong công trình này, nhóm tiền huấn luyện FinBERT, một mô hình BERT hướng đến tác vụ tài chính. FinBERT được huấn luyện trên kho ngữ liệu tài chính lớn, đại diện cho giao tiếp tài chính bằng tiếng Anh. Kết quả cho thấy FinBERT vượt các mô hình BERT thông dụng trên ba tác vụ phân loại cảm xúc tài chính. Với việc công bố FinBERT, nhóm hy vọng các nhà thực hành và nhà nghiên cứu có thể dùng FinBERT cho nhiều ứng dụng rộng hơn, nơi mục tiêu dự đoán vượt ra ngoài cảm xúc, chẳng hạn các kết quả liên quan đến tài chính như lợi suất cổ phiếu, biến động giá cổ phiếu, gian lận doanh nghiệp, v.v.

## Lời cảm ơn

Nghiên cứu này được hỗ trợ bởi Theme-based Research Scheme (số T31-604/18-N) của Research Grants Council tại Hồng Kông.

## References

Emily Alsentzer, John Murphy, William Boag, WeiHung Weng, Di Jindi, Tristan Naumann, and Matthew McDermott. 2019. Publicly available clinical bert embeddings. In Proceedings of the 2nd Clinical Natural Language Processing Workshop, pages 72–78.

Iz Beltagy, Kyle Lo, and Arman Cohan. 2019. Scibert: Pretrained language model for scientific text. In Proceedings of EMNLP.

Richard A Cazier and Ray J Pfeiffer. 2016. Why are 10-k filings so long? Accounting Horizons, 30(1):1–21.

X Cui, D Lam, and A Verma. 2016. Embedded value in bloomberg news and social sentiment data. Bloomberg LP.

Jacob Devlin, Ming-Wei Chang, Kenton Lee, and Kristina Toutanova. 2019. Bert: Pre-training of deep bidirectional transformers for language understanding. In Proceedings of NAACL, pages 4171–4186.

Jeremy Howard and Sebastian Ruder. 2018. Universal language model fine-tuning for text classification. In Proceedings ACL, pages 328–339.

Allen H Huang, Amy Y Zang, and Rong Zheng. 2014. Evidence on the information content of text in analyst reports. The Accounting Review, 89(6):2151–2180.

Kexin Huang, Jaan Altosaar, and Rajesh Ranganath. 2019. Clinicalbert: Modeling clinical notes and predicting hospital readmission. arXiv:1904.05342.

sri International. 1987. Investor information needs and the annual report. Financial Executives Research Foundation.

Jinhyuk Lee, Wonjin Yoon, Sungdong Kim, Donghyeon Kim, Sunkyu Kim, Chan Ho So, and Jaewoo Kang. 2019. BioBERT: a pre-trained biomedical language representation model for biomedical text mining. Bioinformatics.

Pekka Malo, Ankur Sinha, Pekka Korhonen, Jyrki Wallenius, and Pyry Takala. 2014. Good debt or bad debt: Detecting semantic orientations in economic texts. Journal of the Association for Information Science and Technology, 65(4):782–796.

Tomas Mikolov, Ilya Sutskever, Kai Chen, Greg Corrado, and Jeffrey Dean. 2013. Distributed representations of words and phrases and their compositionality. In Proceedings of NIPS, pages 3111–3119.

Jeffrey Pennington, Richard Socher, and Christopher D Manning. 2014. Glove: Global vectors for word representation. In Proceedings of EMNLP, pages 1532–1543.

Matthew E. Peters, Mark Neumann, Mohit Iyyer, Matt Gardner, Christopher Clark, Kenton Lee, and Luke Zettlemoyer. 2018. Deep contextualized word representations. In Proc. of NAACL.
