clear all;
clc;

%SNR-MSE

snr=-10:5:25;
res=zeros(1,length(snr));
for i=1:length(snr)
    sum=0;
    for j=1:10    %10times for average
        sum=sum+Estimate_D(16,10^(snr(i)/10));
    end
    sum=sum/10;
    res(i)=sum;
end
semilogy(snr,res,'-o');


subplot(1,2,1);
stem(1:M,abs(F*h_dl(:,:,1)));
subplot(1,2,2);
stem(1:M,abs(F*h_dl(:,:,4)));