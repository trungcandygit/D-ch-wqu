2. The workers process their chunks.
3. The manager collects the results from the workers (gather
phase) and combines them as appropriate to the application.
Snow can be used with socket connections, Message Passing Interface
(MPI), Parallel Virtual Machine (PVM), or NetWorkSpaces [12, 13].
The socket transport does not require any additional packages, and is
very portable. We have used socket connections. Snow is a non-sharedmemory system example, if we are using a network of workstations,
each workstation has its own and independent memory. But, in the
multicore and one-computer case, the memory is shared between all the
running processes. In both cases, the cost of communications should be
kept in mind. The cost of communication is dependent on a variety
of features including the programming model semantics, the network
topology, data handling and routing, and associated software protocols.
Reducing the computation time by adding more processors would only
improve marginally the overall execution time as the communication
costs remains fixed.

Fig. 1. All mentions for “FUELPRICES” theme in Spain.

IV. Results
A. Results using data from GDELT GKG
We are analyzing tone in mentions from GKG database. All
mentions have some common characteristic, they refer to Spain as
location at some point, themes “ENV_SOLAR” or “FUELPRICES”
are detected in the text and, the lines contain one of the following
words: “gobierno”, “government”, “council”, “ministers”, “ministry”,
“ministro”, “ministerio” (we interpret it as the text mentions the
Spanish Government). GDELT 2.0 and GKG new version are relativity
recent. For this reason, we only have data filling these requisites
from February 18th, 2015 to October 28th, 2015. Since is a project
in constant update, in order to close our study, we refer here to data
obtained in our last interaction with Google’s BigQuery on October
28th, 2015.
The following figures show the mean and typical deviation in
mentions (tone). All mentions (mentions without filtering words
nor languages) and only government mentions are displayed and
compared. Blue bars represent mean values in tone, black ones
represent error bars. According to Fig. 1 and its histogram in Fig. 3,
the average index of the mentions due to fuel and energy prices are

Fig. 2. Mentions for “FUELPRICES” theme in Spain filtering words
(government mentions).

Fig. 3. Histogram - All mentions for “FUELPRICES” theme in Spain.

- 40 -

Special Issue on Big Data & AI
to the government. However, once we filter for words related to the
government, the negative tone appears much more clearly.

Fig. 4. Histogram - Mentions for “FUELPRICES” theme in Spain filtering
words (government mentions).

In order to be able to use these data and conduct some test on them,
we first check whether the indexes are normally distributed. figures 5
and 6 present Q-Q plots, which are probability plots, i.e., a graphical
method for comparing two probability distributions by plotting their
quantiles against each other. Here, we use Q-Q plot to compare
data against Normal Distribution with mean and standard deviation
according to the sample. Formally, the Shapiro-Wilk test [14] allows
us to reject normality. For all data samples mean values are near to
zero while typical deviation values are between 0.7 and 1.7. A normal
distribution is symmetric about its mean, but this is not the case, and,
taking into account the figures, we detect some extreme positive values
which are balancing out a more frequent negative values and, for this
reason, the mean tone in close to zero.

Fig. 7. All mentions for “ENV_SOLAR” theme in Spain.

Fig. 8. Mentions for “ENV_SOLAR” theme in Spain filtering words
(government mentions).

Fig. 5. Q-Q Plot - All mentions for “FUELPRICES” theme in Spain.

Fig. 9. Histogram – All mentions for “ENV_SOLAR” theme in Spain.

Fig. 6. Q-Q Plot - Mentions for “FUELPRICES” theme in Spain filtering words.

Next, we conduct a similar exercise but filtering in GDELT a
different theme than before. So, we include environment and solar
(“ENV_SOLAR” theme) to the previous exercises and analyze tone
in the same way. We can see than the sentiment index does provide
some negative tone messages when we do not filter using words related

Fig. 10. Histogram – Mentions for “ENV_SOLAR” theme in Spain filtering
words (government mentions).

- 41 -

International Journal of Interactive Multimedia and Artificial Intelligence, Vol. 3, Nº6
tone collected by MeanALLFuel is not significantly different from zero
at standard levels. Public opinion could to some extent weakly affect
fuel prices and, indirectly, fuel demand in the short-term.

C. CTM results using CTM algorithm

Fig. 11. Q-Q Plot – All mentions for “ENV_SOLAR” theme in Spain.

Despite the graphic, Shapiro-Wilk normality test produces no
suspicion about normality. But the mean tone, although is close to zero,
is negative.

In this subsection we present the results obtained using a CTM
algorithm to discover and correlate topics. We must note that we
only have applied the algorithm to Spanish texts. The R package
“topicmodels” allow us to display the graphs collected in Fig. 14. For
the theme named “FUELPRICES” and text written in Spanish, the
cluster Group 1 corresponds to HTML tags or other words that have
not been properly removed or English words that appear in texts that
“textcat” R package has been classified as written in Spanish. On the
other hand, clusters named Group 3 and 6 refer to words like (translated
from Spanish) “stock exchange”, “market”, “government”, “income”,
“Europe”, “state”, “congress”…, “gas”, “price”, “growth” and other
Spanish locations as “Madrid” or “Barcelona” are words contained in
the rest of the groups.

Fig. 14. Using “topicmodels” R package. “FUELPRICES” theme, text written
in Spanish.

Fig. 12. Q-Q Plot – Mentions for “ENV_SOLAR” theme in Spain filtering
words.

B. Correlation analysis: Prices and Demand
