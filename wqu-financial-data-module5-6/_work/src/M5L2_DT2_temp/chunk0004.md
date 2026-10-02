accuracy of 0.872, a 4.4% improvement over uncased BERT model and 15.4% improvement over
cased BERT model. On FiQA dataset, the best
model uncased FinBERT-FinVocab achieves the
accuracy of 0.844, a 15.6% improvement over
uncased BERT model and a 29.2% improvement
over cased BERT model. Lastly, on the AnalystTone dataset, the best model uncased FinBERTFinVocab improves the uncased and cased BERT
model by 4.3% and 5.5% respectively. Overall
speaking, pretraining on financial corpora, as expected, is effective and enhances the downstream
financial sentiment classification tasks. In financial markets where capturing the accurate sentiment signal is of utmost importance, we believe
the overall FinBERT improvement demonstrates
its practical utility.
FinVocab vs. BaseVocab We assess the importance of an in-domain financial vocabulary by pretraining different FinBERT models using BaseVocab and FinVocab. For both uncased and cased
model, we see that FinBERT-FinVocab outperforms its BaseVocab counterpart. However, the
performance improvement is quite marginal on
PhraseBank and AnalystTone task. Only do we
see substantial improvement on FiQA task (0.844
vs. 0.796). Given the magnitude of improvement,
we suspect that while an in-domain vocabulary is
helpful, FinBERT benefits most from the financial
communication corpora pretraining.
Cased vs. Uncased We follow (Devlin et al.,
2019) in using both the cased model and the uncased model for all tasks. Experiments result suggest that uncased models perform better than cased
models in all tasks. This result is consistent with

prior work of Scientific domain and Biomedical
domain BERT models.
Corpus Contribution We also train different FinBERT models on three financial corpus separately.
The performance of different FinBERT models
(cased version) on different tasks are present in
Table 3. It shows that FinBERT trained on all
corpora achieves the overall best performance indicating that combining additional financial communication corpus could improve the language
model quality. Among three datasets, Analyst
Reports dataset appears to perform well in three
different tasks, even though it only has 1.1 billion word tokens. Prior research finds that corporate report such as 10-Ks and 10-Qs contains
redundant content, and that a substantial amount
of textual volume contained in 10-K reports is attributable to managerial discretion in how firms
respond to mandatory disclosure requirements
(Cazier and Pfeiffer, 2016). Does it suggest that
Analyst Reports data contains more information
content than corporate reports and earnings call
transcripts? We leave it for future research.

6 Conclusion
In this work, we pre-train a financial-task oriented
BERT model, FinBERT. The FinBERT model
is trained on a large financial corpora that are
representative of English financial communications. We show that FinBERT outperforms generic
BERT models on three financial sentiment classification tasks. With the release of FinBERT, we
hope practitioners and researchers can utilize FinBERT for a wider range of applications where the
prediction target goes beyond sentiment, such as

financial-related outcomes including stock returns,
stock volatilities, corporate fraud, etc.

Acknowledgments

Tomas Mikolov, Ilya Sutskever, Kai Chen, Greg Corrado, and Jeffrey Dean. 2013. Distributed representations of words and phrases and their compositionality. In Proceedings of NIPS, pages 3111–3119.

This work was supported by Theme-based Research Scheme (No. T31-604/18-N) from Research Grants Council in Hong Kong.

Jeffrey Pennington, Richard Socher, and Christopher D
Manning. 2014. Glove: Global vectors for word
representation. In Proceedings of EMNLP, pages
1532–1543.

References

Matthew E. Peters, Mark Neumann, Mohit Iyyer, Matt
Gardner, Christopher Clark, Kenton Lee, and Luke
Zettlemoyer. 2018. Deep contextualized word representations. In Proc. of NAACL.

Emily Alsentzer, John Murphy, William Boag, WeiHung Weng, Di Jindi, Tristan Naumann, and
Matthew McDermott. 2019. Publicly available clinical bert embeddings. In Proceedings of the 2nd
Clinical Natural Language Processing Workshop,
pages 72–78.
Iz Beltagy, Kyle Lo, and Arman Cohan. 2019. Scibert: Pretrained language model for scientific text. In
Proceedings of EMNLP.
Richard A Cazier and Ray J Pfeiffer. 2016. Why are
10-k filings so long? Accounting Horizons, 30(1):1–
21.
X Cui, D Lam, and A Verma. 2016. Embedded
value in bloomberg news and social sentiment data.
Bloomberg LP.
Jacob Devlin, Ming-Wei Chang, Kenton Lee, and
Kristina Toutanova. 2019. Bert: Pre-training of deep
bidirectional transformers for language understanding. In Proceedings of NAACL, pages 4171–4186.
Jeremy Howard and Sebastian Ruder. 2018. Universal
language model fine-tuning for text classification. In
Proceedings ACL, pages 328–339.
Allen H Huang, Amy Y Zang, and Rong Zheng. 2014.
Evidence on the information content of text in analyst reports. The Accounting Review, 89(6):2151–
2180.
Kexin Huang, Jaan Altosaar, and Rajesh Ranganath.
2019. Clinicalbert: Modeling clinical notes and predicting hospital readmission. arXiv:1904.05342.
sri International. 1987. Investor information needs and
the annual report. Financial Executives Research
Foundation.
Jinhyuk Lee, Wonjin Yoon, Sungdong Kim,
Donghyeon Kim, Sunkyu Kim, Chan Ho So,
and Jaewoo Kang. 2019. BioBERT: a pre-trained
biomedical language representation model for
biomedical text mining. Bioinformatics.
Pekka Malo, Ankur Sinha, Pekka Korhonen, Jyrki Wallenius, and Pyry Takala. 2014. Good debt or bad
debt: Detecting semantic orientations in economic
texts. Journal of the Association for Information
Science and Technology, 65(4):782–796.
