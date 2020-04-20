close all
%% time period to plot
period=1/(1.5*10^(9));
tstart=-period;
increment=period/100;
tend=period;
numOfPCoe=1000;
%% calculate coeficients
coe= fourierCoeficientsRect(numOfPCoe);
%% calculate fundamental period
w0=2*pi/period;
%% plotting input
val=[];
for t=tstart:increment:tend
    val=[val sumPt(coe,t,numOfPCoe,w0)];
end
q=[tstart:increment:tend];
plot(q,val);
axis([tstart tend -5 5]);

%% transmission line
width=29.55; %in mils
length=1000; %in mils 
distance=7.87; %distance of dielectric in mils 
ThicknessOfCopper=1.377; %thickness of copper trace in mils 

ThicknessofCopperM=1.377*2.54*10^(-5); %Thickness of copper trace in meters 
widthM=width*2.54*10^(-5); %Width and Length in meters 
lengthM=length*2.54*10^(-5);
distanceM=distance*2.54*10^(-5);

epsilonR=4.6;%dielectric constant, permitivity 
uR=1;%permeability of copper 
u0=1.256637062*10^(-6); %vacuum permeability 
eps0=8.85*10^(-12); %epsilon zero 
Roh=1.68*10^(-8);

%assuming microstrip line

L=distanceM*u0*uR/widthM;
C=widthM*eps0*epsilonR/distanceM;
R=Roh*lengthM/(ThicknessofCopperM*widthM);
ZoDC=sqrt(L/C);

%You can input your own L,C,G,R values here 
%R=10*10^(-3);
G=10^(-9);
%L=10*10^(-9);
%C=15*10^(-15);
l=lengthM;

rangeOfFreq=getFrequencies(numOfPCoe,w0);
ZL=50;
[g G Zo]=getGammas(rangeOfFreq,R,G,L,C,ZL);
H=getResponse(g, G, l);
%% plotting output
figure;
val=[];
for t=tstart:increment:tend
%     plot(t,sumPt(coe,t,100,w0),'-x');
%     hold on
    val=[val sumPtResponse(coe,t,numOfPCoe,w0,H)];
end
q=[tstart:increment:tend];
plot(q,val);
axis([tstart tend -5 5]);
%% functions
%% sum points of original function
function [point]=sumPt(ak,t,n,w0)
k=[-n:1:n];
point=sum(ak.*exp(j*w0*k*t));
end
%% sum the response of the points
function [response]=sumPtResponse(ak,t,n,w0,H)
k=[-n:1:n];
response=sum(ak.*exp(j*w0*k*t).*H);
end

%% get frequencies
function [angFreq]=getFrequencies(n,w0)
k=[-n:1:n];
k(n+1)=0.000000001;
angFreq=k*w0;
end
%% get scaling factor
function [H]= getResponse(g, G, l)
H=(1+G)./(exp(g*l)+G.*exp(g*(-l)));
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