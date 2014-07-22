function [X_mis y_mis]= pr1_4_misclassified(X, y, w)

X_mis = X(find(sign(X * w) ~= y), :);
y_mis = y(find(sign(X * w) ~= y));

end



