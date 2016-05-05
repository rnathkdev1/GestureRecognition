function p=recognizePattern(mean,covariance,x)

[n,~]=size(covariance);

coef=1/((2*pi)^(n/2)*sqrt(det(covariance)));
delta=x-mean;
p=coef*exp(-0.5*delta'/covariance*delta);




end
