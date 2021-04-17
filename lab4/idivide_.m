function c = idivide_(a,b)
% Integer division with rounding towards zero: idivide_fix
    c = (a - rem(a,b)) ./ b;
end