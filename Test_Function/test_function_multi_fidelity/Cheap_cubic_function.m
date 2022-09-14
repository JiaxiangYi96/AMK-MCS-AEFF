function obj=Cheap_cubic_function(x,A)
% x1 and x2 is the input variables 


x1=x(:,1);
x2=x(:,2);
y=(x1.^3+x2.^3-18)-A.*(1.5.*((x1-15).^3+2.*(x2-15).^3)-18);% +5.*(x1+x2-5)

obj=y;

end