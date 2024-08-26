function sym_out = bits_to_sym_QPSK(bits, bits_per_symbol)
sym_out = zeros(1, length(bits)/bits_per_symbol);
for i = 1:length(sym_out)
    if bits(2*i-1:2*i) == [0 1]
        sym_out(i) = -1+1i;
    elseif bits(2*i-1:2*i) == [0 0]
        sym_out(i) = 1+1i;
    elseif bits(2*i-1:2*i) == [1 0]
        sym_out(i) = 1-1i;
    elseif bits(2*i-1:2*i) == [1 1]
        sym_out(i) = -1-1i;
    end
    
end
