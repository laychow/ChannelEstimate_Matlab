clear all;
clc;

%SNR-MSE
%%dl

RE=100 ;


snr=-10:5:25;
res_ul=zeros(1,length(snr));

for i=1:length(snr)
    sum_ul=0;
   
    for j=1:RE   %10times for average
        sum_ul=sum_ul+Estimate_U_m(64,10^(snr(i)/10));
      
    end
    sum_ul=sum_ul/RE;
   
    res_ul(i)=sum_ul;
  
end
h1=semilogy(snr,res_ul,'-o','Color',[56/255 145/255 204/255]);

hold on;

grid on;

snr=-10:5:25;
res_ul=zeros(1,length(snr));

for i=1:length(snr)
    sum_ul=0;
   
    for j=1:RE   %10times for average
        sum_ul=sum_ul+Estimate_U(64,10^(snr(i)/10));
      
    end
    sum_ul=sum_ul/RE;

    res_ul(i)=sum_ul;

end
h3=semilogy(snr,res_ul,'-^','Color',[241/255 194/255 81/255]);

hold on;


grid on;

%{
snr=-10:5:25;
res_ul=zeros(1,length(snr));

for i=1:length(snr)
    sum_ul=0;

    for j=1:RE   %10times for average
        sum_ul=sum_ul+Estimate_U(64,10^(snr(i)/10));
    
    end
    sum_ul=sum_ul/RE;

    res_ul(i)=sum_ul;

end
h5=semilogy(snr,res_ul,'-s','Color',[145/255 188/255 87/255]);

hold on;
grid on;
%}
xlabel('SNR/dB');
ylabel('MSE');
legend([h1 h3],'modified','not modified');
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