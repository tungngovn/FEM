function D = bdp(E,v)
D = E/((1+v)*(1-2*v))*[1-v v 0;v 1-v 0;0 0 (1-2*v)/2];
end