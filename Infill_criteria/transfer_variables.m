function obj=transfer_variables(x,mu,sigma)
% this function is used to transfer the design variables from standard
% space into the variables space

obj=x.*repmat(sigma,size(x,1),1)+repmat(mu,size(x,1),1);

end