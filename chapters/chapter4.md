# Linear Models

### Section 4.1

The author first explains the principles of the Central Limit Theorem... summing up random fluctuations will lead to a normal distribution.

The basic idea is that the Normal Distribution results in cases where we add up lots of small, independent effects.

Things like measurement errors, variation in temperatures every day, and exam scores all ultimately "forget" the underlying process.

EX: a student answering 100 questions on a test has some influence on the outcome of their result based on a number of factors (preparedeness, mental fortitude, etc), thus maybe the student get 95 questions correct but when we — but when we zoom out, each question was influenced by those small, independent factors. When these are aggregated over the whole population, a bell-shaped distribution often emerges.

Additionally, multiplying small numbers together resembles addition... meaning they also tend to converge to a normal distribution.

We see the Gaussian distribution again on the log scale in the case when we multiply large numbers. This is because adding logs is the same as multiplying the original numbers.

> Using the Gaussian is an expression of our state of ignorance.

We use it when all we can conjure up is the mean and variance... it doesn't perform well in many contexts.

However, we use it as our baseline because many processes are represented well by it

**Definitions:**
- Probability Mass Function -> probability distributions with only discrete outcomes.
- Probability Density Function -> probability distributions with contionus outcomes.

### Section 4.2

> The language for describing models.

We have five main components that we assign in four steps:

The **first** step is defining our variables of which there are two types:
- the **outcome** variable(s) is what we are trying to predict with our model
  - a students test score
- the **predictor** variable(s) is what we use to understand the outcome
  - hours studied, IQ, intelligence of the person sitting next to them etc.

The **second** step is finding the likelihood function that represents our outcome:
- test scores are roughly normally distributed

In the **third** step, we put everything together in that we need to show how the variables and likelihood function from steps 1 and 2 are related:
- the output score follows a normal distribution where the parameters of the distribution (mean and variance) are found by some linear combination of our predictor variables
  - $ \text{score}_i \sim \text{Normal}(\alpha + \beta \cdot \text{hours}_i, \sigma) $
    - the parameters $\alpha$, $\beta$, and $\sigma$ are what we want to infer -> they tell us the relationship between the predictor variables (hour studied etc) and the outcome variable (final score)
    - $\alpha$ represents the baseline score a student expects from zero study hours
    - $\beta$ represents the increase in test scoer for each hour studied
    - $\sigma$ represents the variability in scores not explained by studying

The **fourth** step of setting up a model is to take each of the variables from before and assign them a **prior**.
- this allows us to give some information about the parameters before observing data
- in previous years, the average test score was 80% with a standard deviation of 10%
  - $ \mu \sim \text{Normal}(70, 10) $
  - $ \sigma \sim \text{Exponential}(1/10) $
    - this is kind of meta but we have a variance for our mean and then represent the actual variance separately
    - both the mean and the standard deviation could vary from our estimate

The format typically defines the likelihood first which will show how each variable is involved.

The following lines will define the priors for each variable.

### Section 4.3

Next, we need to understand how to implement the above steps.

After we've defined our variables from step 1, step 2 requires us to determine a likelihood function for the outcome variable.

This task is not as simple as saying we have a Gaussian distribution... the variables of the distribution (mean and variance) must also be modeled correctly.

This is difficult because we are often uncertain about the true shape of our outcome.

SO... we basically admit that we're not going to be able to perfectly represent this likelihood function. Instead we try different values for the mean and variance (or whatever params) and determine their plausibility based on the data. Giving us *another* distribution representing the different values for our params for our actual distribution.

Copying and pasting this excerpt because it explains it best:

> There are an infinite number of possible Gaussian distributions. Some have small means. Others have large means. Some are wide, with a large $\sigma$. Others are narrow. We want our Bayesian machine to consider every possible distribution, each defined by a combination of $\mu$ and $\sigma$, and rank them by posterior plausibility. Posterior plausibility provides a measure of the logical compatibility of each possible distribution with the data and model.


EX: Looking at height data for a population, we want to model it.

First we determine our outcome variable to be height. We now need a likelihood function.

> To begin, we skip the predictor variable step since we are just trying to learn about the base model structure of our outcome variable before worrying about prediction. This is common practice. **Once we determine our "true" likelihood, we will express it in terms of our predictors.**

We begin with plotting the raw data:

![alt text](/images/6.png)

Our data looks roughly Normal, but the author cautions to not just go off of what the raw data looks like... we could have multiple distributions within our population (think male and female data etc.).

With that said, we are usually okay to use a Normal distribution due to our comments from section 4.1.

> Recognize we use the Gaussian not just because the raw data "looks Normal", but because of our modeling assumptions and what we know about the data generating process.

We can now set up our model using our knowledge from section 4.2:

$$
\begin{aligned}
h_i &\sim \text{Normal}(\mu, \sigma) \\\\
\mu &\sim \text{Normal}(193, 20) \\\\
\sigma &\sim \text{Uniform}(0, 50)
\end{aligned}
$$

Recognize the first line as our likelihood function for our outcome and the following lines are the priors for our parameters.

The priors use whatever basic knowledge we can give the model (I am 193 cm so I went with this) and then the prior for the standard deviation just needs to be set as a positive value.

**Prior Distribution for $\mu$**
![alt text](/images/1.png)

**Prior Distribution for $\sigma$**
![alt text](/images/2.png)

Notice we didn't specify any sort of prior for our outcome variable height, but in a downstream way by specifying these priors that feed into the distriubtion for height, we imply a prior distribution which we can find by sampling.

