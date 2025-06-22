# Small Worlds and Large Worlds

> Bayesian models are created inside of an environment that is controlled by us.

We define the variables and make sure it performs appropriately under the assumptions we also create.

The environment is defined as completely as possible to model the real world.

> When the model is deployed, it is placed outside of this perfect context... thus it will fail at times.

### Section 2.1

> To perform Bayesian inference, a good start is to explore every possible decision we can make and subsequent decisions that follow.

The idea is that as we learn what results actually occur, we begin to "prune" off.

![alt text](/images/image-2.png)

In the forking forest of marbles example, the author illustrates every possible path if we know that the marbles are BWWW, and then we "prune" impossible paths based on the fact that we pulled BWB.

*Note we are saying that after each pull we put the marble back in the bag and can potentially pull it again. The ordering is most important in this example.

![alt text](/images/image-3.png)

The author notes that in 3/64 paths we get the desired BWB sequence.

The idea is that based on the setup of our bag, we can assign probabilities to those scenarios. For example, if we had BBBW, then we would have 9/64 paths being BWB.

Look at this chart and convince yourself how to compute the number of possibilities without drawing the garden.

![alt text](/images/image-4.png)

At each step:
1. how many of the four marbles give me that marble in the sequence

BBBW
1. 3 marbles to get the first B
2. 1 marble to get the one W
3. 3 marbles to get the second B

This gives us 3 x 1 x 3 = 9 total paths.

> With this information, given we pulled BWB, we can determine which set of 4 marbles had the highest probability of being in the bag — or as McElreath says, "the relative plausibility of each conjecture." *smh*

This method can also be used to update our probability.

Say for example that after starting with BWB, we now pull another B. In order to update, we just multiply again by the ways to produce a B as demonstrated above.

The author uses this as a way of illustrating the idea of prior information. The BWB was our prior, and then with the new B we do $W_{prior} * W_{new}$ to find our $D_{new}$ which is BWBB ($D_{prior}$ being BWB).

The author makes the point that in this form of updating probability/counts, the prior data and the new data are of the same type: marbles drawn from the bag.\

However, this is not always the case for example suppose that blue marbles are worth more than white marbles such that there are three times as many BWWW as BBBW, and two times as many BWWW as BBWW. Thus our counts are updated and the probabilities change:

![alt text](/images/image-5.png)

**Shifting to Probability**

> **Distinction**: A plausibility is *unnormalized* meaning it is just a relative way to represent which hypothesis better explains the data
>
> EX: out of 9 friends 3 want pepperoni pizza and 6 want cheese. Thus, pepperoni is 1/2 as popular as cheese.
>
> A probability is *normalized*
>
> In the same example but if you want probability, you say if we picked at random, there is a 3/9 = 0.333 chance a person chooses pepperoni.

McElreath makes the point that proceeding by counting sequences is impractical.

For one, its only relative so just knowing counts of 3, 8, and 9 doesn't tell us all that much about our data. 

Second, the potential sequences grows very fast as we collect more data. For example, with ten data points we have $4^{10} = 1,048,576$ possible sequences. It makes more sense to capture "rates".

We can find these rates by simply dividing the count of each one by the sum of the other counts i.e. 3 ways for BWWW, 8 for BBWW, 9 for BBBW -> 0.15, 0.40, and 0.45 plausibility respectively.

This is technically an update; however, it was our first collection of data so technically our prior is uniform (1) for each composition. 

The general formula is: 

plausibility of p *after* $D_{new}$ = (ways $p$ can produce $D_{new}$ * prior plausibility) / sum of products

> Personal Note: do not get confused by the use of $p$ in this section... it is purely a label and does not factor into our calculations at this point although it will be later.
> Each *value* of $p$ has a plausibility which we *are* using.

**Definitions**
- Parameter: a conjectured proportion, like $p$ in the above example -> a way of indexing possible explanations of data
- Likelihood: relative number of ways a parameter can produce the data -> found by enumerating all possible data sequences and eliminating those inconsistent with the data
- Prior Probability: prior plausibility of a specific parameter
- Posterior Probability: new, updated plausibility of a parameter

### Section 2.2

EX: Given a globe representing Earth, the following strategy is adopted to determine how much of the surface is water: Toss the globe in the air and when you catch it, record where your hands are Water or Land.

