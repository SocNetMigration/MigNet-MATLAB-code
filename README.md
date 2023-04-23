# Code package for the paper <br> "A model of dynamic migration networks: Explaining Turkey's inter-provincial migration flows"

This repo contains the dataset and the code that generates the results reported in the paper entitled
"*A model of dynamic migration networks: Explaining Turkey's inter-provincial migration flows*"

+ The script **main_migration.m** runs the experiments for real data.
+ The script **main_migration_artificial_data.m** runs the experiments for simulated data.

The real data are contained in the files in the directory "Inputfies". The main script automatically imports them suitably.

The experiment results are shown in figures, showing trace plots, histograms, box plots, etc. obtained from the samples generated by the MCMC algorithms.

The model is a Dirichlet-multinomial model with a hierarchical specification, where the migration probabilities have Dirichlet distributions, whose parameters are determined by a regression function. The model has a distinct intercept and a time slope parameter for each province; those parameters are themselves random, following the same distributions for all provinces. Details for those models can be found in the paper.

## Guides for using the code for other data sets

### Inference (Training)

**Algorithm 1** in the paper is an Metropolis-within-Gibbs type MCMC method to estimate the parameters of the Dirichlet-Multinomial model.

The MATLAB code for this algorithm is **MCMC_Migration.m**. To use this code for other data sets, the data must be converted in a certain format. Below are the details of that format.

The Matlab function is the form

*[Theta_samp, range_theta] = MCMC_Migration(Y, U, V, Z, year_vec, K0, theta0_common, M)*

Input data contains the migration counts and the one-way and two-way external factors regarding N provinces for T years.
 
+ *Y*: a $T \times 1$ cell array, each cell contains a $N \times N$ matrix $Y_{t}$  <br>
$Y_{t}(i, j)$: # people migrating from province $i$ to province $j$.
+ *U*: a ($T \times 1$) cell array, each cell contains a $K_{1} \times N$ matrix $U_{t}$ <br> 
$U_{t}(k, i)$: the value of the i'th feature of the i'th migration-sending province
+ *V*: a $T \times 1$ cell array, each cell contains a $K_{2} \times N$ matrix $V_{t}$ <br> 
$V_{t}(k, j)$: the value of the k'th feature of the $i$'th migration-receiving province.
+ *Z:* a $T \times 1$ cell array, each cell contains a $Z_{t}$ of size $N \times N \times L$ matrix <br> 
$Z_{t}(i, j, l)$: the value for the $l$'th feature of provinces $i, j$ 
+ *year_vec*: This is the vector of years that correspond to time steps $1, \ldots, T$
+ *K0*: the (order+1) for the polynomial for the baseline probability parameter 
+ *theta0_common*: set to $1$ for common baseline parameter, set to 0 for a distinct baseline parameter for each province
+ *M*: number of MCMC iterations 

Outputs are as follows <br>
+ *Theta_samp*: An $M \times D$ matrix of samples from the MCMC. Each column (sample) is formed as <br>
 $[\theta_{1}, \theta_{2}, \theta_{3}, \theta_{4}, \text{vec}(\theta_{0}), \mu_{0},  \text{vec}(\Sigma_{0})]$
+ *range_theta*: The range information of those components. For example, the location of $\mu_{0}$ in one column of *Theta_samp* is *range_theta{6}* (since it is the 6'th component of $\theta$.)

### Prediction (Testing)
The outputs of the function can be used on the testing data to perform prediction by using the following Matlab code

*[Y_pred, log_Y_pred, Prop_pred] = pred_migration(P, U, V, Z, year_vec, Thetas, range_theta)*

+ *P*: a $T_{\text{test}} \times 1$ cell array, each cell contains a $N \times 1$ vector $P_{t}$  <br>
$P_{t}(i)$: # population of province $i$ at time $t$.
+ *U*: a ($T_{\text{test}} \times 1$) cell array, each cell contains a $K_{1} \times N$ matrix $U_{t}$ <br> 
$U_{t}(k, i)$: the value of the i'th feature of the i'th migration-sending province
+ *V*: a $T_{\text{test}} \times 1$ cell array, each cell contains a $K_{2} \times N$ matrix $V_{t}$ <br> 
$V_{t}(k, j)$: the value of the k'th feature of the $i$'th migration-receiving province.
+ *Z:* a $T_{\text{test}} \times 1$ cell array, each cell contains a $Z_{t}$ of size $N \times N \times L$ matrix <br> 
$Z_{t}(i, j, l)$: the value for the $l$'th feature of provinces $i, j$ 
+ *year_vec*: This is the vector of years that correspond to time steps $1, \ldots, T_{\text{test}}$
+ *Thetas* and *range_theta*: These are the MCMC samples (after a burn-in time) and the range information of the components in $\theta$, both of which are outputted by the function *MCMC_Migration*.

Outputs
+ *Y_pred*: : a $T_{\text{test}} \times 1$ cell array, each cell contains a $N \times 1$ matrix $Ypred_{t}$  <br>
$Ypred_{t}(i, j)$: # prediction of number people migrating from province $i$ to province $j$ at time $t$.
+ *log_Y_pred*: a $T_{\text{test}} \times 1$ cell array, each cell contains a $N \times N$ matrix $logYpred_{t}$  <br>
$logYpred_{t}(i, j)$: # prediction of the logarithm of the number of people migrating from province $i$ to province $j$ at time $t$.
+ *Prop_pred*: a $T_{\text{test}} \times 1$ cell array, each cell contains a $N \times N$ matrix $Ppred_{t}$  <br>
$Ppred_{t}(i, j)$: # prediction of the proportion of the people migrating from province $i$ to province $j$ at time $t$.
