module mf_triangle #(
    parameter signed [10:0] A = -383,
    parameter signed [10:0] B = -300,
    parameter signed [10:0] C = -217
)(
    input  logic signed [10:0] x,    // input variable (ADC diff)
    output logic [7:0] mu            // membership degree (0-255)
);
    localparam logic signed [10:0] SCALE = 11'd255;
    logic signed [11:0] num1, num2, den1, den2;
    logic signed [21:0] tmp;
    logic signed [15:0] result;
    always_comb begin
        mu = 8'd0;
        if ((x > A) && (x < B)) begin
            num1 = x - A;
            den1 = B - A;
            tmp = num1 * SCALE;
            result = (tmp + (den1 >> 1)) / den1;
            mu = (result > 255) ? 8'd255 : result[7:0];
        end
        else if ((x >= B) && (x < C)) begin
            num2 = C - x;
            den2 = C - B;
            tmp = num2 * SCALE;
            result = (tmp + (den2 >> 1)) / den2;
            mu = (result > 255) ? 8'd255 : result[7:0];
        end
        else if (x == B) begin
            mu = 8'd255;
        end
    end
endmodule
