function c = quantize(a,b)
% К ПУНКТУ №4 ЗАДАНИЯ
    c = round(a./b);                % равномерное квантование
  % c = sign(a).*fix(abs(a)./b);    % квантование с мертвой зоной