M=10000;
F=zeros(M,M);
for i=1:M
    for j=1:M
        F(i,j)=exp(-1i*(2*pi/M)*(i-1)*(j-1))/sqrt(M);
    end
end
a_t=0:M-1;
a_c=exp(1i*2*pi*0.6232);
a=(a_c.^a_t).';
res=F*a;