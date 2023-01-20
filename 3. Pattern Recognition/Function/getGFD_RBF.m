%% REF
% D. Zhang and G. Lu, “Shape-based image retrieval using generic Fourier descriptor,” Signal Processing: Image Communication, vol. 17, no. 10, pp. 825–848, 2002.
function [output] = getGFD_RBF(order,rho)
% compute the radial polynomial
output=exp(1j*2*pi*order.*rho);
end