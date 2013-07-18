clear; close; clc;

function c = check_algorithm(S)
    [M, c] = inversion_count(S);
    [M, c_check] = inversion_count_dbg(S);
    if(c != c_check)
        fprintf('The algorithm is wrong!!');
        exit;
    end
end

% == CHECK ORDERED ASC =================================
S = (1:100)';
c = check_algorithm(S);
fprintf('Ordered Vector: inv count [%i]\n',c);

% == CHECK RANDOM VECTOR ===============================
for i = 1:10
    S = floor(rand(100,1)*100);
    c = check_algorithm(S);
    fprintf('Random Vector: inv count [%i]\n',c);
end

% == CHECK ORDERED DESC ================================
S = (100:-1:1)';
c = check_algorithm(S);
fprintf('Inverse ordered Vector: inv count [%i]\n',c);

fprintf('Pause (Press a key)');
pause;

fprintf('Counting inversions for IntegerArray.txt (100k numbers)');
A = load('IntegerArray.txt');
[M, c] = inversion_count(A);
fprintf('Inversions %i', c);
