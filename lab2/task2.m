clc
% arithmetic decoding

P = [0.2 0.5 0.2 0.1]; % probabilities
M = length(a); % number of symbol
B = 0.7530; % 0.8750; % B = 0.111

L = cumsum([0 P(1:end-1)]);
U = cumsum(P);

S = zeros(1, M);
for i = 1:M
   S(i) = max(find(L <= B));
   B = (B - L(S(i))) / (U(S(i)) - L(S(i)));
end

%S

%
a = S + n
char(a)