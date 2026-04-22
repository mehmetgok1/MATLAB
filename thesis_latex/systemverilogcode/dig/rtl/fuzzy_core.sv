module fuzzy_core (
    input  logic clk,
    input  logic reset_n,
    input  logic signed [10:0] diff_V,   // ΔV from ADC
    input  logic signed [10:0] diff_I,   // ΔI from ADC
    input  logic signed [10:0] V_pv,     // Panel Voltage (for mapping)
    input  logic signed [10:0] dV_A_neg, dV_B_neg,   // (dV: ΔV membership thresholds)
    input  logic signed [10:0] dV_A_tri, dV_B_tri, dV_C_tri,  
    input  logic signed [10:0] dV_A_pos, dV_B_pos,  
    input  logic signed [10:0] dI_A_neg, dI_B_neg, //(dI: ΔI membership thresholds)
    input  logic signed [10:0] dI_A_tri, dI_B_tri, dI_C_tri,
    input  logic signed [10:0] dI_A_pos, dI_B_pos,
    input  logic signed [10:0] Vpv_A_low, Vpv_B_low,   // (Vpv: Panel voltage thresholds)
    input  logic signed [10:0] Vpv_A_opt, Vpv_B_opt, Vpv_C_opt,  
    input  logic signed [10:0] Vpv_A_high, Vpv_B_high,  
    input  logic signed [7:0] C1, C2, C3, C4,
    input  logic signed [7:0] C5, C6, C7, C8,
    output logic signed [10:0] duty_adjust
);
    logic [7:0] dV_mu_neg, dV_mu_ze, dV_mu_pos;
    logic [7:0] dI_mu_neg, dI_mu_ze, dI_mu_pos;
    logic [7:0] Vpv_mu_low, Vpv_mu_opt, Vpv_mu_high;
    logic [7:0] w [1:8];
    fuzzifier fuzz_inst (
        .diff_V(diff_V), .diff_I(diff_I), .V_pv(V_pv),
        .dV_A_neg(dV_A_neg), .dV_B_neg(dV_B_neg),
        .dV_A_tri(dV_A_tri), .dV_B_tri(dV_B_tri), .dV_C_tri(dV_C_tri),
        .dV_A_pos(dV_A_pos), .dV_B_pos(dV_B_pos),
        .dI_A_neg(dI_A_neg), .dI_B_neg(dI_B_neg),
        .dI_A_tri(dI_A_tri), .dI_B_tri(dI_B_tri), .dI_C_tri(dI_C_tri),
        .dI_A_pos(dI_A_pos), .dI_B_pos(dI_B_pos),
        .Vpv_A_low(Vpv_A_low), .Vpv_B_low(Vpv_B_low),
        .Vpv_A_opt(Vpv_A_opt), .Vpv_B_opt(Vpv_B_opt), .Vpv_C_opt(Vpv_C_opt),
        .Vpv_A_high(Vpv_A_high), .Vpv_B_high(Vpv_B_high),
        .dV_mu_neg(dV_mu_neg), .dV_mu_ze(dV_mu_ze), .dV_mu_pos(dV_mu_pos),
        .dI_mu_neg(dI_mu_neg), .dI_mu_ze(dI_mu_ze), .dI_mu_pos(dI_mu_pos),
        .Vpv_mu_low(Vpv_mu_low), .Vpv_mu_opt(Vpv_mu_opt), .Vpv_mu_high(Vpv_mu_high)
    );
    inference inf_inst (
        .dV_mu_neg(dV_mu_neg), .dV_mu_ze(dV_mu_ze), .dV_mu_pos(dV_mu_pos),
        .dI_mu_neg(dI_mu_neg), .dI_mu_ze(dI_mu_ze), .dI_mu_pos(dI_mu_pos),
        .Vpv_mu_low(Vpv_mu_low), .Vpv_mu_opt(Vpv_mu_opt), .Vpv_mu_high(Vpv_mu_high),
        .w(w)
    );
    defuzzifier defuzz_inst (
        .w(w),
        .C1(C1), .C2(C2), .C3(C3), .C4(C4),
        .C5(C5), .C6(C6), .C7(C7), .C8(C8),
        .dDuty(duty_adjust)
    );
endmodule