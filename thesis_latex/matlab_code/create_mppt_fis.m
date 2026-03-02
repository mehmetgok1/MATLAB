clear; clc;

% 1. Create New FIS
fis = sugfis;
fis.Name = 'MPPT_Thesis_Stable';

%% 2. Inputs: dV and dI
% dV Input (Raw ADC difference)
fis = addInput(fis, [-10 10], 'Name', 'dV_raw');
fis = addMF(fis,'dV_raw','linzmf',[-5 0],'Name','Negative');
fis = addMF(fis,'dV_raw','trimf',[-4 0 4],'Name','Zero'); 
fis = addMF(fis,'dV_raw','linsmf',[0 5],'Name','Positive');

% dI Input (Raw ADC difference)
fis = addInput(fis, [-10 10], 'Name', 'dI_raw');
fis = addMF(fis,'dI_raw','linzmf',[-5 0],'Name','Negative');
fis = addMF(fis,'dI_raw','trimf',[-4 0 4],'Name','Zero');
fis = addMF(fis,'dI_raw','linsmf',[0 5],'Name','Positive');

%% 3. Input: V_pv (The "Map")
% 0-1024 ADC count. Target ~783 (30.6V).
fis = addInput(fis, [0 1024], 'Name', 'V_pv');
% 1. Low Voltage: Ramp down earlier (720 to 760)
% 1. Low Voltage: Ends at 730 (Was 770)
% If V < 730, use Big Steps. If V > 730, relax.
fis = addMF(fis,'V_pv','zmf',[680 730],'Name','Low_Voltage');

% 2. Optimal Range: Wide Base [720 ... 850]
% This guarantees that between 730 and 840, ONLY the "Fine Tuning" rules (+/- 1) apply.
fis = addMF(fis,'V_pv','trimf',[720 783 850],'Name','Optimal_Range');

% 3. High Voltage: Starts at 840 (Was 790)
% Only panic if V > 840.
fis = addMF(fis,'V_pv','smf',[840 890],'Name','High_Voltage');
%% 4. OUTPUT: Adaptive Step Size
fis = addOutput(fis, [-20 20], 'Name', 'dDuty');

% MF Index 1: Safety Brake (-15)
fis = addMF(fis,'dDuty','constant',-15,'Name','Big_Decrease');

% MF Index 2: Fine Tune Down (-1)
fis = addMF(fis,'dDuty','constant',-1, 'Name','Decrease');

% MF Index 3: Steady State (0)
fis = addMF(fis,'dDuty','constant', 0, 'Name','Hold');

% MF Index 4: Fine Tune Up (+1)
fis = addMF(fis,'dDuty','constant', 1, 'Name','Increase');

% MF Index 5: Safety Throttle (+15)
fis = addMF(fis,'dDuty','constant', 15,'Name','Big_Increase');

%% 5. Rule Base
% [dV, dI, V_pv, Output, Weight, AND/OR]
ruleList = [];

% --- GROUP A: SAFETY (Speed) ---
ruleList = [ruleList; 
    0 0 1 1 1 1]; % V=Low  -> Big_Decrease (Index 1)
ruleList = [ruleList; 
    0 0 3 5 1 1]; % V=High -> Big_Increase (Index 5)

% --- GROUP B: FINE TUNING (Precision) ---
ruleList = [ruleList;
    3 3 2 2 1 1; % Pos/Pos -> Decrease (-1)
    3 1 2 4 1 1; % Pos/Neg -> Increase (+1)
    1 3 2 4 1 1; % Neg/Pos -> Increase (+1)
    1 1 2 2 1 1; % Neg/Neg -> Decrease (-1)
    
    % *** THE CRITICAL CHANGE IS HERE ***
    % OLD: 2 2 2 2 1 1 (Stuck -> Perturb/Decrease)
    % NEW: 2 2 2 3 1 1 (Stuck -> HOLD)
    % If dV=0 and dI=0, do NOTHING. Stay there.
    2 2 2 3 1 1; 

    2 1 2 3 1 1; % Stable  -> Hold (0)  //The "Shock Absorber" (The Filter Effect) ; The "Ocean" Analogy (The Battery Effect)
    2 3 2 3 1 1; % Stable  -> Hold (0)  //same effect as above, battery huge cap voltage can be constant and current can wiggle
];

fis = addRule(fis, ruleList);

%% 6. Write to File
writefis(fis, '../FIS_RULES/mppt_sugeno.fis');
fprintf('Success: Perturb rule disabled. Controller will now HOLD at the peak.\n');