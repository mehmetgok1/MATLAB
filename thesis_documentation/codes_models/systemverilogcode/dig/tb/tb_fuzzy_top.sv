`timescale 1ns/1ps

module tb_fuzzy_top;

    logic clk;
    logic reset_n;
    logic [9:0] V_in;
    logic [9:0] I_in;
    logic [9:0] dac_value;

    // Instantiate the top module
    fuzzy_top uut (
        .clk(clk),
        .reset_n(reset_n),
        .V_in(V_in),
        .I_in(I_in),
        .dac_value(dac_value)
    );
    

    // Clock generation: 10 ns period
    initial clk = 0;
    always #5 clk = ~clk;

    // Test stimulus
    initial begin
        // Initialize inputs
        reset_n = 0;
        V_in = 10'd0;
        I_in = 10'd0;

        // Apply reset for 20 ns
        #20;
        reset_n = 1;

        // Apply a simple ramp for V and I
        repeat (20) begin
            #10;
            V_in = V_in + 10'd10;  // increment voltage
            I_in = I_in + 10'd5;   // increment current
            $display("Time=%0t ns, V_in=%0d, I_in=%0d, DAC=%0d", $time, V_in, I_in, dac_value);
        end

        // Apply some negative steps
        repeat (10) begin
            #10;
            V_in = V_in - 10'd8;
            I_in = I_in - 10'd3;
            $display("Time=%0t ns, V_in=%0d, I_in=%0d, DAC=%0d", $time, V_in, I_in, dac_value);
        end

        $finish;
    end

endmodule
