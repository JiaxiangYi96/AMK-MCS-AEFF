function obj=corr_proposed(x, kriging_model_lf,kriging_model_discrepancy)
[~,predict_LMSE]=predictor(x,kriging_model_lf);
[~,predict_dMSE]=predictor(x,kriging_model_discrepancy);

sigma_L=sqrt(predict_LMSE);
sigma_H=sqrt(predict_LMSE+predict_dMSE);

obj=sigma_L./sigma_H;
% obj=sigma_L./sqrt(predict_dMSE);
end