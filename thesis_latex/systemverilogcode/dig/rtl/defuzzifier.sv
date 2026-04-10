module defuzzifier (
    input  logic [7:0] w [1:8],          // 8 Rule weights from Inference
    output logic signed [10:0] dDuty     // Final step size
);

    // Sugeno Constants from MATLAB
    // Index matches our Rule List: 
    // w1:-40 (decrease duty to boost V), w2:+40 (increase duty to brake V)
    // w3:-10, w4:+10, w5:+10, w6:-10, w7:0, w8:0
    localparam signed [7:0] C1 = -40; // Big Decrease (boost when V=Low)
    localparam signed [7:0] C2 =  40; // Big Increase (brake when V=High)
    localparam signed [7:0] C3 =  -5; // Decrease
    localparam signed [7:0] C4 =   5; // Increase
    localparam signed [7:0] C5 =   5; // Increase
    localparam signed [7:0] C6 =  -5; // Decrease
    localparam signed [7:0] C7 =   0; // Hold
    localparam signed [7:0] C8 =   0; // Hold

    // Intermediate accumulators
    logic signed [20:0] sum_wi_ci; 
    logic [15:0] sum_wi;

    always_comb begin
        // Weighted Sum: Σ(wi * Ci)
        sum_wi_ci = ( $signed({1'b0, w[1]}) * C1 ) +
                    ( $signed({1'b0, w[2]}) * C2 ) +
                    ( $signed({1'b0, w[3]}) * C3 ) +
                    ( $signed({1'b0, w[4]}) * C4 ) +
                    ( $signed({1'b0, w[5]}) * C5 ) +
                    ( $signed({1'b0, w[6]}) * C6 ) +
                    ( $signed({1'b0, w[7]}) * C7 ) +
                    ( $signed({1'b0, w[8]}) * C8 );

        // Total Weight: Σ(wi)
        sum_wi = w[1] + w[2] + w[3] + w[4] + w[5] + w[6] + w[7] + w[8];

        // Weighted Average (The "Defuzz")
        if (sum_wi != 0) begin
            dDuty = sum_wi_ci / $signed({1'b0, sum_wi});
        end else begin
            dDuty = 0;
        end
    end
endmodule