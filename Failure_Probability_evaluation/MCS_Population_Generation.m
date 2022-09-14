function obj=MCS_Population_Generation(mu,sigma,num) 

if mu(1)==120
     mu_real=log((mu.^2)./sqrt(sigma.^2+mu.^2));
     sigma_real=sqrt(log(sigma.^2./mu.^2+1));
    Mu=repmat(mu_real,num,1);
    Sigma=repmat(sigma_real,num,1);
    search_x=lognrnd(Mu,Sigma);
    obj=search_x;
else
    Mu=repmat(mu,num,1);
    Sigma=repmat(sigma,num,1);
    search_x=normrnd(Mu,Sigma);
    obj=search_x;
end

end