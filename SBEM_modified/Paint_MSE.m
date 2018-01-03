clear all;
clc;

%SNR-MSE
%%dl

RE=5 ;
tau_table=zeros(3,8);

snr=-10:5:25;
res_ul_16m=zeros(1,length(snr));
res_dl_16m=zeros(1,length(snr));

for i=1:length(snr)
    sum_ul=0;
    sum_dl=0;
    tau_final=0;
   
    for j=1:RE   %10times for average
        [mse,tau]=Estimate_U_m(16,10^(snr(i)/10));
        sum_ul=sum_ul+mse;
        tau_final=tau_final+tau;
        sum_dl=sum_dl+Estimate_D_m(16,10^(snr(i)/10));
      
    end
    sum_ul=sum_ul/RE;
    tau_final=tau_final/RE;
    sum_dl=sum_dl/RE;
   
    res_ul_16m(i)=sum_ul;
    tau_table(1,i)=tau_final;
    res_dl_16m(i)=sum_dl;
  
end




snr=-10:5:25;
res_ul_32m=zeros(1,length(snr));
res_dl_32m=zeros(1,length(snr));

for i=1:length(snr)
    sum_ul=0;
    sum_dl=0;
    tau_final=0;
   
    for j=1:RE   %10times for average
        [mse,tau]=Estimate_U_m(32,10^(snr(i)/10));
        sum_ul=sum_ul+mse;
        tau_final=tau_final+tau;
        sum_dl=sum_dl+Estimate_D_m(32,10^(snr(i)/10));
      
    end
    sum_ul=sum_ul/RE;
    tau_final=tau_final/RE;
    sum_dl=sum_dl/RE;
   
    res_ul_32m(i)=sum_ul;
    tau_table(1,i)=tau_final;
    res_dl_32m(i)=sum_dl;
  
end




snr=-10:5:25;
res_ul_64m=zeros(1,length(snr));
res_dl_64m=zeros(1,length(snr));

for i=1:length(snr)
    sum_ul=0;
    sum_dl=0;
    tau_final=0;
   
    for j=1:RE   %10times for average
        [mse,tau]=Estimate_U_m(64,10^(snr(i)/10));
        sum_ul=sum_ul+mse;
        tau_final=tau_final+tau;
        sum_dl=sum_dl+Estimate_D_m(64,10^(snr(i)/10));
      
    end
    sum_ul=sum_ul/RE;
    tau_final=tau_final/RE;
    sum_dl=sum_dl/RE;
   
    res_ul_64m(i)=sum_ul;
    tau_table(1,i)=tau_final;
    res_dl_64m(i)=sum_dl;
  
end


snr=-10:5:25;
res_ul_16=zeros(1,length(snr));
res_dl_16=zeros(1,length(snr));
for i=1:length(snr)
    sum_ul=0;
    sum_dl=0;
    for j=1:RE   %10times for average
        sum_ul=sum_ul+Estimate_U(16,10^(snr(i)/10));
        sum_dl=sum_dl+Estimate_D(16,10^(snr(i)/10));
    end
    sum_ul=sum_ul/RE;
    sum_dl=sum_dl/RE;
    res_ul_16(i)=sum_ul;
    res_dl_16(i)=sum_dl;
end



snr=-10:5:25;
res_ul_32=zeros(1,length(snr));
res_dl_32=zeros(1,length(snr));
for i=1:length(snr)
    sum_ul=0;
    sum_dl=0;
    for j=1:RE   %10times for average
        sum_ul=sum_ul+Estimate_U(32,10^(snr(i)/10));
        sum_dl=sum_dl+Estimate_D(32,10^(snr(i)/10));
    end
    sum_ul=sum_ul/RE;
    sum_dl=sum_dl/RE;
    res_ul_32(i)=sum_ul;
    res_dl_32(i)=sum_dl;
end



snr=-10:5:25;
res_ul_64=zeros(1,length(snr));
res_dl_64=zeros(1,length(snr));
for i=1:length(snr)
    sum_ul=0;
    sum_dl=0;
    for j=1:RE   %10times for average
        sum_ul=sum_ul+Estimate_U(64,10^(snr(i)/10));
        sum_dl=sum_dl+Estimate_D(64,10^(snr(i)/10));
    end
    sum_ul=sum_ul/RE;
    sum_dl=sum_dl/RE;
    res_ul_64(i)=sum_ul;
    res_dl_64(i)=sum_dl;
end

figure(1);
grid on;
h1=semilogy(snr,res_ul_16m,'-o','Color',[56/255 145/255 204/255]);
hold on;
h2=semilogy(snr,res_ul_32m,'-^','Color',[241/255 194/255 81/255]);
hold on;
h3=semilogy(snr,res_ul_64m,'-s','Color',[145/255 188/255 87/255]);
hold on;
h4=semilogy(snr,res_ul_16,'--o','Color',[56/255 145/255 204/255]);
hold on;
h5=semilogy(snr,res_ul_32,'--^','Color',[241/255 194/255 81/255]);
hold on;
h6=semilogy(snr,res_ul_64,'--s','Color',[145/255 188/255 87/255]);

xlabel('SNR/dB');
ylabel('MSE');
title('uplink');
legend([h1 h2 h3],'L=16','L=32','L=64');




figure(2);

h7=semilogy(snr,res_dl_16m,'-o','Color',[56/255 145/255 204/255]);
hold on;
h8=semilogy(snr,res_dl_32m,'-^','Color',[241/255 194/255 81/255]);
hold on;
h9=semilogy(snr,res_dl_64m,'-s','Color',[145/255 188/255 87/255]);
hold on;
h10=semilogy(snr,res_dl_16,'--o','Color',[56/255 145/255 204/255]);
hold on;
h11=semilogy(snr,res_dl_32,'--^','Color',[241/255 194/255 81/255]);
hold on;
h12=semilogy(snr,res_dl_64,'--s','Color',[145/255 188/255 87/255]);

xlabel('SNR/dB');
ylabel('MSE');
title('downlink');
legend([h7 h8 h9],'L=16','L=32','L=64');
grid on;





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