function [xret, yret] = ex3_2_pickMisclassified(X, y, w)

yeval = sign(X * w);

idxmiss = find(yeval ~= y);


if length(idxmiss) < 1
    idx = ceil(rand(1, 1) * size(X, 1));
else
    idx = idxmiss(ceil(rand(1, 1) * length(idxmiss)));
end


xret = X(idx, :)';
yret = y(idx);

end

