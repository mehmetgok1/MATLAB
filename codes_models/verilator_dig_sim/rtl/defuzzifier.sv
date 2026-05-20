module defuzzifier (
    input  logic [7:0] rule_weights [0:6][0:6],
    output logic signed [10:0] duty_adjust
);

    // Define fuzzy set type
    typedef enum logic [2:0] {
        NB = 3'd0, NM = 3'd1, NS = 3'd2, ZE = 3'd3,
        PS = 3'd4, PM = 3'd5, PB = 3'd6
    } fuzzy_set_t;

    // Rule base: ΔV × ΔI → output fuzzy set
    parameter fuzzy_set_t rule_base [0:6][0:6] = '{
        '{NB, NB, NM, NS, PM, PB, PB}, // If ΔV is NB
        '{NB, NM, NM, NS, PM, PM, PB}, // If ΔV is NM
        '{NM, NM, NS, NS, PS, PM, PM}, // If ΔV is NS 
        '{PS, PS, PS, ZE, NS, NS, NS}, // If ΔV is ZE
        '{PM, PM, PS, PS, NS, NM, NM}, // If ΔV is PS
        '{PB, PM, PM, PS, NM, NM, NB}, // If ΔV is PM
        '{PB, PB, PM, PS, NM, NB, NB}  // If ΔV is PB
    };

    // Output centers as array for easy indexing
    // Range: -100 to +100 for aggressive MPPT control
    localparam signed [10:0] centers [0:6] = '{-100, -67, -33, 0, 33, 67, 100};

    // Intermediate accumulators
    logic signed [20:0] numerator;    // 21 bits signed for Σ(weight * center)
    logic [15:0] denominator;         // 16 bits unsigned for Σ(weight)

    always_comb begin
    numerator   = 0;
    denominator = 0;

    for (int dv_idx = 0; dv_idx < 7; dv_idx++) begin
        for (int di_idx = 0; di_idx < 7; di_idx++) begin
            logic [7:0] weight;
            fuzzy_set_t output_set;
            logic signed [10:0] center;
            logic signed [8:0] signed_weight;

            weight       = rule_weights[dv_idx][di_idx];
            output_set   = rule_base[dv_idx][di_idx];
            center       = centers[output_set];
            signed_weight = $signed({1'b0, weight});

            numerator   += signed_weight * center;
            denominator += weight;
        end
    end

    if (denominator != 0) begin
        logic signed [15:0] signed_denom;
        signed_denom = $signed({1'b0, denominator});
        duty_adjust = numerator / signed_denom;
    end else begin
        duty_adjust = 0;
    end
end


endmodule