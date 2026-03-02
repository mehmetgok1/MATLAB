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
% Formula for Cc: (2^L - 1)*C_bri = 2^L*C + Cc
C_bri = m * C_unit;
C_lsb_array_sum = 2^L * C_unit; % e.g., 64C for 6-bit LSB
C_c = (2^L - 1) * C_bri - C_lsb_array_sum;

fprintf('--- Configuration Results ---\n');
fprintf('Resolution: %d-bit (%d LSB + %d MSB)\n', N, L, M);
fprintf('Bridge Cap (C_bri): %.1f * C\n', m);

if C_c < 0
    fprintf('WARNING: Calculated Cc is %.1f * C.\n', C_c);
    fprintf('A negative capacitor is physically impossible!\n');
    fprintf('Reason: C_bri=1 is too small for a 6+6 split. Try m >= 1.016 or m = 2.\n\n');
else
    fprintf('Adjustment Cap (Cc): %.1f * C\n\n', C_c);
end

% ==========================================
% STEP 3: WEIGHT VERIFICATION
% ==========================================
% Generate LSB binary weights: [1, 2, 4, 8, 16, 32...]
lsb_bits = 2.^(0:L-1);
msb_bits = 2.^(0:M-1);

% Calculate Attenuation Factor (alpha)
% alpha = Cbri / (Cbri + C_lsb_total + Cc)
C_lsb_total = C_lsb_array_sum + C_c; 
alpha = C_bri / (C_bri + C_lsb_total);

% Final Weights
w_lsb = alpha * lsb_bits;
w_msb = msb_bits;
all_weights = [w_lsb, w_msb];

% Linearity Check: The gap between the LSBs and MSBs
% Ideally, MSB[0] should be exactly 2x the LSB[max]
gap = w_msb(1) / w_lsb(end);
fprintf('--- Linearity Verification ---\n');
fprintf('Weight Ratio (MSB_min / LSB_max): %.4f\n', gap);
if abs(gap - 2) < 1e-6
    fprintf('RESULT: Binary Weighting is PERFECT.\n');
else
    fprintf('RESULT: Binary Weighting is BROKEN.\n');
end

% ==========================================
% STEP 4: PLOT TRANSFER FUNCTION
% ==========================================
num_steps = 1000;
vin = linspace(0, sum(all_weights), num_steps);
digital_out = zeros(size(vin));

for i = 1:num_steps
    v_rem = vin(i);
    code = 0;
    for b = N:-1:1
        if v_rem >= all_weights(b)
            v_rem = v_rem - all_weights(b);
            code = code + 2^(b-1);
        end
    end
    digital_out(i) = code;
end

figure;
plot(vin, digital_out, 'LineWidth', 1.5);
title(sprintf('%d-bit ADC (%d+%d Split, m=%.1f)', N, L, M, m));
xlabel('Analog Input'); ylabel('Digital Output Code');
grid on;
