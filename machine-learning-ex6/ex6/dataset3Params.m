function [C, sigma] = dataset3Params(X, y, Xval, yval)
%DATASET3PARAMS returns your choice of C and sigma for Part 3 of the exercise
%where you select the optimal (C, sigma) learning parameters to use for SVM
%with RBF kernel
%   [C, sigma] = DATASET3PARAMS(X, y, Xval, yval) returns your choice of C and 
%   sigma. You should complete this function to return the optimal C and 
%   sigma based on a cross-validation set.
%

% You need to return the following variables correctly.

C = 1;
sigma = 0.3;

% ====================== YOUR CODE HERE ======================
% Instructions: Fill in this function to return the optimal C and sigma
%               learning parameters found using the cross validation set.
%               You can use svmPredict to predict the labels on the cross
%               validation set. For example, 
%                   predictions = svmPredict(model, Xval);
%               will return the predictions on the cross validation set.
%
%  Note: You can compute the prediction error using 
%        mean(double(predictions ~= yval))
%

C1 = [0.01, 0.03, 0.1, 0.3, 1, 3, 10, 30];
sigma1 = [0.01, 0.03, 0.1, 0.3, 1, 3, 10, 30];
Param = zeros(numel(C1)*numel(sigma1), 2); % [64*2]

for i=1:numel(C1)
    for j=1:numel(sigma1)
        Param(j+(i-1)*numel(C1),1:2)=[C1(i) sigma1(j)];
    end
end

Counts = zeros(2,1);
tempCounts = 0;
idx = 0;
for i=1:size(Param, 1)
    model= svmTrain(X, y, Param(i,1), @(x1, x2) gaussianKernel(x1, x2, Param(i,2))); 
    predictions = svmPredict(model, Xval);
    if mean(double(predictions)) == mean(double(yval))     
        temp = predictions == yval;
        Counts = arrayfun( @(x)sum(temp==1), unique(temp));
        if Counts(2) > tempCounts
            tempCounts = Counts;
            idx = i;
        end
    end
end
C = Param(idx, 1);
sigma = Param(idx, 2);
% =========================================================================

end
