load('res_ul_16m.mat');
load('res_ul_32m.mat');
load('res_ul_64m.mat');
load('res_ul_16.mat');
load('res_ul_32.mat');
load('res_ul_64.mat');
load('res_dl_16m.mat');
load('res_dl_32m.mat');
load('res_dl_64m.mat');
load('res_dl_16.mat');
load('res_dl_32.mat');
load('res_dl_64.mat');
snr=-10:5:25;
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
%title('uplink');
legend([h1 h2 h3],'L=16','L=32','L=64');
grid on;



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
%title('downlink');
legend([h7 h8 h9],'L=16','L=32','L=64');
grid on;