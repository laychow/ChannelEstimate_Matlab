%按照上行的分组方法
function MSE=Estimate_D_test2(L,sigma_p)

load ('a_theta.mat');
load ('B_index.mat');
%load ('S.mat');
load ('PHI_final.mat');
load ('F.mat');
load ('B_index_grouped')
d=1;    %天线间隔
lambda=2;  %载波波长
M=128; %天线数
P=100; %路径数
K=32;  %用户数

tau=16;

OMEGA=tau/4;
%sigma_p=100;
sigma_n=1;
rho=sigma_p/sigma_n;
P_dt=L*rho;
S_dl=zeros(L,tau);
Ss_temp=rand(L,L);
S_temp=orth(Ss_temp);
S_dl=S_temp(:,1:tau).*sqrt(L*sigma_p);
S_k=sqrt(P_dt/(tau*L*sigma_p))*(S_dl');


%生成DL信道h

b_kp=sqrt(1/2)*(randn(K,P) + 1i*randn(K,P)); %信道复增益
h_dl=zeros(M,1,K);

for k=1:K
	h_dl(1:M,1,k)=(1/sqrt(P))*([b_kp(k,:)*a_theta(1:P,1:M,k)].');%%%%%%%
	
end
save h_dl.mat h_dl;



%obtain y at MS

y_dl=zeros(L,1,K);
for i=1:K
	g=B_index_grouped(2,i);
	Y_temp=zeros(1,L);
%     Y_tempp=zeros(1,M);
	for k=1:K
        if (B_index_grouped(2,k)==g)
			index_d=B_index_grouped(1,k);
%             Y_tempp=(F*PHI_final(:,:,k)*h_dl(:,:,k))';
%             Y_temp=Y_temp+Y_tempp(:,index_d:index_d+tau-1)*S_k;
            
			Y_temp=Y_temp+((F(index_d:index_d+tau-1,:)*PHI_final(:,:,k)*h_dl(:,:,i))')*S_k;
		end
	end
	y_dl(:,:,i)=(Y_temp+sqrt(sigma_n/2)*(randn(1,L) + 1i*randn(1,L)))';
end
save y_dl.mat y_dl;

%估计dl
h_es_dl_before=zeros(M,1,K);
h_es_dl=zeros(M,1,K);
h_es_dl_temp=zeros(tau,1,K);
h_es_dl_tempp=zeros(M,1,K);
S_TEMP=pinv(S_k');
for k=1:K
	index_d=B_index_grouped(1,k);
    h_es_dl_temp(:,:,k)=S_TEMP*y_dl(:,:,k);
	h_es_dl_tempp(index_d:index_d+tau-1,:,k)=h_es_dl_temp(:,:,k);
	h_es_dl(:,:,k)=(PHI_final(:,:,k)')*(F')*h_es_dl_tempp(:,:,k);
   
end
save h_es_dl_temp.mat h_es_dl_temp ;
save h_es_dl_tempp.mat h_es_dl_tempp;
save S_TEMP.mat S_TEMP;
save S_k.mat S_k;

save h_es_dl.mat h_es_dl;


MSE=0;
MSE_temp=0;

for k=1:K
     MSE_temp=((norm(h_dl(:,:,k)-h_es_dl(:,:,k)))^2)/(norm(h_dl(:,:,k)))^2;
     MSE=MSE+MSE_temp;
end
MSE=MSE/K;
	
