clear all;
clc;
d=1;    %天线间隔
lambda=2;  %载波波长
M=128; %天线数
P=100; %路径数
K=2;  %用户数
z=pi/180;  %角度弧度变换系数
theta_Option=[-48.59,-14.18,14.48,48.59].*z;
theta_AS=2*z;
theta=zeros(P,K);
for i=1:K
	index_matrix=randperm(4);
    theta_low=theta_Option(index_matrix(1))-theta_AS;
    theta_up=theta_Option(index_matrix(1))+theta_AS;
	theta(1:P,i)=unifrnd(theta_low,theta_up,P,1);
end
F=zeros(M,M);
for i=1:M
    for j=1:M
        F(i,j)=exp(1i*(2*pi/M)*(i-1)*(j-1))/sqrt(M);
    end
end

a_theta=zeros(P,M,K);
for k=1:K
	for i=1:P
		for j=1:M
			a_theta(i,j,k)=exp(1i*(2*pi*d/lambda)*(j-1)*sin(theta(i,k)));
		end
	end
end

%多用户

a=randn(1,P) + 1i*randn(1,P); %复增益系数
h=zeros(M,1,K);
h1=zeros(M,1,K);   %DFT后h
for k=1:K
	h(1:M,1,k)=(1/sqrt(P))*([a*a_theta(1:P,1:M,k)]');
	h1(1:M,1,k)=F*h(1:M,1,k);
end

%加旋转参数

B_index=zeros(1,K);  %只记录第一个索引，索引集为[B_index~B_index+tau-1]
h2=zeros(M,1,K);  %DFT & 旋转 后的h
V=100; %扫描精度
tau=16;
phi=pi/(V*M);
PHI=zeros(M,M,K);
phi_final=zeros(1,K);
PHI_final=zeros(M,M,K);

for k=1:K
	H_max=0;
	h_max=0;
	h_percent=0;
	for j=1:V
		for i=1:M
			PHI(i,i,k)=exp(1i*(i-1)*phi*j);
		end
		h2(1:M,1,k)=F*PHI(1:M,1:M,k)*h(1:M,1,k);
		for l=1:(M-tau+1)
			h_percent=norm(h2(l:l+tau-1,1,k))/norm(h2(1:M,1,k));  %Attention：这里直接用的模值并没有算平方
		    if h_percent>h_max
		    	h_max=h_percent;
		    	B_index(k)=l;
		    end
		end
		if h_max>H_max
			H_max=h_max;
			phi_final(k)=phi*j;
		end
	end
	for i=1:M
		PHI_final(i,i,k)=exp(1i*(i-1)*phi_final(k));
	end
end
for k=1:K
	h2(:,:,k)=F*PHI_final(:,:,k)*h(:,:,k);
end

%画图

%{
subplot(2,1,1);
stem(1:M,abs(h1(:,:,3)));
title('without spatial rotation');

subplot(2,1,2);
stem(1:M,abs(h2(:,:,3)));
title('with spatial rotation');



for k=1:K
	subplot(K,2,2*k-1);
	stem(1:M,abs(h1(:,:,k)));
    title('without spatial rotation');
    subplot(K,2,2*k);
    stem(1:M,abs(h2(:,:,k)));
    title('with spatial rotation');
end
%}
