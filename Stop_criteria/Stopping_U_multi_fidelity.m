function obj=Stopping_U_multi_fidelity(x,kriging_model_lf,kriging_model_discrepancy)

[y,mse]=estimated_value(x,kriging_model_lf,kriging_model_discrepancy);
mse=sqrt(mse);
% compute the value of U
U=abs(y./mse);
% find out the samples whose U value is less than 3
X_u=x(find(U<=3),:);
X_f=x(find(y<0),:);

% compute the probability failure 
[U_y,U_mse]=estimated_value(X_u,kriging_model_lf,kriging_model_discrepancy);
U_mse=sqrt(max(0,U_mse));
% calculate the probability of failure
X_temp=-abs(U_y./U_mse);
p_fail=Gaussian_CDF(X_temp);
% P_fail=normcdf(0,Safe_y,Safe_mse);
mu_fail=size(X_u,1)*mean(p_fail);

obj=mu_fail/size(X_f,1);




end