from the in-sample to the out-of-sample setting, but the gap is absolutely acceptable, conﬁrming a good generalization capability of the trained LSTM model.
The model showed higher performance at high (0.9) and low (0.1) quantiles with
lower weighted quantile losses. Figure 5 illustrates the median absolute forecast error (MAFE, in orange) against the real time series observations (in blue).

Information Extraction from the GDELT Database

63

Fig. 5. Mean absolute forecast error (MAFE) (orange) against real observations (blue).
(Color ﬁgure online)

The performance of the model slightly worsen from the end of May to July 2018,
corresponding to a period of political turmoil in Italy. Indeed, on the 29th of May,
the Italian spread sharpely rose reaching 250 basis point. Investors where particularly worried about the possibility of anti-euro government and not conﬁdent on
the formation of a stable government. From June until November 2018, a series of
discussions about deﬁcit spending engagements and possible conﬂicts with European ﬁscal rules continued to worry the markets. The spread strongly increased in
October and November with values around 300 basis point. We can see this also
from the performance of our model which worsen a bit in this stressed period, which
however the model looks to handle quite well anyway. Since 2019, the Italian political situation started to improve and the spread smoothly declined, especially after
the agreement with Brussels on budget deﬁcit in December 2018. However, some
events hit the Italian economy afterwards, such as the EU negative outlook and
the European parliament elections which contributed to a temporary increase on
interest rates. Our model performs quite well in this period in terms of absolute
error ratios showing a good robustness.
Figure 6 shows a scatter plot amongst the median out-of-sample forecasted
points and the real observations. To some degree the points in the scatter plot
roughly follow the diagonal, showing a ﬁne correlation among the forecasted
points and the real observations, and suggesting good quality of the forecasting
results. This is also conﬁrmed by the acceptable value of 0.23 computed for the

64

S. Consoli et al.

Fig. 6. Scatter plot amongst the median out-of-sample forecasted points and the real
observations.

R-squared metrics on the out-of-sample median forecasts for such a challenging prediction exercise. This value of the R-squared measure indicates that the
LSTM model explains a quite ample variability of the response data around its
median, suggesting a certain degree of closeness among the forecasted data and
the real observations.

6

Conclusion and Overlook

In this contribution we have presented our work-in-progress related to the development of a methodology for building alternative economic and ﬁnancial indicators capturing investor’s emotions and topics popularity from GDELT, the
Global Data on Events, Location, and Tone database, a free open platform containing real-time worlds broadcast, print, and web news. The currently on-going
project in which this work is developed is aimed at producing improved forecasting methods to analyse the sovereign bond markets of countries in the EU.
We have reported some preliminary results on the application of this methodology for predicting the Italian sovereign bond market. This use case reveals
initial good performance of the methodology, suggesting the validity of the approach. Using the information extracted from the Italian news media contained in
GDELT combined with a deep Long Short-Term Memory Network opportunely
trained and validated with a rolling window approach, we have been able to
obtain quite good forecasting results.

Information Extraction from the GDELT Database

65

This work represents one of the ﬁrst to study the behaviour of government
yield spreads and ﬁnancial portfolio decisions in the presence of classical yield
curve factors and information extracted from news. We believe that these new
measures are able to capture and predict changes in interest rates dynamics
especially in period of turmoil. Overall, the paper shows how to use a large scale
database as GDELT to derive ﬁnancial indicators in order to capture future
intentions of agents in sovereign bond markets.
Certainly more research is still needed to be exploited in the directions of the
presented work. First we will try to improve the performance of the implemented
DeepAR model by tweaking architecture and optimizing the hyperparameters of
the LSTM model. Furthermore, in current research we are experimenting other
diﬀerent prediction models, ranging from traditional economic methods to other
novel machine learning approaches, including Gradient Boosting Machines and
neural forecasting methods. In a future extended version of the paper we will
compare and thoroughly analyze the performance of these methods to better
exploit the non-linear eﬀects of the dependent variables. Interpretability of the
implemented machine learning models by using, e.g., computed Shapley values,
will be an important object of future investigation in order to ﬁnely assess the
contributions of the diﬀerent covariates in the models predictions.
Acknowledgments. The authors would like to thank the colleagues of the Centre
for Advanced Studies at the Joint Research Centre of the European Commission for
helpful guidance and support during the development of this research work.

References
1. Agrawal, S., Azar, P., Lo, A.W., Singh, T.: Momentum, mean-reversion and social
media: evidence from StockTwits and Twitter. J. Portfolio Manag. 44, 85–95
(2018)
2. Alexandrov, A., et al.: GluonTS: probabilistic time series models in Python. CoRR,
abs/1906.05264 (2019). http://arxiv.org/abs/1906.05264
3. Beber, A., Brandt, M.W., Kavajecz, K.A.: Flight-to-quality or ﬂight-to-liquidity?
Evidence from the Euro-area bond market. Rev. Financ. Stud. 22(3), 925–957
(2009)
4. Benidis, K., et al.: Neural forecasting: introduction and literature overview. CoRR,