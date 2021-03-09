function morseCode = string2morse(x)

    morseCode = {"  "};
    morse_code = {'- - - - -','. - - - -','. . - - -','. . . - -','. . . . -','. . . . .','- . . . .','- - . . .','- - - . .','- - - - .','. -','- . . .','- . - .','- . .','.','. . - .','- - .','. . . .','. .','. - - -','- . -','. - . .','- -','- .','- - -','. - - .','- - . -','. - .','. . .','-','. . -','. . . -','. - -','- . . -','- . - -','- - . .',' ','\n'}; 
    Numbers_Or_Letters={'0','1','2','3','4','5','6','7','8','9','A','B','C','D','E','F','G','H','I','J','K','L','M','N','O','P','Q','R','S','T','U','V','W','X','Y','Z',' ','\n'};

    for i = 1 : length(x)
        
        j = 0 ;
        
        if int32(x(i:i)) >= 97 && int32(x(i:i)) <= 122
            j = int32(x(i:i))-86;
        elseif int32(x(i:i)) >= 65 && int32(x(i:i)) <= 90
            j = int32(x(i:i))-54;
        elseif int32(x(i:i)) >= 48 && int32(x(i:i)) <= 57
            j = int32(x(i:i))-47;
        elseif int32(x(i:i)) ~= 32
            continue;
        end
        
        if int32(x(i:i)) ~= 32
            morseCode = [morseCode,morse_code{j}," "];
        elseif int32(x(i:i)) == 32
            morseCode = [morseCode,"   "];
        end
        
    end
    
    morseCode = [morseCode,""];
    morseCode = strjoin(morseCode);
    
end