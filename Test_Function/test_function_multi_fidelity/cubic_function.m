function obj=cubic_function(x)
% x1 and x2 is the input variables 

x1=x(:,1);
x2=x(:,2);
y=x1.^3+x2.^3-18;

obj=y;

end