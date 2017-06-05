function [bestEpsilon bestF1] = selectThreshold(yval, pval)
%SELECTTHRESHOLD Find the best threshold (epsilon) to use for selecting
%outliers
%   [bestEpsilon bestF1] = SELECTTHRESHOLD(yval, pval) finds the best
%   threshold to use for selecting outliers based on the results from a
%   validation set (pval) and the ground truth (yval).
%

m = size(yval);

bestEpsilon = 0;
bestF1 = 0;
F1 = 0;

stepsize = (max(pval) - min(pval)) / 1000;
for epsilon = min(pval):stepsize:max(pval)
    
    % ====================== YOUR CODE HERE ======================
    % Instructions: Compute the F1 score of choosing epsilon as the
    %               threshold and place the value in F1. The code at the
    %               end of the loop will compare the F1 score for this
    %               choice of epsilon and set it to be the best epsilon if
    %               it is better than the current choice of epsilon.
    %               
    % Note: You can use predictions = (pval < epsilon) to get a binary vector
    %       of 0's and 1's of the outlier predictions
    
    TP = 0;
    FP = 0;
    FN = 0;

    predictions = (pval < epsilon);
    for i = 1:m
        if predictions(i) == yval(i)
            if predictions(i) == 1
                TP = TP + 1;  
            end
        elseif predictions(i) != yval(i)
            if  predictions(i) == 1
                FP = FP + 1;
            elseif predictions(i) == 0
                FN = FN + 1;
            end
        end
    end
    
    P = TP/(TP+FP);
    R = TP/(TP+FN);
    F1 = 2*((P*R)/(P+R));

    % =============================================================

    if F1 > bestF1
       bestF1 = F1;
       bestEpsilon = epsilon;
    end
end

end
