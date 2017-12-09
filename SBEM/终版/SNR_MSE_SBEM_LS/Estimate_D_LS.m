%在MS端获得的y不包含与自己相同索引的用户参与累加

function MSE=Estimate_D_LS(L,sigma_p)

load ('a_theta.mat');



load ('F.mat');

d=1;    %天线间隔
lambda=2;  %载波波长
M=128; %天线数
P=100; %路径数
K=32;  %用户数




%sigma_p=100;
sigma_n=1;
rho=sigma_p/sigma_n;
P_dt=K*L*rho;
S_dl=zeros(M,M);
Ss_temp=rand(M,M);
S_temp=orth(Ss_temp);
S_dl=S_temp.*sqrt(L*sigma_p);
S_k=sqrt(P_dt/(M*L*sigma_p))*(S_dl');
save S_k.mat S_k;

%生成DL信道h

b_kp=sqrt(1/2)*(randn(K,P) + 1i*randn(K,P)); %信道复增益
h_dl=zeros(M,1,K);

for k=1:K
	h_dl(1:M,1,k)=(1/sqrt(P))*([b_kp(k,:)*a_theta(1:P,1:M,k)].');%%%%%%%
	
end
save h_dl.mat h_dl;


%obtain y at MS

y_dl=zeros(M,1,K);
for k=1:K
	%y_dl_temp=(F*PHI_final(:,:,k)*h_dl(:,:,k))'*S_k+sqrt(sigma_n/2)*(randn(1,M) + 1i*randn(1,M));

	y_dl(:,:,k)=S_k'*h_dl(:,:,k)+(sqrt(sigma_n/2)*(randn(M,1)+ 1i*randn(M,1)));


end
save y_dl.mat y_dl;

%估计dl

h_es_dl=zeros(M,1,K);

S_TEMP=pinv(S_k');
for k=1:K
	h_es_dl(:,:,k)=S_TEMP*y_dl(:,:,k);
   
end

save h_es_dl.mat h_es_dl;

MSE=0;
MSE_temp=0;
for k=1:K
        MSE_temp=((norm(h_dl(:,:,k)-h_es_dl(:,:,k)))^2)/(norm(h_dl(:,:,k)))^2;
        MSE=MSE+MSE_temp;
    end
MSE=MSE/K;
	
