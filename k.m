function K = k(theta, E, A, L)
format long;
l=cosd(theta);
m=sind(theta);
k = ones(4,4);
k(1,1) = l*l;
k(1,2) = l*m;
k(1,3) = -l*l;
k(1,4) = -l*m;
k(2,1) = l*m;
k(2,2) = m*m;
k(2,3) = -l*m;
k(2,4) = -m*m;
k(3,1) = -l*l;
k(3,2) = -l*m;
k(3,3) = l*l;
k(3,4) = l*m;
k(4,1) = -l*m;
k(4,2) = -m*m;
k(4,3) = l*m;
k(4,4) = m*m;

T = ((E*A)/L)
K = T*k
