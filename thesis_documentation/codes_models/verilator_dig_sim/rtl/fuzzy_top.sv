module fuzzy_top (
    input  logic       clk,
    input  logic       reset_n,
    input  logic [9:0] V_in,    // raw voltage input
    input  logic [9:0] I_in,    // raw current input
    output logic [9:0] dac_value // final DAC output
);

    // Wires for differences
    logic signed [10:0] diff_V, diff_I;
    logic signed [10:0] duty_adjust; // output from fuzzy core

    // Instantiate diff generators
    diff_generator diff_V_inst (
        .clk(clk),
        .rst_n(reset_n),
        .in_value(V_in),
        .diff(diff_V)
    );

    diff_generator diff_I_inst (
        .clk(clk),
        .rst_n(reset_n),
        .in_value(I_in),
        .diff(diff_I)
    );

    // Instantiate fuzzy core
    fuzzy_core fuzzy_core_inst (
        .clk(clk),
        .reset_n(reset_n),
        .diff_V(diff_V),
        .diff_I(diff_I),
        .duty_adjust(duty_adjust)
    );

    // Instantiate duty integrator
    duty_integrator integrator_inst (
        .clk(clk),
        .reset_n(reset_n),
        .duty_adjust(duty_adjust),
        .dac_value(dac_value)
    );

endmodule
