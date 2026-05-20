module fuzzifier(
    input  logic signed [10:0] diff_V,   // dV_raw (derivative of voltage)
    input  logic signed [10:0] diff_I,   // dI_raw (derivative of current)
    input  logic signed [10:0] V_pv,     // V_pv differential (ADC: Vpv/12 - 2.5V, center at 512)
    input  logic signed [10:0] dV_A_neg, dV_B_neg,    // dV Membership Function Parameters
    input  logic signed [10:0] dV_A_tri, dV_B_tri, dV_C_tri,
    input  logic signed [10:0] dV_A_pos, dV_B_pos,
    input  logic signed [10:0] dI_A_neg, dI_B_neg,    // dI Membership Function Parameters
    input  logic signed [10:0] dI_A_tri, dI_B_tri, dI_C_tri,
    input  logic signed [10:0] dI_A_pos, dI_B_pos,
    input  logic signed [10:0] Vpv_A_low, Vpv_B_low,    // Vpv Membership Function Parameters
    input  logic signed [10:0] Vpv_A_opt, Vpv_B_opt, Vpv_C_opt,
    input  logic signed [10:0] Vpv_A_high, Vpv_B_high,
    output logic [7:0] dV_mu_neg,    // dV Membership degrees
    output logic [7:0] dV_mu_ze,
    output logic [7:0] dV_mu_pos,
    output logic [7:0] dI_mu_neg,// dI Membership degrees
    output logic [7:0] dI_mu_ze,
    output logic [7:0] dI_mu_pos,
    output logic [7:0] Vpv_mu_low,// V_pv Membership degrees
    output logic [7:0] Vpv_mu_opt,
    output logic [7:0] Vpv_mu_high
);
    
    mf_z        mf_dv_neg (.A(dV_A_neg), .B(dV_B_neg), .x(diff_V), .mu(dV_mu_neg)); // Negative: linzmf
    mf_triangle mf_dv_ze  (.A(dV_A_tri), .B(dV_B_tri), .C(dV_C_tri), .x(diff_V), .mu(dV_mu_ze));    // Zero: trimf
    mf_s        mf_dv_pos (.A(dV_A_pos), .B(dV_B_pos), .x(diff_V), .mu(dV_mu_pos)); // Positive: linsmf
    mf_z        mf_di_neg (.A(dI_A_neg), .B(dI_B_neg), .x(diff_I), .mu(dI_mu_neg));    // Negative: linzmf
    mf_triangle mf_di_ze  (.A(dI_A_tri), .B(dI_B_tri), .C(dI_C_tri), .x(diff_I), .mu(dI_mu_ze));// Zero: trimf
    mf_s        mf_di_pos (.A(dI_A_pos), .B(dI_B_pos), .x(diff_I), .mu(dI_mu_pos));// Positive: linsmf
    // V_pv Fuzzification (DIFFERENTIAL INPUT, Vcm at 512)
    mf_z        mf_vpv_low  (.A(Vpv_A_low), .B(Vpv_B_low), .x(V_pv), .mu(Vpv_mu_low));     // 1. Low_Voltage (Turbo Mode)
    mf_triangle mf_vpv_opt  (.A(Vpv_A_opt), .B(Vpv_B_opt), .C(Vpv_C_opt), .x(V_pv), .mu(Vpv_mu_opt));    // 2. Optimal_Range (The Sweet Spot)
    mf_s        mf_vpv_high (.A(Vpv_A_high), .B(Vpv_B_high), .x(V_pv), .mu(Vpv_mu_high));     // 3. High_Voltage (Safety Brake)
endmodule