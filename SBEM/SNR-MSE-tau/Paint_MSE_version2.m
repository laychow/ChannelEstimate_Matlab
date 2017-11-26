clear all;
clc;

%UL
%%tau=8
snr=-10:5:25;
res=zeros(1,length(snr));
for i=1:length(snr)
    sum=0;
    for j=1:1    %10times for average
        sum=sum+Estimate_U(8,10^(snr(i)/10));
    end
    sum=sum/1;
    res(i)=sum;
end
semilogy(snr,res,'-o');
hold on;

%%tau=16
snr=-10:5:25;
res=zeros(1,length(snr));
for i=1:length(snr)
    sum=0;
    for j=1:10    %10times for average
        sum=sum+Estimate_U(16,10^(snr(i)/10));
    end
    sum=sum/10;
    res(i)=sum;
end
semilogy(snr,res,'-^');
hold on;



%DL
snr=-10:5:25;
res=zeros(1,length(snr));
for i=1:length(snr)
    sum=0;
    for j=1:1    %10times for average
        sum=sum+Estimate_D(8,10^(snr(i)/10));
    end
    sum=sum/1;
    res(i)=sum;
end
semilogy(snr,res,'--o');
hold on;

%%tau=16
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
semilogy(snr,res,'--^');
hold on;

grid on;
xlabel('SNR/dB');
ylabel('MSE');
legend('\tau=8','\tau=16');