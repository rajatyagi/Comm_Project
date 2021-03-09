function final_recvd = lowpass(y,fc,Fs)
    
    cut_off = 2*fc/Fs;
    order = 64;

    h = fir1(order,cut_off);
    con = conv(y,h);

    final_recvd = 2 * con(order/2 + 1 :length(con)-order/2);

end