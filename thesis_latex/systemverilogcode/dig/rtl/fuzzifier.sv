module fuzzifier(
    input  logic signed [10:0] diff_V,   // dV_raw (derivative of voltage)
    input  logic signed [10:0] diff_I,   // dI_raw (derivative of current)
    input  logic signed [10:0] V_pv,     // V_pv differential (ADC: Vpv÷12 - 2.5V, center at 512)

    // dV Membership degrees
    output logic [7:0] dV_mu_neg,
    output logic [7:0] dV_mu_ze,
    output logic [7:0] dV_mu_pos,

    // dI Membership degrees
    output logic [7:0] dI_mu_neg,
    output logic [7:0] dI_mu_ze,
    output logic [7:0] dI_mu_pos,

    // V_pv Membership degrees
    output logic [7:0] Vpv_mu_low,
    output logic [7:0] Vpv_mu_opt,
    output logic [7:0] Vpv_mu_high
);

    //=======================================================
    // dV_raw Fuzzification (Match: [-5 0 5] ranges)
    //=======================================================
    // Negative: linzmf [-5 0]
    mf_z        #(.A(-5), .B(0))         mf_dv_neg (.x(diff_V), .mu(dV_mu_neg));
    // Zero: trimf [-4 0 4]
    mf_triangle #(.A(-4), .B(0), .C(4))  mf_dv_ze  (.x(diff_V), .mu(dV_mu_ze));
    // Positive: linsmf [0 5]
    mf_s        #(.A(0),  .B(5))         mf_dv_pos (.x(diff_V), .mu(dV_mu_pos));

    //=======================================================
    // dI_raw Fuzzification (Match: [-5 0 5] ranges)
    //=======================================================
    // Negative: linzmf [-5 0]
    mf_z        #(.A(-5), .B(0))         mf_di_neg (.x(diff_I), .mu(dI_mu_neg));
    // Zero: trimf [-4 0 4]
    mf_triangle #(.A(-4), .B(0), .C(4))  mf_di_ze  (.x(diff_I), .mu(dI_mu_ze));
    // Positive: linsmf [0 5]
    mf_s        #(.A(0),  .B(5))         mf_di_pos (.x(diff_I), .mu(dI_mu_pos));

    //=======================================================
    // V_pv Fuzzification (DIFFERENTIAL INPUT, Vcm at 512)
    // 12-bit ADC, top 10 bits used (1 LSB = 5mV × 12 = 60mV)
    // Scaling: Vpv_analog ÷ 12, compared against 2.5V (Vcm)
    // MPP operating window: 28V-32V (narrow band around 30V MPP)
    // ADC center (30V): 512
    //=======================================================
    
    // 1. Low_Voltage (Turbo Mode): 
    // Maintain strong boost until well into optimal range (ADC ~525)
    // Z-curve: ramps down from ADC 340 to 525
    // At ADC=485, Low still has 60%+ membership to push past the oscillation zone
    mf_z        #(.A(340), .B(480))              mf_vpv_low  (.x(V_pv), .mu(Vpv_mu_low));
    
    // 2. Optimal_Range (The Sweet Spot): 
    // Tight window 28-32V (ADC [460-564], center at 512 for 30V)
    // Triangle: [460, 512, 564] (peak at MPP, ±52 ADC counts ≈ ±2V)
    // Overlaps Low [460-480] and High [544-564] for continuous behavior
    mf_triangle #(.A(460), .B(512), .C(533))      mf_vpv_opt  (.x(V_pv), .mu(Vpv_mu_opt));
    
    // 3. High_Voltage (Safety Brake): 
    // Engage brake above 32V (ADC > 544)
    // S-curve: ramps up from ADC 544 to 680
    // Overlap with Optimal: [544-564] for smooth transition
    mf_s        #(.A(510), .B(680))              mf_vpv_high (.x(V_pv), .mu(Vpv_mu_high));
endmodule