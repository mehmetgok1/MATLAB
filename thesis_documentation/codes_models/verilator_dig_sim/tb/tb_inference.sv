`timescale 1ns/1ps

module tb_inference;

    // Testbench signals
    logic [7:0] DV_mu_nb, DV_mu_nm, DV_mu_ns, DV_mu_ze, DV_mu_ps, DV_mu_pm, DV_mu_pb;
    logic [7:0] DI_mu_nb, DI_mu_nm, DI_mu_ns, DI_mu_ze, DI_mu_ps, DI_mu_pm, DI_mu_pb;
    logic [7:0] O_mu_nb, O_mu_nm, O_mu_ns, O_mu_ze, O_mu_ps, O_mu_pm, O_mu_pb;
    
    // Expected outputs for verification
    logic [7:0] expected_nb, expected_nm, expected_ns, expected_ze, expected_ps, expected_pm, expected_pb;
    
    // Instantiate DUT
    inference dut (
        .DV_mu_nb(DV_mu_nb),
        .DV_mu_nm(DV_mu_nm),
        .DV_mu_ns(DV_mu_ns),
        .DV_mu_ze(DV_mu_ze),
        .DV_mu_ps(DV_mu_ps),
        .DV_mu_pm(DV_mu_pm),
        .DV_mu_pb(DV_mu_pb),
        .DI_mu_nb(DI_mu_nb),
        .DI_mu_nm(DI_mu_nm),
        .DI_mu_ns(DI_mu_ns),
        .DI_mu_ze(DI_mu_ze),
        .DI_mu_ps(DI_mu_ps),
        .DI_mu_pm(DI_mu_pm),
        .DI_mu_pb(DI_mu_pb),
        .O_mu_nb(O_mu_nb),
        .O_mu_nm(O_mu_nm),
        .O_mu_ns(O_mu_ns),
        .O_mu_ze(O_mu_ze),
        .O_mu_ps(O_mu_ps),
        .O_mu_pm(O_mu_pm),
        .O_mu_pb(O_mu_pb)
    );
    
    // Test case task
    task test_case(
        input string name,
        input [7:0] dv_nb, dv_nm, dv_ns, dv_ze, dv_ps, dv_pm, dv_pb,
        input [7:0] di_nb, di_nm, di_ns, di_ze, di_ps, di_pm, di_pb,
        input [7:0] exp_nb, exp_nm, exp_ns, exp_ze, exp_ps, exp_pm, exp_pb
    );
        begin
            // Apply inputs
            DV_mu_nb = dv_nb; DV_mu_nm = dv_nm; DV_mu_ns = dv_ns; DV_mu_ze = dv_ze;
            DV_mu_ps = dv_ps; DV_mu_pm = dv_pm; DV_mu_pb = dv_pb;
            
            DI_mu_nb = di_nb; DI_mu_nm = di_nm; DI_mu_ns = di_ns; DI_mu_ze = di_ze;
            DI_mu_ps = di_ps; DI_mu_pm = di_pm; DI_mu_pb = di_pb;
            
            expected_nb = exp_nb; expected_nm = exp_nm; expected_ns = exp_ns;
            expected_ze = exp_ze; expected_ps = exp_ps; expected_pm = exp_pm; expected_pb = exp_pb;
            
            #10; // Wait for combinational logic
            
            $display("@%0t %s:", $time, name);
            $display("  DV: NB=%0d NM=%0d NS=%0d ZE=%0d PS=%0d PM=%0d PB=%0d", 
                     dv_nb, dv_nm, dv_ns, dv_ze, dv_ps, dv_pm, dv_pb);
            $display("  DI: NB=%0d NM=%0d NS=%0d ZE=%0d PS=%0d PM=%0d PB=%0d",
                     di_nb, di_nm, di_ns, di_ze, di_ps, di_pm, di_pb);
            $display("  OUT: NB=%0d NM=%0d NS=%0d ZE=%0d PS=%0d PM=%0d PB=%0d",
                     O_mu_nb, O_mu_nm, O_mu_ns, O_mu_ze, O_mu_ps, O_mu_pm, O_mu_pb);
            $display("  EXP: NB=%0d NM=%0d NS=%0d ZE=%0d PS=%0d PM=%0d PB=%0d",
                     exp_nb, exp_nm, exp_ns, exp_ze, exp_ps, exp_pm, exp_pb);
            
            // Check results
            if (O_mu_nb !== exp_nb) $display("  ERROR: NB expected %0d, got %0d", exp_nb, O_mu_nb);
            if (O_mu_nm !== exp_nm) $display("  ERROR: NM expected %0d, got %0d", exp_nm, O_mu_nm);
            if (O_mu_ns !== exp_ns) $display("  ERROR: NS expected %0d, got %0d", exp_ns, O_mu_ns);
            if (O_mu_ze !== exp_ze) $display("  ERROR: ZE expected %0d, got %0d", exp_ze, O_mu_ze);
            if (O_mu_ps !== exp_ps) $display("  ERROR: PS expected %0d, got %0d", exp_ps, O_mu_ps);
            if (O_mu_pm !== exp_pm) $display("  ERROR: PM expected %0d, got %0d", exp_pm, O_mu_pm);
            if (O_mu_pb !== exp_pb) $display("  ERROR: PB expected %0d, got %0d", exp_pb, O_mu_pb);
            
            $display("");
        end
    endtask
    
    // Main test sequence
    initial begin
        $display("=== Fuzzy Inference Engine Testbench ===");
        $display("Testing rule base evaluation...\n");
        
        // Test Case 1: Single strong rule (ΔV=NB, ΔI=PB) → Output=PB
        test_case("Strong Right MPP", 
            // DV: NB=255, others=0
            255, 0, 0, 0, 0, 0, 0,
            // DI: PB=255, others=0  
            0, 0, 0, 0, 0, 0, 255,
            // Expected: Only PB active
            0, 0, 0, 0, 0, 0, 255
        );
        
        // Test Case 2: Single strong rule (ΔV=PB, ΔI=NB) → Output=NB
        test_case("Strong Left MPP",
            // DV: PB=255, others=0
            0, 0, 0, 0, 0, 0, 255,
            // DI: NB=255, others=0
            255, 0, 0, 0, 0, 0, 0,
            // Expected: Only NB active
            255, 0, 0, 0, 0, 0, 0
        );
        
        // Test Case 3: Multiple rules contributing to same output
        test_case("Multiple PB Rules",
            // DV: NB=200, NM=150 (both contribute to PB output)
            200, 150, 0, 0, 0, 0, 0,
            // DI: PB=180, PM=100 (both contribute to PB output)
            0, 0, 0, 0, 0, 100, 180,
            // Expected: PB = max(min(200,180)=180, min(150,100)=100, min(200,100)=100, min(150,180)=150) = 180
            0, 0, 0, 0, 0, 0, 180
        );
        
        // Test Case 4: At MPP (small changes around zero)
        test_case("Near MPP",
            // DV: ZE=200, PS=50, NS=30
            0, 0, 30, 200, 50, 0, 0,
            // DI: ZE=180, NS=40, PS=60
            0, 0, 40, 180, 60, 0, 0,
            // Expected: Mixed outputs with ZE dominant
            0, 0, 40, 180, 60, 0, 0  // This needs manual calculation based on rule base
        );
        
        // Test Case 5: Conflicting rules - test MAX aggregation
        test_case("MAX Aggregation Test",
            // DV: NB=100 (contributes to PB), PB=80 (contributes to NB)
            100, 0, 0, 0, 0, 0, 80,
            // DI: PB=90 (contributes to PB), NB=70 (contributes to NB)
            70, 0, 0, 0, 0, 0, 90,
            // Expected: Both NB and PB active, with correct strengths
            80, 0, 0, 0, 0, 0, 100  // PB wins with strength 100
        );
        
        // Test Case 6: All zeros
        test_case("All Zeros",
            0, 0, 0, 0, 0, 0, 0,
            0, 0, 0, 0, 0, 0, 0,
            0, 0, 0, 0, 0, 0, 0
        );
        
        // Test Case 7: Single medium rule
        test_case("Medium Rule",
            // DV: NM=128
            0, 128, 0, 0, 0, 0, 0,
            // DI: PM=128
            0, 0, 0, 0, 0, 128, 0,
            // Expected: rule_base[NM][PM] = PB → Output=PB with strength 128
            0, 0, 0, 0, 0, 0, 128
        );
        
        $display("=== Test Complete ===");
        #100;
        $finish;
    end
    
    // Waveform dumping
    initial begin
        $dumpfile("tb_inference.vcd");
        $dumpvars(0, tb_inference);
    end
    
endmodule