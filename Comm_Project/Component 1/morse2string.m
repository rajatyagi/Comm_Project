function message = morse2string(x)

    morse_code = {'.----','..---','...--','....-','.....','-....','--...','---..','----.','-----','.-','-...','-.-.','-..','.','..-.','--.','....','..','.---','-.-','.-..','--','-.','---','.--.','--.-','.-.','...','-','..-','...-','.--','-..-','-.--','--..',' ','\n'}; 
    Numbers_Or_Letters={'1','2','3','4','5','6','7','8','9','0','A','B','C','D','E','F','G','H','I','J','K','L','M','N','O','P','Q','R','S','T','U','V','W','X','Y','Z',' ','\n'};

    message = char();
    
    buf = char();
    
    for i = 1:length(x)
        
        if (length(buf) == 5 || strcmp(x(i),' ')) && (i <= length(x) - 2) 

            if strcmp(x(i+1),' ') && strcmp(x(i+2),' ') && ~isempty(buf)
                
                [~, index] = ismember(buf, morse_code);
                if index > 0 
                    message = [message , Numbers_Or_Letters(index)];
                elseif index <= 0
                    message = [message , ' * '];
                end
                buf = char();

                if i <= length(x) - 6
                    if strcmp(x(i+3),' ') && strcmp(x(i+1+4),' ') && strcmp(x(i+5),' ') && strcmp(x(i+6),' ')
                        message = [message , ' '];
                    end
                end
            end
            
        elseif strcmp(x(i),'.') || strcmp(x(i),'-')
            buf = [buf , x(i)];
        end
        
    end
    
    [~, index] = ismember(buf, morse_code);
    if index > 0 
        message = [message , Numbers_Or_Letters(index)];
    end
    
    if iscellstr(message)
       
        message = string(strjoin(message,''));    
        
    end

end