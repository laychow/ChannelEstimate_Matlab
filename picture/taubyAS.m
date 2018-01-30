function tau_final=taubyAS(AS)
d=1;    %天线间隔
lambda=2;  %载波波长 
M=128; %天线数
P=100; %路径数
K=32;  %用户数
z=pi/180;  %角度转弧度
sigma_p=10^1.5;
sigma_n=1;
rho=sigma_p/sigma_n;
L=64;

theta=zeros(P,K);
theta_Option=(-60 + 120.*rand([1 32])).*z;
theta_AS=AS*z;

%index_matrix=zeros(4,K);
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

tau_final=32;
for tau=8:32
    %disp(tau);
    S=zeros(L,tau);
    Ss_temp=rand(L,L);
    S_temp=orth(Ss_temp);
    S=S_temp(:,1:tau).*sqrt(L*sigma_p);
    G=ceil(K/tau);
    OMEGA=tau/4;    %组之间最小间隔


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
    H_max=zeros(K,1);
   
    for k=1:K
        
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
            for l=(M-tau+2):M
                h_percent=((norm(h2(l:M,1,k)))^2+(norm(h2(1:l-(M-tau+1),1,k)))^2)/(norm(h2(1:M,1,k)))^2;         %%%%%%%
                if h_percent>h_max
                    h_max=h_percent;
                    b_index(k)=l;
                end
            end

            if h_max>H_max(k)
                H_max(k)=h_max;
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
    tp=0;%探针
    for k=1:K
       if H_max(k)>0.97        %    门限
           tp=1;
       else 
           tp=0;
           break;
       end
    end
   if tp==1
       tau_final=tau;
       break;
   end
       
   
end
