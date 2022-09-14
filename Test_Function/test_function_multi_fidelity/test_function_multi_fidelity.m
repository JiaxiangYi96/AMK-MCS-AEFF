function [num_vari,z,A,cost_ratio,mu,sigma,design_space,stopping_thresholds]=test_function_multi_fidelity(name)
%--------------------------------------------------------------------------
% single-objective optimization problem
switch name
    case'plot_func'
        num_vari=2;  z=0; mu=[0,0];sigma=[1,1];
        design_space=[mu-5*sigma;mu+5*sigma]; stopping_thresholds=[0.03 0.02 0.01];
    case 'four_branches_function'
        num_vari=2;   A=1; cost_ratio=5; z=0;  mu=[0,0];sigma=[1,1];
        design_space=[mu-5*sigma;mu+5*sigma];stopping_thresholds=[0.03 0.02 0.01];
    case 'four_branches_function_2'
        num_vari=2;   z=0; mu=[0,0];sigma=[1,1];
        design_space=[mu-5*sigma;mu+5*sigma];stopping_thresholds=[0.03 0.02 0.01];
    case 'cubic_function'
        num_vari=2;  z=0;  mu=[10,9.9];sigma=[5,5];
        design_space=[mu-5*sigma;mu+5*sigma];stopping_thresholds=[0.03 0.02 0.01];
    case 'Circular_Pipe_function'
        num_vari=2;  z=0;  mu=[301.079,0.503];sigma=[14.78,0.049];
        design_space=[mu-5*sigma;mu+5*sigma];stopping_thresholds=[0.03 0.02 0.01];
    case 'Hyper_sphere_bound_function'
        num_vari=2;  z=0;  mu=[0.5,0.5];sigma=[0.2,0.2];
        design_space=[mu-5*sigma;mu+5*sigma];stopping_thresholds=[0.03 0.02 0.01];
    case 'Cantilever_beam_function'
        num_vari=2;   z=0; mu=[1000,250];sigma=[200,37.5];
        design_space=[mu-5*sigma;mu+5*sigma];stopping_thresholds=[0.03 0.02 0.01];
    case 'multimodal_function'
        num_vari=2; A=0; cost_ratio=5;  z=0;  mu=[1.5,2.5];sigma=[1,1];
        design_space=[mu-5*sigma;mu+5*sigma];stopping_thresholds=[0.03 0.02 0.01];
    case 'Modified_Rastrigin_function'
        num_vari=2;  z=0; cost_ratio=10;  mu=[0,0];sigma=[1,1];
        design_space=[mu-5*sigma;mu+5*sigma];stopping_thresholds=[0.03 0.02 0.01];
    case 'nonlinear_oscillator_function'
        num_vari=6; A=1; cost_ratio=10;   z=0; mu=[1,1,0.1,0.5,1,1];
        sigma=[0.05,0.1,0.01,0.05,0.1,0.1];design_space=[mu-5*sigma;mu+5*sigma];stopping_thresholds=[0.03 0.02 0.01];
    case 'nonlinear_oscillator_function2'
        num_vari=6; A=1; cost_ratio=10;   z=0; mu=[1,1,0.1,0.5,1,1];
        sigma=[0.05,0.1,0.01,0.05,0.2,0.2];design_space=[mu-5*sigma;mu+5*sigma];stopping_thresholds=[0.05 0.03 0.01];
    case 'Cantilever_tube_function'
        num_vari=9;
        z=0;
        mu=[5 42 3000 3000  90000  220  18000  ];
        sigma=[0.1 0.5 300 300  9000 22 1800  ];
        design_space_1=[mu-5*sigma;mu+5*sigma];
        design_space_2=[119.75 59.75;120.25 60.25];
        design_space=[design_space_1 design_space_2];
        stopping_thresholds=[0.03 0.02 0.01];
    case 'Vehicle_side_impact_function'
        num_vari=7;  z=0; mu=[1.38 1.38 1.38 1.38 0.3 0 0];
        sigma=[0.3 0.3 0.3 0.3 0.06 10 10];design_space=[mu-5*sigma;mu+5*sigma];
        stopping_thresholds=[0.03 0.02 0.01];
    case 'roof_truss'
        num_vari=6;  A=0.2;  cost_ratio=10; z=0; 
        mu=[20000,13.5,9.82*10^-4,0.04,1.2*10^11,3*10^10];
        sigma=[2000,0.50,6*10^-5,0.008,1.2*10^10,3*10^9];
        design_space=[mu-5*sigma;mu+5*sigma];stopping_thresholds=[0.03 0.02 0.01];
    case'highly_nonlinear_log'
        num_vari=6; A=2; cost_ratio=10;   z=0; mu=[120 120 120 120 50 40]; sigma=[12 12 12 12 15 12];  
       design_space=[mu-5*sigma;mu+5*sigma]; 
       stopping_thresholds=[0.03 0.02 0.01];
    otherwise
        sprintf('%s function is not defined', name);
end

end
