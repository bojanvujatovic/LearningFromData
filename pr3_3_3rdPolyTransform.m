function Z = pr3_3_3rdPolyTransform(X)

N = size(X, 1);
x1 = X(:, 2);
x2 = X(:, 3);

dtilda = 9;

Z = ones(N, dtilda + 1);

Z(:, 2)  = x1;
Z(:, 3)  = x2;
Z(:, 4)  = x1.^2;
Z(:, 5)  = x1.*x2;
Z(:, 6)  = x2.^2;
Z(:, 7)  = x1.^3;
Z(:, 8)  = (x1.^2).*x2;
Z(:, 9)  = x1.*(x2.^2);
Z(:, 10) = x2.^3;

end

