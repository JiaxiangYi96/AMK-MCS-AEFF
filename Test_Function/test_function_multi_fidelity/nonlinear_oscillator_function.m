function obj=nonlinear_oscillator_function(x)
% defining the variebles
m=x(:,1);
c1=x(:,2);
c2=x(:,3);
r=x(:,4);
t1=x(:,5);
F1=x(:,6);

% calculate the Intermediate variables  
w0=sqrt((c1+c2)./m);

% calculate the objective function values
obj=3*r-abs((2*F1)./(m.*w0.^2).*sin(w0.*t1./2));

end