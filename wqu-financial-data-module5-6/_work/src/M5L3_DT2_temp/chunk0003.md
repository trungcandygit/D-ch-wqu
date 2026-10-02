classical factors into the model. Being the government bond yields a highly
persistent and non-stationary process, we have considered its log-diﬀerences and
obtained a stationary series of daily changes representing our prediction target,
illustrated in Fig. 1. This kind of forecasting exercise is an extremely challenging
task, as the target series behaves similarly to a random walk process. Missing
data, related to weekends and holidays, have been dropped from the target time
series, giving a ﬁnal number of 468 data points.

Fig. 1. Log-diﬀerences of the sovereign spread for Italy against Germany as the diﬀerence between the Italian 10 year maturity bond yield minus the German counterpart.

For our Italian case study, we have also extracted the news information from
GKG in GDELT from a set of around 20 newspapers for Italy, published over
the considered period of the analysis. After this selection procedure we obtained
a total of 18,986 articles, with a total of 2,978 GCAM, 1,996 Themes and 155
locations. Applying the feature selection procedure described above, we have
extracted 31 dimensions of the General Inquirer Harvard IV psychosocial Dictionary, 61 dimensions of Roget’s Thesaurus, 7 dimensions of the Martindale
Regressive Imagery and 3 dimensions of the Aﬀective Norms for English Words
(ANEW) dictionary. After the features engineering procedure, we have been left
with a total of 45 variables, of which 9 are themes, 34 are GCAM, 2 locations.
The selected topics contained WB themes such as Inﬂation, Government, Central
Banks, Taxation and Policy, which are indeed important thematics discussed in

60

S. Consoli et al.

the news when considering interest rates issues. Moreover, selected GCAM features included optimism, pessimism or arousal, which explore the emotional state
of the market. Figure 2 shows the top correlated covariates with respect to the
target.

Fig. 2. Log-diﬀerences of the sovereign spread for Italy against Germany as the diﬀerence between the Italian 10 year maturity bond yield minus the German counterpart.

Several studies in the literature have shown that during stressed periods, complex non-linear relationships among explanatory variables aﬀect the behaviour
of the output target which simple linear models are not able to capture. For this
reason, in this empirical exercise we have used a deep Long Short-Term Memory Network (LSTM) [15] to best accounting for non-linearities and assessing
the predictive power of the selected GDELT variables. The LSTM was implemented relying on the DeepAR model available in Gluon Time Series (GluonTS) [2]9 , an open-source library for probabilistic time series modelling that
focuses on deep learning-based approaches and interfacing Apache MXNet10 .
DeepAR is an LSTM model working into a probabilistic setting, that is, predictions are not restricted to point forecasts only, but probabilistic forecastings
are produced according to a user-deﬁned predictive distribution (in our case a
student t-distribution was experimentally selected). For our experiment we have
set experimentally to use 2 RNN layers, each having 40 LSTM cells, and used a
learning rate equal to 0.001. The number of training epochs was set to 500, with
training loss being the negative log-likelihood function.
9
10

Available at: https://gluon-ts.mxnet.io/#gluonts-probabilistic-time-series-modeling.
Available at: https://mxnet.apache.org/.

Information Extraction from the GDELT Database

61

We have used a robust scaling for the training variables by adopting statistics
robust to the presence of outliers. That is, we have removed the median to
each time series, and the data were scaled according to the interquartile range.
Furthermore we have adopted a rolling window estimation technique where the
ﬁrst estimation sample started at the beginning of March and ended in May
2017. For each window, one step-ahead forecasts have been calculated. The whole
experiment required to run few hours in parallel on 40 cores at 2.10 GHz each
into an Intel(R) Xeon(R) E7 64-bit server having overall 1 TB of shared RAM.

Fig. 3. Median forecasts (green) and observations for the target series (blue) for the
entire forecasting period. (Color ﬁgure online)

Figure 3 shows the observations for the target time series (blue line) together
with the median forecast (dark green line) and the conﬁdence interval in lighter
green. To better visualize the diﬀerences between observed and predicted time
series, we have reported the same plot on a smaller time range (50 days) in
Figure 4. A qualitative analysis of the ﬁgure suggests that the forecasting model
does a reasonable job at capturing the variability and volatility of the time series.
We have also computed a number of commonly used evaluation metrics
[21], such as the mean absolute scaled error (MASE), the symmetric mean
absolute percentage error (sMAPE), the root mean square error (RMSE), and
the (weighted) quantile losses (wQuantileLoss), that is the quantile negative
log-likelihood loss weighted with the density. The obtained in-sample and outof-sample results are shown in Table 1. As expected the results worsen passing

62

S. Consoli et al.

Fig. 4. Probabilistic forecasts (green) and observations for the target series (blue) for
the ﬁrst 50 days in the testing period. The green continuous line shows the median of the
probabilistic predictions, while the lighter green areas represents an higher conﬁdence
interval. (Color ﬁgure online)
Table 1. Forecasting results of the LSTM model in terms of MASE, sMAPE, RMSE,
and wQuantileLoss error metrics.
Metrics

LSTM results
In-sample Out-of-sample

MASE

0.112

0.682

sMAPE

0.130

1.148

RMSE

0.493

0.885

wQuantileLoss[0.1] 0.050

0.869

wQuantileLoss[0.3] 0.115

0.899

wQuantileLoss[0.5] 0.151

0.914

wQuantileLoss[0.7] 0.121

0.923

wQuantileLoss[0.9] 0.047

0.907
