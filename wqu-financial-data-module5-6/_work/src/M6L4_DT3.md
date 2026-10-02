# M6L4_DT3

10/2/26, 10:02 AM                                                            Challenger O-Ring Data Analysis | Online Ethics

    (/)

                                                                Online Ethics Center
                                                      FOR      ENGINEERING                   AND       SCIENCE

                                                           GET INVOLVED (/JOIN-OEC-COMMUNITY)

                                                                                                                               
       Site Search

    LOG IN (/USER/LOGIN)

    Home (/)           /    Challenger O -Ring Dat a Analysis

    Challenger O-Ring Data Analysis
   Share
    (https://www.addtoany.com/share#url=https%3A%2F%2Fonlineethics.virginia.edu%2Fcases%2Fnumerical-

    design-problems-ethical-content%2Fchallenger-o-ring-data-analysis&title=Challenger%20O-

    Ring%20Data%20Analysis)

          (/#facebook)               (/#twitter)            (/#linkedin)              (/#email)

    Author(s)

    Joseph H. Wujek (/taxonomy/term/991)

    Parent Collection

    Numerical & Design Problems With Ethical Content (/collection-

    detail/Numerical%20%26%20Design%20Problems%20With%20Ethical%20Content)

    Authoring Institution

    Zachry Department of Civil Engineering-TAMU Ethics (/taxonomy/term/381)

    Year:     1995

    DOI

https://onlineethics.virginia.edu/cases/numerical-design-problems-ethical-content/challenger-o-ring-data-analysis                  1/7

10/2/26, 10:02 AM                                                            Challenger O-Ring Data Analysis | Online Ethics

    https://doi.org/10.18130/2pem-7a20

    Rights

    Use of Materials on the OEC (/use-materials-oec)

    Discipline(s)

    Aerospace Engineering (/taxonomy/term/15126)

    Computer, Math, and Physical Sciences (/taxonomy/term/15051)

    Engineering (/taxonomy/term/15121)

    Material Science and Engineering (/taxonomy/term/15181)

    Mechanical Engineering (/taxonomy/term/15186)

    Statistics and Probability (/taxonomy/term/15116)

    Topics

    Catastrophes, Hazards, Disasters (/taxonomy/term/17191)

    Employer/Employee Relationships (/taxonomy/term/17331)

    Lab and Workplace Safety (/taxonomy/term/17376)

    Safety (/taxonomy/term/17411)

    Workplace Ethics (/taxonomy/term/17426)

         Case Study / Scenario (/taxonomy/term/13236)

                                                                                                                          Print PDF (/print/pdf/node/36426

    Description

    This case provides an analysis of the O-ring data from the Challenger Disaster and argues for a launch

    scrub. Suitable for courses in applied statistics, material, and general engineering levels 1-4.

    Body

    Introduction

    Solutions

    Footnotes

    INTRODUCTION

    The events leading to the Challenger disaster are well known. This problem involves analysis of O-ring data

    and involves arguing for a launch scrub based on the results.

    The data of Table 1 have been used by David Hodges in the Freshman Seminar at University of California at

    Berkeley. 1 These data are from successful flights. Roger Boisjoly has indicated that these data were not

    available prior to the Challenger disaster.2 Use the data in Table 1 as needed.3

      1. Obtain a linear regression plot and extrapolate the result to predict the material loss in the O-ring at the

          time of the disastrous Challenger launch. Assume that the O-ring was at the launch pad ambient

https://onlineethics.virginia.edu/cases/numerical-design-problems-ethical-content/challenger-o-ring-data-analysis                                       2/7

10/2/26, 10:02 AM                                                            Challenger O-Ring Data Analysis | Online Ethics

          temperature, 29 °F.

           a. Compute the correlation coefficient, r. Compare it the critical value of r at the 5% significance level

               and explain the meaning.

                                                                2              2
           b. Comment on the meaning of r, r , and 1 r . How relevant would this be in arguing for no launch?

            c. Compute the 95% confidence interval bounds and show the result in your linear plot.

           d. Comment on goodness of fit using the Chi-square test.

           e. Comment on goodness of fit using the Kolmogorov-Smirnov test.

               Table 1, Data from Challenger Post-flight

               Measurements3

                O-ring temp in °F Erosion depth,                    δ mils *
                66.0                        0.0

                70.0                        53.0

                69.0                        0.0

                68.0                        0.0

                67.0                        0.0

                72.0                        0.0

                73.0                        0.0

                70.0                        0.0

                57.0                        40.0

                63.0                        0.0

                70.0                        28.0

                78.0                        0.0

                67.0                        0.0

                53.0                        48.0

                67.0                        0.0

                75.0                        0.0

                70.0                        0.0

                81.0                        0.0

                76.0                        0.0

                79.0                        0.0

                75.0                        0.0

                76.0                        0.0

                                   -3
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

      2. Problem 2 is intended for exercises in curve-fitting. Because of their open-ended nature, solutions are

          not given. A pitfall of using a logarithmic transformation is attempting to compute the logarithm of zero!

      3. Problem 3 is intended for exercises in curve-fitting. Because of their open-ended nature, solutions are

          not given. A pitfall of using a logarithmic transformation is attempting to compute the logarithm of zero!

      4. The erratic data would have been sufficient to indicate "we have a problem" because of the risk to

          human lives. The astronauts were not informed of the history of the O-ring defects, thus informed

          consent was not possible.

    Back to Top

    FOOTNOTES

          1. Lighthall, F. "Launching the Space Shuttle Challenger: Disciplinary Deficiencies in the Analysis of

          Engineering Data," IEEE Transactions on Engineering Management, Vol. 38, No. 1, February 1991. pp.

          63-74.

          2. Boisjoly, R. Pers. comm. November 1993.

          3. Lighthall, p. 70, Table I.

          4. Found in many texts and handbooks. See for example, Fisher, R., and Yates, F., Statistical Tables for

          Biological. Agricultural, and Medical Research. Oliver & Boyd, Ltd., Edinburgh, 1957.

          5. Owen, D. Handbook of Statistical Tables. Addison`Wesley, Reading, MA, 1962. p. 51.

          6. Owen, p. 64.

https://onlineethics.virginia.edu/cases/numerical-design-problems-ethical-content/challenger-o-ring-data-analysis              5/7

10/2/26, 10:02 AM                                                            Challenger O-Ring Data Analysis | Online Ethics

          Figure 1, Chart- Linear Regression on O-ring Data (After Lighthall)

    Back to Top

    Notes

    Author: Dr. Joseph H. Wujek, P.E., College of Engineering University of California, Berkeley.

    These problems were originally developed as part of an NSF-funded project to create numerical problems

    that raise ethical issues for use in engineering and other course assignments. The problems presented here

    have been edited slightly for clarity.

    Citation

    Joseph H. Wujek. 1995. Challenger O-Ring Data Analysis. Online Ethics Center.

    DOI:https://doi.org/10.18130/2pem-7a20. https://onlineethics.org/cases/numerical-design-problems-

    ethical-content/challenger-o-ring-data-analysis.

https://onlineethics.virginia.edu/cases/numerical-design-problems-ethical-content/challenger-o-ring-data-analysis              6/7

10/2/26, 10:02 AM                                                            Challenger O-Ring Data Analysis | Online Ethics

         Related Resources

         Columbia Disaster Bibliography (/cases/oec-bibliographies/columbia-disaster-bibliography)

         L'Acide Case Scenario 2: Concerned Citizen (/cases/lacide-case-scenario-2-concerned-citizen)

         A Research Strategy for Environmental, Health, and Safety Aspects of Engineered Nanomaterials

         (/cases/national-academies-press-consensus-study-reports/research-strategy-environmental-health-

         and)

         L'Acide Case Scenario 1: Consulting Firm Engineer (/cases/lacide-case-scenario-1-consulting-firm-

         engineer)

         Three Teaching Case Studies of Accidents in Nuclear Energy Development in Japan (/cases/three-

         teaching-case-studies-accidents-nuclear-energy-development-japan)

                       SUBMIT CONTENT TO THE OEC ( /SUBMIT-RESOURCES-OEC)                                               DONATE ( /DONATE)

                     This material is based upon work supported by the National

                     Science Foundation under Award No. 2055332. Any

                     opinions, findings, and conclusions or recommendations

                     expressed in this material are those of the author(s) and do

                     not necessarily reflect the views of the National Science

                     Foundation.

                    (https://twitter.com/OnlineEthicsCtr)

    © 2026 By the Rector and Visitors of the University of Virginia                    OEC Terms of

    Use (/oec-website-policy)

    Notice of Non-Discrimination and Equal Opportunity

    (http://eocr.virginia.edu/notice-non-discrimination-and-equal-opportunity) |

    Report a Barrier (http://reportabarrier.virginia.edu) | Privacy Policy

    (http://www.virginia.edu/siteinfo/privacy/) | onlineethics@virginia.edu

    (mailto:onlineethics@virginia.edu)

https://onlineethics.virginia.edu/cases/numerical-design-problems-ethical-content/challenger-o-ring-data-analysis                           7/7

