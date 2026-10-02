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

CONCLUSION AND FUTURE WORK

In this paper, we implemented BERT for the financial domain by
further pre-training it on a financial corpus and fine-tuning it for
sentiment analysis (FinBERT). This work is the first application of
BERT for finance to the best of our knowledge and one of the few
that experimented with further pre-training on a domain-specific
corpus. On both of the datasets we used, we achieved state-of-theart results by a significant margin. For the classification task, we
increased the state-of-the art by 15% in accuracy.
In addition to BERT, we also implemented other pre-training
language models like ELMo and ULMFit for comparison purposes.
ULMFit, further pre-trained on a financial corpus, beat the previous
state-of-the art for the classification task, only to a smaller degree
than BERT. These results show the effectiveness of pre-trained language models for a down-stream task such as sentiment analysis
especially with a small labeled dataset. The complete dataset included more than 3000 examples, but FinBERT was able to surpass
the previous state-of-the art even with a training set as small as
500 examples. This is an important result, since deep learning techniques for NLP have been traditionally labeled as too "data-hungry",
which is apparently no longer the case.
We conducted extensive experiments with BERT, investigating
the effects of further pre-training and several training strategies.
We couldn’t conclude that further pre-training on a domain-specific
corpus was significantly better than not doing so for our case. Our
theory is that BERT already performs good enough with our dataset
that there is not much room for improvement that further pretraining can provide. We also found that learning rate regimes that
fine-tune the higher layers more aggressively than the lower ones
perform better and are more effective in preventing catastrophic
forgetting. Another conclusion from our experiments was that,
comparable performance can be achieved with much less training
time by fine-tuning only the last 2 layers of BERT.
Financial sentiment analysis is not a goal on its own, it is as
useful as it can support financial decisions. One way that our work
might be extended, could be using FinBERT directly with stock
9
