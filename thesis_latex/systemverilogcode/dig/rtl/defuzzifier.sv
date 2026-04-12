module defuzzifier (
    input  logic [7:0] w [1:8],                   // 8 Rule weights from Inference
    input  logic signed [7:0] C1, C2, C3, C4,     // Sugeno constants (tunable)
    input  logic signed [7:0] C5, C6, C7, C8,
    output logic signed [10:0] dDuty              // Final step size
);

    logic signed [20:0] sum_wi_ci;
    logic [9:0] sum_wi;
    logic [4:0] shift_amount;

    always_comb begin
        //======================================================================
        // WEIGHTED SUM: Σ(wi * Ci)
        //======================================================================
        sum_wi_ci = ( $signed({1'b0, w[1]}) * C1 ) +
                    ( $signed({1'b0, w[2]}) * C2 ) +
                    ( $signed({1'b0, w[3]}) * C3 ) +
                    ( $signed({1'b0, w[4]}) * C4 ) +
                    ( $signed({1'b0, w[5]}) * C5 ) +
                    ( $signed({1'b0, w[6]}) * C6 ) +
                    ( $signed({1'b0, w[7]}) * C7 ) +
                    ( $signed({1'b0, w[8]}) * C8 );

        //======================================================================
        // TOTAL WEIGHT: Σ(wi)
        //======================================================================
        sum_wi = {1'b0, w[1]} + {1'b0, w[2]} + {1'b0, w[3]} + {1'b0, w[4]} + 
                 {1'b0, w[5]} + {1'b0, w[6]} + {1'b0, w[7]} + {1'b0, w[8]};

        //======================================================================
        // HARDWARE-EFFICIENT DEFUZZIFICATION: Replace Divider with Right-Shift
        // Find the CLOSEST power of 2 to sum_wi for minimal quantization error
        //======================================================================
        if (sum_wi == 0) begin
            shift_amount = 5'd0;  // Avoid division by zero
        end
        else if (sum_wi < 12'd24) begin
            // For very small sums, use shift_amount = 4 (2^4 = 16)
            shift_amount = 5'd4;
        end
        else if (sum_wi < 12'd48) begin
            shift_amount = 5'd5;   // 2^5 = 32
        end
        else if (sum_wi < 12'd96) begin
            shift_amount = 5'd6;   // 2^6 = 64
        end
        else if (sum_wi < 12'd192) begin
            shift_amount = 5'd7;   // 2^7 = 128
        end
        else if (sum_wi < 12'd384) begin
            shift_amount = 5'd8;   // 2^8 = 256
        end
        else if (sum_wi < 12'd768) begin
            shift_amount = 5'd9;   // 2^9 = 512
        end
        else if (sum_wi < 12'd1536) begin
            shift_amount = 5'd10;  // 2^10 = 1024
        end
        else begin
            shift_amount = 5'd11;  // 2^11 = 2048 (max case)
        end

        // Sugeno defuzzification: ΔD ≈ (Σ(wi * Ci)) >> shift_amount
        // Now uses closest power-of-2 for much better accuracy
        if (sum_wi != 0) begin
            dDuty = sum_wi_ci >> shift_amount;
        end else begin
            dDuty = 11'sd0;
        end
    end
endmodule
