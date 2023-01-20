%% REF
% M. Bober, F. Preteux, and W.-Y. Y. Kim, “Shape descriptors,” in Introduction to MPEG 7: Multimedia Content Description Language, B. S. Manjunat, P. Salembier, and T. Sikora, Eds. John Wiley & Sons, 2002, ch. 15, pp. 231–260.
function [output] = getART_RBF(order,rho)
% compute the radial polynomial
if order==0
    output=rho.^0;
else
    output=cos(pi*order.*rho);
end
end