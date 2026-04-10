module fuzzy_top (
    input  logic        clk,
    input  logic        reset_n,
    input  logic        mppt_enable,
    input  logic [9:0]  manual_duty_adj,
    input  logic [9:0]  V_in,    // ADC Voltage (10-bit, Vcm at 512: Vpv÷12 - 2.5V)
    input  logic [9:0]  I_in,    // ADC Current (10-bit, Vcm at 512: I÷8 - 2.5V)
    output logic [9:0]  dac_value // Final DAC Output to hardware
);

    // --- Internal Signals ---
    logic signed [10:0] diff_V;       // Change in Voltage
    logic signed [10:0] diff_I;       // Change in Current
    logic signed [10:0] duty_adjust;  // Fuzzy Output (+/- 15, +/- 1, etc.)

    // --- 1. Differentiators (Calculate dV and dI) ---
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

    // --- 2. The Fuzzy Brain ---
    fuzzy_core fuzzy_core_inst (
        .clk(clk),
        .reset_n(reset_n),
        
        // Dynamic Inputs (Changes)
        .diff_V(diff_V),
        .diff_I(diff_I),
        
        // *** THE CRITICAL FIX ***
        // We must pass the RAW V_in so the core knows if voltage is Low/Optimal/High.
        // We zero-pad it ({1'b0, ...}) to match the signed [10:0] input of the core.
        .V_pv({1'b0, V_in}), 
        
        // Output
        .duty_adjust(duty_adjust)
    );

    // Inside your Top Module
    logic [9:0] mppt_duty_wire;   // Output of the Integrator

    // 1. The Integrator (Spying on the Manual Wire)
    duty_integrator integrator_inst (
        .clk(clk),
        .reset_n(reset_n),
        .mppt_enable(mppt_enable),      // The physical switch state
        .manual_duty_in(manual_duty_adj), // <--- CONNECT MANUAL INPUT HERE
        .duty_adjust(duty_adjust),
        .dac_value(mppt_duty_wire)
    );

    // 2. The Switch (Multiplexer)
    assign dac_value = (mppt_enable) ? mppt_duty_wire : manual_duty_adj;

endmodule