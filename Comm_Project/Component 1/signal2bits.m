function [result , output] = signal2bits(final_recvd,reps)

    result = [];
    output = [];
    count1 = 0;
    count0 = 0;

    for k = 0:floor(length(final_recvd)/reps) - 1
        count1 = 0;
        count0 = 0;
        for i = 1:reps
            if final_recvd(k*reps+i) > 0
                count1 = count1 + 1;
                output = [output , 1];
            else 
                output = [output , -1];
                count0 = count0 + 1;
            end
        end

        if count1 > count0
            result = [result , 1];
        else
            result = [result , 0];
        end

    end

end