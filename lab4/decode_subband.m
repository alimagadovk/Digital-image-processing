% Используется только в jp2.m
% покомпонентное декодирование элементов массива subband
% компоненты могут иметь целые значения из диапазона 0..255
for i = 1: size(subband,1)
        for j = 1: size(subband,2)
            decode_symbol;
            update_model;
            subband(i,j) = symbol -1;
        end
    end