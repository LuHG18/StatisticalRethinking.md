# Section 4.3 Code (Not practice problems)
library(rethinking)
data("Howell1")
d <- Howell1

str(d)

d2 <- d[d$age >= 18, ]

dens(d2$height)
