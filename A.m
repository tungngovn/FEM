function B = A(x,y)
%A Summary of this function goes here
%   Detailed explanation goes here
x21=x(2)-x(1);
y31=y(3)-y(1);
y21=y(2)-y(1);
x31=x(3)-x(1);
B=(x21*y31-y21*x31)/2;
end

