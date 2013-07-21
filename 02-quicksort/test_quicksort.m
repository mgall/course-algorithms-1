clear; close; clc;


function [M1, c] = check_algorithm(S)
    pStrategy = @(v,l,r) l;
    %pStrategy = @(v,l,r) r;
    %pStrategy = @(v,l,r) medianOfThree(v,l,r);

    [M1, c] = quicksort(S, pStrategy);
    M2 = sort(S);
    if(sum(M1 == M2) != size(M1,1))
        fprintf('The algorithm is wrong!!');
        exit;
    end

end

% == CHECK ORDERED ASC =================================
S = (1:100)';
[M, c] = check_algorithm(S);
fprintf('Ordered Vector: comparison count [%i]\n',c);

% == CHECK RANDOM VECTOR ===============================
for i = 1:10
    S = randperm(100)';
    [M, c] = check_algorithm(S);
    fprintf('Random Vector: comparison count [%i]\n',c);
end

% == CHECK ORDERED DESC ================================
S = (100:-1:1)';
[M, c] = check_algorithm(S);
fprintf('Inverse ordered Vector: comparison count [%i]\n',c);

fprintf('Pause (Press a key)\n');
pause;

fprintf('Counting comparisons for QuickSort.txt (10k numbers)\n');
A = load('QuickSort.txt');
[M, c] = check_algorithm(A);
fprintf('Comparisons %i\n', c);
