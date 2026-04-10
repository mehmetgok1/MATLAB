module fuzzy_core (
    input  logic clk,
    input  logic reset_n,
    input  logic signed [10:0] diff_V,   // ΔV from ADC
    input  logic signed [10:0] diff_I,   // ΔI from ADC
    input  logic signed [10:0] V_pv,     // Panel Voltage (for mapping)
    output logic signed [10:0] duty_adjust
);

    // --- 1. Fuzzifier Output Wires ---
    logic [7:0] dV_mu_neg, dV_mu_ze, dV_mu_pos;
    logic [7:0] dI_mu_neg, dI_mu_ze, dI_mu_pos;
    logic [7:0] Vpv_mu_low, Vpv_mu_opt, Vpv_mu_high;

    // --- 2. Inference Output Wires (Firing Strengths) ---
    logic [7:0] w [1:8];

    //=======================================================
    // Module Instantiations
    //=======================================================

    // Fuzzifier: Translates ADC counts to Fuzzy sets
    fuzzifier fuzz_inst (
        .diff_V(diff_V),
        .diff_I(diff_I),
        .V_pv(V_pv),
        .dV_mu_neg(dV_mu_neg), .dV_mu_ze(dV_mu_ze), .dV_mu_pos(dV_mu_pos),
        .dI_mu_neg(dI_mu_neg), .dI_mu_ze(dI_mu_ze), .dI_mu_pos(dI_mu_pos),
        .Vpv_mu_low(Vpv_mu_low), .Vpv_mu_opt(Vpv_mu_opt), .Vpv_mu_high(Vpv_mu_high)
    );

    // Inference: Applies the 8 Rules (Safety + Fine Tuning)
    inference inf_inst (
        .dV_mu_neg(dV_mu_neg), .dV_mu_ze(dV_mu_ze), .dV_mu_pos(dV_mu_pos),
        .dI_mu_neg(dI_mu_neg), .dI_mu_ze(dI_mu_ze), .dI_mu_pos(dI_mu_pos),
        .Vpv_mu_low(Vpv_mu_low), .Vpv_mu_opt(Vpv_mu_opt), .Vpv_mu_high(Vpv_mu_high),
        .w(w)
    );

    // Defuzzifier: Weighted Average to find dDuty
    defuzzifier defuzz_inst (
        .w(w),
        .dDuty(duty_adjust)
    );

endmodule