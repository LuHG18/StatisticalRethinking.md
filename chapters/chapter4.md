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
