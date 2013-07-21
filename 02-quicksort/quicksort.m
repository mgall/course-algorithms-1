function [V, c] = quicksort(V, pivotFunc)
    % Select standerd pivot fetcher
    if (~exist('pivotFunc','var'))
        pivotFunc = @(v,l,r) l;
    end
    
    % Main quick sort starter
    n = size(V,1);

    [V,c] = sortPartition(V, 1, n, pivotFunc);
    
end


function [V,c] = sortPartition(V, l, r, pivotFunc)
    [V, ip] = partition(V, l, r, pivotFunc(V,l,r));
    n = r-l+1;
    c = n-1;
    %fprintf('[%i,%i]=%i Partition (%i, %i) %i (%i,%i)\n', l, r, n, l, ip-1, ip, ip+1, r);
    %pause;

    if( n>2 && l<ip-1 )
        [V, c1] = sortPartition(V, l, ip-1, pivotFunc);
        c += c1;
    end
   
    if( n>2 && r>ip+1 )
        [V, c2] = sortPartition(V, ip+1, r, pivotFunc);
        c += c2;
    end
end


function [V,ip] = partition(V, l, r, kp)
    V([l,kp]) = V([kp,l]);

    i = l+1;
    for j = (l+1):(r)
        if (V(j) < V(l))
            V([i,j]) = V([j,i]);
            i += 1;
        end
    end

    V([l,i-1]) = V([i-1,l]);
    ip = i-1;
end
