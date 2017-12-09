clear all;
clc;
RE=100;
%UL
%%tau=8
snr=-10:5:25;
res_ul=zeros(1,length(snr));
res_dl=zeros(1,length(snr));
for i=1:length(snr)
    sum_ul=0;
    sum_dl=0;
    
    for j=1:RE    %10times for average
        sum_ul=sum_ul+Estimate_U(8,10^(snr(i)/10));
        sum_dl=sum_dl+Estimate_D(8,10^(snr(i)/10));
    end
    sum_ul=sum_ul/RE;
    sum_dl=sum_dl/RE;
    res_ul(i)=sum_ul;
    res_dl(i)=sum_dl;
end
f1=semilogy(snr,res_ul,'-o');
hold on;
f2=semilogy(snr,res_dl,'--o');
hold on;


%%tau=16
snr=-10:5:25;
res_ul=zeros(1,length(snr));
res_dl=zeros(1,length(snr));
for i=1:length(snr)
    sum_ul=0;
    sum_dl=0;
    
    for j=1:RE    %10times for average
        sum_ul=sum_ul+Estimate_U(16,10^(snr(i)/10));
        sum_dl=sum_dl+Estimate_D(16,10^(snr(i)/10));
    end
    sum_ul=sum_ul/RE;
    sum_dl=sum_dl/RE;
    res_ul(i)=sum_ul;
    res_dl(i)=sum_dl;
end
f3=semilogy(snr,res_ul,'-^');
hold on;
f4=semilogy(snr,res_dl,'--^');
hold on;

grid on;
xlabel('SNR/dB');
ylabel('MSE');
legend([f1,f3],'\tau=8','\tau=16');