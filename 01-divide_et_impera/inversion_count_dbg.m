function [M, c] = inversion_count_dbg(X)

n = size(X,1);
c = 0;

M = X;
for i = 1:n
    for j = i+1:n;
        c += X(i,1) > X(j,1);    
    end
end

end
