clc
clear all
close all
addpath('Test_Function/test_function_multi_fidelity','Failure_Probability_evaluation','Sample_plan_code','Stop_criteria','Infill_criteria','dace')
%% dedine the tested function
%  multimodal_function  cubic_function  Circular_Pipe_function
%  four_branches_function nonlinear_oscillator_function ,'four_branches_function','nonlinear_oscillator_function','highly_nonlinear_log'
for fun_name={'multimodal_function'}
    test_function=char(fun_name);
    % Cheap_multimodal_function  Cheap_cubic_function
    % Cheap_Cantilever_beam_function  Cheap_Circular_Pipe_function Cheap_four_branches_function
    test_lf_function=strcat('Cheap_',test_function);
    % test_lf_function='Cheap_multimodal_function';
    % import the basic information of the tested function
    [num_vari,z,A,cost_ratio,mu,sigma,design_space,given_thresholds]=test_function_multi_fidelity(test_function);
    % define the basic parameters of the low fidelity function
    for error=given_thresholds
        num_trials=2;
        record.result=zeros(num_trials,8);
        for run=1:1:num_trials
            fprintf('--------------Test_function=%s;  run= %d  A=%d,  Cost_ratio=%d error_threhold %s---------------------------\n',test_function,run,A,cost_ratio,error);
            % the paramters used for meta-model construction
            % LF samples
            num_low=4*cost_ratio;
            sample_xl= repmat(design_space(1,:),num_low,1)+repmat(design_space(2,:)-design_space(1,:),num_low,1).*...
                lhsdesign(num_low,num_vari,'criterion','maximin','iterations',1000);
            sample_yl= feval(test_lf_function,sample_xl,A);
            % HF samples
            num_high=6;
            [sample_xh,~]=subset(sample_xl,num_high);
            sample_yh = feval(test_function,sample_xh);
            %% constuct the surrogate model
            % low fidelity model
            kriging_model_lf=dacefit(sample_xl,sample_yl,'regpoly0','corrgauss',1*ones(1,num_vari),0.001*ones(1,num_vari),1000*ones(1,num_vari));
            sample_xh_yl=predictor(sample_xh,kriging_model_lf);
            % discrepance model
            kriging_model_discrepancy=dacefit(sample_xh,sample_yh - sample_xh_yl,'regpoly0','corrgauss',1*ones(1,num_vari),0.001*ones(1,num_vari),1000*ones(1,num_vari));
            %% main iterative process
            gen=1;
            iteration=0;
            cost=size(sample_xh,1)+size(sample_xl,1)/cost_ratio;
            num_search=10^4*gen;
            search_x=MCS_Population_Generation(mu,sigma,num_search);
            [pf_estimate,pf_real,cov_estimate,real_relative_error]=reliabiliy_evaluation_multi_fidelity(search_x,mu,kriging_model_lf,kriging_model_discrepancy,test_function);
            while cov_estimate>0.05 ||iteration<=2
                num_search=10^4*gen;
                search_x=MCS_Population_Generation(mu,sigma,num_search);
                stop_value=Stopping_U_multi_fidelity(search_x,kriging_model_lf,kriging_model_discrepancy);
                while stop_value>error  && iteration<500
                    %% find the point with sequential samping methods using GA algorithm
                    %LF
                    objl=-Infill_Standard_AEFF(search_x, kriging_model_lf,kriging_model_discrepancy,z,sample_xh,sample_xl,cost_ratio,1);
                    [bestobj_lf,Index1]=max(objl);
                    xselected_lf=search_x(Index1,:);
                    % HF
                    objh=-Infill_Standard_AEFF(search_x, kriging_model_lf,kriging_model_discrepancy,z,sample_xh,sample_xl,cost_ratio,0);
                    [bestobj_hf,Index2]=max(objh);
                    xselected_hf=search_x(Index2,:);
                    %% update the MF Kriging model
                    if bestobj_lf>=bestobj_hf
                        % add the new point to design set
                        if ismember(xselected_lf,sample_xl,'rows')==0
                            sample_xl = [sample_xl;xselected_lf];
                            Fselected_LF=feval(test_lf_function,xselected_lf,A);
                            sample_yl = [sample_yl;Fselected_LF];
                            % rebuild the Kriging model using the new design set
                            kriging_model_lf=dacefit(sample_xl,sample_yl,'regpoly0','corrgauss',1*ones(1,num_vari),0.001*ones(1,num_vari),1000*ones(1,num_vari));
                            sample_xh_yl=predictor(sample_xh,kriging_model_lf);
                            % rebuild the Kriging model using the new design set
                            kriging_model_discrepancy=dacefit(sample_xh,sample_yh - sample_xh_yl,'regpoly0','corrgauss',1*ones(1,num_vari),0.001*ones(1,num_vari),1000*ones(1,num_vari));
                        else
                            search_x=MCS_Population_Generation(mu,sigma,num_search);
                        end
                    else
                        % add the new point to design set
                        if ismember(xselected_hf,sample_xh,'rows')==0
                            sample_xh = [sample_xh;xselected_hf];
                            Fselected_HF=feval(test_function,xselected_hf);
                            [Fselected_LF,~]=predictor(xselected_hf,kriging_model_lf);
                            sample_yh = [sample_yh;Fselected_HF];
                            sample_xh_yl = [sample_xh_yl;Fselected_LF];
                            % rebuild the Kriging model using the new design set
                            kriging_model_discrepancy=dacefit(sample_xh,sample_yh - sample_xh_yl,'regpoly0','corrgauss',1*ones(1,num_vari),0.001*ones(1,num_vari),1000*ones(1,num_vari));
                            
                        else
                            search_x=MCS_Population_Generation(mu,sigma,num_search);
                        end
                    end
                    % updating some parameters
                    iteration = iteration+1;
                    %             if size(sample_xh,2)==2
                    %                 plot_figures_multi_fidelity(kriging_model_lf, kriging_model_discrepancy,design_space,num_low,num_high,sample_xl,sample_xh,test_hf_function,iteration);
                    %             end
                    evaluation = size(sample_xl,1)/cost_ratio+size(sample_xh,1);
                    %%
                    %the stopping criterion
                    stop_value=Stopping_U_multi_fidelity(search_x,kriging_model_lf,kriging_model_discrepancy);
                    cost=evaluation;
                    [pf_estimate,pf_real,~,real_relative_error]=reliabiliy_evaluation_multi_fidelity(search_x,mu, kriging_model_lf,kriging_model_discrepancy,test_function);
                    fprintf(' A=%f,cr=%d,Run=%d; iter=%d; tc_hf=%d,tc_lf=%d, pf_estimate=%f; pf_real=%f; stop_value=%f  real_error=%f \n',...
                        A,cost_ratio,run,iteration ,size(sample_xh,1), size(sample_xl,1),pf_estimate,pf_real,stop_value,real_relative_error);
                    
                    
                end
                %% calclulate the failure probility
                [pf_estimate,pf_real,cov_estimate,real_relative_error]=reliabiliy_evaluation_multi_fidelity(search_x,mu, kriging_model_lf,kriging_model_discrepancy,test_function);
                % final result of one run
                gen=gen+1;
                high_size=size(sample_xh,1);
                low_size=size(sample_xl,1);
                cost=high_size+low_size/cost_ratio;
                
            end
            record.result(run,:)=[high_size,low_size,cost,pf_estimate,pf_real,cov_estimate,real_relative_error,size(search_x,1)];
            fprintf('A=%f,cr=%d,Run=%d; iter=%d; tc_hf=%d,tc_lf=%d, pf_estimate=%f; pf_real=%f; stop_value=%f  real_error=%f \n',...
                A,cost_ratio,run,iteration , size(sample_xh,1),  size(sample_xl,1),pf_estimate,pf_real,stop_value,real_relative_error);
            
            save(strcat('Results/',test_function,'/',mfilename,'_',num2str(100*error),'_',num2str(cost_ratio),'.mat'),'record');
        end
        record.mean=mean(record.result);
        save(strcat('Results/',test_function,'/',mfilename,'_',num2str(100*error),'_',num2str(cost_ratio),'.mat'),'record');
    end
end