clear all;
clc;

%AS-MSE
RE=100;



theta_AS=4:2:32;
res=zeros(1,length(theta_AS));
for i=1:length(theta_AS)
	sum=0;
	for j=1:RE
		sum=sum+Estimate_U(16,theta_AS(i));
	end
	sum=sum/RE;
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
	for j=1:RE
		sum=sum+Estimate_U(24,theta_AS(i));
	end
	sum=sum/RE;
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
	for j=1:RE
		sum=sum+Estimate_U(32,theta_AS(i));
	end
	sum=sum/RE;
	res(i)=sum;
end


semilogy(theta_AS,res,'-s');
set(gca,'xticklabel',[4:4:32]);
grid on;
hold on;
legend('\tau =16','\tau =24','\tau =32');


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