function [L C Z] = parTrace(l, w, h, t, e0)

L = 2.0*l*log((5.98*h)/(.8*w+t));
C = .264*l*(e0 + 1.41)/(log((5.98*h)/(.8*w+t)));
Z = 31.6*sqrt(L/C);

fprintf('Capacitance(pF): %f\n', C)
fprintf('Inductance(nH): %f\n', L)
fprintf('Char Impedance: %f\n', Z)
end