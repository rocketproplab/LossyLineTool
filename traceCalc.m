function [L, C, R, ZoDC] = traceCalc(length,width,distance,ThicknessOfCopper)
%[L, C, R, ZoDC] = traceCalc(lengthM,widthM,distanceM,ThicknessofCopperM)
% Parameters in mils

epsilonR=4.3;%dielectric constant, permitivity 
uR=1;%permeability of copper 
u0=1.256637062*10^(-6); %vacuum permeability 
eps0=8.85*10^(-12); %epsilon zero 
Roh=1.68*10^(-8); %resistivity


%% unit conversions
ThicknessofCopperM=ThicknessOfCopper*2.54*10^(-5); %Thickness of copper m
widthM=width*2.54*10^(-5); %Width and Length in meters
% lengthM=length*2.54*10^(-5);
% distanceM=distance*2.54*10^(-5);
lengthM=length*2.54*10^(-5);

%ThicknessofCopperI=ThicknessofCopper*10^(-3); %Thickness of trace in inches
widI=width*10^(-3); %Width and Length in inches
lenI=length*10^(-3); % Length of trace
distI=distance*10^(-3); % Distance between trace and ground plane

%% microstrip approximations
L = inductanceCalc(lenI,widI,distI); % in uH
C = capacitanceCalc(lenI,width,distance,ThicknessOfCopper,epsilonR); % uF

%% assuming microstrip line
%L=distanceM*u0*uR/widthM;
%C=widthM*eps0*epsilonR/distanceM;
R=Roh*lengthM/(ThicknessofCopperM*widthM);
ZoDC=sqrt(L/C);

function L = inductanceCalc(len,wid,dist)
    L = 0.00508*(log(2*len/(wid+dist)) + 0.5 + 0.2235*(wid+dist)/len); %uH
end

function C = capacitanceCalc(len,wid,dist,thick,epsilonR)
    C = (10^6)*len*0.67*(epsilonR+1.41)/log(5.98*dist/(0.8*wid+thick)); % uF
end

end