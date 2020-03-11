
## Best fit line

# We check the x and y are column vectors.


# Generate Random Numbers or Read from file -------------------------------


x <- rnorm(10)
y <- 0.87*x+rnorm(10, sd=0.1)

plot(x,y)

if (length(x) != length(y)) {
  warning(" X size not equal to Y size, check the elements NA!")
 
}

# Solve the least squares problem, A*x ~= b.

fit <- lm(y ~x)

# Summary -----------------------------------------------------------------
residuals(fit)


summary(fit)

# Plot Results ------------------------------------------------------------

x0 <- seq(min(x), max(x), length = 5)  ## prediction grid
y0 <- predict.lm(fit, newdata = list(x = x0))  ## predicted values
lines(x0, y0, col = 2)  ## add regression curve (colour: red)
