# Small Worlds and Large Worlds

> Bayesian models are created inside of an environment that is controlled by us.

We define the variables and make sure it performs appropriately under the assumptions we also create.

The environment is defined as completely as possible to model the real world.

> When the model is deployed, it is placed outside of this perfect context... thus it will fail at times.

### Section 2.1

> To perform Bayesian inference, a good start is to explore every possible decision we can make and subsequent decisions that follow.

The idea is that as we learn what results actually occur, we begin to "prune" off.

![alt text](image-2.png)

In the forking forest of marbles example, the author illustrates every possible path if we know that the marbles are BWWW, and then we "prune" impossible paths based on the fact that we pulled BWB.

*Note we are saying that after each pull we put the marble back in the bag and can potentially pull it again. The ordering is most important in this example.

![alt text](image-3.png)

The author notes that in 3/64 paths we get the desired BWB sequence.

The idea is that based on the setup of our bag, we can assign probabilities to those scenarios. For example, if we had BBBW, then we would have 9/64 paths being BWB.

Look at this chart and convince yourself how to compute the number of possibilities without drawing the garden.

![alt text](image-4.png)

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

