module duty_integrator (
    input  logic        clk,
    input  logic        reset_n,
    input  logic        mppt_enable,
    input  logic signed [10:0] duty_adjust,
    input  logic [9:0]  manual_duty_in,
    output logic [9:0]  dac_value
);

    // --- CONFIGURATION ---
    // CHANGE THIS: 4 for Turbo Sim, 14 for Real Hardware
    localparam int FRAC_BITS = 4; 

    // Safety Headroom: 10 (Data) + FRAC_BITS + 2 (Sign/Overflow)
    // Keep 26 bits because it is safe for both 9 and 14.
    logic signed [25:0] acc; 

    // --- SCALED LIMITS (Calculated automatically) ---
    localparam signed [25:0] MIN_ACC = 26'd307 << FRAC_BITS; 
    localparam signed [25:0] MAX_ACC = 26'd716 << FRAC_BITS; 
    localparam signed [25:0] START_VAL = 26'd512 << FRAC_BITS;

    always_ff @(negedge clk or negedge reset_n) begin
        if (!reset_n) begin
            acc <= START_VAL; 
        end else begin
            
            if (mppt_enable == 1'b0) begin
                // === MANUAL MODE ===
                acc <= signed'({1'b0, manual_duty_in}) << FRAC_BITS;
            end 
            else begin
                // === MPPT MODE ===
                logic signed [26:0] next_acc; 
                next_acc = acc + duty_adjust; 

                if (next_acc > MAX_ACC) 
                    acc <= MAX_ACC;
                else if (next_acc < MIN_ACC) 
                    acc <= MIN_ACC;
                else 
                    acc <= next_acc[25:0];
            end
        end
    end

    // === OUTPUT ===
    // Dynamic Slicing
    assign dac_value = acc[FRAC_BITS + 9 : FRAC_BITS];

endmodule
