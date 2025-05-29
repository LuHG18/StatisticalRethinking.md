# Chapter 1: Golems of Prague

### Section 1.2
**Defintions**
- Hypothesis (high-level/vague) - an idea or belief we want to evaluate
  - ex: My car is out of gas
- Process Model (concrete mechanisms/assumptions) - an explanation of what would happen if the hypothesis were true
  - if the car is out of gas, the engine won't start
- Statistical Model (measurable test) - a specific pattern you look for in the data that would be expected if the process model were true
  - i turn the key and car will not start

**Core Idea**

> The frequentist statistical method tests models as if there's only one process behind them.
>
>This is not a valid approach.

Consider the car example where there is not only one process model. We could have an issue with the battery which would explain why the engine won't start. Thus, we cannot draw a strong conlcusion from the fact that the car did not start.

In frequentist methods, we have the idea that we can never really *prove* a hypothesis is true - we can only rule out an idea by showing it is false.

To this end, we develop a **null hypothesis** which assumes the opposite of what we want to show. For example, instead of trying to prove the car is out of gas, we say:

>"$H_0$: The car has gas and is working fine."

With this hypothesis, we develop a process model and then a statistical method.

Now when we turn the key and the car doesn't start, we say:

>"If the car *should* start if it has gas, this result falsifies the null."

But as was shown above, in many scenarios we cannot be sure *which* model caused the pattern that we observed.

We can think of an example with only one plausible process model, and in this case the method presented above would work well.

> $H_0$: The car is out of gas."

Our process model would then be:

> "If the car is out of gas, then it won't start when I turn the key."

Test:

> You turn the key, and the car starts.

**Core Idea**

> Falsification doesn't work because hypotheses themselves are too difficult to represent in a model. There are too many relations ("many models correspond to the same hypothesis, and many hypotheses correspond to a single model").
>
> Even the aspect of measuring the data that we use to falsify a model is complex and not concrete.

We've already shown the complex relations above in an example, but to the point about measurement, even if data "rejects" a model it could be debated that (1.) the data is noisy (2.) the wrong measurement was made or (3.) assumptions about the variance or distribution are incorrect.

EX:

A feature for a new app is being launched.

> $H_0$: The feature has no effect - users come back at the same rate as before."

After developing a process model, when a statistical test is selected (t-test, regression etc.), assumptions are inherently made.

> Think: the variation in user behavior follows a normal distribution or is stable across different demographics or the user decisions are independent of each other.

We could easily think of how any of these could be violated in certain situations.

These are assumptions that the statistical model might rely on, and thus if they are broken our model of choice provides no guarantees.

From the book, in page 4


McElreath gives more [examples](https://civil.colorado.edu/~balajir/CVEN6833/bayes-resources/RM-StatRethink-Bayes.pdf#page=21) to get across the idea that the falsification approach is heavily flawed, but they are intuitive to understand and further enforce the ideas from above.

