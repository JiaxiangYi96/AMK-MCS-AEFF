function plot_figures_multi_fidelity(dmodelLF, dmodelDiff,design_space,num_low,num_high,XL,XH,test_hf_function,iteration)
%%
num_test=100;
x1_plot=linspace(design_space(1,1),design_space(2,1),num_test);
x2_plot=linspace(design_space(1,2),design_space(2,2),num_test);
% calculate the real responses
for ii=1:1:num_test
    for jj=1:1:num_test
        X_temp=[x1_plot(ii),x2_plot(jj)];
        Y_real_plot(jj,ii)=feval(test_hf_function,X_temp);
        Y_MF_plot(jj,ii)=estimated_value(X_temp,dmodelLF,dmodelDiff);
        
    end
end

if iteration==0
    figure(999);
    v=[-10^6,0,10^7];
    contour(x1_plot,x2_plot,Y_real_plot,v,'-','LineWidth',2,'LineColor','k');
    hold on
    contour(x1_plot,x2_plot,Y_MF_plot,v,'-','LineWidth',1.5,'LineColor','m');
    hold on
    plot(XL(1:num_low,1),XL(1:num_low,2),'s','MarkerSize',12,'MarkerEdgeColor','b','LineWidth',2);
    hold on
    plot(XH(1:num_high,1),XH(1:num_high,2),'o','MarkerSize',12,'MarkerEdgeColor','r','LineWidth',2);
    hold on
    set(gca,'LineWidth',1.2,'fontsize',16)
    print(num2str(iteration),'-dtiff','-r600')
else
    figure(iteration)
    v=[-10^6,0,10^7];
    contour(x1_plot,x2_plot,Y_real_plot,v,'-','LineWidth',2,'LineColor','k');
    hold on
    contour(x1_plot,x2_plot,Y_MF_plot,v,'-','LineWidth',1.5,'LineColor','m');
    hold on
    plot(XL(1:num_low,1),XL(1:num_low,2),'s','MarkerSize',10,'MarkerEdgeColor','b','LineWidth',1.5);
    hold on
    plot(XL(num_low+1:size(XL,1),1),XL(num_low+1:size(XL,1),2),'s','MarkerSize',12,'MarkerFaceColor','b','MarkerEdgeColor','b');
    hold on
    plot(XH(1:num_high,1),XH(1:num_high,2),'o','MarkerSize',12,'MarkerEdgeColor','r','LineWidth',2);
    hold on
    plot(XH(num_high+1:size(XH,1),1),XH(num_high+1:size(XH,1),2),'o','MarkerSize',12,'MarkerFaceColor','r','MarkerEdgeColor','r');
    set(gca,'LineWidth',1.5,'fontsize',16)
    print(num2str(iteration),'-dtiff','-r600')
    drawnow
end

end