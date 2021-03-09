
function [bpsk_with_reps,output,recvd_msg] = commSystem(msg,reps,T,snrdb)

    Ts = 1/reps; %sampling time
    Fs = 1/Ts; %sampling frequency
    fc = 2/T; %carrier frequency
    
    %preprocessing
    morseCode = string2morse(msg);
    binaryMorseCode = morse2bit(char(morseCode));
    bpsk_symbols = binaryMorseCode*2 -1;

    %modulation
    t=linspace(0,T*length(bpsk_symbols),T*reps*length(bpsk_symbols)); 
    bpsk_with_reps = symbolRep(bpsk_symbols , reps);  
    carrier_wave = sin(2*pi*fc*t);   % carrier wave
    passband_signal = carrier_wave .* bpsk_with_reps ;  %Modulted Passband signal

    %channel
    recvd_noisy = awgn(passband_signal,snrdb,'measured');

    %demodulation
    y = recvd_noisy .* carrier_wave;
    final_recvd = lowpass(y,fc,Fs);

    %postprocessing
    [result,output] = signal2bits(final_recvd,reps);
    recvd_morseCode = bit2morse(result);
    recvd_msg = morse2string(recvd_morseCode);
    
end