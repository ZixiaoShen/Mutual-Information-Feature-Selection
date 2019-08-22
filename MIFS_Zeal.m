function [Rank, Score] = MIFS_Zeal(X, y)
    
    num_F = size(X, 2);
    rank = [];
    for i = 1:num_F
        F_score = -Mutual_Information(X(:, i), y);
%         F_score = -muteinf(X(:, i), y);
        rank = [rank; F_score i];
    end
    rank = sortrows(rank, 1);  
    Score = rank(1:num_F, 1);
    Rank = rank(1:num_F, 2);
end
