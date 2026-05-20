module mf_z #(
    parameter signed [15:0] A = -64,   // start point
    parameter signed [15:0] B =  64    // end point
)(
    input  logic signed [15:0] x,      // input (q8.8)
    output logic [15:0] mu             // membership (q8.8)
);
    always_comb begin
        if (x <= A)
            mu = 16'd256;  // 1.0
        else if (x >= B)
            mu = 16'd0;
        else
            mu = ((B - x) * 16'sd256) / (B - A);
    end
endmodule