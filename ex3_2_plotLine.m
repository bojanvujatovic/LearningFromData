function [] = ex3_2_plotLine(w, c, xlow, xupp)

X = [
    1, xlow;
    1, xupp
    ];

y = - X * w(1:2) / w(3);

if(c == 1)
    plot(X(:, 2), y, 'r-');
elseif(c == 2)
    plot(X(:, 2), y, 'b-');
else
    plot(X(:, 2), y, 'g-');

end

