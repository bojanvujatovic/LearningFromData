function E = ex3_2_calcError(X, y, w)

N = length(y);

ypred = sign(X * w);

n = sum(ypred ~= y);

E = n/N;


end

