function [Z, d_tilda] = pr3_3_polyTransform(X, Q)

% Explanation
% =================================================
% Model this as multiset of identical powers (with Q of them, denoted by 
% 0's) and d + 1 dimensions (1, x_1, ..., x_d) which are divided by 
% identical separating bars (d of them, denoted by 1's). Now if we define
% d_tilda + 1 (Q+d+1)-vectors in a way that the first (Q+q) dimensions
% are one unique permutation of [1 1 ... 1 1  0 0 ... 0 0]:
%                                ^^^^^^^^^^^  ^^^^^^^^^^^
%                                 d of them    Q of them
% and the last dimension is fixed as 1, we see that one such vector j
% corresponds to jth dimension in polynomial transformation as:
%   z_j = product_{i = 1}^d  x_i^((index of i+1th 1) - (index of ith 1) - 1)
% For example:
%   vector_j: 0 1 0 1 0 0 1  
%        pos: 1 2 3 4 5 6 7
% This vector corresponds to a dimension j in Z matrix:
%   z_j = 1^(can be anything) * x_1^(4 - 2 - 1) * x_2(7 - 4 - 1)
%   z_j = x_1 * x_2^2
% and 


d       = size(X, 2) - 1;
d_tilda = nchoosek(Q + d, d) - 1; 

N = size(X, 1);

Z = ones(N, d_tilda + 1);

mat = [unique(perms([ones(1,d),zeros(1,Q)]), 'rows'), ones(nchoosek(Q+d,d),1)];

for j = 1:d_tilda
    
    pos = find(mat(j, :));
    
    for i = 1:d
        Z(:, j+1) = Z(:, j+1) .* (X(:, i+1) .^ (pos(i+1) - pos(i) - 1));
    end
    
end




end

