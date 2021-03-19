clc
clear

a = 'CBABD';

n = double('A') - 1;

a = a - n;

% arithmetic encoding

P = [0.2 0.5 0.2 0.1]; % probabilities
S = a; % message

L_cur = 0;
U_cur = 1;

L = cumsum([0 P(1:end-1)]);
U = cumsum(P);

for i = 1:length(S)
   W = U_cur - L_cur;
   U_cur = L_cur + W * U(S(i));
   L_cur = L_cur + W * L(S(i));
   dec2bin(L_cur * 2^16)
   dec2bin(U_cur * 2^16)
end

L_cur
U_cur
L_cur_bin = dec2bin(L_cur * 2^16)
U_cur_bin = dec2bin(U_cur * 2^16)