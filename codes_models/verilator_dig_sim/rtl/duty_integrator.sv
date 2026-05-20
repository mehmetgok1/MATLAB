module duty_integrator (
    input  logic        clk,
    input  logic        reset_n,
    input  logic signed [10:0] duty_adjust,  // from fuzzy core
    output logic [9:0]  dac_value            // to DAC (0..1023)
);

    // Internal accumulator: 11 bits plus extra headroom to avoid overflow
    logic signed [15:0] acc;

    // Saturation limits (0.3*1023 = 307, 0.7*1023 = 716)
    localparam logic [15:0] MIN_ACC = 16'd307;
    localparam logic [15:0] MAX_ACC = 16'd716;

    always_ff @(posedge clk or negedge reset_n) begin
        if (!reset_n)
            acc <= 16'd512; // start at midpoint 0.5
        else begin
            acc <= acc + {{5{duty_adjust[10]}}, duty_adjust}; // sign-extend to 16 bits

            // Saturate directly
            if (acc > MAX_ACC)
                acc <= MAX_ACC;
            else if (acc < MIN_ACC)
                acc <= MIN_ACC;
        end
    end

    // Output to 10-bit DAC
    assign dac_value = acc[9:0]; // take lower 10 bits

endmodule