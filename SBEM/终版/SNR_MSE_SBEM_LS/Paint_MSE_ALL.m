clear all;
clc;


RE=1;    %计算取平均的次数
%UL
%%L=16
snr=-10:5:25;
res_16_ul_ls=zeros(1,length(snr));
res_16_dl_ls=zeros(1,length(snr));
for i=1:length(snr)
    sum_ul=0;
    sum_dl=0;
    for j=1:RE    %10times for average
        sum_ul=sum_ul+Estimate_U_LS(16,10^(snr(i)/10));
        sum_dl=sum_dl+Estimate_D_LS(16,10^(snr(i)/10));
    end
    sum_ul=sum_ul/RE;
    sum_dl=sum_dl/RE;
    res_16_ul_ls(i)=sum_ul;
    res_16_dl_ls(i)=sum_dl;
end


%%L=32
snr=-10:5:25;
res_32_ul_ls=zeros(1,length(snr));
res_32_dl_ls=zeros(1,length(snr));
for i=1:length(snr)
    sum_ul=0;
    sum_dl=0;
    for j=1:RE    %10times for average
        sum_ul=sum_ul+Estimate_U_LS(32,10^(snr(i)/10));
        sum_dl=sum_dl+Estimate_D_LS(32,10^(snr(i)/10));
    end
    sum_ul=sum_ul/RE;
    sum_dl=sum_dl/RE;
    res_32_ul_ls(i)=sum_ul;
    res_32_dl_ls(i)=sum_dl;
end

%%L=64
snr=-10:5:25;
res_64_ul_ls=zeros(1,length(snr));
res_64_dl_ls=zeros(1,length(snr));
for i=1:length(snr)
    sum_ul=0;
    sum_dl=0;
    for j=1:RE   %10times for average
        sum_ul=sum_ul+Estimate_U_LS(64,10^(snr(i)/10));
        sum_dl=sum_dl+Estimate_D_LS(64,10^(snr(i)/10));
    end
    sum_ul=sum_ul/RE;
    sum_dl=sum_dl/RE;
    res_64_ul_ls(i)=sum_ul;
    res_64_dl_ls(i)=sum_dl;
end





%SBEM
%%L=16
snr=-10:5:25;
res_16_ul_sbem=zeros(1,length(snr));
res_16_dl_sbem=zeros(1,length(snr));
for i=1:length(snr)
    sum_ul=0;
    sum_dl=0;
    for j=1:RE    %10times for average
        sum_ul=sum_ul+Estimate_U_SBEM(16,10^(snr(i)/10));
        sum_dl=sum_dl+Estimate_D_SBEM(16,10^(snr(i)/10));
    end
    sum_ul=sum_ul/RE;
    sum_dl=sum_dl/RE;
    res_16_ul_sbem(i)=sum_ul;
    res_16_dl_sbem(i)=sum_dl;
end


%%L=32
snr=-10:5:25;
res_32_ul_sbem=zeros(1,length(snr));
res_32_dl_sbem=zeros(1,length(snr));
for i=1:length(snr)
    sum_ul=0;
    sum_dl=0;
    for j=1:RE    %10times for average
        sum_ul=sum_ul+Estimate_U_SBEM(32,10^(snr(i)/10));
        sum_dl=sum_dl+Estimate_D_SBEM(32,10^(snr(i)/10));
    end
    sum_ul=sum_ul/RE;
    sum_dl=sum_dl/RE;
    res_32_ul_sbem(i)=sum_ul;
    res_32_dl_sbem(i)=sum_dl;
end



%%L=64
snr=-10:5:25;
res_64_ul_sbem=zeros(1,length(snr));
res_64_dl_sbem=zeros(1,length(snr));
for i=1:length(snr)
    sum_ul=0;
    sum_dl=0;
    for j=1:RE    %10times for average
        sum_ul=sum_ul+Estimate_U_SBEM(64,10^(snr(i)/10));
        sum_dl=sum_dl+Estimate_D_SBEM(64,10^(snr(i)/10));
    end
    sum_ul=sum_ul/RE;
    sum_dl=sum_dl/RE;
    res_64_ul_sbem(i)=sum_ul;
    res_64_dl_sbem(i)=sum_dl;
end

figure(1);

semilogy(snr,res_16_ul_ls,'-o');
hold on;
semilogy(snr,res_32_ul_ls,'-^');
hold on;
semilogy(snr,res_64_ul_ls,'-s');
hold on;
semilogy(snr,res_16_ul_sbem,'--o');
hold on;
semilogy(snr,res_32_ul_sbem,'--^');
hold on;
semilogy(snr,res_64_ul_sbem,'--s');
hold on;
title('uplink');
grid on;
xlabel('SNR/dB');
ylabel('MSE');
legend('L=16','L=32','L=64');

figure(2);

semilogy(snr,res_16_dl_ls,'-o');
hold on;
semilogy(snr,res_32_dl_ls,'-^');
hold on;
semilogy(snr,res_64_dl_ls,'-s');
hold on;
semilogy(snr,res_16_dl_sbem,'--o');
hold on;
semilogy(snr,res_32_dl_sbem,'--^');
hold on;
semilogy(snr,res_64_dl_sbem,'--s');
hold on;
title('downlink');
grid on;
xlabel('SNR/dB');
ylabel('MSE');
legend('L=16','L=32','L=64');


