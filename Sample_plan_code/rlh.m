function X=rlh(n, k, Edges)
% Generates a random Latin hypercube within the [0,1]＿k hypercube.
%%
%Inputs:
% n 每 desired number of points
% k 每 number of design variables (dimensions)
% Edges 每 if Edges=1 the extreme bins will have their centres
% on the edges of the domain, otherwise the bins will
% be entirely contained within the domain (default
% setting).
%%
%Output:
% X 每 Latin hypercube sampling plan of n points in k
% dimensions.
if nargin < 3
Edges=0;
end
% Pre 每 allocate memory
X=zeros (n,k);
for i=1:k
X(:,i)=randperm(n)';
end
if Edges==1
X=(X-1)/(n-1);
else
X=(X-0.5)/n;
end