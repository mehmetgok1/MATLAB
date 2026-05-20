module fuzzy_core (
    input  logic clk,
    input  logic reset_n,
    input  logic signed [10:0] diff_V,  // ΔV = Vₖ - Vₖ₋₁
    input  logic signed [10:0] diff_I,  // ΔI = Iₖ - Iₖ₋₁
    output logic signed [10:0] duty_adjust  // Final duty cycle adjustment
);

    // Fuzzifier outputs
    logic [7:0] DV_mu_nb, DV_mu_nm, DV_mu_ns, DV_mu_ze, DV_mu_ps, DV_mu_pm, DV_mu_pb;
    logic [7:0] DI_mu_nb, DI_mu_nm, DI_mu_ns, DI_mu_ze, DI_mu_ps, DI_mu_pm, DI_mu_pb;
    
    // Inference outputs (7x7 rule weights)
    logic [7:0] rule_weights [0:6][0:6];

    // Instantiate all modules
    fuzzifier fuzzifier_inst (
        .diff_V(diff_V),
        .diff_I(diff_I),
        .DV_mu_nb(DV_mu_nb),
        .DV_mu_nm(DV_mu_nm),
        .DV_mu_ns(DV_mu_ns),
        .DV_mu_ze(DV_mu_ze),
        .DV_mu_ps(DV_mu_ps),
        .DV_mu_pm(DV_mu_pm),
        .DV_mu_pb(DV_mu_pb),
        .DI_mu_nb(DI_mu_nb),
        .DI_mu_nm(DI_mu_nm),
        .DI_mu_ns(DI_mu_ns),
        .DI_mu_ze(DI_mu_ze),
        .DI_mu_ps(DI_mu_ps),
        .DI_mu_pm(DI_mu_pm),
        .DI_mu_pb(DI_mu_pb)
    );

    inference inference_inst (
        .DV_mu_nb(DV_mu_nb),
        .DV_mu_nm(DV_mu_nm),
        .DV_mu_ns(DV_mu_ns),
        .DV_mu_ze(DV_mu_ze),
        .DV_mu_ps(DV_mu_ps),
        .DV_mu_pm(DV_mu_pm),
        .DV_mu_pb(DV_mu_pb),
        .DI_mu_nb(DI_mu_nb),
        .DI_mu_nm(DI_mu_nm),
        .DI_mu_ns(DI_mu_ns),
        .DI_mu_ze(DI_mu_ze),
        .DI_mu_ps(DI_mu_ps),
        .DI_mu_pm(DI_mu_pm),
        .DI_mu_pb(DI_mu_pb),
        .rule_weights(rule_weights)
    );

    defuzzifier defuzzifier_inst (
        .rule_weights(rule_weights),
        .duty_adjust(duty_adjust)
    );

endmodule