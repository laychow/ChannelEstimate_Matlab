clear all;
clc;
M=128;
P=9;
z=pi/180;
F=zeros(M,M);
for i=1:M
    for j=1:M
        F(i,j)=exp(-1i*(2*pi/M)*(i-1)*(j-1))/sqrt(M);
    end
end
theta=unifrnd(25*z,29*z,P,1);
a_the=zeros(P,M);
for i=1:P
	for j=1:M
		a_the(i,j)=exp(1i*pi*(j-1)*sin(theta(i)));
	end
end

%单用户k

a=randn(1,P) + 1i*randn(1,P) ;
h=zeros(M,1);
h=(1/sqrt(P))*([a*a_the]');
h1=F*h;   %DFT变换之后h
subplot(2,1,1);
stem(1:M,abs(h1));
title('without spatial rotation');



%加旋转参数

%{
phi=pi/(6*M); 
PHI=zeros(M,M);
for i=1:M
	PHI(i,i)=exp(1i*(i-1)*phi);
end
h2=F*PHI*h; %旋转后h
subplot(2,1,2);
stem(1:M,abs(h2));
title('with spatial rotation');
%}

V=100;    %扫描精度
tau=16;
phi=pi/(V*M); 
PHI=zeros(M,M);
phi_final=0;
H_max=0;
h_max=0;
h_temp=0;
for j=1:V
	for i=1:M
		PHI(i,i)=exp(1i*(i-1)*phi*j);
	end
	h2=F*PHI*h; %旋转后h
	for k=1:M-tau+1
		h_temp=norm(h2(k:k+tau-1,:))/norm(h2);
		if h_temp>h_max
			h_max=h_temp;
        end
    end
	if h_max>H_max
		H_max=h_max;
		phi_final=phi*j;
	end
end

PHI_final=zeros(M,M);
for i=1:M
	PHI_final(i,i)=exp(1i*(i-1)*phi_final);
end
h2=F*PHI_final*h; %旋转后h
subplot(2,1,2);
stem(1:M,abs(h2));
title('with spatial rotation');







