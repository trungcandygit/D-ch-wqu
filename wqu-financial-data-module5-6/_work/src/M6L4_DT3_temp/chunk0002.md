               * 1 mil is 10            inch

      2. Try fitting polynomials of n = 2, 3, ... to the data and apply the measures of problem l(c) , (d) , and (e) to

          the results.

      3. Try transforming the dataset by logarithmic or power functions and fit a linear function to the

          transformed variables. Apply the measures of problem 1(c) , (d) , and (e) to the results and compare.

      4. For the results found above, how useful would the data have been in arguing for a "no launch" decision?

          Comment on the ethical implications.

https://onlineethics.virginia.edu/cases/numerical-design-problems-ethical-content/challenger-o-ring-data-analysis              3/7

10/2/26, 10:02 AM                                                                   Challenger O-Ring Data Analysis | Online Ethics

    Back to Top

    SOLUTIONS

    It is assumed that students have received instruction on the engineering aspects of the disaster.

    The purpose of these exercises is to sensitize students to the following issues:

          The world is probabilistic, not deterministic, and nothing is "sure."

          Though data may be inconclusive, when matters of life and property are at stake, "not knowing" should

          be equivalent to "we have a problem."

          Linear regression is but one way of fitting a function to data and interpreting results statistically.

      1. (The plot is given below, and is suitable for creating an overhead foil.) (Three significant figures are given

          in the equation for checking results.) At 29 °F the material loss (95 % confidence) is in the range of 25

          to 105 mils. This extreme variability indicates (see also below) high risk of seal failure. Though

          extrapolation is always suspect, the very notion of "not knowing" with statistical validity how the seal

          would perform at 29 °F should have been taken as sufficient reason to cancel the launch.

           a. From Figure 1, r = ` 0.56. From a table of critical values of correlation coefficients, at the 95 %

               confidence level (5% significance, for 20 degrees of freedom [22 data pairs minus two parameters in

               the linear equation], rc = 0.423 is found. 4. This means that with 5% probability, data exhibiting a

               correlation coefficient as great as 0.423 will not be correlated. Or, rc may be interpreted as the

               maximum value that may take by chance (95% of the time) alone, when no correlation exists.

           b. The correlation coefficient r is defined thus: r= SXY/(SXSY)

               The numerator is the sample covariance, the denominator the product of the sample variances of

               the two variables: X, Y.

               Thus the r-value is a measure of association of the two variables. Now 0 < (absolute value) r < 1,

                                                                                                                                                2
               with r = +/- 1 indicating perfect correlation, and r = 0 indicating perfect non-correlation. Then r                                  is a

                                                                                                   2
               measure of the variability due to causality, and 1`r                                    is a measure of variability due to randomness.

               See also the comments just after the problem statement, above.

            c. See Figure 1. Explain the meaning of the confidence interval. One interpretation is: "If we performed

               a very large number of tests, 95% of the outcomes would lie in the indicated 95%`bounded range."

           d. For both the Chi-square test and the K-S test of problem (e) the test hypothesis is: Ho The data are

               uncorrelated.

                                                             2          2
               We accept the hypothesis if: X                    o> X       1 -   α,v

               where 1 `      α= C is the confidence level (α is the significance level) , and v is the degrees of freedom
               Here, v = N ` 1 ` m, where N is the number of observations of the variables (22 in this case) , and m

               is the number of parameters in the equation being tested (m = 2 for linear equation) .

               The term on the left side of the inequality is the observed Chi-square statistic, computed the data.

               The right side of the inequality is the value of the Chi-square variable corresponding to probability C,

               i.e. the value of the integral of the density function to the variate. These are tabulated.

https://onlineethics.virginia.edu/cases/numerical-design-problems-ethical-content/challenger-o-ring-data-analysis                                          4/7

10/2/26, 10:02 AM                                                            Challenger O-Ring Data Analysis | Online Ethics
                                                          2                                2
               For the problem at hand:5 X                    0.95,19 = 30.1 and X             0 = 422.

               Therefore, the hypothesis is accepted that the data are not linearly correlated.

           e. For the Kolmogorov-Smirnov test we use the same hypothesis: Ho The data are uncorrelated.

               We reject the hypothesis if: Sup{ yf Yd}?dα(v)

               The subscripts on y refer to "fused" and "data" values, respectively. Thus, for a datapair xd, Yd the

               value of the fitted function at xd is yf . The maximum value ("supremum") is the compared to the K`S

               statistic for the significance level and degrees of freedom as in problem (d)6.

               We find Sup{|yf yd|} = 45, and d0.05(l9) = 0.301, so we cannot reject the hypothesis that the data

               are not linearly correlated.