In designing a Bayesian model, the author gives a three step loop:

1. Data Story
> Define our experiment to better understand how we're collecting our data/information.

Proportion of the surface that is water is $p$.
One toss has probability $p$ of producing a Water and $1-p$ of producing Land.
Each toss is independent of the others.

This step is more specific than the original hypothesis. Leading us to think more deeply about what is involved in the question.

We must consider how we will sample and how we will measure our data.

Our ultimate goal is to resolve ambiguity in how we handle the design of the experiment.

**Definitions:**
- Sampling: which observations you gather
  - EX: tossing the globe and catching it
- Measuring: what you record from those observations
  - EX: determine wheter the sampled point is Water or Land by looking at where your hand is touching blue or green


2. Update
> Re-evaluate our conjectures as we collect information.

We start off with our prior plausibilities as we have done before.

For this example, our priors are uniform, meaning for every $p$ (potential percentage of the globe that is water) there is the same plausibility of being true.

Now, if we were to toss the globe once and land on water, we update our priors to become our posteriors.

Now, we know that $p = 0$ has a plausibility of zero since we have seen some water the would must contain > 0% water. Additionally, $p > 50%$ has increased in plausibility since we have technically seen no evidence of land.

The author points out another difference at this point between typical statistical methods and Bayesian

In classical methods, there is usually a sample size requirement to be able to obtain a mathematically correct estimator.

In Bayesian, the amount of data does not affect the validity of our model. It just means we are more reliant on our original priors. This can still mislead us.

**Defintions:**
- Estimator: a rule or formula in classical stats that is applied to the data to get an estimate of some unknown quantity
  - EX: sample mean or sample std dev <- these methods are only "guaranteed" to be correct when the sample size is large
  - the difference from Bayesian is that it is always valid
    - "Given what I knew before, and what I just saw, here's what I believe now" -> the math is always coherent


3. Evaluate
> Make sure that shit is right.

No point in going too in detail here... the author says we go into specifics later.

### Section 2.3
> 3 Main Components: Likelihood, Parameters, Priors

1. Likelihood
> The score of our hypothesis based on how well it explains the data we've experienced.

Given some prior $p$ that says 50% of the world is water, we use our likelihood function to determine how "likely" that reality is.

**Defintions**
- Likelihood function: tool to score our hypotheses
  - From our marble example before, it tells us the relative number of ways each conjecture could produce an observation.
  - EX: The binomial distribution is a good model for a binary method like our globe tossing scenario.
    - this is because each toss is independent of each other AND the probability is the same on each toss
    - if the globe is tossed 9 times and we get 6 waters we can do the equation below

$$
L(p) = P(\text{6 waters in 9 tosses} \mid p) = \binom{9}{6} p^6 (1 - p)^3
$$

Remember this equation as it is just one part of the larger equation we use to determine our final result.

Likelihood is often represented in the following way:
$$
L(p|w,n)
$$

Which translates to "the likelihood of $p$ given the observations $w$ and the number of data points $n$"

2. Parameters
> Represent our conjectures from before.

The $p$, $w$, and $n$ are all parameters.

Parameters can be estimated from data.

In the globe toss, $n$ and $w$ are the data and we try to estimate $p$, but this is not always the case.

3. Priors
> The initial plausibility we define for each parameter that we wish to estimate.

This is represented as a probability distribution. Thus, it needs:
1. to cover all possible values the parameter could take
2. assign a plausibility to each of those values
3. be normalized (add up to zero)

In the examples above we used uniform priors, meaning we gave equal plausibility to each possible value, which is represented by a uniform distribution.

This allows the engineer to use any information they have about the parameter ahead of time, ultimately given guard rails (constraints) for the parameter estimation.

When designing an experiment, the prior is just another aspect that needs to be tuned and worked with to see what works best, even different probability distributions could be tried.

4. Posteriors
> The consequence of the steps from above.

The posterior is deterministic given a prior, likelihood, and parameters, although it *represents* uncertainty.

Similar to the prior, the posterior is also a probability distribution.

> Given what was believed prior and the data that was just observed, the posterior tells us how plausible each value of the parameter is now.


We had some prior belief about a parameter. Say we had three values for $p$ and with a uniform distribution they all had a prior of 1/3.

