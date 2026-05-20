module tb_fuzzy_core;

    logic clk;
    logic reset_n;
    logic signed [10:0] diff_V;
    logic signed [10:0] diff_I;
    logic signed [10:0] V_pv;         // Added V_pv
    logic signed [10:0] duty_adjust;
    
    // Clock generation
    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end
    
    // DUT instantiation using named ports to be safe
    fuzzy_core dut (
        .clk(clk),
        .reset_n(reset_n),
        .diff_V(diff_V),
        .diff_I(diff_I),
        .V_pv(V_pv),
        .duty_adjust(duty_adjust)
    );
    
    initial begin
        // Initialize
        reset_n = 0;
        diff_V = 0;
        diff_I = 0;
        V_pv = 783; // Start in Optimal Range
        #20 reset_n = 1;
        #10;
        
        $display("=====================================================");
        $display("   MPPT FUZZY CORE VERIFICATION (Sugeno Thesis Ver)  ");
        $display("=====================================================");
        
        // --- TEST 1: SAFETY LOGIC ---
        $display("\n[Group A: Safety Logic]");
        test(0, 0, 700, "Low Voltage (Safety Brake)");   // Target: ~ -15
        test(0, 0, 880, "High Voltage (Safety Throttle)"); // Target: ~ +15

        // --- TEST 2: FINE TUNING (In Optimal Range 783) ---
        $display("\n[Group B: Fine Tuning - Optimal Range]");
        test(4,  4, 783, "Pos/Pos (Over Peak)");         // Target: -1
        test(4, -4, 783, "Pos/Neg (Climbing)");          // Target: +1
        test(-4, 4, 783, "Neg/Pos (Climbing)");          // Target: +1
        test(-4,-4, 783, "Neg/Neg (Over Peak)");         // Target: -1

        // --- TEST 3: THE "HOLD" RULE ---
        $display("\n[Group C: Steady State / Stuck]");
        test(0, 0, 783, "At MPP (Stuck/Stable)");        // Target: 0 (The Hold Rule!)
        
        #50;
        $display("\n=====================================================");
        $display("   Simulation Finished                               ");
        $display("=====================================================");
        $finish;
    end
    
    // Updated task to handle V_pv
    task test(input signed [10:0] v, i, vp, string desc);
        diff_V = v;
        diff_I = i;
        V_pv   = vp;
        @(posedge clk);
        #2; // Wait for combinational logic to settle
        $display("Inputs: ΔV=%4d, ΔI=%4d, Vpv=%4d | Output: duty=%3d | Desc: %s", 
                  v, i, vp, duty_adjust, desc);
    endtask
    
endmodule