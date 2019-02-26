%%  Gerry Chen
%   ECE559 - interleaver test vector generator
%       generates test vectors for turbo coder internal interleaver
%   Feb 18, 2019

testInd = 0;

%% 1056-size code blocks
for K = [1056,6144]
    % one-hot tests
    for i = 1:5
        invec = zeros(K,1,'uint8');
        invec(i) = 1;
        outvec = interleaver(invec);
        MIF_gen(sprintf('tests/input%d.mif',testInd),invec,8,K/8);
        MIF_gen(sprintf('tests/output_expected%d.mif',testInd),outvec,8,K/8);
        testInd = testInd+1;
    end
    for i = 1:5
        invec = zeros(K,1,'uint8');
        invec(K+1-i) = 1;
        outvec = interleaver(invec);
        MIF_gen(sprintf('tests/input%d.mif',testInd),invec,8,K/8);
        MIF_gen(sprintf('tests/output_expected%d.mif',testInd),outvec,8,K/8);
        testInd = testInd+1;
    end
    % block stripe tests
        invec = uint8(mod(1:K,2)); % input = output since even stays even
        outvec = interleaver(invec);
        MIF_gen(sprintf('tests/input%d.mif',testInd),invec,8,K/8);
        MIF_gen(sprintf('tests/output_expected%d.mif',testInd),outvec,8,K/8);
        testInd = testInd+1;

        invec = uint8(mod(0:K-1,2)); % input = output since odd stays odd
        outvec = interleaver(invec);
        MIF_gen(sprintf('tests/input%d.mif',testInd),invec,8,K/8);
        MIF_gen(sprintf('tests/output_expected%d.mif',testInd),outvec,8,K/8);
        testInd = testInd+1;

        invec = uint8(mod(fix((1:K)/2),2)); % input = output since odd stays odd
        outvec = interleaver(invec);
        MIF_gen(sprintf('tests/input%d.mif',testInd),invec,8,K/8);
        MIF_gen(sprintf('tests/output_expected%d.mif',testInd),outvec,8,K/8);
        testInd = testInd+1;
    % random data test
        invec = uint8(randi(2, [K,1])-1);
        outvec = interleaver(invec);
        MIF_gen(sprintf('tests/input%d.mif',testInd),invec,8,K/8);
        MIF_gen(sprintf('tests/output_expected%d.mif',testInd),outvec,8,K/8);
        testInd = testInd+1;
end