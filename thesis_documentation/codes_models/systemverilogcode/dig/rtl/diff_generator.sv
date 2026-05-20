module diff_generator (
    input  logic        clk,
    input  logic        rst_n,
    input  logic [9:0]  in_value,     // current input sample
    output logic signed [10:0] diff   // signed difference output
);
    logic [9:0] prev_value;
    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n)
            prev_value <= 10'd0;
        else
            prev_value <= in_value;
    end
    always_comb begin
        diff = $signed({1'b0, in_value}) - $signed({1'b0, prev_value});
    end
endmodule