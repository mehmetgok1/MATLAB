module inference (
    input  logic [7:0] DV_mu_nb, DV_mu_nm, DV_mu_ns, DV_mu_ze, DV_mu_ps, DV_mu_pm, DV_mu_pb,
    input  logic [7:0] DI_mu_nb, DI_mu_nm, DI_mu_ns, DI_mu_ze, DI_mu_ps, DI_mu_pm, DI_mu_pb,
    output logic [7:0] rule_weights [0:6][0:6]  // 7x7 matrix of min values
);

    // Arrays for membership values
    logic [7:0] DV_mu [0:6];
    logic [7:0] DI_mu [0:6];

    // Assign inputs to arrays
    assign DV_mu = '{DV_mu_nb, DV_mu_nm, DV_mu_ns, DV_mu_ze, DV_mu_ps, DV_mu_pm, DV_mu_pb};
    assign DI_mu = '{DI_mu_nb, DI_mu_nm, DI_mu_ns, DI_mu_ze, DI_mu_ps, DI_mu_pm, DI_mu_pb};

    always_comb begin
        // Compute min values for all 7x7 combinations
        for (int dv_idx = 0; dv_idx < 7; dv_idx++) begin
            for (int di_idx = 0; di_idx < 7; di_idx++) begin
                rule_weights[dv_idx][di_idx] = (DV_mu[dv_idx] < DI_mu[di_idx]) ? 
                                             DV_mu[dv_idx] : DI_mu[di_idx];
            end
        end
    end

endmodule