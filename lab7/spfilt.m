function f = spfilt(g, type, m, n, parameter)
%SÐFILÒ Performs linear and nonlinear spatial filtering. 
% F = SPFILT(G, TYPE, M, N, PARAMETER) performs spatial filtering 
% of image G using a TYPE filter of size M-by—N. Valid calls to 
% SPFILT are as follows: 
% 
% F = SPFILT(G, ’amean’, M, N) Arithmetic mean filtering. 
% F = SPFILT(G, ’gmean’, M, N) Geometric mean filtering. 
% F = SPFILT(G, ’hmean’, Ì, N) Harmonic mean filtering. 
% F = SPFILT(G, ’chmean’, M, N, Q) Contraharmonic mean 
%                                  filtering of order Q. The 
%                                  default is Q = 1.5. 
% F = SPFILT(G, ’median’, M, N) Median filtering. 
% F = SPFILT(G, ’max’, M, N) Max filtering. 
% F = SPFILT(G, ’min’, M, N) Min filtering. 
% F = SPFILT(G, ’midpoint’, M, N) Midpoint filtering. 
% F = SPFILT(G, ’atrimmed’, M, N, D) Alpha—trimmed mean filtering. 
%                                    Parameter D must be a nonnega— 
%                                    tive even integer; its default 
%                                    value is D = 2. 
%
% The default values when only G and TYPE are input are M = N = 3, 
% Q = 1.5, and D = 2. 
% Process inputs.
if nargin == 2
    m = 3; n = 3; Q = 1.5; d = 2;
elseif nargin == 5
    Q = parameter; d = parameter;
elseif nargin == 4
    Q = 1.5; d = 2;
else
    error('Wrong number of inputs.');
end
% Do the filtering.
switch type
    case 'amean'
        w = fspecial('average', [m n]);
        f = imfilter(g, w, 'replicate');
    case 'gmean'
        f = gmean(g, m, n);
    case 'hmean'
        f = harmean(g, m, n);
    case 'chmean'
        f = charmean(g, m, n, Q);
    case 'median'
        f = medfilt2(g, [m n], 'symmetric');
    case 'max'
        f = ordfilt2(g, m*n, ones(m, n), 'symmetric');
    case 'min'
        f = ordfilt2(g, 1, ones(m, n), 'symmetric');
    case 'midpoint'
        f1 = ordfilt2(g, 1, ones(m, n), 'symmetric');
        f2 = ordfilt2(g, m*n, ones(m, n), 'symmetric');
        f = imlincomb(0.5, f1, 0.5, f2);
    case 'atrimmed'
        if (d < 0) | (d/2 ~= round(d/2))
            error('d must be a nonnegative, even integer.')
        end
        f = alphatrim(g, m, n, d);
    otherwise
        error('Unknown filter type.')
end
end