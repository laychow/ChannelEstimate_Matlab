%UL

clear all;
clc;
%run('TrainingSequence.m');
load('B_index.mat');
load('tau.mat');
load('sigma_p.mat');
load('L.mat');


%分组

OMEGA=tau/4;


%%初始化
B_index_grouped=zeros(3,K);%第一行为集合B的第一个索引；第二行为其所在组数；第三行为原始用户号
B_index_grouped(1,1:K)=B_index; 
B_index_grouped(2,1:K)=0; 
for i=1:K
	B_index_grouped(3,i)=i;  %记下原始的用户号
end

%%索引排序
for i=1:K
	for j=i+1:K
		if B_index_grouped(1,i)>B_index_grouped(1,j)
			temp=B_index_grouped(:,i);
			B_index_grouped(:,i)=B_index_grouped(:,j);
			B_index_grouped(:,j)=temp;
		end
	end
end

%%分组
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

%%还原顺序
for i=1:K
	for j=i+1:K
		if B_index_grouped(3,i)>B_index_grouped(3,j)
			temp=B_index_grouped(:,i);
			B_index_grouped(:,i)=B_index_grouped(:,j);
			B_index_grouped(:,j)=temp;
		end
	end
end

%%得出组数
Group_number=0;
for k=1:K
	if B_index_grouped(2,k)>Group_number
		Group_number=B_index_grouped(2,k);
	end
end

%上行传输

P_ut=rand(1,K);
d_k=P_ut/(L*(sigma_p^2));

%%得到BS端接收Y

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

%%UL信道估计

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




        




                
