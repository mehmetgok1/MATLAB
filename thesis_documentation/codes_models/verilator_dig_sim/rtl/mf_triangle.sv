//=======================================================
// Triangular Membership Function (synthesizable)
//=======================================================
module mf_triangle #(
    parameter signed [10:0] A = -383,
    parameter signed [10:0] B = -300,
    parameter signed [10:0] C = -217
)(
    input  logic signed [10:0] x,    // input variable (ADC diff)
    output logic [7:0] mu            // membership degree (0-255)
);

    // Internal signals with enough width to prevent overflow
    logic signed [11:0] num1;        // x - A
    logic signed [11:0] num2;        // C - x
    logic signed [11:0] den1;        // B - A
    logic signed [11:0] den2;        // C - B
    logic signed [21:0] tmp;         // for scaled intermediate values
    logic signed [15:0] result;

    always_comb begin
        // Default output
        mu = 8'd0;

        // Left slope
        if ((x > A) && (x < B)) begin
            num1 = x - A;
            den1 = B - A;
            tmp = num1 * 22'sd256;   // scale by 256
            result = tmp / den1;
            mu = (result > 255) ? 8'd255 : result[7:0];
        end

        // Right slope
        else if ((x >= B) && (x < C)) begin
            num2 = C - x;
            den2 = C - B;
            tmp = num2 * 22'sd256;   // scale by 256
            result = tmp / den2;
            mu = (result > 255) ? 8'd255 : result[7:0];
        end

        // Peak value
        else if (x == B) begin
            mu = 8'd255;
        end

        // Outside region → mu = 0 (already default)
    end

endmodule
