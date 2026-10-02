Classical economic models are not dynamically scalable to manage and maintain Big Data structures, like the GDELT one we are dealing with. A whole
new set of big data analytics models and tools that are robust in high dimensions, like the ones from machine learning, are required [19,24]. In particular

196

S. Consoli et al.

in our computational study we have chosen to rely on Gradient Boosting (GB)
[14], a well-known machine-learning approach which has been shown to be successful in various modelling problems in Economics and Finance [5,6,16,28].
Gradient boosting is a machine learning technique for regression and classiﬁcation problems, which produces a prediction model in the form of an ensemble of
weak prediction models, typically decision trees. It builds the model in a stagewise fashion like other boosting methods do, and it generalizes them by allowing
optimization of an arbitrary diﬀerentiable loss function. That is, algorithms that
optimize a cost function over function space by iteratively choosing a function
(weak hypothesis) that points in the negative gradient direction.
In particular for our implementation we have used the H2O 12 library available
for the R programming language. H2O is a scalable open-source machine learning
platform that oﬀers parallelized implementations of many supervised and unsupervised machine learning algorithms, including Gradient Boosting Machines.
In addition, to determine the optimal parameter values of our GB model,
we have used a 10-fold cross-validation together with a grid search (or parameter sweep) procedure [3]. Grid search involves an exhaustive searching through
a manually speciﬁed subset of the hyperparameter space of the learning algorithm, guided by some performance metric (like in our case minimizing the mean
squared error mean). The main parameters to optimize in our GB model are the
maximum tree depth, which indicates the the maximum possible depth of a tree
in the model and is used to control over-ﬁtting, as higher depth will allow model
to learn relations very speciﬁc to a particular sample; and the learning rate,
which determines the impact of each tree on the ﬁnal outcome of the GB model.
GB works by starting with an initial estimate which is updated using the output
of each tree; the learning rate parameter controls then the magnitude of this
change in the estimates. Therefore, lower values are generally preferred as they
make the model robust to the speciﬁc characteristics of the tree and thus allowing it to generalize well. However lower values would require higher number of
trees to model all the relations and will be computationally expensive.
To explore the hyperparameters space looking for optimal values of these
parameters, the grid search procedure tests the GB model with values going
from 1 to 10 (by steps of 1) for the maximum tree depth parameter and from
0.01 to 0.99 (by steps of 0.10) for the learning rate parameter, the best parameter values with respect to the mean squared error are produced as output. In
the case that one of the produced parameter values reaches one of the related
upper or lower bound, i.e. corner solutions, a greedy approach is iterated. The
search boundaries of the speciﬁc parameter are perturbed, and the grid search
procedure is restarted from the sub-optimal parameters coming from the previous estimation. The procedure halts when both produced parameter values fall
inside the related search boundaries, giving these parameter values as output.
Although grid search does not provide an absolute guarantee that it will ﬁnd
the global optimal parameter values, in practice we have found it to work quite
12

R Interface for the “H2O” Scalable Machine Learning Platform: https://cran.rproject.org/web/packages/h2o/index.html.

Using the GDELT Dataset to Analyse the Italian Sovereign Bond Market

197

well, despite to be quite computationally expensive. In general grid searching is
a widely adopted and accepted procedure for this kind of tuning tasks [3].
4.4

Experimental Analysis
