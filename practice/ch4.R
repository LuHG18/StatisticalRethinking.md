# Section 4.3 Code (Not practice problems)
library(rethinking)
data("Howell1")
d <- Howell1

str(d)

d2 <- d[d$age >= 18, ]

dens(d2$height)


curve ( dnorm( x , 178 , 0.1) , from=100 , to=250)


sample_mu <- rnorm( 1e4 , 178 , 0.1 )
sample_sigma <- runif( 1e4 , 0 , 50 )
prior_h <- rnorm( 1e4 , sample_mu , sample_sigma )
dens( prior_h ) 


mu.list <- seq( from=140, to=160 , length.out=200 )
sigma.list <- seq( from=4 , to=9 , length.out=200 )
post <- expand.grid( mu=mu.list , sigma=sigma.list )
post$LL <- sapply( 1:nrow(post) , function(i) sum( dnorm(
  d2$height ,
  mean=post$mu[i] ,
  sd=post$sigma[i] ,
  log=TRUE ) ) )
post$prod <- post$LL + dnorm( post$mu , 178 , 20 , TRUE ) +
  dunif( post$sigma , 0 , 50 , TRUE )
post$prob <- exp( post$prod - max(post$prod) )

image_xyz( post$mu , post$sigma , post$prob )


# Section 4.3

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



# We cam define and fit the model in one call
m4.2 <- map(
  alist(
    height ~ dnorm( mu , sigma ) ,
    mu ~ dnorm( 178 , 0.1 ) ,
    sigma ~ dunif( 0 , 50 )
  ) ,
  data=d2 )

precis( m4.2 )


plot(d2$height ~ d2$weight)



# Now we move to the linear model with a predictor
m4.3 <- map(
  alist(
    height ~ dnorm( mu , sigma ) ,
    # linear function
    mu <- a + b*weight ,
    a ~ dnorm( 156 , 100 ) ,
    b ~ dnorm( 0 , 10 ) ,
    sigma ~ dunif( 0 , 50 )
  ) ,
  data=d2 )

precis( m4.3 , corr=TRUE )

plot( height ~ weight , data=d2 )
abline( a=coef(m4.3)["a"] , b=coef(m4.3)["b"] ) # this is the MAP prediction line (a = alpha, b = beta)



N <- 10
dN <- d2[ 1:N , ] # take 10 samples
mN <- map(
  alist( # just our model def
    height ~ dnorm( mu , sigma ) ,
    mu <- a + b*weight ,
    a ~ dnorm( 178 , 100 ) ,
    b ~ dnorm( 0 , 10 ) ,
    sigma ~ dunif( 0 , 50 )
  ) , data=dN )


# extract 20 samples from the posterior (mN)
post <- extract.samples( mN , n=20 )
# display raw data and sample size
plot( dN$weight , dN$height ,
      xlim=range(d2$weight) , ylim=range(d2$height) ,
      col=rangi2 , xlab="weight" , ylab="height" )
mtext(concat("N = ",N))
# plot the lines, with transparency
for ( i in 1:20 )
  abline( a=post$a[i] , b=post$b[i] , col=col.alpha("black",0.3) )

mu <- link( m4.3 )
str(mu)



# this is a process we can use to determine the distributions over a set of predictor values and plot CIs
post <- extract.samples(m4.3) # sample 10k times from our model
mu.link <- function(weight) post$a + post$b*weight # create a funciton using the 10k samples to find mu
weight.seq <- seq( from=25 , to=70 , by=1 ) # set up a constant sequence of weight values from 25 to 70 for easy plotting, this is not our real data
mu <- sapply( weight.seq , mu.link ) # apply the function to weight values 25 to 70
mu.mean <- apply( mu , 2 , mean ) # find the average 
mu.HPDI <- apply( mu , 2 , HPDI , prob=0.89 ) # find the interval that holds 89% of our samples

