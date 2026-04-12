module inference (
    // dV and dI inputs (3 each)
    input  logic [7:0] dV_mu_neg, dV_mu_ze, dV_mu_pos,
    input  logic [7:0] dI_mu_neg, dI_mu_ze, dI_mu_pos,
    // V_pv inputs (3)
    input  logic [7:0] Vpv_mu_low, Vpv_mu_opt, Vpv_mu_high,

    // Rule Firing Strengths (w1 through w8)
    output logic [7:0] w [1:8] 
);

    // Internal function for 3-input MIN
    function automatic logic [7:0] min3(logic [7:0] a, logic [7:0] b, logic [7:0] c);
        logic [7:0] m2;
        m2 = (a < b) ? a : b;
        return (m2 < c) ? m2 : c;
    endfunction

    always_comb begin
        // --- GROUP A: SAFETY RULES ---
        // Rule 1: V=Low -> Big_Decrease (w1)
        w[1] = Vpv_mu_low; 
        
        // Rule 2: V=High -> Big_Increase (w2)
        w[2] = Vpv_mu_high;

        // --- GROUP B: FINE TUNING (Only active in Optimal Range) ---
        // Rule 3: Pos/Pos/Opt -> Decrease
        w[3] = min3(dV_mu_pos, dI_mu_pos, Vpv_mu_opt);
        
        // Rule 4: Pos/Neg/Opt -> Increase
        w[4] = min3(dV_mu_pos, dI_mu_neg, Vpv_mu_opt);
        
        // Rule 5: Neg/Pos/Opt -> Increase
        w[5] = min3(dV_mu_neg, dI_mu_pos, Vpv_mu_opt);
        
        // Rule 6: Neg/Neg/Opt -> Decrease
        w[6] = min3(dV_mu_neg, dI_mu_neg, Vpv_mu_opt);

        // Rule 7: Stuck (Ze/Ze/Opt) -> HOLD
        w[7] = min3(dV_mu_ze, dI_mu_ze, Vpv_mu_opt);

        // Rule 8: Stable (Ze/Any/Opt) -> HOLD (Combining your two stable rules)
        // We can simplify the "Stable" logic here or list them separately.
        w[8] = min3(dV_mu_ze, (dI_mu_neg > dI_mu_pos ? dI_mu_neg : dI_mu_pos), Vpv_mu_opt);
    end
endmodule