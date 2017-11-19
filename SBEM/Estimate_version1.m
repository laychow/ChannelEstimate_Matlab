%UL

clear all;
clc;
%run('TrainingSequence.m');
load('B_index.mat');
load('tau.mat');
load('sigma_p.mat');
load('L.mat');


%����

OMEGA=tau/4;


%%��ʼ��
B_index_grouped=zeros(3,K);%��һ��Ϊ����B�ĵ�һ���������ڶ���Ϊ������������������Ϊԭʼ�û���
B_index_grouped(1,1:K)=B_index; 
B_index_grouped(2,1:K)=0; 
for i=1:K
	B_index_grouped(3,i)=i;  %����ԭʼ���û���
end

%%��������
for i=1:K
	for j=i+1:K
		if B_index_grouped(1,i)>B_index_grouped(1,j)
			temp=B_index_grouped(:,i);
			B_index_grouped(:,i)=B_index_grouped(:,j);
			B_index_grouped(:,j)=temp;
		end
	end
end

%%����
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
        	if (B_index_grouped(1,k+a)-B_index_grouped(1,k))>=(tau+OMEGA)&&(B_index_grouped(2,k+a)==0)
                B_index_grouped(2,k+a)=g;
                k=k+a;
                a=1;
            else a=a+1;
            end
        else a=a+1;
        end
    end
end

%%��ԭ˳��
for i=1:K
	for j=i+1:K
		if B_index_grouped(3,i)>B_index_grouped(3,j)
			temp=B_index_grouped(:,i);
			B_index_grouped(:,i)=B_index_grouped(:,j);
			B_index_grouped(:,j)=temp;
		end
	end
end

%%�ó�����
Group_number=0;
for k=1:K
	if B_index_grouped(2,k)>Group_number
		Group_number=B_index_grouped(2,k);
	end
end

%���д���

P_ut=rand(1,K);
d_k=P_ut/(L*(sigma_p^2));

%%�õ�BS�˽���Y

Y=zeros(M,L);
N=randn(M,L) + 1i*randn(M,L);

for g=1:Group_number
	Y_temp=zeros(M,1);
	for k=1:K
		if B_index_grouped(2,k)==g
			Y_temp=Y_temp+d_k(k)*h(:,:,k);
		end
	end
	Y=Y+Y_temp*(S(:,g)');
end
Y=Y+N;

%%UL�ŵ�����

y_g=zeros(M,1,Group_number);
h_es_ul=zeros(M,1,K);
h_es_ul_temp=zeros(M,1,K);


for g=1:Group_number
	y_g(:,:,g)=(1/(L*(sigma_p)^2))*Y*S(:,g);
end

for g=1:Group_number
	for k=1:K
		if B_index_grouped(2,k)==g
			h_es_ul_temp(:,:,k)=(1/sqrt(d_k(k))).*F*PHI_final(:,:,k)*y_g(:,:,g);
			index_t=B_index_grouped(1,k);
			h_es_ul(index_t:index_t+tau-1,:,k)=h_es_ul_temp(index_t:index_t+tau-1,:,k);
			h_es_ul(:,:,k)=(PHI_final(:,:,k)')*(F')*h_es_ul(:,:,k);
		end
	end
end

save h_es_ul;




        




                
