clear; clc;
% ==========================================
% STEP 1: DIRECT CONFIGURATION
% ==========================================
N = 12;     % Total Bits
L = 6;      % LSB Bits
M = 6;      % MSB Bits
m = 2;      % Bridge Capacitor Ratio (Cbri = m * C)
C_unit = 1; % Normalized unit cap
% ==========================================
% STEP 2: EWM CALCULATIONS (Eq. 4 logic)
% ==========================================
C_bri = m * C_unit;
C_lsb_array_sum = 2^L * C_unit; % e.g., 64C for 6-bit LSB
C_c = (2^L - 1) * C_bri - C_lsb_array_sum;
if C_c < 0
    fprintf('WARNING: Calculated Cc is %.1f * C.\n', C_c);
    fprintf('A negative capacitor is physically impossible!\n');
else
    fprintf('Adjustment Cap (Cc): %.1f * C\n\n', C_c);
end
% ==========================================
% STEP 3: WEIGHT VERIFICATION
% ==========================================
lsb_bits = 2.^(0:L-1);
msb_bits = 2.^(0:M-1);
% Calculate Attenuation Factor (alpha)
C_lsb_total = C_lsb_array_sum + C_c; 
alpha = C_bri / (C_bri + C_lsb_total);
% Final Weights
w_lsb = alpha * lsb_bits;
w_msb = msb_bits;
all_weights = [w_lsb, w_msb];
% Linearity Check: The gap between the LSBs and MSBs
gap = w_msb(1) / w_lsb(end);
fprintf('Weight Ratio (MSB_min / LSB_max): %.4f\n', gap);
if abs(gap - 2) < 1e-6
    fprintf('RESULT: Binary Weighting is PERFECT.\n');
else
    fprintf('RESULT: Binary Weighting is BROKEN.\n');
end

