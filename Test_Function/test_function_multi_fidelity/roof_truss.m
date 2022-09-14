function obj=roof_truss(x)
q=x(:,1);
l=x(:,2);
As=x(:,3);
Ac=x(:,4);
Es=x(:,5);
Ec=x(:,6);


%
obj=0.030-q.*l.^2/2.*(3.81./(Ac.*Ec)+1.13./(As.*Es));
end