function obj=Cheap_multimodal_function(x,A)
% x1 and x2 is the input variables 

x1=x(:,1);
x2=x(:,2);
% y=((x1.^2+4).*(x2-1))./20-sin((5.*x1)./2)-2;

obj=-((((x1-4*A).^2+4).*((x2-A)-1))./20-sin((5.*x1-2*A)./2)-2)-sin(5/22*(x1+x2/2)+1.25);

end