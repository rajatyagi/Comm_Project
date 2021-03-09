clc;
clear all;

%random bits generation
snr_range = -20:2:20;
bits = randi([0,1],250,1);
snr1 = 3;

disp("Message Bits:");
disp(num2str(bits'));

%Simulation function
[symbols1,symbols2,recvdSymbols,recvd_bits] = commSystem(bits,snr1);

disp("Received Bits:");
disp(num2str(recvd_bits));

%BER for our simulated system over the snr_range
ber = bitErrRate(bits,snr_range);

%plots
figure(1);
    scatter(recvdSymbols(:,1),recvdSymbols(:,2));
    title("received symbols");
    grid on;
    
figure(2);
    plot(symbols1(:,1),symbols1(:,2),'ro');
    hold on;
    plot(symbols2(:,1),symbols2(:,2),'bo');
    hold on;
    legend("S0","S1");
    title("Detection results");
    grid on;
    
figure(3);
    semilogy(snr_range,ber,'-bo');
    title('BIT Error Rate');
    grid on
    xlabel('Signal to noise ratio');
    ylabel('Bit error rate');
    
   