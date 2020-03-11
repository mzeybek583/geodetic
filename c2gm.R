


# Cartesian coordinates to the geographic coordinates ---------------------


# Params
#GRS80
library(matlab)

a <- 6378137
f <- 1/298.257222101
b <- 6356752.3141


# Cartesian Coordinates Input (X , Y , Z) ---------------------------------------------
# WGS84

X <- 3583454.81330  
Y <- 3206040.31456
Z <- 4177515.50939


# Calculations ------------------------------------------------------------


lambda <- atan2(Y,X);
ex2 <- (2-f)*f/((1-f)^2);
c = a*sqrt(1+ex2);
p <- sqrt(X^2+Y^2)
phi = atan(Z/((p*(1-(2-f))*f)));


# Iteration of Phi --------------------------------------------------------


h = 0.1; oldh = 0;
while (abs(h-oldh) > 1.e-12) {
  oldh = h;
  N = c/sqrt(1+ex2*cos(phi)^2);
  phi = atan(Z/((p*(1-(2-f)*f*N/(N+h)))));
  h = p/cos(phi)-N;
}
phi = phi*180/pi;


# Results -----------------------------------------------------------------


b = zeros(1,3);
b[1] = fix(phi);
b[2] = fix(rem(phi,b[1,1])*60);
b[3] = (phi-b[1,1]-b[1,2]/60)*3600;
lambda = lambda*180/pi;

l = zeros(1,3);
l[1] = fix(lambda);
l[2] = fix(rem(lambda,l[1,1])*60);
l[3] = (lambda-l[1,1]-l[1,2]/60)*3600;


# Printing to the screen --------------------------------------------------

cat(sprintf('\n     phi = %5.6f\n',phi))
cat(sprintf('\n     lambda = %5.6f\n',lambda))
cat(sprintf('\n     h = %5.6f\n',h))

cat(sprintf('\n     phi = %3.0f %3.0f %8.5f\n',b[1],b[2],b[3]))
cat(sprintf('\n  lambda = %3.0f %3.0f %8.5f\n',l[1],l[2],l[3]))
cat(sprintf('\n       h = %14.3f\n',h))