We now take the result from our likelihood.
- remember from above this was based on the distribution we thought best reflected our data -> this is the tool that powers our model

Take our 6 waters in 9 globe tosses, we can run the binomial function which gives us likelihoods for each value of $p$.

To find our posteriors, we multiply this likelihood output by the prior (1/3 in this case) which will give us updated plausibilities for each value of $p$, essentially creating a new distribution.

To effectively make this a probability distribution however, we need to normalize each result.

We do this by dividing this product by the sum of all potential values of our product.
Just think about it and it makes sense. If we have three differently sized parts of something and we want to determine one parts percentage of the whole thing, we gotta it divide by the sum of the parts. This is easy for discrete values since we can just sum, but for continuous values we have to take an integral.

In the continuous case parameters can take on an infinite number of values and not just a few discrete ones. The equation looks like this:

$$
\text{Posterior}(p) = \frac{P(D \mid p) \cdot P(p)}{\int_0^1 P(D \mid p) \cdot P(p) \, dp}
$$

The denominator expresses the total plausibility of the data, considering every possible value of $p$, weighted by the prior belief.


### Section 2.4

We begin looking at various methods of testing parameters.

The first is **Grid Appoximation**

Very simple.

Just pick a set of plausbilities for a parameter along with a prior for each one (probably uniform to start in our examples so far).

Calculate the likelihood value for each of the plausibility values we gave, so we now have a new value in each spot of the "grid".

Then, we multiply the likelihood at each point in the grid by its corresponding prior to get a set of posterior values.

Finally, we standardize them by dividing each point in the grid by the sum of the entire grid.

We can plot the final value (y) at each initial plausbile value (x) to get a graph of our posterior distribution.

This isn't used much in the practical applications because it scales poorly.

Think about the case where we have two parameters. My first thought was OK if we need to handle two parameters we can just have a second grid so it would be two times the amount of approximations made.

This is not the case. 

When we think about multiple parameters, we can say that the params are unrelated before seeing any data. However, once data is introduced the parameters can become correlated.

Because of this we need a joint grid to explore combinations.

A 2D grid would thus require the amount of approximations made before *squared*.

Next option is **Quadratic Approximation**

This stems from the idea we started in the grid approximation where we will ultimately create a posterior distribution that looks something like this:

![alt text](/images/image-7.png)

This distribution doesn't stick out as anything in particular, but if we look closer:

![alt text](/images/image-9.png)

That looks a bit more like a typical Gaussian distribution.

The idea behind the quadratic approach is that we can determine the point in the posterior distribution with the highest likelihood (MAP -> maximum a posteriori).

Then we find the curvature of the (log of the) posterior to determine how "wide" or "narrow" the peak of the distribution is — the standard deviation.

Let's do an example to show this:

1. Step 1: Find the Unnormalized posterior which we've done before
   1. Unnormalized posterior: $P(p|D) ∝ P(D|p) * P(p)$
   2. Likelihood: $P(D|p) = \binom{9}{6} p^6 (1-p)^3$
   3. Prior: $P(p) = 1$
   4. Unnormalized posterior: $P(p|D) ∝ p^6(1-p)^3$
2. Step 2: Take the log of the posterior we found in step 1
   1. $log(P(p|D)) = 6logp+3log(1-p)$ (ignore constants)
3. Step 3: Find the posterior mode
   1. Take the derivative of the log expression
      1. $\frac{6}{p} - \frac{3}{1-p}$
      2. $p=\frac{2}{3}$ <- the MAP
4. Find the standard deviation
   1. Take second derivative of the log expression (not solving this shit lmao)
   2. plug in our MAP to find the "curvature"
   3. the variation is found by taking $\frac{1}{|curvature|}$
      1. inverse relationship -> as the sharpness of the curvature increases, the "wideness" (variation) of the distribution increases
   4. take the square root to find the standard deviation


Finally, we have **Markov chain Monte Carlo**.

Not much detail here.

Premise is that when we have multi-level models with thousands of parameters GA obviously isn't practical. QA works in some cases but often does not due to the inability to define a unified function for the posterior distribution.

Thus, we turn to MCMC which works indirectly by drawing samples from the posterior which gives us the frequencies of various parameter values which correspond to posterior plausibilities.

More detail in Chapter 8.