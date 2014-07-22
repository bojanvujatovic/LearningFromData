function [X_mis y_mis]= pr1_5_AdalineMisclassified(X, y, w)

X_mis = X(find((X * w) .* y <= ones(size(y))), :);
y_mis = y(find((X * w) .* y <= ones(size(y))));

end



