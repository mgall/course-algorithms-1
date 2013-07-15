function [M,c] = inversion_count(X)

    n = size(X,1);
    if (n<=1)
        [M, c] = [X, 0];
    else
        [M, c] = inversion(X,1,n);
    end
end

function [M, c] = inversion(X, s, e)
    
    n = (e-s+1);
    %fprintf('Step n=%d (%d, %d)\n', n,s,e);
    if ( n <= 2 )
        [M,c] = base_merge(X,s,e);
    else
        % Divide
        p = floor((e+s)/2);
        %fprintf('Pivoting at %d|%d|%d\n', s, p, e);
        [X1, c1] = inversion(X, s, p);
        [X2, c2] = inversion(X, p+1, e);

        % Combine
        [M, c3] = deep_merge(X1,X2);
        
        %fprintf('Found %d|%d|%d\n', c1,c2,c3);
        c = c1 + c2 + c3;
    end
end


function [M, c] = base_merge(X,ia,ib)
    a = X(ia,1); b = X(ib,1);
    if(ia==ib)
        M = a*ones(1,1);
        c = 0;
    else if (a>b)
        M = [b; a];
        c = 1;
    else
        M = [a; b];
        c = 0;
    end
end


function [M, c] = deep_merge(A, B)
    na = size(A,1);
    nb = size(B,1);
    M = zeros(na+nb,1);
    c = 0;
    ia =1; ib=1; im=1; 

    while (ia<=na || ib <= nb)
        if( ib > nb || (ia<=na && A(ia,1) <= B(ib,1)) )
            M(im,1) = A(ia,1);
            ia +=1;
        else
            M(im,1) = B(ib,1);
            ib +=1;
            c += na-ia+1;
        end
        
        im += 1;
    end
end
