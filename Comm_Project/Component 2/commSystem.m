function [symbols1,symbols2,recvdSymbols,recvd_bits] = commSystem(bits,snr)
   
    %bit to symbols
    symbols = [];
    a = 2;

    for i = 1:length(bits)

         x = 0;
         y = 0;

         if bits(i) == 0     %if bit = 0 symbol => S1
             x = a;
             y = 0;
         else                %if bit = 1 symbol => S2   
             x = 0;
             y = a;
         end

        symbols = [symbols [x y]];

    end

    %Multiplicative Gaussian noise
    H = [];

    for i = 1:length(bits)  
    noise1 = randn(1) + 1i*randn(1);   %Complex Gaussian noise
    noise2 = randn(1) + 1i*randn(1);   %Complex Gaussian noise
    H = [H [noise1 noise2]];
    end

    %y = Hx + N        Channel
    y = symbols.*H;   %multiplication with complex gaussian noise 
    pseudoRecvd = awgn(y,snr,'measured'); %Additive noise
    
    %Symbol Detection
    symbols1 = [];
    symbols2 = [];
    recvd_bits = [];
    recvdSymbols = [];

    for i = 1:2:length(pseudoRecvd)-1   %considering two symbols at a time

        if abs(pseudoRecvd(i))^2 > abs(pseudoRecvd(i+1))^2    %S1 detection
            
            %Storing the symbols detected as S1 by adding the two components
            symbols1 = [symbols1 ; [real(pseudoRecvd(i) + pseudoRecvd(i+1)) imag(pseudoRecvd(i) + pseudoRecvd(i+1))]];
            %Storing the bits detected as S1 => 0
            recvd_bits = [recvd_bits 0]; 
        
        elseif abs(pseudoRecvd(i+1))^2 > abs(pseudoRecvd(i))^2   %S2 detection
        
            %Storing the symbols detected as S2 by adding the two components
            symbols2 = [symbols2 ; [real(pseudoRecvd(i) + pseudoRecvd(i+1)) imag(pseudoRecvd(i) + pseudoRecvd(i+1))]];
            %Storing the bits detected as S2 => 1
            recvd_bits = [recvd_bits 1];
       
        end    
        
        recvdSymbols = [recvdSymbols ; [real(pseudoRecvd(i) + pseudoRecvd(i+1)) imag(pseudoRecvd(i) + pseudoRecvd(i+1))]];
        
    end

end 