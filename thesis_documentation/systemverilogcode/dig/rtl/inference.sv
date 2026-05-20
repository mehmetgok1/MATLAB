module inference (
    input  logic [7:0] dV_mu_neg, dV_mu_ze, dV_mu_pos,
    input  logic [7:0] dI_mu_neg, dI_mu_ze, dI_mu_pos,
    input  logic [7:0] Vpv_mu_low, Vpv_mu_opt, Vpv_mu_high,
    output logic [7:0] w [1:8] 
);
    function automatic logic [7:0] min3(logic [7:0] a, logic [7:0] b, logic [7:0] c);
        logic [7:0] m2;
        m2 = (a < b) ? a : b;
        return (m2 < c) ? m2 : c;
    endfunction
    always_comb begin
        // --- GROUP A: SAFETY RULES ---
        w[1] = Vpv_mu_low; 
        w[2] = Vpv_mu_high;
        // --- GROUP B: FINE TUNING (Only active in Optimal Range) ---
        w[3] = min3(dV_mu_pos, dI_mu_pos, Vpv_mu_opt);
        w[4] = min3(dV_mu_pos, dI_mu_neg, Vpv_mu_opt);
        w[5] = min3(dV_mu_neg, dI_mu_pos, Vpv_mu_opt);
        w[6] = min3(dV_mu_neg, dI_mu_neg, Vpv_mu_opt);
        w[7] = min3(dV_mu_ze, dI_mu_ze, Vpv_mu_opt);
        // Rule 8: Stable (Ze/Any/Opt) -> HOLD (Combining two stable rules)
        w[8] = min3(dV_mu_ze, (dI_mu_neg > dI_mu_pos ? dI_mu_neg : dI_mu_pos), Vpv_mu_opt);
    end
endmodule