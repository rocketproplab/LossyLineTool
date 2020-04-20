close all
%% time period to plot
period=1/(1.5*10^(9));
numOfPCoe=1000;
%% read off sheet
[l w d t names] = readSheet();
for i=1:size(names)
    printCalc(l(i),w(i),d(i),t(i),char(names(i)),period,numOfPCoe)
end
%% calc and save plot function
function printCalc(length,width,distance,ThicknessOfCopper,name,period,numOfPCoe)
% printCalc(length,width,distance,ThicknessOfCopper,name,period,numOfPCoe)
%   Calculates inductance, capacitance, and resistance of trace, plots the
%   response superimposed on a square wave, and writes the plot to the working
%   directory under 'name.pdf'.
%% time period to plot
tstart=-period;
increment=period/100;
tend=period;
%% calculate coeficients
coe= fourierCoeficientsRect(numOfPCoe);
%% calculate fundamental period
w0=2*pi/period;
%% transmission line function
%width=29.55; %in mils
%length=1000; %in mils 
%distance=7.87; %distance of dielectric in mils 
%ThicknessOfCopper=1.377; %thickness of copper trace in mils 

ThicknessofCopperM=ThicknessOfCopper*2.54*10^(-5); %Thickness of copper trace in meters 
widthM=width*2.54*10^(-5); %Width and Length in meters 
lengthM=length*2.54*10^(-5);
distanceM=distance*2.54*10^(-5);

[L, C, R, ZoDC]=traceCalc(lengthM,widthM,distanceM,ThicknessofCopperM);

%You can input your own L,C,G,R values here 
%R=10*10^(-3);
G=10^(-9);
%L=10*10^(-9);
%C=15*10^(-15);
l1=lengthM;

rangeOfFreq=getFrequencies(numOfPCoe,w0);
ZL=50;
[g G Zo]=getGammas(rangeOfFreq,R,G,L,C,ZL);
H=getResponse(g, G, l1);
%% plotting output
f = figure;
val=[];
for t1=tstart:increment:tend
%     plot(t,sumPt(coe,t,100,w0),'-x');
%     hold on
    val=[val sumPtResponse(coe,t1,numOfPCoe,w0,H)];
end
q=[tstart:increment:tend];
plot(q,val);
axis([tstart tend -5 5]);

name=strcat(name,'.pdf');
exportgraphics(f,name);
close;
end
%% functions
%% sum points of original function
function [point]=sumPt(ak,t,n,w0)
k=[-n:1:n];
point=sum(ak.*exp(j*w0*k*t));
end
%% sum the response of the points
function [response]=sumPtResponse(ak,t1,n,w0,H)
k=[-n:1:n];
response=sum(ak.*exp(j*w0*k*t1).*H);
end

%% get frequencies
function [angFreq]=getFrequencies(n,w0)
k=[-n:1:n];
k(n+1)=0.000000001;
angFreq=k*w0;
end
%% get scaling factor
function [H]= getResponse(g, G, l1)
H=(1+G)./(exp(g*l1)+G.*exp(g*(-l1)));
end

%% get small gamma, output imepedence, and big gamma
function [g G Z0]=getGammas(angFreq,R,G,L,C,ZL)
g=sqrt((R+j*angFreq*L).*(G+j*angFreq*C));
Z0=sqrt((R+j*angFreq*L)./(G+j*angFreq*C));
G=(ZL-Z0)./(ZL+Z0);
end
%% get fourier coeficients of square wave
function [ak] = fourierCoeficientsRect(n)
k=[-n:1:n];
ak=1/2*sincu(pi/2*k);
ak(n+1)=1/2;
%*sin(pi/2*k)./(pi/2*k);
end
%% get sinc of some vector
function [r] = sincu(w)
r=sin(w)./(w);
end