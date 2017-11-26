MSE=0;
MSE_temp=zeros(1,K);
for k=1:K
        MSE_temp(k)=((norm(h_dl(:,:,k)-h_es_dl(:,:,k)))^2)/(norm(h_dl(:,:,k)))^2;
        
    end
MSE=sum(MSE_temp(:,1:K))/K;