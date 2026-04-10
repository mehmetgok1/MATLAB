module mf_z #(
    parameter signed [10:0] A = -64,
    parameter signed [10:0] B = 383
)(
    input  logic signed [10:0] x,
    output logic [7:0] mu
);

    logic signed [11:0] diff, denom;
    logic signed [19:0] scaled;
    logic [7:0] div_result;

    always_comb begin
        if (x <= A) begin
            mu = 8'd255;        // High at left
        end
        else if (x >= B) begin
            mu = 8'd0;          // Low at right
        end
        else begin
            // Falling linear ramp: mu = 255 * (B - x) / (B - A)
            diff = B - x;       // Note: B - x, not x - A
            denom = B - A;
            scaled = diff * 8'd255;
            div_result = (scaled + (denom >> 1)) / denom;
            mu = (div_result > 255) ? 8'd255 : div_result;
        end
    end
endmodule