//=======================================================
// Testbench for mf_triangle
//=======================================================
module DUT;

    logic signed [10:0] x;
    logic [7:0] mu;

    // Instantiate DUT
    mf_triangle #(
        .A(-383),
        .B(-300),
        .C(-217)
    ) dut (
        .x(x),
        .mu(mu)
    );

    initial begin
        $display("x\tmu");
        for (x = -400; x <= -200; x = x + 10) begin
            #1;
            $display("%0d\t%0d", x, mu);
        end
        $finish;
    end

endmodule
