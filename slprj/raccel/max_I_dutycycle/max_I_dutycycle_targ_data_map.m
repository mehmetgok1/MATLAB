    function targMap = targDataMap(),

    ;%***********************
    ;% Create Parameter Map *
    ;%***********************
    
        nTotData      = 0; %add to this count as we go
        nTotSects     = 4;
        sectIdxOffset = 0;

        ;%
        ;% Define dummy sections & preallocate arrays
        ;%
        dumSection.nData = -1;
        dumSection.data  = [];

        dumData.logicalSrcIdx = -1;
        dumData.dtTransOffset = -1;

        ;%
        ;% Init/prealloc paramMap
        ;%
        paramMap.nSections           = nTotSects;
        paramMap.sectIdxOffset       = sectIdxOffset;
            paramMap.sections(nTotSects) = dumSection; %prealloc
        paramMap.nTotData            = -1;

        ;%
        ;% Auto data (rtP)
        ;%
            section.nData     = 4;
            section.data(4)  = dumData; %prealloc

                    ;% rtP.DCVoltageSource_Amplitude
                    section.data(1).logicalSrcIdx = 0;
                    section.data(1).dtTransOffset = 0;

                    ;% rtP.PVArray_Npar
                    section.data(2).logicalSrcIdx = 1;
                    section.data(2).dtTransOffset = 1;

                    ;% rtP.RepeatingSequenceStair_OutValues
                    section.data(3).logicalSrcIdx = 2;
                    section.data(3).dtTransOffset = 2;

                    ;% rtP.PWM_Period
                    section.data(4).logicalSrcIdx = 3;
                    section.data(4).dtTransOffset = 18;

            nTotData = nTotData + section.nData;
            paramMap.sections(1) = section;
            clear section

            section.nData     = 1;
            section.data(1)  = dumData; %prealloc

                    ;% rtP.WrapToZero_Threshold
                    section.data(1).logicalSrcIdx = 4;
                    section.data(1).dtTransOffset = 0;

            nTotData = nTotData + section.nData;
            paramMap.sections(2) = section;
            clear section

            section.nData     = 36;
            section.data(36)  = dumData; %prealloc

                    ;% rtP.UnitDelay_InitialCondition
                    section.data(1).logicalSrcIdx = 5;
                    section.data(1).dtTransOffset = 0;

                    ;% rtP.StateSpace_AS_param
                    section.data(2).logicalSrcIdx = 6;
                    section.data(2).dtTransOffset = 1;

                    ;% rtP.StateSpace_BS_param
                    section.data(3).logicalSrcIdx = 7;
                    section.data(3).dtTransOffset = 17;

                    ;% rtP.StateSpace_CS_param
                    section.data(4).logicalSrcIdx = 8;
                    section.data(4).dtTransOffset = 53;

                    ;% rtP.StateSpace_DS_param
                    section.data(5).logicalSrcIdx = 9;
                    section.data(5).dtTransOffset = 85;

                    ;% rtP.StateSpace_X0_param
                    section.data(6).logicalSrcIdx = 10;
                    section.data(6).dtTransOffset = 157;

                    ;% rtP.donotdeletethisgain_Gain
                    section.data(7).logicalSrcIdx = 11;
                    section.data(7).dtTransOffset = 161;

                    ;% rtP.donotdeletethisgain_Gain_d4jhy2psxl
                    section.data(8).logicalSrcIdx = 12;
                    section.data(8).dtTransOffset = 162;

                    ;% rtP.donotdeletethisgain_Gain_mp54r4l1oy
                    section.data(9).logicalSrcIdx = 13;
                    section.data(9).dtTransOffset = 163;

                    ;% rtP.donotdeletethisgain_Gain_fo1neunnau
                    section.data(10).logicalSrcIdx = 14;
                    section.data(10).dtTransOffset = 164;

                    ;% rtP.SwitchCurrents_Value
                    section.data(11).logicalSrcIdx = 15;
                    section.data(11).dtTransOffset = 165;

                    ;% rtP.Constant_Value
                    section.data(12).logicalSrcIdx = 16;
                    section.data(12).dtTransOffset = 169;

                    ;% rtP.Constant1_Value
                    section.data(13).logicalSrcIdx = 17;
                    section.data(13).dtTransOffset = 170;

                    ;% rtP.Constant2_Value
                    section.data(14).logicalSrcIdx = 18;
                    section.data(14).dtTransOffset = 171;

                    ;% rtP.Constant3_Value
                    section.data(15).logicalSrcIdx = 19;
                    section.data(15).dtTransOffset = 172;

                    ;% rtP.Constant4_Value
                    section.data(16).logicalSrcIdx = 20;
                    section.data(16).dtTransOffset = 173;

                    ;% rtP.u_K_Value
                    section.data(17).logicalSrcIdx = 21;
                    section.data(17).dtTransOffset = 174;

                    ;% rtP.uSref_Gain
                    section.data(18).logicalSrcIdx = 22;
                    section.data(18).dtTransOffset = 175;

                    ;% rtP.Tref_K_Value
                    section.data(19).logicalSrcIdx = 23;
                    section.data(19).dtTransOffset = 176;

                    ;% rtP.alpha_Isc_Gain
                    section.data(20).logicalSrcIdx = 24;
                    section.data(20).dtTransOffset = 177;

                    ;% rtP.IL_module_Value
                    section.data(21).logicalSrcIdx = 25;
                    section.data(21).dtTransOffset = 178;

                    ;% rtP.Rs_array_Value
                    section.data(22).logicalSrcIdx = 26;
                    section.data(22).dtTransOffset = 179;

                    ;% rtP.one1_Value
                    section.data(23).logicalSrcIdx = 27;
                    section.data(23).dtTransOffset = 180;

                    ;% rtP.Tref_K1_Value
                    section.data(24).logicalSrcIdx = 28;
                    section.data(24).dtTransOffset = 181;

                    ;% rtP.dEgdT_Gain
                    section.data(25).logicalSrcIdx = 29;
                    section.data(25).dtTransOffset = 182;

                    ;% rtP.EgRef_Gain
                    section.data(26).logicalSrcIdx = 30;
                    section.data(26).dtTransOffset = 183;

                    ;% rtP.Tref_K2_Value
                    section.data(27).logicalSrcIdx = 31;
                    section.data(27).dtTransOffset = 184;

                    ;% rtP.I0_array_Gain
                    section.data(28).logicalSrcIdx = 32;
                    section.data(28).dtTransOffset = 185;

                    ;% rtP.EgRef_Value
                    section.data(29).logicalSrcIdx = 33;
                    section.data(29).dtTransOffset = 186;

                    ;% rtP.k1_Gain
                    section.data(30).logicalSrcIdx = 34;
                    section.data(30).dtTransOffset = 187;

                    ;% rtP.Rsh_array_Value
                    section.data(31).logicalSrcIdx = 35;
                    section.data(31).dtTransOffset = 188;

                    ;% rtP.Rsh_array_5Sref_Value
                    section.data(32).logicalSrcIdx = 36;
                    section.data(32).dtTransOffset = 189;

                    ;% rtP.VT_ref_array_Gain
                    section.data(33).logicalSrcIdx = 37;
                    section.data(33).dtTransOffset = 190;

                    ;% rtP.one_Value
                    section.data(34).logicalSrcIdx = 38;
                    section.data(34).dtTransOffset = 191;

                    ;% rtP.eee_Value
                    section.data(35).logicalSrcIdx = 39;
                    section.data(35).dtTransOffset = 192;

                    ;% rtP.eee_Value_mymnzp31cs
                    section.data(36).logicalSrcIdx = 40;
                    section.data(36).dtTransOffset = 193;

            nTotData = nTotData + section.nData;
            paramMap.sections(3) = section;
            clear section

            section.nData     = 3;
            section.data(3)  = dumData; %prealloc

                    ;% rtP.Output_InitialCondition
                    section.data(1).logicalSrcIdx = 41;
                    section.data(1).dtTransOffset = 0;

                    ;% rtP.FixPtConstant_Value
                    section.data(2).logicalSrcIdx = 42;
                    section.data(2).dtTransOffset = 1;

                    ;% rtP.Constant_Value_dkcolwy3k2
                    section.data(3).logicalSrcIdx = 43;
                    section.data(3).dtTransOffset = 2;

            nTotData = nTotData + section.nData;
            paramMap.sections(4) = section;
            clear section


            ;%
            ;% Non-auto Data (parameter)
            ;%


        ;%
        ;% Add final counts to struct.
        ;%
        paramMap.nTotData = nTotData;



    ;%**************************
    ;% Create Block Output Map *
    ;%**************************
    
        nTotData      = 0; %add to this count as we go
        nTotSects     = 2;
        sectIdxOffset = 0;

        ;%
        ;% Define dummy sections & preallocate arrays
        ;%
        dumSection.nData = -1;
        dumSection.data  = [];

        dumData.logicalSrcIdx = -1;
        dumData.dtTransOffset = -1;

        ;%
        ;% Init/prealloc sigMap
        ;%
        sigMap.nSections           = nTotSects;
        sigMap.sectIdxOffset       = sectIdxOffset;
            sigMap.sections(nTotSects) = dumSection; %prealloc
        sigMap.nTotData            = -1;

        ;%
        ;% Auto data (rtB)
        ;%
            section.nData     = 17;
            section.data(17)  = dumData; %prealloc

                    ;% rtB.mzpip0bwqa
                    section.data(1).logicalSrcIdx = 0;
                    section.data(1).dtTransOffset = 0;

                    ;% rtB.ectzrserex
                    section.data(2).logicalSrcIdx = 1;
                    section.data(2).dtTransOffset = 1;

                    ;% rtB.bvtsrcs5qf
                    section.data(3).logicalSrcIdx = 2;
                    section.data(3).dtTransOffset = 9;

                    ;% rtB.ai1jmox3el
                    section.data(4).logicalSrcIdx = 3;
                    section.data(4).dtTransOffset = 13;

                    ;% rtB.jn3yy0pplo
                    section.data(5).logicalSrcIdx = 4;
                    section.data(5).dtTransOffset = 14;

                    ;% rtB.fjuvc31hed
                    section.data(6).logicalSrcIdx = 5;
                    section.data(6).dtTransOffset = 15;

                    ;% rtB.mwyverf4rq
                    section.data(7).logicalSrcIdx = 6;
                    section.data(7).dtTransOffset = 16;

                    ;% rtB.gxp1pfce0w
                    section.data(8).logicalSrcIdx = 7;
                    section.data(8).dtTransOffset = 17;

                    ;% rtB.m5egozilov
                    section.data(9).logicalSrcIdx = 8;
                    section.data(9).dtTransOffset = 18;

                    ;% rtB.iitgowgawd
                    section.data(10).logicalSrcIdx = 9;
                    section.data(10).dtTransOffset = 19;

                    ;% rtB.ate1zx5an4
                    section.data(11).logicalSrcIdx = 10;
                    section.data(11).dtTransOffset = 20;

                    ;% rtB.mijk53iy5v
                    section.data(12).logicalSrcIdx = 11;
                    section.data(12).dtTransOffset = 21;

                    ;% rtB.ke2w1amc5d
                    section.data(13).logicalSrcIdx = 12;
                    section.data(13).dtTransOffset = 22;

                    ;% rtB.k1o0wmy3qb
                    section.data(14).logicalSrcIdx = 13;
                    section.data(14).dtTransOffset = 23;

                    ;% rtB.fbsyboay3c
                    section.data(15).logicalSrcIdx = 14;
                    section.data(15).dtTransOffset = 24;

                    ;% rtB.cyqfylhq5l
                    section.data(16).logicalSrcIdx = 15;
                    section.data(16).dtTransOffset = 25;

                    ;% rtB.fkvi0lsqg3
                    section.data(17).logicalSrcIdx = 16;
                    section.data(17).dtTransOffset = 26;

            nTotData = nTotData + section.nData;
            sigMap.sections(1) = section;
            clear section

            section.nData     = 1;
            section.data(1)  = dumData; %prealloc

                    ;% rtB.lqm5fmnuma
                    section.data(1).logicalSrcIdx = 17;
                    section.data(1).dtTransOffset = 0;

            nTotData = nTotData + section.nData;
            sigMap.sections(2) = section;
            clear section


            ;%
            ;% Non-auto Data (signal)
            ;%


        ;%
        ;% Add final counts to struct.
        ;%
        sigMap.nTotData = nTotData;



    ;%*******************
    ;% Create DWork Map *
    ;%*******************
    
        nTotData      = 0; %add to this count as we go
        nTotSects     = 6;
        sectIdxOffset = 2;

        ;%
        ;% Define dummy sections & preallocate arrays
        ;%
        dumSection.nData = -1;
        dumSection.data  = [];

        dumData.logicalSrcIdx = -1;
        dumData.dtTransOffset = -1;

        ;%
        ;% Init/prealloc dworkMap
        ;%
        dworkMap.nSections           = nTotSects;
        dworkMap.sectIdxOffset       = sectIdxOffset;
            dworkMap.sections(nTotSects) = dumSection; %prealloc
        dworkMap.nTotData            = -1;

        ;%
        ;% Auto data (rtDW)
        ;%
            section.nData     = 5;
            section.data(5)  = dumData; %prealloc

                    ;% rtDW.mminpo5024
                    section.data(1).logicalSrcIdx = 0;
                    section.data(1).dtTransOffset = 0;

                    ;% rtDW.djksolzyus
                    section.data(2).logicalSrcIdx = 1;
                    section.data(2).dtTransOffset = 1;

                    ;% rtDW.fom2xtbnuw
                    section.data(3).logicalSrcIdx = 2;
                    section.data(3).dtTransOffset = 5;

                    ;% rtDW.lr1ooejihk
                    section.data(4).logicalSrcIdx = 3;
                    section.data(4).dtTransOffset = 6;

                    ;% rtDW.lqm1dvfvxs
                    section.data(5).logicalSrcIdx = 4;
                    section.data(5).dtTransOffset = 7;

            nTotData = nTotData + section.nData;
            dworkMap.sections(1) = section;
            clear section

            section.nData     = 1;
            section.data(1)  = dumData; %prealloc

                    ;% rtDW.nolnqwxnel
                    section.data(1).logicalSrcIdx = 5;
                    section.data(1).dtTransOffset = 0;

            nTotData = nTotData + section.nData;
            dworkMap.sections(2) = section;
            clear section

            section.nData     = 3;
            section.data(3)  = dumData; %prealloc

                    ;% rtDW.dytl2oqz3i.AS
                    section.data(1).logicalSrcIdx = 6;
                    section.data(1).dtTransOffset = 0;

                    ;% rtDW.lzhnjwrpkr.LoggedData
                    section.data(2).logicalSrcIdx = 7;
                    section.data(2).dtTransOffset = 1;

                    ;% rtDW.jwzsfigw0c.LoggedData
                    section.data(3).logicalSrcIdx = 8;
                    section.data(3).dtTransOffset = 5;

            nTotData = nTotData + section.nData;
            dworkMap.sections(3) = section;
            clear section

            section.nData     = 1;
            section.data(1)  = dumData; %prealloc

                    ;% rtDW.b4wyf5afdw
                    section.data(1).logicalSrcIdx = 9;
                    section.data(1).dtTransOffset = 0;

            nTotData = nTotData + section.nData;
            dworkMap.sections(4) = section;
            clear section

            section.nData     = 1;
            section.data(1)  = dumData; %prealloc

                    ;% rtDW.op0zj40xk4
                    section.data(1).logicalSrcIdx = 10;
                    section.data(1).dtTransOffset = 0;

            nTotData = nTotData + section.nData;
            dworkMap.sections(5) = section;
            clear section

            section.nData     = 4;
            section.data(4)  = dumData; %prealloc

                    ;% rtDW.kb4hx0puig
                    section.data(1).logicalSrcIdx = 11;
                    section.data(1).dtTransOffset = 0;

                    ;% rtDW.jhvnjdl2p3
                    section.data(2).logicalSrcIdx = 12;
                    section.data(2).dtTransOffset = 1;

                    ;% rtDW.p4waz02w00
                    section.data(3).logicalSrcIdx = 13;
                    section.data(3).dtTransOffset = 2;

                    ;% rtDW.hmnjp3gdve
                    section.data(4).logicalSrcIdx = 14;
                    section.data(4).dtTransOffset = 3;

            nTotData = nTotData + section.nData;
            dworkMap.sections(6) = section;
            clear section


            ;%
            ;% Non-auto Data (dwork)
            ;%


        ;%
        ;% Add final counts to struct.
        ;%
        dworkMap.nTotData = nTotData;



    ;%
    ;% Add individual maps to base struct.
    ;%

    targMap.paramMap  = paramMap;
    targMap.signalMap = sigMap;
    targMap.dworkMap  = dworkMap;

    ;%
    ;% Add checksums to base struct.
    ;%


    targMap.checksum0 = 271480689;
    targMap.checksum1 = 3186349354;
    targMap.checksum2 = 4153339654;
    targMap.checksum3 = 2395623712;

