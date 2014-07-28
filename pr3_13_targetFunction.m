function y = pr3_13_targetFunction(X, sigma)

y = X(:, 2).^2 + normrnd(0, sigma, size(X, 1), 1);

end

