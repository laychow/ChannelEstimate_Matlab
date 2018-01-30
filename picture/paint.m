clear all;
clc;

%SNR-MSE
%%dl

RE=100 ;
AS=4:2:32;

res=zeros(1,length(AS));
for i=1:length(AS)
    tau_f=0;
    for j=1:RE
        tau_f=tau_f+taubyAS(AS(i));
    end
    tau_f=tau_f/RE;
    res(i)=tau_f;
end

plot(AS,res,'-o');
xlabel('AS/degree');
ylabel('\tau');
grid on;