# Chapter 3: Sampling the Imaginary
> Sampled data is much easier to work with than a posterior distribution.

Instead of thinking of something in terms of its probability of happening, we can instead pull samples from its distribution and think of it in terms of tangible values.

The author calls this the **frequency approach**, and it allows us to approach problems in new ways.

### Intervals with Boundaries

An example of this is needing to find the probability of a distribution in an interval (for example P(0.5 < X < 0.75)). The traditional approach would be to use an integral which depending on the number of parameters can be a difficult problem.

Say however we pull 10,000 samples from a given complicated distribution, we can easily add up the samples within a certain range and divide by the total samples (10k in our case) to get this (approximate) same value.

### Intervals of Defined Masses

We could also have the question of what points in our distribution contain the middle 50% or middle 80% of our data. These are called **Percentile Intervals**.

There is another interval called the **Highest Posterior Density Interval** which is the narrowest interval containing the specified probability mass of our data. This will be most in contrast to our typical PI in a highly skewed posterior distribution.

> We use intervals to help summarize our data... if different interval types give wildly different results then maybe thats not the best way to summarize our data.
>
> Just plot the whole thing maybe.

### Point Estimates

This is kind of an odd task to take one point that represents our posterior distribution... largely because that's kinda what the distribution itself is for.

The first thought I had was to use the MAP which as we know is the max of a distribution.

But what about using the mean or the median of the distribution to represent it?

The answer that the author gives is: it depends.

The "single-value summary" should be chosen based on what we are trying to represent with it. This is best described by the concept of the **Loss Function**. The loss function quantifies how bad a decision is if it turns out to be wrong.

In the book, the author shows us that
- if we care about minimizing absolute error, the posterior median is the best.
- if we care about minimizing large (quadratic) error, the posterior mean minimizes squared error.
- if we care about picking the most likely value, the MAP is the best option.
  - a binary loss function where you incur no error if you exactly match the value, otherwise you incur a fixed loss.

> when just describing the posterior distribution, using the mean, median, and mode is fine. however, if we're making a decision to accept or reject a hypothesis then a point estimate should definitely be supported with the use of the correct loss function.



### Sampling

Every Bayesian model has the ability to generate new data.
1. able to simulate observations
2. estimate parameters from observations

We can now ask the question:

> If this model I built is true, what kind of data would I expect to see?

This is because we have a full posterior distribution we can sample from and then compare to our observed data.