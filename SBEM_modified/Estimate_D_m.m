%来自作者的权威认证！！！
%同一个cluster只累加一次，phi取平均

function MSE=Estimate_D_m(L,sigma_p)

load ('a_theta.mat');
load ('B_index.mat');

load ('tau_final.mat');
load ('phi_final.mat');
load ('F.mat');

d=1;    %天线间隔
lambda=2;  %载波波长
M=128; %天线数
P=100; %路径数
K=32;  %用户数

tau=tau_final;

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
	h_dl(1:M,1,k)=(1/sqrt(P))*((b_kp(k,:)*a_theta(1:P,1:M,k)).');%%%%%%%
	
end



B_index_clu_grouped=zeros(3,K);%第一行是索引；第二行是组号；第三行是用户号
B_index_clu_grouped(1,:)=B_index;
for i=1:K
    B_index_clu_grouped(3,i)=i; 
end
mark=0;

for i=1:K
    for j=i+1:K
        if B_index_clu_grouped(1,i)>B_index_clu_grouped(1,j)
            temp=B_index_clu_grouped(:,i);
            B_index_clu_grouped(:,i)=B_index_clu_grouped(:,j);
            B_index_clu_grouped(:,j)=temp;
        end
    end
end


for g=1:K
	for k_g=g:K
		if(B_index_clu_grouped(2,k_g)==0)
			B_index_clu_grouped(2,k_g)=g;
			mark=k_g;
			break;
        end
    end
    a=1;
    while mark+a<=K
    	if (B_index_clu_grouped(2,mark+a)==0)&&(B_index_clu_grouped(2,mark+a)~=g)
	    	if (B_index_clu_grouped(1,mark+a)==B_index_clu_grouped(1,mark))||(((B_index_clu_grouped(1,mark+a)-B_index_clu_grouped(1,mark))>=(tau+OMEGA-1))&&(B_index_clu_grouped(1,k_g)+M-B_index_clu_grouped(1,mark+a))>=(tau+OMEGA-1))
	    		B_index_clu_grouped(2,mark+a)=g;
	    		mark=mark+a;
	    		a=1;

	    	else 
	    		a=a+1;
            end
        else a=a+1;
	    end
	end
end

for i=1:K
    for j=i+1:K
        if B_index_clu_grouped(3,i)>B_index_clu_grouped(3,j)
            temp=B_index_clu_grouped(:,i);
            B_index_clu_grouped(:,i)=B_index_clu_grouped(:,j);
            B_index_clu_grouped(:,j)=temp;
        end
    end
end
Group_clu_number=max(B_index_clu_grouped(2,:));
save B_index_clu_grouped.mat B_index_clu_grouped;
%扫描每组重复数量
repeat_index=zeros(1,K);
for k=1:K
	re=B_index_clu_grouped(1,k);
	num=0;
	for s=1:K
		if B_index_clu_grouped(1,s)==re
			num=num+1;
		end
	end
	repeat_index(k)=num;
end
save repeat_index.mat repeat_index;

%处理phi
phi_new=zeros(1,K);
for k=1:K
    re=B_index_clu_grouped(1,k);
    tep=0;
    for s=1:K
        if B_index_clu_grouped(1,s)==re
            tep=tep+phi_final(s);
        end
    end
    phi_new(k)=tep/repeat_index(k);
end


PHI_final_new=zeros(M,M,K);
for k=1:K
    for i=1:M
        PHI_final_new(i,i,k)=exp(1i*(i-1)*phi_new(k));
    end
end
save PHI_final_new.mat PHI_final_new;
%obtain y at MS
y_dl=zeros(L,1,K);
for i=1:K
    g=B_index_clu_grouped(2,i);
    Y_temp=zeros(1,L);
    for k=1:K
        if (B_index_clu_grouped(2,k)==g)&&((k==i)||(B_index_clu_grouped(1,k)~=B_index_clu_grouped(1,i)))
            index_d=B_index_clu_grouped(1,k);
            if (index_d<(M-tau+1))
                Y_temp=Y_temp+((F(index_d:index_d+tau-1,:)*PHI_final_new(:,:,k)*h_dl(:,:,i))')*S_k;
            else 
                F_temp=zeros(tau,M);
                F_temp(1:M-index_d+1,:)=F(index_d:M,:);
                F_temp(M-index_d+2:tau,:)=F(1:index_d+tau-M-1,:);
                Y_temp=Y_temp+((F_temp*PHI_final_new(:,:,k)*h_dl(:,:,i))')*S_k;
            end    
        end
    end
    y_dl(:,:,i)=(Y_temp+sqrt(sigma_n/2)*(randn(1,L) + 1i*randn(1,L)))';
end





%{
y_dl=zeros(L,1,K);
for i=1:K
	g=B_index_clu_grouped(2,i);
	Y_temp=zeros(1,L);
%     Y_tempp=zeros(1,M);
	for k=1:K
        if k==i
            index_d=B_index_clu_grouped(1,k);
            Y_temp=Y_temp+((F(index_d:index_d+tau-1,:)*PHI_final(:,:,k)*h_dl(:,:,i))')*S_k;
        elseif (B_index_clu_grouped(2,k)==g)&&(B_index_clu_grouped(1,k)~=B_index_clu_grouped(1,i))
			index_d=B_index_clu_grouped(1,k);
%             Y_tempp=(F*PHI_final(:,:,k)*h_dl(:,:,k))';
%             Y_temp=Y_temp+Y_tempp(:,index_d:index_d+tau-1)*S_k;
            
			Y_temp=Y_temp+((F(index_d:index_d+tau-1,:)*PHI_final(:,:,k)*h_dl(:,:,i))')*S_k;
		end
	end
	y_dl(:,:,i)=(Y_temp+sqrt(sigma_n/2)*(randn(1,L) + 1i*randn(1,L)))';
end
save y_dl.mat y_dl;
%}


%估计dl
h_es_dl_before=zeros(M,1,K);
h_es_dl=zeros(M,1,K);
h_es_dl_temp=zeros(tau,1,K);
h_es_dl_tempp=zeros(M,1,K);
S_TEMP=pinv(S_k');
for k=1:K
	index_d=B_index_clu_grouped(1,k);
    h_es_dl_temp(:,:,k)=S_TEMP*y_dl(:,:,k);
    if (index_d<(M-tau+1))
        h_es_dl_tempp(index_d:index_d+tau-1,:,k)=h_es_dl_temp(:,:,k);
    else
        h_es_dl_tempp(index_d:M,:,k)=h_es_dl_temp(1:M-index_d+1,:,k);
        h_es_dl_tempp(1:index_d+tau-M-1,:,k)=h_es_dl_temp(M-index_d+2:tau,:,k);
    end
	h_es_dl(:,:,k)=(PHI_final_new(:,:,k)')*(F')*h_es_dl_tempp(:,:,k);
   
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
	
