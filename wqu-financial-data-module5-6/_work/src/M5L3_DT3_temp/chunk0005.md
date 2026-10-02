The main objective of our empirical exercise is to assess the predictive power
of GDELT selected features over and above the classical determinants for government credit spreads during stressed periods. We explore predictability for
the 90th percentile of the credit spread distribution, since this is usually classiﬁed as a situation of ﬁnancial distress (see [4] among others). Several studies
in the literature have shown that during these periods, complex non-linear relationships among explanatory variables aﬀect the behaviour of the output target
which simple linear models are not able to capture. We account for that by
using a GB model with a quantile distribution and we adopt a rolling window
estimation technique where the ﬁrst estimation sample starts at the beginning
of March and ending in May 2017. We compare the forecasting perfomance of a
GB model where classical determinants as well as selected GDELT features are
included, with that of a GB model where only classical factors are considered.
We measure the forecasting performance by calculating the absolute error for
each forecast. We also assess the explanatory power of GDELT features over
time by calculating the variable importance at each estimation, and explore the
ﬁve most important variables at each rolling window estimation. This is in line
with standard term structure literature, stating that from three to ﬁve factors
are suﬃcient to explain the dynamics of yield spreads. We estimate the model on
half of the sample and adopt a rolling window to generate one-step ahead forecasts. We use a 10-fold cross-validation for each estimation window, and apply
the grid search procedure previously described in Sect. 4.3 to optimally ﬁnd the
hyperparameters of the GB model.
Figure 1 displays the time series of the Italian spread and the ratio between
absolute forecast errors of the model augmented with GDELT features and that
of the model with classical regressors only. Notice that, when the value of this
ratio is below one, our augmented model performs better than the benchmark. It
is interesting to observe that the performance of our augmented model improves
considerably starting from the end of May 2018 when a period of political turmoil
started in Italy. On the 29th of May, the Italian spread sharpely rose reaching 250
basis point. Investors where particularly worried about the possibility of antieuro government and not conﬁdent on the formation of a stable government.
During these stressed events our GDELT features augmented model strongly
outperforms the benchmark model with absolute ratios values well below one,
i.e. 0.93 on May the 24th that is the minimum value across all the sample under
analysis. This result emphasises the value added of news articles stories in forecasting the yield spreads dynamics during periods of ﬁnancial distress. From
June until November 2018, a series of discussions about deﬁcit spending engagements and possible conﬂits with European ﬁscal rules continued to worry the
markets. The spread strongly increased in October and November with values

198

S. Consoli et al.

Fig. 1. Absolute errors ratios and spread

around 300 basis point. During this period our augmented model agains performs particularly well, with ratio around 0.95 with a minimum value of 0.94 on
November the 9th . Since 2019, the italian political situation started to improve
and the spread smothly decline, especially after the agreement with Brussels
on buget deﬁcit in December 2018. However, some events hit the Italian economy afterwards, such as the EU negative outlook and the European parliament
elections which contributed to a temporary increase on interest rates.
Although in 2019 our aumented model did not perform as well as in 2018 in
terms of absolute error ratios, it still consistently outperforms the benchmark
model. From the analysis above we clearly observe three main sub-periods. The
ﬁrst pre-crisis period ranging form July 2017 till May 2018, the second one is
the crisis period from June till December 2018, the third period from January
2019 till the end of the sample. We next analyse the contribution of each selected
GDELT feature in the prediction of interest rates spread during periods of political stress, splitting the sample in the three identiﬁed subperiods.
Figure 2 shows the frequency of each variables appearing on the top ﬁve positions according to the Gradient Boosting Machine variable importance during
(a) the pre-crisis period, (b) the crisis period, and (c) the post crisis period.
It is interesting to observe that classical factors such as slope and curvature of
spread yield curve are the most important variables during the pre-crisis period.
However, we also observe that amongst the classical regressors, the level factor,
which is pointed by the literature as the most important variable in explaining
interest rates dynamics, is less important than two GCAM sentiment measures,
namely the arousal form ANEW dictionary and Hate of Thesaurs. Figure 2(b)
shows that, during crisis period, classical yield spread factors reduces considerably their predictive contribution. The most important variable is the Arousal

C_WNA_JOY

C_WNA_PESSIMISM

G_GM_l1
G_IT_l1

G_GM_l1

G_IT_l1

G_IT_l1

G_GM_l1

FACTOR_3

FACTOR_2

FACTOR_1

FACTOR_3

FACTOR_2

FACTOR_1

FACTOR_3

FACTOR_2

FACTOR_1

C_WNA_STIR
C_WNA_UNCONCERN

C_WNA_UNCONCERN

C_WNA_SADNESS
C_WNA_TOGETHERNESS

C_WNA_TOGETHERNESS

C_WNA_STIR

C_WNA_STIR
C_WNA_TOGETHERNESS

C_WNA_SADNESS

C_WNA_SADNESS

C_WNA_UNCONCERN

C_WNA_PESSIMISM
C_WNA_REVERENCE

C_WNA_PESSIMISM
C_WNA_REVERENCE

C_WNA_REVERENCE

C_WNA_IDENTIFICATION

C_WNA_OPTIMISM

C_WNA_HOPE

C_WNA_FFECTION

C_WNA_COOLNESS

C_WNA_CONFIDENCE

C_WNA_APPROVAL

C_TH_WARNING

C_TH_UNCERTAINTY

C_TH_RECESSION

C_TH_PLEASURE

C_TH_HATE

C_TH_DISCONTENT

C_TH_CREDIT

C_TH_CERTAINTY

C_TH_AFFECTIONS

C_RI_GLORY

C_RI_AFFECTION

C_HRV_RSPLOSS

C_HRV_FINISH

C_HRV_DECR

C_HED_HAPPINESS

C_ANEW_DOMINANCE

C_ANEW_AROUSAL

B_TAXATION

B_PRICE

B_POLICY

B_MONETARY_POLICY

B_LEADER

B_INFLATION

B_GOVERNMENT

B_CENTRAL_BANKS

C_WNA_OPTIMISM
