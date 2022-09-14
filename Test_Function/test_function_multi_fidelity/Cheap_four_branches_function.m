function obj=Cheap_four_branches_function(x,A)
% which is a rare probability problem 
% the failure failure probability is  2.2212x10^-4 with 10^7 MCS samples
x1=x(:,1);
x2=x(:,2);

%  the four branches
g1=3+(x1-A*x2).^2/10-(A*x1+x2)./sqrt(2);
g2=3+(x1-A*x2).^2/10+(A*x1+x2)./sqrt(2);
g3=(x1-0.9*x2)+7/sqrt(2);
g4=-(x1-0.9*x2)+7/sqrt(2);

g=[g1,g2,g3,g4];

obj=min(g,[],2);

end