function X=fullfactorial(q, Edges)
% Generates a full factorial sampling plan in the unit cube
%%
% Inputs:
% q 每 k 每 vector containing the number of points along each
% dimension
% Edges 每 if Edges=1 the points will be equally spaced from
% edge to edge (default), otherwise they will be in
% the centres of n=q(1)? q(2)?    q(k) bins filling
% the unit cube.
%% Output:
% X 每 full factorial sampling plan
if nargin < 2, Edges=1; end
if min(q) < 2
error('You_must_have_at_least_two_points_per_dimension.');
end
% Total number of points in the sampling plan
n=prod(q);
% Number of dimensions
k=length(q);
%Pre每allocate memory for the sampling plan
X=zeros(n,k);
%Additional phantom element
q(k+1)=1;
for j=1:k
if Edges==1
one_d_slice =(0:1/(q(j)-1):1);
else
one_d_slice =(1/q(j)/2:1/q(j):1);
end
column=[];
while length(column) <n
for l=1:q(j)
column=[column; ones(prod(q(j+1:k)),1)*one_d_slice(l)];
end
end
X(:,j)=column;
end