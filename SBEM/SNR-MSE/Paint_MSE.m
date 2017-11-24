clear all;
clc;

%SNR-MSE

snr=-10:5:25;
res=zeros(1,length(snr));
for i=1:length(snr)
    sum=0;
    for j=1:10   %10times for average
        sum=sum+Estimate_U(16,10^(snr(i)/10));
    end
    sum=sum/10;
    res(i)=sum;
end
semilogy(snr,res,'-o');
grid on;
hold on;

snr=-10:5:25;
res=zeros(1,length(snr));
for i=1:length(snr)
    sum=0;
    for j=1:10    %10times for average
        sum=sum+Estimate_U(32,10^(snr(i)/10));
    end
    sum=sum/10;
    res(i)=sum;
end
semilogy(snr,res,'-s');
grid on;
hold on;


snr=-10:5:25;
res=zeros(1,length(snr));
for i=1:length(snr)
    sum=0;
    for j=1:10    %10times for average
        sum=sum+Estimate_U(64,10^(snr(i)/10));
    end
    sum=sum/10;
    res(i)=sum;
end
semilogy(snr,res,'-h');
grid on;
hold on;


%AS-MSE
%{
theta_AS=4:2:32;
res=zeros(1,length(theta_AS));
for i=1:length(theta_AS)
	sum=0;
	for j=1:20
		sum=sum+Estimate_U(16,theta_AS(i));
	end
	sum=sum/20;
	res(i)=sum;
end

semilogy(theta_AS,res,'-^');
set(gca,'XTickLabel',[4:4:32]);
grid on;
hold on;

theta_AS=4:2:32;
res=zeros(1,length(theta_AS));
for i=1:length(theta_AS)
	sum=0;
	for j=1:20
		sum=sum+Estimate_U(24,theta_AS(i));
	end
	sum=sum/20;
	res(i)=sum;
end

semilogy(theta_AS,res,'-*');
set(gca,'XTick',[4:4:32]);
grid on;
hold on;

theta_AS=4:2:32;
res=zeros(1,length(theta_AS));
for i=1:length(theta_AS)
	sum=0;
	for j=1:50
		sum=sum+Estimate_U(32,theta_AS(i));
	end
	sum=sum/50;
	res(i)=sum;
end


semilogy(theta_AS,res,'-s');
set(gca,'xticklabel',[4:4:32]);
grid on;
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