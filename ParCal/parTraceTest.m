function parTraceTest()

% This program assumes PCB material permeability of 
% FR-4 standard approx 4.5
x = inputdlg({'l', 'h', 'w','t'});
x = cell2mat(x);
l = str2double(x(1,1));
h = str2double(x(2,1));
w = str2double(x(3,1));
t = str2double(x(4,1));
L = 2.0*l*log((5.98*h)/(.8*w+t));
C = .264*l*(4.5 + 1.41)/(log((5.98*h)/(.8*w+t)));
Z = 31.6*sqrt(L/C);
fprintf('Capacitance(pF): %f\n', C);
fprintf('Inductance(nH): %f\n', L);
fprintf('Char Impedance: %f\n', Z);

end