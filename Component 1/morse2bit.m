function binaryMorseCode = morse2bit(x)

    binaryMorseCode = [];

    for i = 1:length(x)
       
        if strcmp(x(i:i)," ")
            binaryMorseCode = [binaryMorseCode, 0];
        elseif strcmp(x(i:i),".")
            binaryMorseCode = [binaryMorseCode, 1];
        elseif strcmp(x(i:i),"-")
            binaryMorseCode = [binaryMorseCode, 1 , 1 , 1];
        end
                
    end

end