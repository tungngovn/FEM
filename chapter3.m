n = 4;

%Tao ma tran A co cac phan tu tren mot hang lan luot la THETA, E, A, L
A = ones(n,4);
%input
for i=1:n
    fprintf('Nut thu');
    disp(i);
    A(i,1) = input('Theta = ');
    %A(i,2) = input('E = ');
    A(i,2) = 2*10^9;
    %A(i,3) = input('A = ');
    A(i,3) = 5*10^(-4);
    A(i,4) = input('l = ');
end

k1 = k(A(1,1) ,A(1,2), A(1,3), A(1,4))
k2 = k(A(2,1) ,A(2,2), A(2,3), A(2,4))
k3 = k(A(3,1) ,A(3,2), A(3,3), A(3,4))
k4 = k(A(4,1) ,A(4,2), A(4,3), A(4,4))

%index theo bang ghep noi (sua cho phu hop)
index1 = [1 2 3 4];
index2 = [3 4 5 6];
index3 = [5 6 7 8];
index4 = [7 8 3 4];

%Chuyen k chung (kk la k chung)
kk = zeros(8);
kk1 = kk_build_2D(kk,k1,index1);
kk2 = kk_build_2D(kk,k2,index2);
kk3 = kk_build_2D(kk,k3,index3);
kk4 = kk_build_2D(kk,k4,index4);

kk = kk1 + kk2 + kk3 + kk4


ff = [0; 0; 0; 0; 0; -10^4; 0; 0] %Vector luc nut chung
bcdof = [1 2 4 7 8]; %Cac bac tu do bi rang buoc
bcval = [0 0 0 0 0]; %Gia tri cac rang buoc

[kk,ff] = boundary_apply_2D(kk,ff,bcdof,bcval); %bo hang bo cot
Q = kk\ff %giai phuong trinh
