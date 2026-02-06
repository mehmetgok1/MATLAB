%% ====================================================
%  Normalized Fuzzy MPPT with Voltage Supervision
%  Target: Buck Converter (PV->12–14V Battery)
%  FIS Type: 3-Input Sugeno
%
%  Inputs:
%   1) dV_pu   = (Vpv(k)-Vpv(k-1))/Vpv(k)
%   2) dI_pu   = (Ipv(k)-Ipv(k-1))/Ipv(k)
%   3) Vpv_pu  = Vpv / Voc
%
%  Output:
%   dDuty (raw integer, scaled by /1024 in PWM)
%  ====================================================

clear; clc;

fis = sugfis;
fis.Name = 'MPPT_Buck_Normalized';

%% ====================================================
%% 1. Input: Normalized Delta PV Voltage (per-unit)
% Typical ripple is within ±5%
fis = addInput(fis, [-0.1 0.1], 'Name', 'dV_pu');

fis = addMF(fis,'dV_pu','linzmf',[-0.05 0],'Name','Negative');
fis = addMF(fis,'dV_pu','trimf',[-0.01 0 0.01],'Name','Zero');
fis = addMF(fis,'dV_pu','linsmf',[0 0.05],'Name','Positive');

%% ====================================================
%% 2. Input: Normalized Delta PV Current (per-unit)
fis = addInput(fis, [-0.1 0.1], 'Name', 'dI_pu');

fis = addMF(fis,'dI_pu','linzmf',[-0.05 0],'Name','Negative');
fis = addMF(fis,'dI_pu','trimf',[-0.01 0 0.01],'Name','Zero');
fis = addMF(fis,'dI_pu','linsmf',[0 0.05],'Name','Positive');

%% ====================================================
%% 3. Input: Absolute PV Voltage (Normalized to Voc)
% Voc ≈ 40 V → Vpv_pu = Vpv / 40
fis = addInput(fis, [0 1], 'Name', 'Vpv_pu');

% Low: near short-circuit (overloading panel)
fis = addMF(fis,'Vpv_pu','trapmf',[-0.1 0 0.25 0.35],'Name','Low');

% Normal MPPT region
fis = addMF(fis,'Vpv_pu','trapmf',[0.25 0.35 0.85 0.9],'Name','Normal');

% High: near open-circuit
fis = addMF(fis,'Vpv_pu','trapmf',[0.85 0.9 1.1 1.2],'Name','High');

%% ====================================================
%% 4. Output: Duty Cycle Increment (integer)
% PWM resolution assumed: 1024
% Small steps for MPPT, big steps only for protection
fis = addOutput(fis, [-30 30], 'Name', 'dDuty');

fis = addMF(fis,'dDuty','constant',-25,'Name','Big_Decrease'); % ~-2.5%
fis = addMF(fis,'dDuty','constant',-6, 'Name','Decrease');     % ~-0.6%
fis = addMF(fis,'dDuty','constant', 0, 'Name','Hold');
fis = addMF(fis,'dDuty','constant', 6, 'Name','Increase');     % ~+0.6%
fis = addMF(fis,'dDuty','constant', 25,'Name','Big_Increase'); % ~+2.5%

%% ====================================================
%% 5. Rule Base
% Format:
% [dV  dI  Vpv  dDuty  weight]
%
% dV,dI: 1=Neg 2=Zero 3=Pos
% Vpv:   1=Low 2=Normal 3=High
% dDuty: 1=BigDec 2=Dec 3=Hold 4=Inc 5=BigInc

ruleList = [

    % ===== VOLTAGE SUPERVISOR (OVERRIDES MPPT) =====
    % Near Voc → pull current (increase duty)
    0 0 3 5 1;

    % Near Isc → relax load (decrease duty)
    0 0 1 1 1;

    % ===== STANDARD P&O (ONLY IN NORMAL REGION) =====

    % dV↑ dI↑ → left of MPP → need higher Vpv → DECREASE duty
    3 3 2 2 1;

    % dV↑ dI↓ → passed MPP → need lower Vpv → INCREASE duty
    3 1 2 4 1;

    % dV↓ dI↑ → climbing right side → INCREASE duty
    1 3 2 4 1;

    % dV↓ dI↓ → passed MPP (left) → DECREASE duty
    1 1 2 2 1;

    % ===== DEAD ZONE / STABILITY =====
    2 2 2 3 1;
    2 1 2 3 1;
    2 3 2 3 1;
    1 2 2 3 1;
    3 2 2 3 1;
];

fis = addRule(fis, ruleList);

%% ====================================================
%% 6. Save FIS
writefis(fis,'../FIS_RULES/mppt_sugeno_normalized.fis');
fprintf('Normalized MPPT FIS created successfully.\n');

%% ====================================================
%% 7. Visualization (Normal Voltage Region)
figure;
gensurf(fis,[1 2],1,[0.35 0.85]);
title('Normalized MPPT Control Surface (Vpv Normal)');
xlabel('dV_pu'); ylabel('dI_pu'); zlabel('dDuty');