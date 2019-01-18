clc;
points = [0 1 0 0 2 0.5 2 1]; % Toa do cac diem
type = 1;
E = 3*1e7; % Pa, N/m2
v=0.3;
t=0.01; % m
W1=1;
W2=1;
disp('TINH MA TRAN DO CUNG THANH PHAN')
[k1, b1]=ki_build(points, type, -0.5773, -0.5773, E, v, t, W1, W1)
[k2, b2]=ki_build(points, type, 0.5773, -0.5773, E, v, t, W2, W1)
[k3, b3]=ki_build(points, type, 0.5773, 0.5773, E, v, t, W2, W2)
[k4, b4]=ki_build(points, type, -0.5773, 0.5773, E, v, t, W1, W2)
disp('TINH MA TRAN DO CUNG CHUNG')
k=k1+k2+k3+k4 % N/m
ff=[0; -0.2; 0; 0; 0; 0; 0; -0.2] % N
bcdof = [1 2 3 4]; %Cac bac tu do bi rang buoc
bcval = [0 0 0 0]; %Gia tri cac rang buoc

[kk,ff] = boundary_apply_2D(k,ff,bcdof,bcval)
disp('TINH CHUYEN VI')
Q = kk\ff %giai phuong trinh
if type == 1 %Ung suat phang
     D=E/(1-v^2)*[1 v 0; v 1 0; 0 0 (1-v)/2]  % N/m2
end
if type == 2 %Bien dang phang
     D=E/((1+v)*(1-2*v))*[1-v v 0; v 1-v 0; 0 0 (1-2*v)/2]  % N/m2
end
% Tinh ung suat
disp('TINH UNG SUAT')
s1=D*b1*Q  % N/m2
s2=D*b2*Q
s3=D*b3*Q
s4=D*b4*Q

% CAC HAM DUOC SU DUNG
function [ki, bi] = ki_build(points, type, n, e, E, v, t, W01, W02)
    % Diem 1
    x1=points(1);
    y1=points(2);

    % Diem 2
    x2=points(3);
    y2=points(4);

    % Diem 3
    x3=points(5);
    y3=points(6);
    
    % Diem 4
    x4=points(7);
    y4=points(8);    
    
    J11=0.25*((1-n)*(x2-x1)+(1+n)*(x3-x4));
    J12=0.25*((1-n)*(y2-y1)+(1+n)*(y3-y4));
    J21=0.25*((1-e)*(x4-x1)+(1+e)*(x3-x2));
    J22=0.25*((1-e)*(y4-y1)+(1+e)*(y3-y2));
    J=[J11 J12; J21 J22]
    
    A=1/det(J)*[J22 -J12 0 0; 0 0 -J21 J11; -J21 J11 J22 -J12]
    
    G=0.25*[n-1 0 1-n 0 1+n 0 -1-n 0; e-1 0 -1-e 0 1+e 0 1-e 0; 0 n-1 0 1-n 0 1+n 0 -1-n; 0 e-1 0 -1-e 0 1+e 0 1-e]
    
    B=A*G;
    bi=B;
    
    if type == 1 %Ung suat phang
        D=E/(1-v^2)*[1 v 0; v 1 0; 0 0 (1-v)/2]
    end
    if type == 2 %Bien dang phang
        D=E/((1+v)*(1-2*v))*[1-v v 0; v 1-v 0; 0 0 (1-2*v)/2]
    end
    
    ki = t*B'*D*B*det(J)*W01*W02;
end

function [kk,ff] = boundary_apply_2D(kk,ff,bcdof,bcval)
    n = length(bcdof);
    sdof = size(kk);
    for i=1:n
        c=bcdof(i);
        for j=1:sdof
            kk(c,j)=0;
            kk(j,c)=0;
        end
        kk(c,c)=1;
        ff(c)=bcval(i);
    end
end


    
    
    
    
    
    
    
    
    
    
    
    