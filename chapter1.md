# Chapter 1: Golems of Prague

### Section 1.2.1
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

### Section 1.2.2


### Questions:
- What is a process model?
- 