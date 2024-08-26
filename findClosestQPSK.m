% PURPOSE:  Find symbol vector from an N-dimensial list of symbol vectors 
%           that is closest to the given passed in point
% INPUTS:
%   point:   vector representing measured point
%   QPSK_points:  vector listing possible symbol vectors to be searched,
%                  with each column representing a different symbol vector
% OUTPUT:  
%   closest:  The index of the closest symbol
%
% Author: Emily Zeiberg, Feb 2024
% Credit: Professor Patwari

function closest = findClosestQPSK(point, QPSK_points)

dist = zeros(1, length(QPSK_points));
for i=1:length(QPSK_points)
    dist(i) = sqrt((QPSK_points(i, 1) - real(point))^2 + (QPSK_points(i,2) - imag(point))^2);
end
[~, ind] = min(dist);
closest = ind;

