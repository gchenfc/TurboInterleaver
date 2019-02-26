function [outvec] = interleaver(invec)
%%  Gerry Chen
%   ECE559 - interleaver calculator for turbo coder internal interleaver
%   Feb 18, 2019

    assert(length(unique(invec))<=2, 'binary data required');
    
    K = length(invec);
    
    switch (K)
        case 6144
            f1 = 263;
            f2 = 480;
        case 1056
            f1 = 17;
            f2 = 66;
        otherwise
            error('invalid code block length');
    end

    i = (1:K) - 1;
    pi = mod(f1*i+f2*i.^2,K);
    outvec = zeros(K,1);
    outvec(pi+1) = invec;

end