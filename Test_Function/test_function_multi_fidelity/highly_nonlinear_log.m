function obj=highly_nonlinear_log(x)
x1=x(:,1);
x2=x(:,2);
x3=x(:,3);
x4=x(:,4);
x5=x(:,5);
x6=x(:,6);
obj=x1+2*x2+2*x3+x4-5*x5-5*x6+0.001*sum(sin(100*x),2);


end