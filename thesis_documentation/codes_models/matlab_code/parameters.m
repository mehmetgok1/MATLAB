
%% ====================================================
%  235W PV Buck Converter (TSMC 130nm Control)
%  Topologies & Formulas Sources:
%  [1] R. Erickson, D. Maksimovic, "Fundamentals of Power Electronics", 2nd Ed.
%  [2] M. H. Rashid, "Power Electronics Handbook", 4th Ed.
%  [3] Texas Instruments, "Basic Calculation of a Buck Converter" (SLVA477B).
%  ====================================================
clear; clc;
%% 1. System Operating Points
f_sw = 500e3;       
P_max = 235;         
Vin_mpp = 30.6;      
Vout_nom = 14.4;     
% Max Output Current (I = P/V)
I_out_max = P_max / 12.0; % 19.5A

%% 2. Inductor Sizing
Ripple_Ratio = 0.30; 
Delta_I_L = I_out_max * Ripple_Ratio; 
D_nom = Vout_nom / Vin_mpp;          
L_calc = (Vout_nom * (1 - D_nom)) / (f_sw * Delta_I_L); % Formula: L = (Vout * (1 - D)) / (f_sw * dI)
%% 3. Input Capacitor Sizing
Delta_V_in = Vin_mpp * 0.01; 
Cin_calc = (I_out_max * D_nom * (1 - D_nom)) / (f_sw * Delta_V_in);% Formula: Cin = (I_out * D * (1-D)) / (f_sw * dV_in)
%% 4. Sampling Frequency
sampling = 20e3; % Rule: Sampling Freq < 1/10th of Switching Freq to avoid aliasing noise.
%% Sim time
Sim_Time = 0.6; % Seconds

