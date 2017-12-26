M=128;
for k=1:K
    for i=1:M
            PHI_final(i,i,k)=exp(1i*(i-1)*phi_final(k));
    end
end
