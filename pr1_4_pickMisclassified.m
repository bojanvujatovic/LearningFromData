function [x_ret, y_ret] = pr1_4_pickMisclassified(X, y, w)

idxs_miss = find(sign(X * w) ~= y);

if size(idxs_miss, 1) == 0
    x_ret = [];
    y_ret = [];
else
    idx = idxs_miss(randsample(length(idxs_miss), 1));

    x_ret = X(idx, :)';
    y_ret = y(idx);
end

end

