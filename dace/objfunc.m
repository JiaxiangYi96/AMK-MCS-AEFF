function  [obj, fit] = objfunc(theta, par)
% >>>>>>>>>>>>>>>>   Auxiliary functions  ====================
% Initialize
obj = inf;
fit = struct('sigma2',NaN, 'beta',NaN, 'gamma',NaN, ...
    'C',NaN, 'Ft',NaN, 'G',NaN);
m = size(par.F,1);
% Set up  R
r = feval(par.corr, theta, par.D);
idx = find(r > 0);   o = (1 : m)';
mu = (10+m)*eps;
R = sparse([par.ij(idx,1); o], [par.ij(idx,2); o], ...
    [r(idx); ones(m,1)+mu]);
% Cholesky factorization with check for pos. def.
[C, rd] = chol(R);
if  rd,  return, end % not positive definite

% Get least squares solution
C = C';   Ft = C \ par.F;
[Q, G] = qr(Ft,0);
if  rcond(G) < 1e-10
    % Check   F
    if  cond(par.F) > 1e15
        T = sprintf('F is too ill conditioned\nPoor combination of regression model and design sites');
        error(T)
    else  % Matrix  Ft  is too ill conditioned
        return
    end
end
Yt = C \ par.y;   beta = G \ (Q'*Yt);
rho = Yt - Ft*beta;  sigma2 = sum(rho.^2)/m;
detR = prod( full(diag(C)) .^ (2/m) );
obj = sum(sigma2) * detR;
if  nargout > 1
    fit = struct('sigma2',sigma2, 'beta',beta, 'gamma',rho' / C, ...
        'C',C, 'Ft',Ft, 'G',G');
end