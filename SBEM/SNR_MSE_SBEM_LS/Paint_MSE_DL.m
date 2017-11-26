clear all;
clc;

%UL
%%L=16
snr=-10:5:25;
res=zeros(1,length(snr));
for i=1:length(snr)
    sum=0;
    for j=1:10    %10times for average
        sum=sum+Estimate_D_LS(16,10^(snr(i)/10));
    end
    sum=sum/10;
    res(i)=sum;
end
semilogy(snr,res,'-o');
hold on;

%%L=32
snr=-10:5:25;
res=zeros(1,length(snr));
for i=1:length(snr)
    sum=0;
    for j=1:10    %10times for average
        sum=sum+Estimate_D_LS(32,10^(snr(i)/10));
    end
    sum=sum/10;
    res(i)=sum;
end
semilogy(snr,res,'-^');
hold on;


%%L=64
snr=-10:5:25;
res=zeros(1,length(snr));
for i=1:length(snr)
    sum=0;
    for j=1:10    %10times for average
        sum=sum+Estimate_D_LS(64,10^(snr(i)/10));
    end
    sum=sum/10;
    res(i)=sum;
end
semilogy(snr,res,'-s');
hold on;


%DL
%%L=16
snr=-10:5:25;
res=zeros(1,length(snr));
for i=1:length(snr)
    sum=0;
    for j=1:10    %10times for average
        sum=sum+Estimate_D_SBEM(16,10^(snr(i)/10));
    end
    sum=sum/10;
    res(i)=sum;
end
semilogy(snr,res,'--o');
hold on;

%%L=32
snr=-10:5:25;
res=zeros(1,length(snr));
for i=1:length(snr)
    sum=0;
    for j=1:10    %10times for average
        sum=sum+Estimate_D_SBEM(32,10^(snr(i)/10));
    end
    sum=sum/10;
    res(i)=sum;
end
semilogy(snr,res,'--^');
hold on;


%%L=64
snr=-10:5:25;
res=zeros(1,length(snr));
for i=1:length(snr)
    sum=0;
    for j=1:10    %10times for average
        sum=sum+Estimate_D_SBEM(64,10^(snr(i)/10));
    end
    sum=sum/10;
    res(i)=sum;
end
semilogy(snr,res,'--s');
hold on;

grid on;
xlabel('SNR/dB');
ylabel('MSE');
legend('L=16','L=32','L=64');