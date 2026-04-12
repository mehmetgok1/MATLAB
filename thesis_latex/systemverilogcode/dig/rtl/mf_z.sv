module mf_z (
    input  logic signed [10:0] A,
    input  logic signed [10:0] B,
    input  logic signed [10:0] x,
    output logic [7:0] mu
);

    logic signed [11:0] diff, denom;
    logic signed [19:0] scaled;
    logic [7:0] shifted_result;
    logic [4:0] shift_amount;

    always_comb begin
        if (x <= A) begin
            mu = 8'd255;        // High at left
        end
        else if (x >= B) begin
            mu = 8'd0;          // Low at right
        end
        else begin
            // Falling linear ramp: mu = 255 * (B - x) / (B - A)
            diff = B - x;
            denom = B - A;
            
            // Determine shift amount based on CLOSEST power of 2 for minimal quantization error
            if (denom < 12'd12) shift_amount = 5'd3;   // 2^3 = 8
            else if (denom < 12'd24) shift_amount = 5'd4;   // 2^4 = 16
            else if (denom < 12'd48) shift_amount = 5'd5;   // 2^5 = 32
            else if (denom < 12'd96) shift_amount = 5'd6;   // 2^6 = 64
            else if (denom < 12'd192) shift_amount = 5'd7;   // 2^7 = 128
            else if (denom < 12'd384) shift_amount = 5'd8;   // 2^8 = 256
            else if (denom < 12'd768) shift_amount = 5'd9;   // 2^9 = 512
            else if (denom < 12'd1536) shift_amount = 5'd10;  // 2^10 = 1024
            else shift_amount = 5'd11;  // 2^11 = 2048 (standard 10-bit ADC range)
            
            // Hardware-efficient: multiply and right-shift instead of divide
            // mu = 255 * (B - x) / (B - A) ~ (255 * diff) >> shift_amount
            scaled = diff * 8'd255;
            shifted_result = scaled >> shift_amount;
            
            mu = (shifted_result > 255) ? 8'd255 : shifted_result;
        end
    end
endmodule
