`timescale 1ns/1ps

module DUT;

    // Testbench signals
    logic signed [10:0] diff_V;
    logic signed [10:0] diff_I;
    logic [7:0] DV_mu_nb, DV_mu_nm, DV_mu_ns, DV_mu_ze, DV_mu_ps, DV_mu_pm, DV_mu_pb;
    logic [7:0] DI_mu_nb, DI_mu_nm, DI_mu_ns, DI_mu_ze, DI_mu_ps, DI_mu_pm, DI_mu_pb;

    // DUT
    fuzzifier dut (
        .diff_V(diff_V),
        .diff_I(diff_I),
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
        .DI_mu_pb(DI_mu_pb)
    );

    // Simple task to display the results
    task print_mu_values;
        begin
            $display("------------------------------------------------------");
            $display("diff_I = %0d | diff_V = %0d", diff_I, diff_V);
            $display("DI_mu_nb=%0d DI_mu_nm=%0d DI_mu_ns=%0d DI_mu_ze=%0d DI_mu_ps=%0d DI_mu_pm=%0d DI_mu_pb=%0d",
                     DI_mu_nb, DI_mu_nm, DI_mu_ns, DI_mu_ze, DI_mu_ps, DI_mu_pm, DI_mu_pb);
            $display("DV_mu_nb=%0d DV_mu_nm=%0d DV_mu_ns=%0d DV_mu_ze=%0d DV_mu_ps=%0d DV_mu_pm=%0d DV_mu_pb=%0d",
                     DV_mu_nb, DV_mu_nm, DV_mu_ns, DV_mu_ze, DV_mu_ps, DV_mu_pm, DV_mu_pb);
            $display("------------------------------------------------------");
        end
    endtask

    // Stimulus
    initial begin
        $display("Starting fuzzifier test...");

        diff_I = -400; diff_V = -60; #10; print_mu_values();
        diff_I = -200; diff_V = -40; #10; print_mu_values();
        diff_I = -50;  diff_V = -10; #10; print_mu_values();
        diff_I = 0;    diff_V = 0;   #10; print_mu_values();
        diff_I = 100;  diff_V = 20;  #10; print_mu_values();
        diff_I = 250;  diff_V = 50;  #10; print_mu_values();
        diff_I = 400;  diff_V = 64;  #10; print_mu_values();

        $display("Simulation complete.");
        $finish;
    end

endmodule
