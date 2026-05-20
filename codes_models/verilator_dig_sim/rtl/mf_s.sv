module mf_s #(
    parameter signed [15:0] A = -64,   // start point (q8.8)
    parameter signed [15:0] B =  64    // end point   (q8.8)
)(
    input  logic signed [15:0] x,      // input (q8.8)
    output logic [15:0] mu             // membership (q8.8, 0–256)
);
    always_comb begin
        if (x <= A)
            mu = 16'd0;
        else if (x >= B)
            mu = 16'd256;  // 1.0
        else
            mu = ((x - A) * 16'sd256) / (B - A);
    end
endmodule