By taking 10,000 samples from the $\mu$ prior and 10,000 samples from the $\sigma$ prior, and then taking 10,000 samples for the height distribution using these results from the priors.

![alt text](/images/3.png)


Now, we can use the priors for our parameters and our data along with Grid Approximation to estimate the posterior distribution over the parameters of the model.

This is a heatmap of our posterior distribution.

![alt text](/images/4.png)

To learn more about our posterior, we can sample from it and do all the stuff we did in [chapter 3](chapter3.md#chapter-3-sampling-the-imaginary).


Next, we use MAP ([quadratic approximation](chapter2.md#section-24)) with our priors and likelihood function to get a result for our two parameters.

This code will live in the [practice folder](/practice/ch4.R).

```
# Define the model

flist <- alist(
  height ~ dnorm( mu , sigma ) ,
  mu ~ dnorm( 178 , 20 ) ,
  sigma ~ dunif( 0 , 50 )
)

# Fitting a quadratic approximation
m4.1 <- map( flist , data=d2 )

# Display results
precis(m4.1)
```

```
        mean   sd   5.5%  94.5%
mu    154.61 0.41 153.95 155.26
sigma   7.73 0.29   7.27   8.20
```

However, if we change our prior to have a tighter variation of 0.1, we get an interesting result:

```
# We cam define and fit the model in one call
m4.2 <- map(
  alist(
    height ~ dnorm( mu , sigma ) ,
    mu ~ dnorm( 178 , 0.1 ) ,
    sigma ~ dunif( 0 , 50 )
  ) ,
  data=d2 )

precis( m4.2 )
```

```
        mean   sd   5.5%  94.5%
mu    177.86 0.10 177.70 178.02
sigma  24.52 0.93  23.03  26.00
```

If we take a look at the distribution of the updated prior:

![alt text](/images/5.png)

By changing the variation, our prior has become a lot more *informative* and without more data, the MAP will fit more closely to what we told it.

> Our confidence in our prior is reflected in the $\sigma$ value.

We sample from a multivariate model like this using a variance-covariance matrix. This is because there is some interaction between the parameters now that we have a joint distribution and we need to quantify the influence of each one.

**Note:**
There is a distinction to be made about how well the Gaussian models the mean versus the standard deviation. Largely it has to do with the fact that $\sigma \gt 0$ and thus we end up with a right skew (non-normal) distribution. This is all well and good in the GA and MCMC cases because we make no assumptions about the posterior. However, in QA we assume to the posterior is normal in order to do our operation of finding the peak. We typically solve this by modeling $\log{\sigma}$ which belongs in the entire real continuous range and tends to be more normal.


### Section 4.4

To recap, we've been trying to determine a most representative likelihood of height.

To this point, it has looked like this:

$$
\text{height}_i \sim \mathcal{N}(\mu, \sigma)
$$

With that we treated $\mu$ and $\sigma$ as unknown parameters and our goal was to just estimate these values the best we could with the observed data (and our priors).

We were assuming that all centered around a single average height and we wanted to find it.

Now, we introduce a predictor variable with the goal of being able to update our $\mu$ for different people given the value of the predictor — we are using weight.

Thus, our likelihood for height looks like this:

$$
\text{height}_i \sim \mathcal{N}(\mu_i, \sigma)
$$

The change looks small but it represents that our $\mu$ is now expressed linearly like this:

$$
\mu_i = \alpha + \beta \cdot \text{weight}_i
$$

We have made up these $\alpha$ and $\beta$ parameters to represent this relationship. Parameters can be rearranged in different ways — it is completely up to you. However, by defintion of a linear regression, this is how we represent it. The linear relationship is conventional but is not a requirement.


To reflect uncertainty about the slope β, we place a prior on it:

$$
\beta \sim \mathcal{N}(0, \sigma_\beta)
$$

Suppose we start with \( \sigma_\beta = 10 \). This wide prior expresses a very weak assumption, allowing $\beta$ to plausibly take on a large range of values, including strong positive or negative relationships.

At \( \sigma_\beta = 1 \), the prior becomes strongly peaked at 0, making large deviations from 0 highly implausible unless there's strong evidence in the data.

This "shrinking" effect causes the model to default toward a conservative belief that there's little to no relationship between weight and height—**unless the data firmly push it otherwise**.

Thus, decreasing \( \sigma_\beta \) builds conservatism directly into the model, acting as a form of regularization that stabilizes estimates.


**Guideline for Setting Priors: **

> We can generate data from a prior distribution (the same way we do from the posterior distribution)

A general rule of thumb for determining priors is that the results we get from generating should make sense for our domain: height and weight should be positive etc.

But let it be flexible so we can still learn.


To find the contrast between two variables, find the contrast of the distributions.

DO NOT find the mean of each distribution first and then the difference.


There is a difference between simulating the mean value for a parameter for an input of the predictor variable and simulating actual possible oberved outcomes based on the given input.

The first gives the expected mean height $\mu$ at each weight.

For each draw of $\alpha$ and $\beta$ it computes the $\mu = \alpha + \beta*\text{weight}$. The result is a grid of means, but we're not introducing randomness at all.

To do the second, for each $\mu$ we grab a $\sigma$ at the same time as teh $\alpha$ and $\beta$. Then, we can use all these values to sample a height from $\mathcal{N}(\mu, \sigma)$.

A solid analogy is that the first is like predicting the average test score for a student based on hours studied.

The second is like generating an actual test score for the student, adding randomness.