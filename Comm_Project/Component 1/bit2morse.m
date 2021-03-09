function morseCode = bit2morse(x)

    morseCode = char();

    for i = 1:length(x)
       
        if x(i:i) == 0
            morseCode = [morseCode, ' '];
        elseif x(i:i) == 1 && i <= length(x)-2 && i ~= 1
            
            if x(i+1:i+1) == 1 && x(i+2:i+2) == 1
                morseCode = [morseCode, '-'];
                i = i + 2;
            elseif x(i+1:i+1) == 0 && x(i-1:i-1) == 0 
                morseCode = [morseCode, '.'];    
            end
            
        end
                
    end
    
end