function [obj, mse]=estimated_value(x, kriging_model_lf,kriging_model_discrepancy)
[y_LF,mse_LF] = predictor(x,kriging_model_lf);
[y_Diff,mse_Diff] = predictor(x,kriging_model_discrepancy);
y=y_LF+y_Diff;
% the genetic algorithm tries to minimize the objective
obj=y;
mse=mse_LF+mse_Diff;
end