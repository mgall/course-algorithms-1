function ip = medianOfThree(V,l,r)
    n = r-l+1;
    if (n<=2)
        ip = l;
    end
    
    mi = floor((r+l)/2);
    mv = sort(V([l,mi,r]))(2);
    if( V(l) == mv ) 
        ip=l;
    elseif( V(mi) == mv ) 
        ip=mi;
    else
        ip=r;
    end

end
