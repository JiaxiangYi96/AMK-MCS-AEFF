clc;
clear all;
test_hf_function='multimodal_function'; %multimodal_function four_branches_function
test_lf_function='Cheap_multimodal_function';
[num_vari,z,mu,sigma,design_space]=Test_function(test_hf_function);
num_test=100;
x1_plot=linspace(design_space(1,1),design_space(2,1),num_test);
x2_plot=linspace(design_space(1,2),design_space(2,2),num_test);
for ii=1:1:num_test
    for jj=1:1:num_test
        X_temp=[x1_plot(ii),x2_plot(jj)];
        Y_hf_plot(jj,ii)=feval(test_hf_function,X_temp);
    end
end
figure (1)
v=[-10^6,0,10^7];
contour(x1_plot,x2_plot,Y_hf_plot,v,'-','LineWidth',2,'LineColor','k');
hold on
for i=1:5:11
    A=(i-1)/10;
    % calculate the real responses
    for ii=1:1:num_test
        for jj=1:1:num_test
            X_temp=[x1_plot(ii),x2_plot(jj)];
            Y_lf_plot(jj,ii)=feval(test_lf_function,X_temp,A);
        end
    end
    
    if i==1
        figure (1)
        v=[-10^6,0,10^7];
        contour(x1_plot,x2_plot,Y_lf_plot,v,'--','LineWidth',2,'LineColor','g');
        hold on
    elseif i==2
        figure (1)
        v=[-10^6,0,10^7];
        contour(x1_plot,x2_plot,Y_lf_plot,v,'-','LineWidth',1.5,'LineColor','[0.6350 0.0780 0.1840]	');
        hold on
    elseif i==3
        figure (1)
        v=[-10^6,0,10^7];
        contour(x1_plot,x2_plot,Y_lf_plot,v,'-','LineWidth',1.5,'LineColor','[0.8500 0.3250 0.0980]');
        hold on
    elseif i==4
        figure (1)
        v=[-10^6,0,10^7];
        contour(x1_plot,x2_plot,Y_lf_plot,v,'-','LineWidth',1.5,'LineColor','[0.9290 0.6940 0.1250]');
        hold on
    elseif i==5
        figure (1)
        v=[-10^6,0,10^7];
        contour(x1_plot,x2_plot,Y_lf_plot,v,'-','LineWidth',1.5,'LineColor','green');
        hold on
    elseif i==6
        figure (1)
        v=[-10^6,0,10^7];
        contour(x1_plot,x2_plot,Y_lf_plot,v,'-.','LineWidth',2,'LineColor','b');
        hold on
    elseif i==7
        figure (1)
        v=[-10^6,0,10^7];
        contour(x1_plot,x2_plot,Y_lf_plot,v,'-','LineWidth',1.5,'LineColor','[0 0.4470 0.7410]');
        hold on
    elseif i==8
        figure (1)
        v=[-10^6,0,10^7];
        contour(x1_plot,x2_plot,Y_lf_plot,v,'-','LineWidth',1.5,'LineColor','cyan');
        hold on
    elseif i==9
        figure (1)
        v=[-10^6,0,10^7];
        contour(x1_plot,x2_plot,Y_lf_plot,v,'-','LineWidth',1.5,'LineColor','[0.3010 0.7450 0.9330]');
        hold on
    elseif i==10
        figure (1)
        v=[-10^6,0,10^7];
        contour(x1_plot,x2_plot,Y_lf_plot,v,'-','LineWidth',1.5,'LineColor','[0.4940 0.1840 0.5560]');
        hold on
    elseif i==11
        figure (1)
        v=[-10^6,0,10^7];
        contour(x1_plot,x2_plot,Y_lf_plot,v,':','LineWidth',2,'LineColor','r');
        hold on
        
    end
    set(gca,'FontSize',16,'LineWidth',1);
    
    
    
end

