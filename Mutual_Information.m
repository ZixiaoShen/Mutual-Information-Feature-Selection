function info = Mutual_Information(X, Y)

    n_samples = size(X, 1);
    Z = [X Y];
    if(n_samples/10 > 20)
        n_bins = 20;
    else
        n_bins = max(floor(n/10), 10);
    end
    pX = hist(X, n_bins);
    pX = pX ./ n_samples;
    
    i = find(pX == 0);
    pX(i) = 0.00001;
    
    od = size(Y, 2);
    cl = od;
    if(od == 1)
        pY = [length(find(Y==+1)) length(find(Y==-1))]/n_samples;
        cl = 2;
    else
        pY = zeros(1, od);
        for i = 1:od
            pY(i) = length(find(Y==+1));
        end
        pY = pY / n;
    end
    p = zeros(cl, n_bins);
    rx = abs(max(X) - min(X)) / n_bins;
    for i = 1:cl
        xl = min(X);
        for j = 1:n_bins
            if(i == 2) && (od == 1)
                interval = (xl <= Z(:,1)) & (Z(:,2) == -1);
            else
                interval = (xl <= Z(:,1)) & (Z(:,i+1) == +1);
            end
            if(j < n_bins)
                interval = interval & (Z(:,1) < xl + rx);
            end
            
            % find (interval)
            p(i, j) = length(find(interval));
            
            if p(i, j) == 0
                p(i, j) = 0.00001;
            end
            
            xl = xl + rx;
        end
    end
    HX = -sum(pX .* log(pX));
    HY = -sum(pY .* log(pY));
    pX = repmat(pX, cl, 1);
    pY = repmat(pY', 1, n_bins);
    
    p = p ./ n_samples;
    info = sum(sum(p .* log(p ./ (pX .* pY))));
    info = 2 * info ./ (HX + HY);

end
