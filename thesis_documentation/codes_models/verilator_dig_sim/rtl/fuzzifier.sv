module fuzzifier(
    input  logic signed [10:0] diff_V,
    input  logic signed [10:0] diff_I,
    output logic [7:0] DV_mu_nb,
    output logic [7:0] DV_mu_nm,
    output logic [7:0] DV_mu_ns,
    output logic [7:0] DV_mu_ze,
    output logic [7:0] DV_mu_ps,
    output logic [7:0] DV_mu_pm,
    output logic [7:0] DV_mu_pb,
    output logic [7:0] DI_mu_nb,
    output logic [7:0] DI_mu_nm,
    output logic [7:0] DI_mu_ns,
    output logic [7:0] DI_mu_ze,
    output logic [7:0] DI_mu_ps,
    output logic [7:0] DI_mu_pm,
    output logic [7:0] DI_mu_pb
);

    // DInstantiate 7 triangular membership functions for DDI
    mf_triangle #(.A(-383), .B(-300), .C(-217)) dut_mf_nb_DI (.x(diff_I), .mu(DI_mu_nb));
    mf_triangle #(.A(-283), .B(-200), .C(-117)) dut_mf_nm_DI (.x(diff_I), .mu(DI_mu_nm));
    mf_triangle #(.A(-183), .B(-100), .C(-17))  dut_mf_ns_DI (.x(diff_I), .mu(DI_mu_ns));
    mf_triangle #(.A(-83),  .B(0),    .C(83))   dut_mf_ze_DI (.x(diff_I), .mu(DI_mu_ze));
    mf_triangle #(.A(17),   .B(100),  .C(183))  dut_mf_ps_DI (.x(diff_I), .mu(DI_mu_ps));
    mf_triangle #(.A(117),  .B(200),  .C(283))  dut_mf_pm_DI (.x(diff_I), .mu(DI_mu_pm));
    mf_triangle #(.A(217),  .B(300),  .C(383))  dut_mf_pb_DI (.x(diff_I), .mu(DI_mu_pb));


    // DInstantiate 7 triangular membership functions for DDV
    mf_triangle #(.A(-64), .B(-50), .C(-36)) dut_mf_nb_DV (.x(diff_V), .mu(DV_mu_nb));
    mf_triangle #(.A(-47), .B(-33), .C(-19)) dut_mf_nm_DV (.x(diff_V), .mu(DV_mu_nm));
    mf_triangle #(.A(-31), .B(-17), .C(-3))  dut_mf_ns_DV (.x(diff_V), .mu(DV_mu_ns));
    mf_triangle #(.A(-14), .B(0),   .C(14))  dut_mf_ze_DV (.x(diff_V), .mu(DV_mu_ze));
    mf_triangle #(.A(3),   .B(17),  .C(31))  dut_mf_ps_DV (.x(diff_V), .mu(DV_mu_ps));
    mf_triangle #(.A(19),  .B(33),  .C(47))  dut_mf_pm_DV (.x(diff_V), .mu(DV_mu_pm));
    mf_triangle #(.A(36),  .B(50),  .C(64))  dut_mf_pb_DV (.x(diff_V), .mu(DV_mu_pb));
endmodule

/*
    // Define fuzzy set type with meaningful names
    typedef enum logic [2:0] {
        NB = 0,  // Negative Big
        NM = 1,  // Negative Medium  
        NS = 2,  // Negative Small
        ZE = 3,  // Zero
        PS = 4,  // Positive Small
        PM = 5,  // Positive Medium
        PB = 6   // Positive Big
    } fuzzy_set_t;

      // Rule base with meaningful names - MUCH MORE READABLE!
    parameter fuzzy_set_t rule_base [0:6][0:6] = '{
        // ΔV=NB:    ΔI=NB, NM, NS, ZE, PS, PM, PB
        '{NB, NB, NM, NS, PM, PB, PB}, // If ΔV is NB
        '{NB, NM, NM, NS, PM, PM, PB}, // If ΔV is NM
        '{NM, NM, NS, NS, PS, PM, PM}, // If ΔV is NS 
        '{PS, PS, PS, ZE, NS, NS, NS}, // If ΔV is ZE
        '{PM, PM, PS, PS, NS, NM, NM}, // If ΔV is PS
        '{PB, PM, PM, PS, NM, NM, NB}, // If ΔV is PM
        '{PB, PB, PM, PS, NM, NB, NB}  // If ΔV is PB
    };
*/