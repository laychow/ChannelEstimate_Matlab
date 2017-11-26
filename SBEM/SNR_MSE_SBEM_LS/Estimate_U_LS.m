function MSE=Estimate_U_LS(L,sigma_p)
d=1;    %天线间隔
lambda=2;  %载波波长 
M=128; %天线数
P=100; %路径数
K=32;  %用户数
z=pi/180;  %角度转弧度
tau=32;
AS=4;
%tau=16;
G=ceil(K/tau);
theta_Option=[-48.59,-14.48,14.48,48.59].*z;
theta_AS=AS*z;
%sigma_p=100;
sigma_n=1;
rho=sigma_p/sigma_n;
P_ut=L*rho;
d_k=P_ut/(L*(sigma_p));
theta=zeros(P,K);

for i=1:K
	index_matrix(:,i)=randperm(4);
    theta_low=theta_Option(index_matrix(1,i))-theta_AS;
    theta_up=theta_Option(index_matrix(1,i))+theta_AS;
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
	h_ul(1:M,1,k)=(1/sqrt(P))*([a_kp(k,:)*a_theta(1:P,1:M,k)].');%%%%%%%
	
end
save h_ul.mat h_ul;

if L>tau
    S=zeros(L,tau);
    temmp=max(L,L);
    Ss_temp=rand(temmp,temmp);
    S_temp=orth(Ss_temp);
    S=S_temp(1:L,1:tau)*sqrt(L*sigma_p);
    %%在BS端获得Y
    Y=zeros(M,L);
    for k=1:K
        Y=Y+sqrt(d_k)*h_ul(:,:,k)*(S(:,k)');
    end
    Y=Y+sqrt(sigma_n/2)*(randn(M,L) + 1i*randn(M,L));


    %%UL估计
    h_es_ul=zeros(M,1,K);
    for k=1:K
        h_es_ul(:,:,k)=(1/(sqrt(d_k)*(L*sigma_p)))*Y*S(:,k);
    end




else
    S=zeros(L,L);%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    Ss_temp1=rand(L,L);
    S_temp1=orth(Ss_temp1);
    S=S_temp1*sqrt(L*sigma_p);
    %%在BS端获得Y(分两次传输）
    Y=zeros(M,L,2);
    for k=1:(K/2)
        Y(:,:,1)=Y(:,:,1)+sqrt(d_k)*h_ul(:,:,k)*(S(:,k)');
    end
    Y(:,:,1)=Y(:,:,1)+sqrt(sigma_n/2)*(randn(M,L) + 1i*randn(M,L));
    for k=(K/2+1):K
        Y(:,:,2)=Y(:,:,2)+sqrt(d_k)*h_ul(:,:,k)*(S(:,(k-16))');
    end
    Y(:,:,2)=Y(:,:,2)+sqrt(sigma_n/2)*(randn(M,L) + 1i*randn(M,L));
    
   %%UL估计
    h_es_ul=zeros(M,1,K);
    for k=1:(K/2)
        h_es_ul(:,:,k)=(1/(sqrt(d_k)*(L*sigma_p)))*Y(:,:,1)*S(:,k);
    end 
    for k=(K/2+1):K
        h_es_ul(:,:,k)=(1/(sqrt(d_k)*(L*sigma_p)))*Y(:,:,2)*S(:,(k-16));
    end 

end

MSE=0;
MSE_temp=0;
for k=1:K
        MSE_temp=((norm(h_ul(:,:,k)-h_es_ul(:,:,k)))^2)/(norm(h_ul(:,:,k)))^2;
        MSE=MSE+MSE_temp;
    end
MSE=MSE/K;

save a_theta.mat a_theta;


save F.mat F;






        




                


