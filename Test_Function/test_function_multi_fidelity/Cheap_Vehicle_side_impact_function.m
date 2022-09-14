function obj=Cheap_Vehicle_side_impact_function(x,A)
% this function is using for calculating the vehicle side impact problem
% Inputs£º x is a vector contains 7 varibles
% x1 is the floor side inner 
% x2 is the door beam
% x3 is the door belt line 
% x4 is the roof rail 
% x5 is the mat.floor side inner
% x6 is the barrier height 
% x7 is the barrier hiiting 
% Output: the regulated requirement 
x1=x(:,1);
x2=x(:,2);
x3=x(:,3);
x4=x(:,4);
x5=x(:,5);
x6=x(:,6);
x7=x(:,7);
A=2*A;
    obj=(0.489.*x1.*x4+0.843.*x2.*x3-0.0432.*x5.*x6+0.0556.*x5.*x7+0.000786.*x7.^2-0.75)-...
         A.*(0.489.*(x1-A).*(x4-A)-0.843.*(x2-A).*(x3-A)+0.0432.*(x5-A).*(x6-A)+0.0556.*(x5-A).*(x7-A)+0.000786.*(x7-A).^2-1);


end