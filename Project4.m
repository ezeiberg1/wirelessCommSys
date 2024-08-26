% OTA QPSK
%
% ESE 471, Spring 2024
% Author: Emily Zeiberg
% Credit: Professor Patwari

clc;
close all;
clear;

%Import received signal
load('test_2-06-2024_cbrssdr1-hospital-comp_to_cbrssdr1-honors-comp.mat');

%Filter
alpha = 0.5;
N = 8;
Lp = 6;
p = SRRC(alpha, N, Lp);
y = filter(p, 1, s);

%Gain
y_mean = mean(abs(y));
y_norm = y/y_mean;

%Header Symbol Values
header_bits = [1, 1, 0, 0, 1, 1, 0, 0, 1, 1, 0, 0, 1, 1, 0, 0, 1, 1, 0, 0, 1, 1, 0, 0, 1, 1, 0, 0, 1, 1, 0, 0, 1, 1, 0, 0, 1, 1, 0, 0, 1, 1, 0, 0, 1, 1, 0, 0, 1, 1, 0, 0, 1, 1, 0, 0, 1, 1, 0, 0, 1, 1, 0, 0, 1, 1, 1, 0, 1, 0, 1, 1, 1, 0, 0, 1, 0, 0, 0, 0];
header_syms = bits_to_sym_QPSK(header_bits, 2);

% Upsample
% INPUT: modulated values, x
% OUTPUT: modulated values at sampling rate, x_s
h = oversample(header_syms,N);

%Cross-Correlation Block
[c, lags] = xcorr(y_norm, h);
[value, ind] = max(abs(c));
startSample = lags(ind)+1;

stem(abs(c));
hold on;
text(ind-1150,88,"lag =  " + lags(ind) + " \rightarrow")
title('Absolute Value of the Cross-Correlation w/ Lag');
xlabel('c index');
ylabel('Absolute Value');

figure();
stem(lags, abs(c));
title('Absolute Value of the Cross-Correlation vs. Lag');
xlabel('Lag');
ylabel('Absolute Value');



%Phase Sync
theta = angle(c(ind));
y_sync = y_norm*exp(-1j*theta);

%Time Sync
dataStartInd = startSample + 40*N;
y_sync = y_sync(dataStartInd:end);

%Downsample
y_sync = y_sync(N:N:end);
r = y_sync(1:329);


% Plot the Eye Diagram
figure();
plot_eye_diagram(real(r), 8, 0);
title('In-Phase Eye Diagram');
figure();
plot_eye_diagram(imag(r), 8, 0);
title('Quadrature Eye Diagram');

%Symbol Decision
QPSK_points = [-1 1;
               1 1;
               1 -1;
               -1 -1];
data_out = zeros(1,length(r));
for i = 1:length(r)
    data_out(i) = findClosestQPSK(r(i), QPSK_points);
end


%Plot of signal space projection with r
figure();
plot(real(r), imag(r),'o');
hold on;
plot(QPSK_points(:,1), QPSK_points(:,2),'o','MarkerSize',5,'MarkerFaceColor',[0,0,0]);
title('Signal Space Projection with "r"');
xlabel('Real')
ylabel('Imag')
legend('r', 'Symbols');

bits_out = sym_to_bits_QPSK(data_out);  

% Translate to ascii text
% INPUT: Bits
% OUTPUT: Character vector, message_out
message_out = binvector2str(bits_out);
disp(message_out);