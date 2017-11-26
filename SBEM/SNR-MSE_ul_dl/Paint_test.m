clear all;
clc;

%SNR-MSE
%%dl


snr=-10:5:25;
res_ul=zeros(1,length(snr));
res_dl=zeros(1,length(snr));
for i=1:length(snr)
    sum_ul=0;
    sum_dl=0;
    for j=1:10   %10times for average
        sum_ul=sum_ul+Estimate_U(16,10^(snr(i)/10));
        sum_dl=sum_dl+Estimate_D_test2(16,10^(snr(i)/10));
    end
    sum_ul=sum_ul/10;
    sum_dl=sum_dl/10;
    res_ul(i)=sum_ul;
   res_dl(i)=sum_dl;
end
semilogy(snr,res_ul,'-o');
hold on;
semilogy(snr,res_dl,'--o');

grid on;

snr=-10:5:25;
res_ul=zeros(1,length(snr));
res_dl=zeros(1,length(snr));
for i=1:length(snr)
    sum_ul=0;
    sum_dl=0;
    for j=1:10   %10times for average
        sum_ul=sum_ul+Estimate_U(32,10^(snr(i)/10));
        sum_dl=sum_dl+Estimate_D_test2(32,10^(snr(i)/10));
    end
    sum_ul=sum_ul/10;
    sum_dl=sum_dl/10;
    res_ul(i)=sum_ul;
   res_dl(i)=sum_dl;
end
semilogy(snr,res_ul,'-^');
hold on;
semilogy(snr,res_dl,'--^');

grid on;


snr=-10:5:25;
res_ul=zeros(1,length(snr));
res_dl=zeros(1,length(snr));
for i=1:length(snr)
    sum_ul=0;
    sum_dl=0;
    for j=1:10   %10times for average
        sum_ul=sum_ul+Estimate_U(64,10^(snr(i)/10));
        sum_dl=sum_dl+Estimate_D_test2(64,10^(snr(i)/10));
    end
    sum_ul=sum_ul/10;
    sum_dl=sum_dl/10;
    res_ul(i)=sum_ul;
   res_dl(i)=sum_dl;
end
semilogy(snr,res_ul,'-s');
hold on;
semilogy(snr,res_dl,'--s');

grid on;