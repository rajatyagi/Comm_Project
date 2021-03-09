function ber = bitErrRate(T,reps)

    ber = [];
    msg = 'Hello World';
    
    for snrdb = -20:1:20
    
        [bpsk_with_reps,output,~] = commSystem(msg,reps,T,snrdb);

        error=length(find(output ~= bpsk_with_reps));
        ber(snrdb+21) = error/length(output);

    end
        
end