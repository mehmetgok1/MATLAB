module mf_triangle (
    input  logic signed [10:0] A,    // Left slope start
    input  logic signed [10:0] B,    // Peak
    input  logic signed [10:0] C,    // Right slope end
    input  logic signed [10:0] x,    // input variable (ADC diff)
    output logic [7:0] mu            // membership degree (0-255)
);
    logic signed [11:0] num1, num2, den1, den2;
    logic signed [19:0] scaled;
    logic [7:0] shifted_result;
    logic [4:0] shift_amount_left, shift_amount_right;
    always_comb begin
        mu = 8'd0;
        if ((x > A) && (x < B)) begin
            num1 = x - A;
            den1 = B - A;
            // Determine shift amount based on CLOSEST power of 2
            if (den1 < 12'd12) shift_amount_left = 5'd3;   // 2^3 = 8
            else if (den1 < 12'd24) shift_amount_left = 5'd4;   // 2^4 = 16
            else if (den1 < 12'd48) shift_amount_left = 5'd5;   // 2^5 = 32
            else if (den1 < 12'd96) shift_amount_left = 5'd6;   // 2^6 = 64
            else if (den1 < 12'd192) shift_amount_left = 5'd7;   // 2^7 = 128
            else if (den1 < 12'd384) shift_amount_left = 5'd8;   // 2^8 = 256
            else if (den1 < 12'd768) shift_amount_left = 5'd9;   // 2^9 = 512
            else if (den1 < 12'd1536) shift_amount_left = 5'd10;  // 2^10 = 1024
            else shift_amount_left = 5'd11;  // 2^11 = 2048
            // Hardware-efficient: mu = 255 * (x - A) / (B - A) ~ (255 * num1) >> shift_amount
            scaled = num1 * 8'd255;
            shifted_result = scaled >> shift_amount_left;
            mu = (shifted_result > 255) ? 8'd255 : shifted_result;
        end
        else if ((x >= B) && (x < C)) begin
            num2 = C - x;
            den2 = C - B;
            // Determine shift amount based on CLOSEST power of 2
            if (den2 < 12'd12) shift_amount_right = 5'd3;   // 2^3 = 8
            else if (den2 < 12'd24) shift_amount_right = 5'd4;   // 2^4 = 16
            else if (den2 < 12'd48) shift_amount_right = 5'd5;   // 2^5 = 32
            else if (den2 < 12'd96) shift_amount_right = 5'd6;   // 2^6 = 64
            else if (den2 < 12'd192) shift_amount_right = 5'd7;   // 2^7 = 128
            else if (den2 < 12'd384) shift_amount_right = 5'd8;   // 2^8 = 256
            else if (den2 < 12'd768) shift_amount_right = 5'd9;   // 2^9 = 512
            else if (den2 < 12'd1536) shift_amount_right = 5'd10;  // 2^10 = 1024
            else shift_amount_right = 5'd11;  // 2^11 = 2048
            // Hardware-efficient: mu = 255 * (C - x) / (C - B) ~ (255 * num2) >> shift_amount
            scaled = num2 * 8'd255;
            shifted_result = scaled >> shift_amount_right;
            mu = (shifted_result > 255) ? 8'd255 : shifted_result;
        end
        else if (x == B) begin
            mu = 8'd255;
        end
    end

endmodule
