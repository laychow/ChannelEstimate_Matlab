function MSE=Estimate_D(L,sigma_p)

load ('a_theta.mat');
load ('B_index.mat');
load ('S.mat');
load ('PHI_final.mat');

d=1;    %天线间隔
lambda=2;  %载波波长
M=128; %天线数
P=100; %路径数
K=32;  %用户数

tau=16;
%sigma_p=100;
sigma_n=1;
rho=sigma_p/sigma_n;
P_dt=L*rho;
S_k=sqrt(P_dt/(tau*L*sigma_p))*(S');


%生成DL信道h

b_kp=sqrt(1/2)*(randn(K,P) + 1i*randn(K,P)); %信道复增益
h_dl=zeros(M,1,K);

for k=1:K
	h_dl(1:M,1,k)=(1/sqrt(P))*([b_kp(k,:)*a_theta(1:P,1:M,k)].');%%%%%%%
	
end
save h_dl;


%分组
%%相同的index先分到一个cluster里
%{
B_index_cluster=zeros(4,K);%第一行是索引；第二行是cluster号；第三行是组号；第四行是用户号
B_index_cluster(1,:)=B_index;
for i=1:K
        B_index_cluster(4,i)=i; 
end

for i=1:K
    for j=i+1:K
        if B_index_cluster(1,i)>B_index_cluster(1,j)
            temp=B_index_cluster(:,i);
            B_index_cluster(:,i)=B_index_cluster(:,j);
            B_index_cluster(:,j)=temp;
        end
    end
end

mark=0;
for g=1:K
	for k_g=g:K
		if(B_index_cluster(2,k_g)==0)
			B_index_cluster(2,k_g)=g;
			mark=k_g;
			break;
        end
    end
	for k_g=(mark+1):K
		if(B_index_cluster(1,k_g)==B_index_cluster(1,k_g-1))
			B_index_cluster(2,k_g)=g;
		else 
			break;
		end
    end
    if(B_index_cluster(2,K)~=0)
        break;
    end
end
%}
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
	    	if (B_index_clu_grouped(1,mark+a)==B_index_clu_grouped(1,mark))||((B_index_clu_grouped(1,mark+a)-B_index_clu_grouped(1,mark))>=(tau+OMEGA-1))
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




%obtain y at MS

y_dl=zeros(L,1,K);
for i=1:K
	g=B_index_clu_grouped(2,i);
	Y_temp=zeros(1,L);
	for k=1:K
		if B_index_clu_grouped(2:k)==g
			index_d=B_index_clu_grouped(1,k);
			Y_temp=Y_temp+((F(index_d:index_d+tau-1,:)*PHI_final(:,:,k)*h_dl(:,:,i))')*S_k;
		end
	end
	y_dl(:,:,i)=(Y_temp+sqrt(sigma_n/2)*(randn(1,L) + 1i*randn(1,L)))';
end


%估计dl
h_es_dl=zeros(M,1,K);
for k=1:K
	index_d=B_index_clu_grouped(1,k);
	F_TEMP=F';
	S_TEMP=pinv(S_k');
	h_es_dl(:,:,k)=(PHI_final(:,:,k))'*F_TEMP(1:M,index_d:index_d+tau-1)*S_TEMP*y_dl(:,:,k);
end

MSE=0;
MSE_temp=0;
for k=1:K
        MSE_temp=((norm(h_dl(:,:,k)-h_es_dl(:,:,k)))^2)/(norm(h_dl(:,:,k)))^2;
        MSE=MSE+MSE_temp;
    end
MSE=MSE/K;
	
