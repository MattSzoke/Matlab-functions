function [NewSize] = fx_BytesConvert(Size,ToUnit)
% [NewSize] = fx_BytesConvert(Size,ToUnit)
%% CONVERT BYTES TO GIVEN SIZE, k: kiloByte, M: mega, G: giga, T: tera
switch ToUnit
    case 'k' % kilobyte
        NewSize = Size./(1024);
    case 'M' % megabyte
        NewSize = Size./(1024*1024);
    case 'G' % gigabyte
        NewSize = Size./(1024*1024*1024);
    case 'T' % terabyte
        NewSize = Size./(1024*1024*1024*1024);
end

end

