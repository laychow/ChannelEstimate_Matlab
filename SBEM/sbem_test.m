clear all;
clc;
M=512;
F=zeros(M,M);
for i=1:M
    for j=1:M
        F(i,j)=exp(-1i*(2*pi/M)*(i-1)*(j-1))/sqrt(M);
    end
end
a_the=zeros(M,1);
a_the1=zeros(M,1);
for i=1:M
	a_the(i)=exp(1i*pi*(i-1)*sin(0.263));
	
end
a_k=100;
h_k=zeros(M,1);
h_k=a_k*a_the;
h_k1=F*h_k;
X=1:M;
stem(X,abs(h_k1));