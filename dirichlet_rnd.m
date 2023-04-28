function [X] = dirichlet_rnd(alpha, K)

% [X] = dirichlet_rnd(alpha, K)
%
% Generates K independent random vectors with from the Dirichlet
% distribution with parameters alpha
% 
% Last update 28 April 2023

% Generate the random variables from the Gamma distribution
Y = gamrnd(repmat(alpha, K, 1), ones(K, length(alpha)));

%normalise to get the Dirichlet vectors 
X = Y./sum(Y, 2);
