% D?M <4.3>
clear
clc
% B1: MÔ HÌNH HÓA
noe = 2; % T?ng s? ph?n t? c?a c? h?
nnel = 2; % S? nút c?a m?i ph?n t?
ndof = 2; % S? b?c t? do t?i m?i nút
nnode=(nnel-1)*noe+1; % t?ng s? nút c?a c? h?
sdof=nnode*ndof; % t?ng s? b?c t? do c?a c? h?
edof=nnel*ndof; % t?ng s? b?c t? do c?a m?i ph?n t?
ff=zeros(sdof,1);
k=zeros(edof,edof);
kk=zeros(sdof,sdof);
index=zeros(edof,1);
Index=zeros(edof,noe);

E=[200*10^9; 200*10^9];
J=[3.9761*10^-8; 7.854*10^-9];
l=[0.12; 0.12];
area=[1; 1];

bcdof=[1 2 5]; % ??t chuy?n v? nút 1 b? ràng bu?c b?i ?K biên
bcval=[0 0 0]; % Giá tr?

% B2: B?NG GHÉP N?I PH?N T? <ch?nh s?a b?ng tay>
Index(:,1)=[1;2;3;4];
Index(:,2)=[3;4;5;6];
% B3: MA TR?N ?? C?NG CÁC PH?N T?
[k1,kk]=ki_build_normal(1,E,J,l,area,Index,edof,index,kk,k);
[k2,kk]=ki_build_normal(2,E,J,l,area,Index,edof,index,kk,k);

disp('MA TRAN DO CUNG CUA PHAN TU 1:')
k1
disp('MA TRAN DO CUNG CUA PHAN TU 2:')
k2

% for iel=1:noe
%     for i=1:edof
%         index(i)=Index(i,iel);
%     end
%     disp('Ma tran do cung tung thanh: ')
%     k=HermitianBeam(E(iel),J(iel),l(iel),area(iel))
%     kk=kk_build_2D(kk,k,index);
% end    

% B4: MA TR?N ?? C?NG K CHUNG
disp('MA TRAN DO CUNG TONG THE:')
kk

% B5: VECTO L?C NÚT CHUNG <ch?nh s?a b?ng tay>
ff=[-12;-0.24;-1000-12;0.24;0;-5000];

% B6: GI?I H? PH??NG TRÌNH KQ=F
[kk,ff]=boundary_apply_2D(kk,ff,bcdof,bcval);
Q=kk^-1*ff;
disp('CHUYEN VI TAI CAC NUT: ')
Q

% CÁC HÀM DÙNG TRONG CH??NG TRÌNH
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

function k=HermitianBeam(E,J,l,area)
c=E*J/(l^3);
k=c*[12 6*l -12 6*l;6*l 4*l^2 -6*l 2*l^2;-12 -6*l 12 -6*l;6*l 2*l^2 -6*l 4*l^2];
end

function [k,kk]=ki_build_normal(iel,E,J,l,area,Index,edof,index,kk,k)
    for i=1:edof
        index(i)=Index(i,iel);
    end
    k=HermitianBeam(E(iel),J(iel),l(iel),area(iel));
    kk=kk_build_2D(kk,k,index);
end

function [k,kk]=ki_build_unnormal(iel,E,J,l,area,Index,edof,index,kk,k)
    for i=1:edof
        index(i)=Index(i,iel);
    end
    c=3*E(iel)*J(iel)/(l(iel)^3);
    k=c*[1 l(iel) -1 0;l(iel) l(iel)^2 -l(iel) 0;-1 -l(iel) 1 0;0 0 0 0];
    kk=kk_build_2D(kk,k,index);
end

function [kk] = kk_build_2D(kk,k,index)
edof = length(index);
for i=1:edof
    ii = index(i);
    for j=1:edof
        jj = index(j);
        kk(ii,jj)=kk(ii,jj)+k(i,j);
    end
end
end
