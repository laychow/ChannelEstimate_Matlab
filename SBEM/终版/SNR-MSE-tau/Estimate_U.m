function MSE=Estimate_U(tau,sigma_p)
d=1;    %天线间隔
lambda=2;  %载波波长 
M=128; %天线数
P=100; %路径数
K=32;  %用户数
z=pi/180;  %角度转弧度
L=32;
AS=4;
G=ceil(K/tau);
theta_Option=[-48.59,-14.48,14.48,48.59].*z;
theta_AS=AS*z;
OMEGA=tau/4;    %组之间最小间隔
sigma_n=1;
rho=sigma_p/sigma_n;

theta=zeros(P,K);
index_matrix=zeros(4,K);
for i=1:K
	index_matrix(:,i)=randperm(4);
    theta_low=theta_Option(index_matrix(1,i))-theta_AS/2;
    theta_up=theta_Option(index_matrix(1,i))+theta_AS/2;
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


S=zeros(L,tau);
Ss_temp=rand(L,L);
S_temp=orth(Ss_temp);
S=S_temp(:,1:tau).*sqrt(L*sigma_p);


if tau~=32                               %SBEM方法

    h_es_pre=zeros(M,1,K);

    %preamble 生成Y

    Y_pre=zeros(M,L,G);
    P_ut=L*rho;
    d_k=P_ut/(L*(sigma_p));
    %N=sqrt(sigma_n/2)*(randn(M,L) + 1i*randn(M,L));%s = sqrt(var/2)*(randn(1,K) +j*randn(1,K))


    for g=1:G
        for t=1:tau
            if t+(g-1)*tau>K 
                break;
            end
            Y_tem=sqrt(d_k)*h_ul(:,:,t+(g-1)*tau)*(S(:,t)');
            Y_pre(:,:,g)=Y_pre(:,:,g)+Y_tem;
        end
        Y_pre(:,:,g)=Y_pre(:,:,g)+sqrt(sigma_n/2)*(randn(M,L) + 1i*randn(M,L));
    end

    for g=1:G
        for t=1:tau
            if (t+(g-1)*tau)>K 
                break;
            end
            h_es_pre(:,:,t+(g-1)*tau)=(1/(sqrt(d_k)*(L*sigma_p)))*Y_pre(:,:,g)*S(:,t);
        end
    end

    %获得空间信息

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
            h2(:,:,k)=F*PHI(:,:,k)*h_es_pre(:,1,k);
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
    for k=1:K
        h1(:,:,k)=F*h_es_pre(:,:,k);
        h2(:,:,k)=F*PHI_final(:,:,k)*h_es_pre(:,:,k);
    end



    


    %%分组
    B_index_grouped=zeros(3,K);%第一行表示索引，第二行表示组号，第三行表示用户号
    B_index_grouped(1,1:K)=B_index; 
    B_index_grouped(2,1:K)=0; 
    for i=1:K
        B_index_grouped(3,i)=i; 
    end


    for i=1:K
        for j=i+1:K
            if B_index_grouped(1,i)>B_index_grouped(1,j)
                temp=B_index_grouped(:,i);
                B_index_grouped(:,i)=B_index_grouped(:,j);
                B_index_grouped(:,j)=temp;
            end
        end
    end


    for g=1:K
        for k_s=g:K
            if k_s==1 
                B_index_grouped(2,k_s)=1;
                k=k_s;
                break;

            elseif (B_index_grouped(2,k_s)~=(g-1))&&(B_index_grouped(2,k_s)==0)
                B_index_grouped(2,k_s)=g;
                k=k_s;
                break;
            end
        end
        a=1;
        while k+a<=K
            if B_index_grouped(2,k+a)~=g
                if (B_index_grouped(1,k+a)-B_index_grouped(1,k))>=(tau+OMEGA-1)&&(B_index_grouped(2,k+a)==0)
                    B_index_grouped(2,k+a)=g;
                    k=k+a;
                    a=1;
                else a=a+1;
                end
            else a=a+1;
            end
        end
    end


    for i=1:K
        for j=i+1:K
            if B_index_grouped(3,i)>B_index_grouped(3,j)
                temp=B_index_grouped(:,i);
                B_index_grouped(:,i)=B_index_grouped(:,j);
                B_index_grouped(:,j)=temp;
            end
        end
    end
    Group_number=max(B_index_grouped(2,:));


    if Group_number>tau
        Reuse=ceil(Group_number/tau);
        Y=zeros(M,L,Reuse);
        count=1;
        for r=1:Reuse

            for g=(1+(r-1)*tau):(tau+(r-1)*tau)
                Y_temp=zeros(M,1);
                for k=1:K
                    if B_index_grouped(2,k)==g
                        Y_temp=Y_temp+sqrt(d_k)*h_ul(:,:,k);
                    end
                end
                Y(:,:,r)=Y(:,:,r)+Y_temp*(S(:,(g-(r-1)*tau))');
                count=count+1;
                if count>Group_number
                    break;
                end
            end
            Y(:,:,r)=Y(:,:,r)+sqrt(sigma_n/2)*(randn(M,L) + 1i*randn(M,L));
        end
        
        
        %UL估计
        y_g=zeros(M,1,Group_number);
        h_es_ul_temp=zeros(M,1,K);
        h_es_ul_tempp=zeros(M,1,K);
        count=1;
        for r=1:Reuse
            
            for g=(1+(r-1)*tau):(tau+(r-1)*tau)
              y_g(:,:,g)=(1/(L*sigma_p))*Y(:,:,r)*S(:,(g-(r-1)*tau));
              count=count+1;
              if count>Group_number
                  break;
              end

            end
          
        end
        
        for g=1:Group_number
            for k=1:K
                if B_index_grouped(2,k)==g
                     h_es_ul_temp(:,:,k)=(1/sqrt(d_k))*F*PHI_final(:,:,k)*y_g(:,:,g);
                     index_t=B_index_grouped(1,k);
                     h_es_ul_tempp(index_t:index_t+tau-1,:,k)=h_es_ul_temp(index_t:index_t+tau-1,:,k);
                     h_es_ul(:,:,k)=(PHI_final(:,:,k)')*(F')*h_es_ul_tempp(:,:,k);
 
                end
            end
        end
        
    else
        Y=zeros(M,L);


        for g=1:Group_number
            Y_temp=zeros(M,1);
            for k=1:K
                if B_index_grouped(2,k)==g
                    Y_temp=Y_temp+sqrt(d_k)*h_ul(:,:,k);
                end
            end
            Y=Y+Y_temp*(S(1:L,g)');%%%%%可能分组之后的总组数比tau大，就会报错
        end
        Y=Y+sqrt(sigma_n/2)*(randn(M,L) + 1i*randn(M,L));

        %%UL估计

        y_g=zeros(M,1,Group_number);
        h_es_ul=zeros(M,1,K);
        h_es_ul_temp=zeros(M,1,K);
        h_es_ul_tempp=zeros(M,1,K);


        for g=1:Group_number
            y_g(:,:,g)=(1/(L*sigma_p))*Y*S(:,g);
        end

        for g=1:Group_number
            for k=1:K
                if B_index_grouped(2,k)==g
                     h_es_ul_temp(:,:,k)=(1/sqrt(d_k))*F*PHI_final(:,:,k)*y_g(:,:,g);
                     index_t=B_index_grouped(1,k);
                     h_es_ul_tempp(index_t:index_t+tau-1,:,k)=h_es_ul_temp(index_t:index_t+tau-1,:,k);
                     h_es_ul(:,:,k)=(PHI_final(:,:,k)')*(F')*h_es_ul_tempp(:,:,k);
 
                end
            end
        end
        
    end
    



else
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
        

    
end
save h_es_ul.mat h_es_ul;
% save h_es_ul_temp.mat h_es_ul_temp;
% save h_es_ul_tempp.mat h_es_ul_tempp;
save B_index_grouped.mat B_index_grouped;
save Group_number.mat Group_number;

MSE=0;
MSE_temp=0;
for k=1:K
        MSE_temp=((norm(h_ul(:,:,k)-h_es_ul(:,:,k)))^2)/(norm(h_ul(:,:,k)))^2;
        MSE=MSE+MSE_temp;
    end
MSE=MSE/K;

save a_theta.mat a_theta;
save B_index.mat B_index;
save phi_final.mat phi_final;
save F.mat F;





        




                


