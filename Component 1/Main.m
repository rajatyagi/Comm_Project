clc;
close all;

%----------------------Manually Typing the message---------------------

message = input('Write a message (using alphanumeric characters only) : ','s');

%------------------Converting message to Morse Code--------------------

morseCode = string2morse(message);

input('Press Enter to View the morse Code of your message : ','s')

disp("Morse Code:");
disp(morseCode);

%----------------Morse Code in binary format for BPSK------------------

binaryMorseCode = morse2bit(char(morseCode));

disp("Morse Code in Binary format:");
disp(num2str(binaryMorseCode));

%------------binary bits to BPSK symbols 1 -> 1 & 0 -> -1--------------

bpsk_symbols = binaryMorseCode*2 -1;

%----------------------------MODULATION--------------------------------

reps = 25; %repititions
Ts = 1/reps; %sampling time
Fs = 1/Ts; %sampling frequency
T = 1; %Bit duration
fc = 2/T; %carrier frequency

%time from 0 to T*length(bpsk_symbols) step size T/reps
t=linspace(0,T*length(bpsk_symbols),T*reps*length(bpsk_symbols)); 

% repeating the symbols 'reps' number of times
bpsk_with_reps = symbolRep(bpsk_symbols , reps);  

carrier_wave = sin(2*pi*fc*t);   % carrier wave
passband_signal = carrier_wave .* bpsk_with_reps ;  %Modulted Passband signal

%----------------------------Received Signal (Channel)----------------------------

snr = 5;
recvd_noisy = awgn(passband_signal,snr,'measured');

%----------------------------DEMODULATION------------------------------

y = recvd_noisy .* carrier_wave;

final_recvd = lowpass(y,fc,Fs);

[result,output] = signal2bits(final_recvd,reps);

%-------------------------------PLOTS---------------------------------

%Modulted Passband signal and digital wave plot

input('Press Enter to View the signal generated for your message : ','s')

figure(1);
    subplot(2,1,1);
    plot(t,bpsk_with_reps);
    title("Digital Waveform of the Message");
    ylim([-1.5 1.5]);
    xlim([0 30]) ;

    subplot(2,1,2);
    plot(t,passband_signal);
    title("Passband Signal");
    ylim([-1.5 1.5]);
    xlim([0 30]);

input('Press Enter to View the difference between I/P and O/P of the channel : ','s')
    
%Input and Output of Channel
figure(2);
    subplot(2,1,1);
    plot(t,passband_signal);
    title("Passband signal Sent in the Channel");
    ylim([-1.5 1.5]);
    xlim([0 30]);

    subplot(2,1,2);
    plot(t,recvd_noisy);
    title("Signal Received from the Channel");
    ylim([-1.5 1.5]);
    xlim([0 30]);

input('Press Enter to View the first step of demodulation of your message signal : ','s')    
    
%Noisy received signal multiplied with Carrier Wave
figure(3);
    plot(t,y);
    title("Noisy signal Multiplied with Carrier Wave");
    ylim([-1.5 1.5]);
    xlim([0 30]);

input('Press Enter to View the message signal received by filtering : ','s')    
    
%Output of the Lowpass Filter
figure(4);
    plot(t,final_recvd);
    title("Output of Lowpass Filter");
    ylim([-2 2]);
    xlim([0 30]);

input('Press Enter to View the final output of demodulation : ','s') 
    
%Final Demodulated Waveform (Digital)
figure(5);
    plot(t,output);
    title("Output of Demodulation");
    ylim([-2 2]);
    xlim([0 50]);

%---------------------------Recevied Data Display-----------------------------

input('Press Enter to View the received Data : ','s') 

disp("Recieved Bits:");
disp(num2str(result));

morseCode = bit2morse(result);

disp("Received Morse Code:");
disp(morseCode);

message = morse2string(morseCode);

disp("Received Message:");
disp(message);

%---------------------------SNR vs BER ,LER & WER-----------------------------

input('Press Enter to calculate Error rates of the comm system : ','s')

snrdb = -20 : 1 : 20;

disp("Calculating Bit Error Rate For Our Comm System.....");
ber = bitErrRate(T,reps);

disp("Calculating Letter Error Rate For Our Comm System.....")
ler = letterErrRate(T,reps);

disp("Calculating Word Error Rate For Our Comm System.....")
wer = wordErrRate(T,reps);

input('Press Enter to View BER vs SNR : ','s')

figure(6)
    semilogy(snrdb,ber,'-bo');
    title('BIT Error Rate');
    grid on
    xlabel('Signal to noise ratio');
    ylabel('Bit error rate');

input('Press Enter to View LER vs SNR : ','s')
    
figure(7)
    semilogy(snrdb,ler,'-bo');
    title('Letter Error Rate'); 
    grid on
    xlabel('Signal to noise ratio');
    ylabel('letter error rate');
        
input('Press Enter to View WER vs SNR : ','s')    

figure(8)
    semilogy(snrdb,wer,'-bo');
    title('Word Error Rate');
    grid on
    xlabel('Signal to noise ratio');
    ylabel('word error rate');
    
    