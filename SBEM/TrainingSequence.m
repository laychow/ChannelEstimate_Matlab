%生成导频序列

run('sbem_version2.m');
L=16; %也可以选32,64
sigma_p=10;


%{
clc;  clear all; 
GG=128;                 %产生128个DFT码本   
for m=1:4                         
    for n=1:2         
                    
            W3(m,n)=exp(i*2*pi*(m-1)*((n-1))/4)/2;           
       
    end
end


for i=1:L
	for j=1:tau
		S(i,j)=exp(2i*pi*(i-1)*((j-1))/L)/tau;
	end
end
%}

S=zeros(L,tau);
Ss_temp=rand(L,L);
S_temp=orth(Ss_temp);
S=S_temp(:,1:tau).*sqrt(L*sigma_p);
