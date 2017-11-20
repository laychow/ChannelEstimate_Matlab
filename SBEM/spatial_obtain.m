run ('TrainingSequence.m');
G=K/tau;
h_es_pre=zeros(M,1,K);

%preamble ���Y

Y_pre=zeros(M,L,G);
P_ut=L*rho;
d_k=P_ut/(L*(sigma_p));
N=sqrt(sigma_n/2)*(randn(M,L) + 1i*randn(M,L));%s = sqrt(var/2)*(randn(1,K) +j*randn(1,K))


for g=1:G
	for t=1:tau
		Y_tem=sqrt(d_k)*h(:,:,t+(g-1)*tau)*(S(:,t)');
		Y_pre(:,:,g)=Y_pre(:,:,g)+Y_tem;
	end
	Y_pre(:,:,g)=Y_pre(:,:,g)+N;
end

%����

for g=1:G
	for t=1:tau
		h_es_pre(:,:,t+(g-1)*tau)=(1/(sqrt(d_k)*(L*(sigma_p))))*Y_pre(:,:,g)*S(:,t);
	end
end

%��ÿռ���Ϣ

B_index=zeros(1,K);  %只记录第�?个索引，索引集为[B_index~B_index+tau-1]
h2=zeros(M,1,K);  %DFT & 旋转 后的h
V=100;  %ɨ�辫��
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
			PHI(i,i,k)=exp(1i*(i-1)*phi*j);
		end
		h2(1:M,1,k)=F*PHI(1:M,1:M,k)*h_es_pre(1:M,1,k);
		for l=1:(M-tau+1)
			h_percent=norm(h2(l:l+tau-1,1,k))/norm(h2(1:M,1,k));  %Attention拢潞脮芒脌茂脰卤陆脫脫脙碌脛脛拢脰碌虏垄脙禄脫脨脣茫脝陆路陆
		    %h_percent=norm(h2(l:l+tau-1,1,k));
            if h_percent>h_max
		    	h_max=h_percent;
		    	B_index(k)=l;
		    end
		end
		if h_max>H_max
			H_max=h_max;
			phi_final(k)=phi*j;
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
