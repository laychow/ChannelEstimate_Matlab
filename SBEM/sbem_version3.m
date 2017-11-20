clear all;
clc;
d=1;    %天线间隔
lambda=2;  %载波波长
M=128; %天线数
P=100; %路径数
K=32;  %用户数
z=pi/180;  %角度转弧度
tau=16;
theta_Option=[-48.59,-14.48,14.48,48.59].*z;
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
        F(i,j)=exp(-1i*(2*pi/M)*(i-1)*(j-1))/sqrt(M);
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

a_kp=sqrt(1/2)*(randn(K,P) + 1i*randn(K,P)); %复增益系数
h=zeros(M,1,K);

for k=1:K
	h(1:M,1,k)=(1/sqrt(P))*([a_kp(k,:)*a_theta(1:P,1:M,k)]');
	
end
save h;