function signal_with_reps = symbolRep(x , reps)

    bb = repmat(x',1,reps);  
    signal_with_reps = bb';
    signal_with_reps = signal_with_reps(:)';

end