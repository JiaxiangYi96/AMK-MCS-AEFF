function Phiq=mmphi(X, q, p)
% Calculates the sampling plan quality criterion of Morris and
% Mitchell.
%%
%Inputs:
% X 每 sampling plan
% q 每 exponent used in the calculation of the metric
% p 每 the distance metric to be used (p=1 rectangular 每
% (default, p=2 Euclidean)
%%
%Output:
% Phiq 每 sampling plan ＆space每fillingness＊ metric
% Assume defaults if arguments list incomplete
if ~exist('p','var')
p=1;
end
if ~exist('q','var')
q=2;
end
% Calculate the distances between all pairs of
% points (using the p每norm) and build multiplicity array J
%
[J,d]=jd(X,p);
% The sampling plan quality criterion
Phiq=sum(J.*(d.^(-q)))^(1/q);