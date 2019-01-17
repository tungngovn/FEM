function A = B(x,y)
%B Summary of this function goes here
%   Detailed explanation goes here
x21=x(2)-x(1);
y31=y(3)-y(1);
y21=y(2)-y(1);
x31=x(3)-x(1);
C=x21*y31-y21*x31;
A=[y(2)-y(3) 0 y(3)-y(1) 0 y(1)-y(2) 0;0 x(3)-x(2) 0 x(1)-x(3) 0 x(2)-x(1);x(3)-x(2) y(2)-y(3) x(1)-x(3) y(3)-y(1) x(2)-x(1) y(1)-y(2)]/C;
end

