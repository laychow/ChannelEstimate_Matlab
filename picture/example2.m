d=1;    %天线间隔
lambda=2;  %载波波长   Carrier frequency 2 GHz
M=128; %天线数
P=100; %路径数
K=1;  %用户数
z=pi/180;  %角度转弧度
tau=16;
AS=4;
G=ceil(K/tau);
theta_Option=1*z;
L=16;

theta_AS=AS*z;
OMEGA=tau/4;    %组之间最小间隔
sigma_p=1;
sigma_n=1;
rho=sigma_p/sigma_n;

theta=zeros(P,K);
for i=1:K
%	index_matrix(:,i)=randperm(4);
    theta_low=theta_Option(i)-theta_AS/2;
    theta_up=theta_Option(i)+theta_AS/2;
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

%生成信道
%a_kp=(randn(K,P) + 1i*randn(K,P));
a_kp=sqrt(1/2)*(randn(K,P) + 1i*randn(K,P)); %信道复增益
h_ul=zeros(M,1,K);

for k=1:K
	h_ul(1:M,1,k)=(1/sqrt(P))*((a_kp(k,:)*a_theta(:,:,k)).');%%%%%%%
	
end
save h_ul.mat h_ul;




B_index=zeros(1,K);  %只记录起始索引[B_index~B_index+tau-1]
b_index=zeros(1,K);
h1=zeros(M,1,K);
h2=zeros(M,1,K);  %DFT 后的h
V=100;  %扫描精度
%tau=16;
phi=2*pi/(V*M);
PHI=zeros(M,M,K);
phi_final=zeros(1,K);
PHI_final=zeros(M,M,K);

for k=1:K
    H_max=0;
    h_max=0;
    h_percent=0;
    for j=1:(V+1)
        for i=1:M
            PHI(i,i,k)=exp(1i*(i-1)*(phi*(j-1)-pi/M));
        end
        h2(:,:,k)=F*PHI(:,:,k)*h_ul(:,1,k);
        for l=1:(M-tau+1)
            h_percent=(norm(h2(l:l+tau-1,1,k)))^2/(norm(h2(1:M,1,k)))^2;  %Attention
            %h_percent=norm(h2(l:l+tau-1,1,k));
            if h_percent>h_max
                h_max=h_percent;
                b_index(k)=l;
            end
        end
        if h_max>H_max
            H_max=h_max;
            B_index(k)=b_index(k);
            phi_final(k)=(phi*(j-1)-pi/M);
        end
    end
    for i=1:M
        PHI_final(i,i,k)=exp(1i*(i-1)*phi_final(k));
    end
end

subplot(2,1,1);
stem(1:M,abs(F*PHI_final*h_ul));
title('$$\theta _{k}= 1^{\circ  }$$','Interpreter','latex');
xlabel('q');
ylabel('$$|{{\rm\textbf{h}}}_k^{F,ro}|$$','Interpreter','latex');

d=1;    %天线间隔
lambda=2;  %载波波长   Carrier frequency 2 GHz
M=128; %天线数
P=100; %路径数
K=1;  %用户数
z=pi/180;  %角度转弧度
tau=16;
AS=4;
G=ceil(K/tau);
theta_Option=-1*z;
L=16;

theta_AS=AS*z;
OMEGA=tau/4;    %组之间最小间隔
sigma_p=1;
sigma_n=1;
rho=sigma_p/sigma_n;

theta=zeros(P,K);
for i=1:K
%	index_matrix(:,i)=randperm(4);
    theta_low=theta_Option(i)-theta_AS/2;
    theta_up=theta_Option(i)+theta_AS/2;
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

%生成信道
%a_kp=(randn(K,P) + 1i*randn(K,P));
a_kp=sqrt(1/2)*(randn(K,P) + 1i*randn(K,P)); %信道复增益
h_ul=zeros(M,1,K);

for k=1:K
	h_ul(1:M,1,k)=(1/sqrt(P))*((a_kp(k,:)*a_theta(:,:,k)).');%%%%%%%
	
end
save h_ul.mat h_ul;




B_index=zeros(1,K);  %只记录起始索引[B_index~B_index+tau-1]
b_index=zeros(1,K);
h1=zeros(M,1,K);
h2=zeros(M,1,K);  %DFT 后的h
V=100;  %扫描精度
%tau=16;
phi=2*pi/(V*M);
PHI=zeros(M,M,K);
phi_final=zeros(1,K);
PHI_final=zeros(M,M,K);

for k=1:K
    H_max=0;
    h_max=0;
    h_percent=0;
    for j=1:(V+1)
        for i=1:M
            PHI(i,i,k)=exp(1i*(i-1)*(phi*(j-1)-pi/M));
        end
        h2(:,:,k)=F*PHI(:,:,k)*h_ul(:,1,k);
        for l=1:(M-tau+1)
            h_percent=(norm(h2(l:l+tau-1,1,k)))^2/(norm(h2(1:M,1,k)))^2;  %Attention
            %h_percent=norm(h2(l:l+tau-1,1,k));
            if h_percent>h_max
                h_max=h_percent;
                b_index(k)=l;
            end
        end
        if h_max>H_max
            H_max=h_max;
            B_index(k)=b_index(k);
            phi_final(k)=(phi*(j-1)-pi/M);
        end
    end
    for i=1:M
        PHI_final(i,i,k)=exp(1i*(i-1)*phi_final(k));
    end
end


subplot(2,1,2);
stem(1:M,abs(F*PHI_final*h_ul));
title('$$\theta _{k}= -1^{\circ  }$$','Interpreter','latex');
xlabel('q');
ylabel('$$|{{\rm\textbf{h}}}_k^{F,ro}|$$','Interpreter','latex');