module duty_integrator (
    input  logic        clk,
    input  logic        reset_n,
    input  logic        mppt_enable,
    input  logic signed [10:0] duty_adjust,
    input  logic [9:0]  manual_duty_in,
    output logic [9:0]  dac_value
);
    localparam int FRAC_BITS = 6; 
    logic signed [25:0] acc; 
    localparam signed [25:0] MIN_ACC = 26'd307 << FRAC_BITS; 
    localparam signed [25:0] MAX_ACC = 26'd716 << FRAC_BITS; 
    localparam signed [25:0] START_VAL = 26'd512 << FRAC_BITS;
    always_ff @(posedge clk or negedge reset_n) begin
        if (!reset_n) begin
            acc <= START_VAL; 
        end else begin
            if (mppt_enable == 1'b0) begin
                acc <= signed'({1'b0, manual_duty_in}) << FRAC_BITS;
            end 
            else begin
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
    assign dac_value = acc[FRAC_BITS + 9 : FRAC_BITS];    // Example (FRAC=9): We want bits [18:9]
endmodule