function E = pr1_5_classificationError(X, y, w)

E = sum(y ~= sign(X * w)) / length(y);

end

