function obj=Cheap_highly_nonlinear_log(x,A)
x1=x(:,1);
x2=x(:,2);
x3=x(:,3);
x4=x(:,4);
x5=x(:,5);
x6=x(:,6);
obj=2*x1+x2+2*x3+x4-5*x5-5*x6+0.01*sum(sin(A*100*x),2);


end