function MSE=Estimate_D(L,sigma_p)

load ('a_theta.mat');
load ('B_index_grouped.mat');
load ('S.mat')
d=1;    %ÌìÏß¼ä¸ô
lambda=2;  %ÔØ²¨²¨³¤
M=128; %ÌìÏßÊý
P=100; %Â·¾¶Êý
K=32;  %ÓÃ»§Êý
z=pi/180;  %½Ç¶È×ª»¡¶È
L=64;

%tau=16;
G=K/tau;
theta_Option=[-48.59,-14.48,14.48,48.59].*z;
theta_AS=AS*2*z;
sigma_p=100;
sigma_n=1;
rho=sigma_p/sigma_n;


% theta=zeros(P,K);
% for i=1:K
% 	index_matrix=randperm(4);
%     theta_low=theta_Option(index_matrix(1))-theta_AS;
%     theta_up=theta_Option(index_matrix(1))+theta_AS;
% 	theta(1:P,i)=unifrnd(theta_low,theta_up,P,1);
% end
% F=zeros(M,M);
% for i=1:M
%     for j=1:M
%         F(i,j)=exp(-1i*(2*pi/M)*(i-1)*(j-1))/sqrt(M);
%     end
% end
% 
% a_theta=zeros(P,M,K);
% for k=1:K
% 	for i=1:P
% 		for j=1:M
% 			a_theta(i,j,k)=exp(1i*(2*pi*d/lambda)*(j-1)*sin(theta(i,k)));
% 		end
% 	end
% end

%Éú³ÉDLÐÅµÀh

b_kp=sqrt(1/2)*(randn(K,P) + 1i*randn(K,P)); %ÐÅµÀ¸´ÔöÒæ
h=zeros(M,1,K);

for k=1:K
	h(1:M,1,k)=(1/sqrt(P))*([b_kp(k,:)*a_theta(1:P,1:M,k)].');%%%%%%%
	
end
save h;

%{
S=zeros(L,tau);
Ss_temp=rand(L,L);
S_temp=orth(Ss_temp);
S=S_temp(:,1:tau).*sqrt(L*sigma_p);


%run ('TrainingSequence.m');

h_es_pre=zeros(M,1,K);

%preamble ç”ŸæˆY

Y_pre=zeros(M,L,G);
P_ut=L*rho;
d_k=P_ut/(L*(sigma_p));
%N=sqrt(sigma_n/2)*(randn(M,L) + 1i*randn(M,L));%s = sqrt(var/2)*(randn(1,K) +j*randn(1,K))


for g=1:G
	for t=1:tau
		Y_tem=sqrt(d_k)*h(:,:,t+(g-1)*tau)*(S(:,t)');
		Y_pre(:,:,g)=Y_pre(:,:,g)+Y_tem;
	end
	Y_pre(:,:,g)=Y_pre(:,:,g)+sqrt(sigma_n/2)*(randn(M,L) + 1i*randn(M,L));
end



for g=1:G
	for t=1:tau
		h_es_pre(:,:,t+(g-1)*tau)=(1/(sqrt(d_k)*(L*sigma_p)))*Y_pre(:,:,g)*S(:,t);
	end
end

%èŽ·å¾—ç©ºé—´ä¿¡æ¯

B_index=zeros(1,K);  %åªè®°å½•èµ·å§‹ç´¢å¼•[B_index~B_index+tau-1]
h2=zeros(M,1,K);  %DFT åŽçš„h
V=100;  %?Â¨?Ã¨????
%tau=16;
phi=2*pi/(V*M);
PHI=zeros(M,M,K);
phi_final=zeros(1,K);
PHI_final=zeros(M,M,K);

for k=1:K
	H_max=0;
	h_max=0;
	h_percent=0;
	for j=1:V
		for i=1:M
			PHI(i,i,k)=exp(1i*(i-1)*(phi*j+-pi/M));
		end
		h2(1:M,1,k)=F*PHI(1:M,1:M,k)*h_es_pre(1:M,1,k);
		for l=1:(M-tau+1)
			h_percent=norm(h2(l:l+tau-1,1,k))/norm(h2(1:M,1,k));  %Attention
		    %h_percent=norm(h2(l:l+tau-1,1,k));
            if h_percent>h_max
		    	h_max=h_percent;
		    	B_index(k)=l;
		    end
		end
		if h_max>H_max
			H_max=h_max;
			phi_final(k)=(phi*j+-pi/M);
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



OMEGA=tau/4;    %ç»„ä¹‹é—´æœ€å°é—´éš?


%%åˆ†ç»„
B_index_grouped=zeros(3,K);%ç¬¬ä¸€è¡Œè¡¨ç¤ºç´¢å¼•ï¼Œç¬¬äºŒè¡Œè¡¨ç¤ºç»„å·ï¼Œç¬¬ä¸‰è¡Œè¡¨ç¤ºç”¨æˆ·å·
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
            k=1;
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

%}
 Group_number=max(B_index_grouped(2,:));



%obtain 