module tb_fuzzy_core;

    logic clk;
    logic reset_n;
    logic signed [10:0] diff_V;
    logic signed [10:0] diff_I;
    logic signed [10:0] duty_adjust;
    
    // Clock
    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end
    
    // DUT
    fuzzy_core dut (.*);
    
    initial begin
        reset_n = 0;
        diff_V = 0;
        diff_I = 0;
        #20;
        reset_n = 1;
        #10;
        
        $display("=== Quick MPPT Verification ===");
        
        // Quick test sequence
        test(12, -68, "Right MPP");   // Should be negative
        test(-11, 40, "Left MPP");    // Should be positive  
        test(0, 0, "At MPP");          // Should be near zero
        
        #50;
        $finish;
    end
    
    task test(input signed [10:0] v, i, string desc);
        diff_V = v;
        diff_I = i;
        @(posedge clk);
        #1;
        $display("ΔV=%0d, ΔI=%0d → duty=%0d (%s)", v, i, duty_adjust, desc);
    endtask
    
endmodule