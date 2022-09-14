function [r,RMSE]=r(y1,y2,n)
% this function is used for calculation the correlation of two function
fenzi=n*sum(y1.*y2)-sum(y1)*sum(y2);
fenmu=(n*sum(y1.^2)-sum(y1).^2)*(n*sum(y2.^2)-sum(y2).^2);
fenmu=sqrt(fenmu);
r=(fenzi/fenmu).^2;

% fenzi=sum((y1-mean(y1)).*(y2-mean(y2)));
% fenmu=(sqrt(sum((y1-mean(y1)).^2))).*(sqrt(sum((y2-mean(y2)).^2)));
% r=(fenzi/fenmu).^2;

RMSE=sqrt(mean((y1-y2).^2));

end                                                                                                                                                                                                       

