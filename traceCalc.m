function [L, C, R, ZoDC] = traceCalc(lengthM,widthM,distanceM,ThicknessofCopperM)
%[L, C, R, ZoDC] = traceCalc(lengthM,widthM,distanceM,ThicknessofCopperM)

epsilonR=4.6;%dielectric constant, permitivity 
uR=1;%permeability of copper 
u0=1.256637062*10^(-6); %vacuum permeability 
eps0=8.85*10^(-12); %epsilon zero 
Roh=1.68*10^(-8);

%% assuming microstrip line
L=distanceM*u0*uR/widthM;
C=widthM*eps0*epsilonR/distanceM;
R=Roh*lengthM/(ThicknessofCopperM*widthM);
ZoDC=sqrt(L/C);

%% MattLABScript
%R=Roh*lengthM/(ThicknessofCopperM*widthM);
% parTrace takes other units (mils?)
%[L,C,ZoDC] = parTrace(lengthM,widthM,distanceM,ThicknessofCopperM,epsilonR);
end