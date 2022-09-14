function obj=multimodal_function(x)
% x1 and x2 is the input variables 

x1=x(:,1);
x2=x(:,2);
y=((x1.^2+4).*(x2-1))./20-sin((5.*x1)./2)-2;

obj=-y;

end