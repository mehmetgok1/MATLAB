
%% ====================================================
%  270W PV Buck Converter (TSMC 130nm Control)
%  Topologies & Formulas Sources:
%  [1] R. Erickson, D. Maksimovic, "Fundamentals of Power Electronics", 2nd Ed.
%  [2] M. H. Rashid, "Power Electronics Handbook", 4th Ed.
%  [3] Texas Instruments, "Basic Calculation of a Buck Converter" (SLVA477B).
%  ====================================================
clear; clc;

%% 1. System Operating Points
f_sw = 500e3;        % 500 kHz (Selected for Tape-out Logic density)
P_max = 270;         % 270 Watts (User Spec)
Vin_mpp = 30.6;      % PV Voltage at MPP
Vout_nom = 14.4;     % Battery Charging Voltage

% Max Output Current (I = P/V)
% Designed for worst-case low battery voltage (12V)
I_out_max = P_max / 12.0; % 22.5A

%% 2. Inductor Sizing
% Source: Erickson [1], Chapter 2, Equation 2.18
% Rule: Select Ripple (dI) between 20-40% of max load [3].
Ripple_Ratio = 0.30; 
Delta_I_L = I_out_max * Ripple_Ratio; % 6.75A
D_nom = Vout_nom / Vin_mpp;           % Duty Cycle

% Formula: L = (Vout * (1 - D)) / (f_sw * dI)
L_calc = (Vout_nom * (1 - D_nom)) / (f_sw * Delta_I_L);
% Result: ~2.26 uH

%% 3. Input Capacitor Sizing
% Source: Rashid [2], Chapter 10 "DC-DC Converters", Eq 10.32
% Also derived in TI Application Report SLTA055 for input ripple.
% Target Input Ripple: 1% of Vin (Essential for MPPT accuracy).
Delta_V_in = Vin_mpp * 0.01; 

% Formula: Cin = (I_out * D * (1-D)) / (f_sw * dV_in)
Cin_calc = (I_out_max * D_nom * (1 - D_nom)) / (f_sw * Delta_V_in);
% Result: ~36 uF (Select standard 47uF)

%% 4. Sampling Frequency
% Source: Nyquist-Shannon Theorem & Feedback Control Theory
% Rule: Sampling Freq < 1/10th of Switching Freq to avoid aliasing noise.
sampling = 20e3;     % 20 kHz


%% Sim time
Sim_Time = 0.1; % Seconds
%% Frequency and Sampling Specs
%buck_freq=1e5;
%sampling=1e6;
%delay =1000/sampling;
%duty_change_delay=600*delay;
%%% MPPT Points
%Vin=30.6;
%%% Expected Output
%Vout=15;
%D=Vout/Vin;
%%% Inductor Sizing
%Ripple_Iout=0.2;
%Lout=Vout*(1-D)/(buck_freq*Ripple_Iout);
%%% Capacitor Sizing
%Cin=10e-3;
%%delay=10e-6;
