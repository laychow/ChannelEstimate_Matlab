clear all;
clc;


RE=5 ;



snr=-10:5:25;
res_ul=zeros(1,length(snr));
res_dl=zeros(1,length(snr));
for i=1:length(snr)
    sum_ul=0;
    sum_dl=0;
    for j=1:RE   %10times for average
        sum_ul=sum_ul+Estimate_U_ro(10^(snr(i)/10));
        sum_dl=sum_dl+Estimate_D_ro(10^(snr(i)/10));
    end
    sum_ul=sum_ul/RE;
    sum_dl=sum_dl/RE;
    res_ul(i)=sum_ul;
    res_dl(i)=sum_dl;
end
f1=semilogy(snr,res_ul,'-s');

hold on;
f2=semilogy(snr,res_dl,'--s');


snr=-10:5:25;
res_ul=zeros(1,length(snr));
res_dl=zeros(1,length(snr));
for i=1:length(snr)
    sum_ul=0;
    sum_dl=0;
    for j=1:RE   %10times for average
        sum_ul=sum_ul+Estimate_U_wro1(10^(snr(i)/10));
        sum_dl=sum_dl+Estimate_D_wro(10^(snr(i)/10));
    end
    sum_ul=sum_ul/RE;
    sum_dl=sum_dl/RE;
    res_ul(i)=sum_ul;
    res_dl(i)=sum_dl;
end
f3=semilogy(snr,res_ul,'-^');

hold on;
f4=semilogy(snr,res_dl,'--^');

grid on;
xlabel('SNR/dB');
ylabel('MSE');
legend([f1,f3],'with spatial rotation','without spatial rotation');