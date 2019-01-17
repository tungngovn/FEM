function [kk] = kk_build_2D(kk,k,index)
edof = length(index);
for i=1:edof
    ii = index(i);
    for j=1:edof
        jj = index(j);
        kk(ii,jj)=kk(ii,jj)+k(i,j);
    end
end