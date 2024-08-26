% PURPOSE:  Find the bits corresponding to each symbol for QPSK
% INPUTS:
%   symbols:   vector containing each symbol in the received signal
% OUTPUT:  
%   bits_out:  vector that contains the bits corresponding to each symbol
%
% Author: Emily Zeiberg, March 2024

function bits_out = sym_to_bits_QPSK(symbols)
bits_out = zeros(1, length(symbols)*2);
for i = 1:length(symbols)
    if symbols(i) == 1
        bits_out(2*i-1:2*i) = [0 1];
    elseif symbols(i) == 2
        bits_out(2*i-1:2*i) = [0 0];
    elseif symbols(i) == 3
        bits_out(2*i-1:2*i) = [1 0];
    elseif symbols(i) == 4
        bits_out(2*i-1:2*i) = [1 1];
    end
    
end