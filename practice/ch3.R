p_grid <- seq( from=0 , to=1 , length.out=1000 )
prior <- rep( 1 , 1000 )
likelihood <- dbinom( 6 , size=9 , prob=p_grid )
posterior <- likelihood * prior
posterior <- posterior / sum(posterior)
set.seed(100)
samples <- sample( p_grid , prob=posterior , size=1e4 , replace=TRUE )

# 3E1
sum(samples < 0.2) / 1e4

# 3e3
mean(samples > 0.2 & samples < 0.8)

#3e5
quantile(samples, 0.8)

#3e7
HPDI(samples, 0.66)


#3M1
p_grid <- seq( from=0 , to=1 , length.out=1000 )
prior <- rep( 1 , 1000 )
likelihood <- dbinom( 8 , size=15 , prob=p_grid )
posterior <- likelihood * prior
posterior <- posterior / sum(posterior)

#3M2
set.seed(100)
samples <- sample( p_grid , prob=posterior , size=1e4 , replace=TRUE )

HPDI(samples, 0.9) # finds the smallest interval containing 90% of the posterior

#3M3
s <- rbinom( 1e4 , size=15 , prob=samples )
sum(s==8)/1e4

