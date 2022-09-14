function obj=Infill_Standard_AEFF(x, kriging_model_lf,kriging_model_discrepancy,z,XH,XL,num_q,t)

% basic information of the tested problem
[y, s]=estimated_value(x, kriging_model_lf,kriging_model_discrepancy);
s=sqrt(s);
e=2.*s;
% calcuate the EFF value
EFF=(y-z).*(2.*Gaussian_CDF((z-y)./s)-Gaussian_CDF((z-e-y)./s)-Gaussian_CDF((z+e-y)./s))- ...
    s.*(2.*Gaussian_PDF((z-y)./s)-Gaussian_PDF((z-e-y)./s)-Gaussian_PDF((z+e-y)./s))+...
    e.*(Gaussian_CDF((z+e-y)./s)-Gaussian_CDF((z-e-y)./s));

% this section is used to identify the candidate sample for the high fidelity
if t==0
    %Sample Density function
    %     for i = 1:size(x,1)
    %         d2=zeros(size(XH,1),1);
    %         for j=1:size(XH,1)
    %             a=x(i,:);c=XH(j,:);
    %             d2(j)=sum((a-c).^2.*(kriging_model_lf.theta+kriging_model_discrepancy.theta));
    %         end
    %         corr22 = 1-exp(-d2);
    %         corr23 = prod(corr22);
    %         corr2(i,:) = corr23;
    %     end
    corr2=1;
    obj=-EFF.*corr2;
    
elseif t==1
    % this section is used to identify the candidate point for the low fidelity
    % the core used to quantify the eff of the low fidelity samples
    Corr_reduction=corr_proposed(x, kriging_model_lf,kriging_model_discrepancy);
    EFF_LF=EFF.*Corr_reduction*num_q;
    %Sample Density function
    %     for i = 1:size(x,1)
    %         d2=zeros(size(XL,1),1);
    %         for j=1:size(XL,1)
    %             a=x(i,:);c=XL(j,:);
    %             d2(j)=sum((a-c).^2.*(kriging_model_lf.theta+kriging_model_discrepancy.theta));
    %         end
    %         corr22 = 1-exp(-d2);
    %         corr23 = prod(corr22);
    %         corr2(i,:) = corr23;
    %     end
    corr2=1;
    obj=-EFF_LF.*corr2;
    
else
    fprintf('the fidelity is wrong\n')
end