%% Frequency and Sampling Specs
buck_freq=1e5;
sampling=1e6;
delay =100/sampling;
%% MPPT Points
Vin=30.6;
%% Expeted Output
Vout=15;
D=Vout/Vin;
%% Inductor Sizing
Ripple_Iout=0.2;
Lout=Vout*(1-D)/(buck_freq*Ripple_Iout);
%% Capacitor Sizing
Cin=10e-3;