clear all;
clc;

%SNR-MSE
%%dl

RE=1 ;


snr=-10:5:25;
res_ul=zeros(1,length(snr));
res_dl=zeros(1,length(snr));
for i=1:length(snr)
    sum_ul=0;
    sum_dl=0;
    for j=1:RE   %10times for average
        sum_ul=sum_ul+Estimate_U(16,10^(snr(i)/10));
        sum_dl=sum_dl+Estimate_D_test5(16,10^(snr(i)/10));
    end
    sum_ul=sum_ul/RE;
    sum_dl=sum_dl/RE;
    res_ul(i)=sum_ul;
    res_dl(i)=sum_dl;
end
h1=semilogy(snr,res_ul,'-o');

hold on;
h2=semilogy(snr,res_dl,'--o');

grid on;

snr=-10:5:25;
res_ul=zeros(1,length(snr));
res_dl=zeros(1,length(snr));
for i=1:length(snr)
    sum_ul=0;
    sum_dl=0;
    for j=1:RE   %10times for average
        sum_ul=sum_ul+Estimate_U(32,10^(snr(i)/10));
        sum_dl=sum_dl+Estimate_D_test5(32,10^(snr(i)/10));
    end
    sum_ul=sum_ul/RE;
    sum_dl=sum_dl/RE;
    res_ul(i)=sum_ul;
    res_dl(i)=sum_dl;
end
h3=semilogy(snr,res_ul,'-^');

hold on;
h4=semilogy(snr,res_dl,'--^');

grid on;


snr=-10:5:25;
res_ul=zeros(1,length(snr));
res_dl=zeros(1,length(snr));
for i=1:length(snr)
    sum_ul=0;
    sum_dl=0;
    for j=1:RE   %10times for average
        sum_ul=sum_ul+Estimate_U(64,10^(snr(i)/10));
        sum_dl=sum_dl+Estimate_D_test5(64,10^(snr(i)/10));
    end
    sum_ul=sum_ul/RE;
    sum_dl=sum_dl/RE;
    res_ul(i)=sum_ul;
    res_dl(i)=sum_dl;
end
h5=semilogy(snr,res_ul,'-s');

hold on;
h6=semilogy(snr,res_dl,'--s');

grid on;

xlabel('SNR/dB');
ylabel('MSE');
legend([h1,h3,h5],'L=16','L=32','L=64');
%DL
%{  
snr=-10:5:25;
res=zeros(1,length(snr));
for i=1:length(snr)
    sum=0;
    for j=1:1    %10times for average
        sum=sum+Estimate_D(16,10^(snr(i)/10));
    end
    sum=sum/1;
    res(i)=sum;
end
semilogy(snr,res,'-s');
%}

%AS-MSE
%{
theta_AS=4:4:32;
res=zeros(1,length(theta_AS));
for i=1:length(theta_AS)
	sum=0;
	for j=1:1
		sum=sum+Estimate_U(16,theta_AS(i));
	end
	sum=sum/1;
	res(i)=sum;
end
semilogy(theta_AS,res,'-^');
hold on;

theta_AS=4:4:32;
res=zeros(1,length(theta_AS));
for i=1:length(theta_AS)
	sum=0;
	for j=1:10
		sum=sum+Estimate_U(24,theta_AS(i));
	end
	sum=sum/10;
	res(i)=sum;
end
semilogy(theta_AS,res,'-*');
hold on;

theta_AS=4:4:32;
res=zeros(1,length(theta_AS));
for i=1:length(theta_AS)
	sum=0;
	for j=1:1
		sum=sum+Estimate_U(32,theta_AS(i));
	end
	sum=sum/1;
	res(i)=sum;
end
semilogy(theta_AS,res,'-s');
hold on;
legend('\tau =16','\tau =24','\tau =32');
%}

%{
+          加号
o          圆圈
*          星号
.          实心点
x         叉号
s         正方形
d         钻石形
^         上三角形
v         下三角形
>        右三角形
<        左三角形
p        五角星形
h        六角星形
%}