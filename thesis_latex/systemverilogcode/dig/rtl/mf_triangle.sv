module mf_triangle #(
    parameter signed [10:0] A = -383,
    parameter signed [10:0] B = -300,
    parameter signed [10:0] C = -217
)(
    input  logic signed [10:0] x,    // input variable (ADC diff)
    output logic [7:0] mu            // membership degree (0-255)
);
    // --- HARDWARE OPTIMIZATION: DIVISION -> MULTIPLY & SHIFT ---
    // Precompute the division as a constant multiplier and use a bitwise right shift (>> 10).
    // This eliminates logic-hungry dividers during synthesis.
    localparam integer DEN_LEFT  = B - A;
    localparam integer DEN_RIGHT = C - B;
    localparam integer MULT_LEFT  = (DEN_LEFT  != 0) ? ((255 << 10) / DEN_LEFT)  : 0;
    localparam integer MULT_RIGHT = (DEN_RIGHT != 0) ? ((255 << 10) / DEN_RIGHT) : 0;

    // Internal signals
    logic signed [11:0] num1, num2;
    logic signed [21:0] tmp;
    logic signed [15:0] result;
    always_comb begin
        // Default outputs
        mu = 8'd0;
        // Left slope: A < x < B
        if ((x > A) && (x < B)) begin
            num1 = x - A;
            tmp = num1 * MULT_LEFT;
            // Bitwise shift replaces division (adding 512 for rounding)
            result = (tmp + 512) >>> 10;
            mu = (result > 255) ? 8'd255 : result[7:0];
        end
        // Right slope: B <= x < C
        else if ((x >= B) && (x < C)) begin
            num2 = C - x;
            tmp = num2 * MULT_RIGHT;
            // Bitwise shift replaces division (adding 512 for rounding)
            result = (tmp + 512) >>> 10;
            mu = (result > 255) ? 8'd255 : result[7:0];
        end
        // Peak: x == B (technically covered above, but explicit)
        else if (x == B) begin
            mu = 8'd255;
        end
    end

endmodule