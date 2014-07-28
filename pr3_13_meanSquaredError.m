function e = pr3_13_meanSquaredError(X, y, w)

e = 1/length(y) * ((w')*(X')*X*w - 2*(w')*(X')*y + (y')*y);

end

