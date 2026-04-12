module fuzzy_top #(
    // dV (ΔVpv) Membership Function Thresholds
    parameter signed [10:0] dV_A_NEG = -5,
    parameter signed [10:0] dV_B_NEG = 0,
    parameter signed [10:0] dV_A_TRI = -4,
    parameter signed [10:0] dV_B_TRI = 0,
    parameter signed [10:0] dV_C_TRI = 4,
    parameter signed [10:0] dV_A_POS = 0,
    parameter signed [10:0] dV_B_POS = 5,
    
    // dI (ΔIout) Membership Function Thresholds
    parameter signed [10:0] dI_A_NEG = -5,
    parameter signed [10:0] dI_B_NEG = 0,
    parameter signed [10:0] dI_A_TRI = -4,
    parameter signed [10:0] dI_B_TRI = 0,
    parameter signed [10:0] dI_C_TRI = 4,
    parameter signed [10:0] dI_A_POS = 0,
    parameter signed [10:0] dI_B_POS = 5,
    
    // Vpv Membership Function Thresholds
    parameter signed [10:0] Vpv_A_LOW = 340,
    parameter signed [10:0] Vpv_B_LOW = 480,
    parameter signed [10:0] Vpv_A_OPT = 460,
    parameter signed [10:0] Vpv_B_OPT = 512,
    parameter signed [10:0] Vpv_C_OPT = 533,
    parameter signed [10:0] Vpv_A_HIGH = 530,
    parameter signed [10:0] Vpv_B_HIGH = 680,
    
    // Sugeno Output Constants (Defuzzifier)
    parameter signed [7:0] C1 = -80,  // Big Decrease
    parameter signed [7:0] C2 =  80,  // Big Increase
    parameter signed [7:0] C3 =  -15,  // Decrease
    parameter signed [7:0] C4 =   15,  // Increase
    parameter signed [7:0] C5 =   15,  // Increase
    parameter signed [7:0] C6 =  -15,  // Decrease
    parameter signed [7:0] C7 =   0,  // Hold
    parameter signed [7:0] C8 =   0   // Hold
)
(
    input  logic        clk,
    input  logic        reset_n,
    input  logic        mppt_enable,
    input  logic [9:0]  manual_duty_adj,
    input  logic [9:0]  V_in,    // ADC Voltage (10-bit, Vcm at 512: Vpv/12 - 2.5V)
    input  logic [9:0]  I_in,    // ADC Current (10-bit, Vcm at 512: I/8 - 2.5V)
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
        
        // Raw Voltage Input (for Low/Optimal/High detection)
        .V_pv({1'b0, V_in}),
        
        // dV Membership Function Parameters
        .dV_A_neg(dV_A_NEG), .dV_B_neg(dV_B_NEG),
        .dV_A_tri(dV_A_TRI), .dV_B_tri(dV_B_TRI), .dV_C_tri(dV_C_TRI),
        .dV_A_pos(dV_A_POS), .dV_B_pos(dV_B_POS),
        
        // dI Membership Function Parameters
        .dI_A_neg(dI_A_NEG), .dI_B_neg(dI_B_NEG),
        .dI_A_tri(dI_A_TRI), .dI_B_tri(dI_B_TRI), .dI_C_tri(dI_C_TRI),
        .dI_A_pos(dI_A_POS), .dI_B_pos(dI_B_POS),
        
        // Vpv Membership Function Parameters
        .Vpv_A_low(Vpv_A_LOW), .Vpv_B_low(Vpv_B_LOW),
        .Vpv_A_opt(Vpv_A_OPT), .Vpv_B_opt(Vpv_B_OPT), .Vpv_C_opt(Vpv_C_OPT),
        .Vpv_A_high(Vpv_A_HIGH), .Vpv_B_high(Vpv_B_HIGH),
        
        // Sugeno Constants
        .C1(C1), .C2(C2), .C3(C3), .C4(C4),
        .C5(C5), .C6(C6), .C7(C7), .C8(C8),
        
        // Output
        .duty_adjust(duty_adjust)
    );

    // Inside your Top Module
    logic [9:0] mppt_duty_wire;   // Output of the Integrator

    // 1. The Integrator 
    duty_integrator integrator_inst (
        .clk(clk),
        .reset_n(reset_n),
        .mppt_enable(mppt_enable),      // The physical switch state
        .manual_duty_in(manual_duty_adj), // MANUAL INPUT 
        .duty_adjust(duty_adjust),
        .dac_value(mppt_duty_wire)
    );

    // 2. The Switch (Multiplexer)
    assign dac_value = (mppt_enable) ? mppt_duty_wire : manual_duty_adj;

endmodule
