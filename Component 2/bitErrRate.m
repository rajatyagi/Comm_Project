function ber = bitErrRate(k,snr_range)

    %SNR vs BER
    ber = [];

    for i = 1:length(snr_range)

        [~,~,~,recvd_bits] = commSystem(k,snr_range(i));    

        error = 0;
        for i = 1:length(k)

            if k(i) ~= recvd_bits(i)

                error = error + 1;  

            end

        end
        
        ber = [ber error/length(k)];

    end

end

