function wer = wordErrRate(T,reps)

    wer = [];
    msg = 'HELLO';
    
    for snrdb = -20:1:20
        error = 0;
        for i = 1:100  
            [~,~,recvd_message] = commSystem(msg,reps,T,snrdb);
            
            if ~strcmp(recvd_message,msg)
                error = error + 1;
            end
        end
        
        if(error == 0)
            error = 0.01;
        end
        
        wer(snrdb+21) = error/100;

    end
        
end