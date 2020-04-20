function parVia(h, d, d1, d2)
L = (h/5)*(1+log(4*h/d));
C = (.0555*4.5*h*d1)/(d2-d1);
Z = 31.6*sqrt(L/C);

fprintf('Capacitance(pF): %f\n', C)
fprintf('Inductance(nH): %f\n', L)
fprintf('Char Impedance: %f\n', Z)
end