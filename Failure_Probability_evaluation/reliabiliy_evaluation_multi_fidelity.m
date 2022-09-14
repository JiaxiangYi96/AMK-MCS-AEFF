function [pf_estimate,pf_real,cov_estimate,real_relative_error]=reliabiliy_evaluation_multi_fidelity(search_x,mu,kriging_model_lf,kriging_model_discrepancy,test_function)
% this function is used to evaluate the performance of the current
% iteration
[num_vari,~,~,~,mu_vari,sigma_vari,~,~]=test_function_multi_fidelity(test_function);
if sum(mu == mu_vari)==num_vari
    num_search=size(search_x,1);
    search_y=estimated_value(search_x,kriging_model_lf,kriging_model_discrepancy);
    real_y=feval(test_function,search_x);
    num_fail=sum(search_y<0);
    num_real=sum(real_y<0);
    pf_estimate=num_fail/num_search;
    pf_real=num_real/num_search;
    cov_estimate=sqrt((1-pf_estimate)/(num_search*pf_estimate));
    real_relative_error=abs(pf_estimate-pf_real)./pf_real;
else
    num_search=size(search_x,1);
    search_y=estimated_value(search_x,kriging_model_lf,kriging_model_discrepancy);
    real_y=feval(test_function,transfer_variables(search_x,mu_vari,sigma_vari));
    num_fail=sum(search_y<0);
    num_real=sum(real_y<0);
    pf_estimate=num_fail/num_search;
    pf_real=num_real/num_search;
    cov_estimate=sqrt((1-pf_estimate)/(num_search*pf_estimate));
    real_relative_error=abs(pf_estimate-pf_real)./pf_real;
    
    
end


end