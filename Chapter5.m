%Nhap du lieu
%E = input('E = ');
E = 210*10^9;
v = 0.3;
%v = input('v = ');
t = 5*10^(-2);
%t = input('t = ');
%D = input('D = '); % = usp(E,v) bdp(E,v)
D = bdp(E,v)

% x1 = input('x1 = '); %Cac toa do x cua phan tu 1 [x1 x2 x3]
% y1 = input('y1 = ');
% x2 = input('x2 = ');
% y2 = input('y2 = ');
% x3 = input('x3 = ');
% y3 = input('y3 = ');
% x4 = input('x4 = ');
% y4 = input('y4 = ');
x1 = [0 1.5 0]
y1 = [0 0 1.5]

A1=A(x1,y1) 
% A2=A(x2,y2);
% A3=A(x3,y3);
% A4=A(x4,y4);
B1=B(x1,y1)
% B2=B(x2,y2);
% B3=B(x3,y3);
% B4=B(x4,y4);
k1=t*A1*B1'*D*B1
% k2=t*A2*B2'*D*B2
% k3=t*A3*B3'*D*B3
% k4=t*A4*B4'*D*B4

%index theo bang ghep noi (sua cho phu hop)
index1 = [1 2 3 4 9 10];
index2 = [1 2 9 10 7 8];
index3 = [7 8 9 10 5 6];
index4 = [3 4 5 6 9 10];

%Chuyen k chung (kk la k chung)
kk = zeros(10)
kk1 = kk_build_2D(kk,k1,index1)
kk2 = kk_build_2D(kk,k2,index2)
kk3 = kk_build_2D(kk,k3,index3)
kk4 = kk_build_2D(kk,k4,index4)

kk = kk1 + kk2 + kk3 + kk4


ff = [0; 0; -500; 0; -500; 0; 0; 0; 0; 0]
bcdof = [1 2 4 6 7 8]; %Cac bac tu do bi rang buoc
bcval = [0 0 0 0 0 0]; %Gia tri cac rang buoc

[kk,ff] = boundary_apply_2D(kk,ff,bcdof,bcval); %bo hang bo cot
Q = kk\ff %giai phuong trinh