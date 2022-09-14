function obj=plot_figures(design_space,test_function,kriging_model,sample_x,num_initial_sample,iteration)
% this function is used to plot the figures during the iteration 
num_test=100;
x1_plot=linspace(design_space(1,1),design_space(2,1),num_test);
x2_plot=linspace(design_space(1,2),design_space(2,2),num_test);
% calculate the real responses
for ii=1:1:num_test
    for jj=1:1:num_test
        X_temp=[x1_plot(ii),x2_plot(jj)];
        Y_real_plot(jj,ii)=feval(test_function,X_temp);
        Y_LHS_plot(jj,ii)=predictor(X_temp,kriging_model);
        
    end
end


figure(iteration)
v=[-10^6,0,10^7];
contour(x1_plot,x2_plot,Y_real_plot,v,'k-','LineWidth',2);
hold on
contour(x1_plot,x2_plot,Y_LHS_plot,v,'m-','ShowText','on','LineWidth',2);
hold on
plot(sample_x(1:num_initial_sample,1),sample_x(1:num_initial_sample,2),'b^','MarkerSize',6,'LineWidth',1.5);
hold on
plot(sample_x(num_initial_sample+1:size(sample_x,1)-1,1),sample_x(num_initial_sample+1:size(sample_x,1)-1,2),'gx','MarkerSize',10,'LineWidth',2.5);
% legend('Real Y','Predict  Y',' Initial samples','added samples');
set(gca,'XTick',design_space(1,1):(design_space(2,1)-design_space(1,1))/5:design_space(2,1))
set(gca,'YTick',design_space(1,2):(design_space(2,2)-design_space(1,2))/5:design_space(2,2))
set(gca,'fontname','Times New Roman','LineWidth',1.5,'fontsize',18)
xlabel('\it x_1','fontname','Times New Roman','fontsize',16)
ylabel('\it x_2','fontname','Times New Roman','fontsize',16)
drawnow
obj=[];
end

