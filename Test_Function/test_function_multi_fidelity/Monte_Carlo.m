
clc
clear

test_function='highly_nonlinear_log';
% import the basic information of the test function
[num_vari,z,mu,sigma,design_space]=test_function_multi_fidelity(test_function);
for ii=1:30
    ii
    num_search=10^6;
    search_x=MCS_Population_Generation(mu,sigma,num_search);
    search_y=feval(test_function,search_x);
    num_real=sum(search_y<0);
    pf_real=num_real/num_search;
    cov_real=sqrt((1-pf_real)/(num_search*pf_real));
    result(ii,:)=[pf_real cov_real];
end
