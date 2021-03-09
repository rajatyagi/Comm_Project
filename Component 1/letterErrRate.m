function ler = letterErrRate(T,reps)

    ler = [];
    
    for snrdb = -20:1:20
        error = 0;
        for i = 1:100  
            msg = 65 + rem(i,26);
            [~,~,recvd_message] = commSystem(char(msg),reps,T,snrdb);
            
            if ~strcmp(recvd_message,char(msg))
                error = error + 1;
            end
        end
        
        if(error == 0)
            error = 0.01 ;
        end
        
        ler(snrdb+21) = error/100;

    end