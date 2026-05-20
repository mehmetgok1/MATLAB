/*
 * model.c
 *
 * Academic License - for use in teaching, academic research, and meeting
 * course requirements at degree granting institutions only.  Not for
 * government, commercial, or other organizational use.
 *
 * Code generation for model "model".
 *
 * Model version              : 1.328
 * Simulink Coder version : 24.2 (R2024b) 21-Jun-2024
 * C source code generated on : Mon Aug 25 22:19:10 2025
 *
 * Target selection: grt.tlc
 * Note: GRT includes extra infrastructure and instrumentation for prototyping
 * Embedded hardware selection: Intel->x86-32 (Windows32)
 * Code generation objective: Debugging
 * Validation result: Not run
 */

#include "model.h"
#include <math.h>
#include "model_private.h"
#include "rtwtypes.h"
#include <string.h>
#include "rt_nonfinite.h"

/* Block signals (default storage) */
B_model_T model_B;

/* Block states (default storage) */
DW_model_T model_DW;

/* Real-time model */
static RT_MODEL_model_T model_M_;
RT_MODEL_model_T *const model_M = &model_M_;
real_T rt_powd_snf(real_T u0, real_T u1)
{
  real_T y;
  if (rtIsNaN(u0) || rtIsNaN(u1)) {
    y = (rtNaN);
  } else {
    real_T tmp;
    real_T tmp_0;
    tmp = fabs(u0);
    tmp_0 = fabs(u1);
    if (rtIsInf(u1)) {
      if (tmp == 1.0) {
        y = 1.0;
      } else if (tmp > 1.0) {
        if (u1 > 0.0) {
          y = (rtInf);
        } else {
          y = 0.0;
        }
      } else if (u1 > 0.0) {
        y = 0.0;
      } else {
        y = (rtInf);
      }
    } else if (tmp_0 == 0.0) {
      y = 1.0;
    } else if (tmp_0 == 1.0) {
      if (u1 > 0.0) {
        y = u0;
      } else {
        y = 1.0 / u0;
      }
    } else if (u1 == 2.0) {
      y = u0 * u0;
    } else if ((u1 == 0.5) && (u0 >= 0.0)) {
      y = sqrt(u0);
    } else if ((u0 < 0.0) && (u1 > floor(u1))) {
      y = (rtNaN);
    } else {
      y = pow(u0, u1);
    }
  }

  return y;
}

/* Model step function */
void model_step(void)
{
  real_T tmp;

  /* UnitDelay: '<S3>/Unit Delay' */
  model_B.UnitDelay = model_DW.UnitDelay_DSTATE;

  /* Sum: '<S6>/Add2' incorporates:
   *  Constant: '<S6>/0_K'
   */
  model_B.Tcell_K = model_P.u_K_Value;

  /* Sum: '<S6>/Add3' incorporates:
   *  Constant: '<S6>/Tref_K'
   */
  model_B.Add3 = model_B.Tcell_K - model_P.Tref_K_Value;

  /* Gain: '<S6>/alpha_Isc' */
  model_B.alpha_Isc = model_P.alpha_Isc_Gain * model_B.Add3;

  /* Sum: '<S6>/Add' incorporates:
   *  Constant: '<S6>/IL_module'
   */
  model_B.Add = model_B.alpha_Isc + model_P.IL_module_Value;

  /* Gain: '<S6>/Npar' */
  model_B.Npar = model_P.PVArray1_Npar * model_B.Add;

  /* Gain: '<S6>/1//Sref' */
  model_B.SSref = model_P.uSref_Gain * 0.0;

  /* Product: '<S6>/Product1' */
  model_B.IL = model_B.Npar * model_B.SSref;

  /* S-Function (sfun_spssw_discc): '<S15>/State-Space' */

  /* S-Function block: <S15>/State-Space */
  {
    real_T accum;

    /*
     * Compute outputs:
     * ---------------
     */
    real_T *Ds = (real_T*)model_DW.StateSpace_PWORK.DS;
    accum = 0.0;
    accum += *(Ds++) * model_B.UnitDelay;
    accum += *(Ds++) * model_B.IL;
    model_B.StateSpace[0] = accum;
    accum = 0.0;
    accum += *(Ds++) * model_B.UnitDelay;
    accum += *(Ds++) * model_B.IL;
    model_B.StateSpace[1] = accum;
  }

  /* Gain: '<S7>/do not delete this gain' */
  model_B.donotdeletethisgain = model_P.donotdeletethisgain_Gain *
    model_B.StateSpace[1];

  /* Gain: '<S9>/do not delete this gain' */
  model_B.donotdeletethisgain_e = model_P.donotdeletethisgain_Gain_j *
    model_B.StateSpace[0];

  /* Product: '<S10>/Product2' incorporates:
   *  Constant: '<S10>/Rs_array_'
   */
  tmp = 0.19811 * model_P.PVArray1_Nser / model_P.PVArray1_Npar;

  /* Product: '<S10>/Product2' */
  model_B.Product2 = model_B.donotdeletethisgain * tmp;

  /* Sum: '<S10>/Add1' */
  model_B.Vd = model_B.donotdeletethisgain_e + model_B.Product2;

  /* Product: '<S3>/Product3' incorporates:
   *  Constant: '<S3>/Tref_K2'
   */
  model_B.Tcell_KTref_K = model_B.Tcell_K / model_P.Tref_K2_Value;

  /* Gain: '<S3>/VT_ref_array' */
  tmp = 1.5254770188308575 * model_P.PVArray1_Nser;

  /* Gain: '<S3>/VT_ref_array' */
  model_B.VT = tmp * model_B.Tcell_KTref_K;

  /* Product: '<S3>/Product1' */
  model_B.Product1 = 1.0 / model_B.VT * model_B.Vd;

  /* Math: '<S3>/Math Function'
   *
   * About '<S3>/Math Function':
   *  Operator: exp
   */
  model_B.expVdVT = exp(model_B.Product1);

  /* Sum: '<S3>/Add' incorporates:
   *  Constant: '<S3>/one'
   */
  model_B.Add_d = model_B.expVdVT - model_P.one_Value;

  /* Sum: '<S3>/Add4' incorporates:
   *  Constant: '<S3>/Tref_K1'
   */
  model_B.Add4 = model_B.Tcell_K - model_P.Tref_K1_Value;

  /* Gain: '<S3>/dEgdT' */
  model_B.dEgdT = model_P.dEgdT_Gain * model_B.Add4;

  /* Sum: '<S3>/Add3' incorporates:
   *  Constant: '<S3>/one1'
   */
  model_B.Add3_o = model_P.one1_Value + model_B.dEgdT;

  /* Gain: '<S3>/EgRef' */
  model_B.E_g = model_P.EgRef_Gain * model_B.Add3_o;

  /* Gain: '<S12>/k1' */
  model_B.k1 = model_P.k1_Gain * model_B.Tcell_K;

  /* Product: '<S12>/Product' */
  model_B.Product = model_B.E_g / model_B.k1;

  /* Sum: '<S12>/Add' incorporates:
   *  Constant: '<S12>/EgRef'
   */
  model_B.Add_o = model_P.EgRef_Value - model_B.Product;

  /* Math: '<S12>/Math Function'
   *
   * About '<S12>/Math Function':
   *  Operator: exp
   */
  model_B.MathFunction = exp(model_B.Add_o);

  /* Fcn: '<S3>/Fcn' */
  tmp = model_B.Tcell_KTref_K;
  tmp = rt_powd_snf(tmp, 3.0);

  /* Fcn: '<S3>/Fcn' */
  model_B.Fcn = tmp;

  /* Gain: '<S3>/I0_array' */
  tmp = 2.8335E-10 * model_P.PVArray1_Npar;

  /* Gain: '<S3>/I0_array' */
  model_B.I0_array = tmp * model_B.Fcn;

  /* Product: '<S3>/Product4' */
  model_B.Product4 = model_B.MathFunction * model_B.I0_array;

  /* Product: '<S3>/Product' */
  model_B.Idiode = model_B.Product4 * model_B.Add_d;

  /* Product: '<S3>/Product2' incorporates:
   *  Constant: '<S3>/Rsh_array'
   */
  tmp = 196.9278 * model_P.PVArray1_Nser / model_P.PVArray1_Npar;

  /* Product: '<S3>/Product2' */
  model_B.IRsh = model_B.Vd / tmp * model_B.SSref;

  /* Product: '<S3>/Product5' incorporates:
   *  Constant: '<S3>/Rsh_array_5%Sref'
   */
  model_B.IRsh_5 = model_B.Vd / model_P.Rsh_array_5Sref_Value;

  /* Sum: '<S3>/Add1' */
  model_B.Add1 = (model_B.Idiode + model_B.IRsh) - model_B.IRsh_5;

  /* Update for UnitDelay: '<S3>/Unit Delay' */
  model_DW.UnitDelay_DSTATE = model_B.Add1;

  /* Matfile logging */
  rt_UpdateTXYLogVars(model_M->rtwLogInfo, (&model_M->Timing.taskTime0));

  /* signal main to stop simulation */
  {                                    /* Sample time: [1.0E-9s, 0.0s] */
    if ((rtmGetTFinal(model_M)!=-1) &&
        !((rtmGetTFinal(model_M)-model_M->Timing.taskTime0) >
          model_M->Timing.taskTime0 * (DBL_EPSILON))) {
      rtmSetErrorStatus(model_M, "Simulation finished");
    }
  }

  /* Update absolute time for base rate */
  /* The "clockTick0" counts the number of times the code of this task has
   * been executed. The absolute time is the multiplication of "clockTick0"
   * and "Timing.stepSize0". Size of "clockTick0" ensures timer will not
   * overflow during the application lifespan selected.
   * Timer of this task consists of two 32 bit unsigned integers.
   * The two integers represent the low bits Timing.clockTick0 and the high bits
   * Timing.clockTickH0. When the low bit overflows to 0, the high bits increment.
   */
  if (!(++model_M->Timing.clockTick0)) {
    ++model_M->Timing.clockTickH0;
  }

  model_M->Timing.taskTime0 = model_M->Timing.clockTick0 *
    model_M->Timing.stepSize0 + model_M->Timing.clockTickH0 *
    model_M->Timing.stepSize0 * 4294967296.0;
}

/* Model initialize function */
void model_initialize(void)
{
  /* Registration code */

  /* initialize real-time model */
  (void) memset((void *)model_M, 0,
                sizeof(RT_MODEL_model_T));
  rtmSetTFinal(model_M, 2.0);
  model_M->Timing.stepSize0 = 1.0E-9;

  /* Setup for data logging */
  {
    static RTWLogInfo rt_DataLoggingInfo;
    rt_DataLoggingInfo.loggingInterval = (NULL);
    model_M->rtwLogInfo = &rt_DataLoggingInfo;
  }

  /* Setup for data logging */
  {
    rtliSetLogXSignalInfo(model_M->rtwLogInfo, (NULL));
    rtliSetLogXSignalPtrs(model_M->rtwLogInfo, (NULL));
    rtliSetLogT(model_M->rtwLogInfo, "tout");
    rtliSetLogX(model_M->rtwLogInfo, "");
    rtliSetLogXFinal(model_M->rtwLogInfo, "");
    rtliSetLogVarNameModifier(model_M->rtwLogInfo, "rt_");
    rtliSetLogFormat(model_M->rtwLogInfo, 4);
    rtliSetLogMaxRows(model_M->rtwLogInfo, 0);
    rtliSetLogDecimation(model_M->rtwLogInfo, 1);
    rtliSetLogY(model_M->rtwLogInfo, "");
    rtliSetLogYSignalInfo(model_M->rtwLogInfo, (NULL));
    rtliSetLogYSignalPtrs(model_M->rtwLogInfo, (NULL));
  }

  /* block I/O */
  (void) memset(((void *) &model_B), 0,
                sizeof(B_model_T));

  /* states (dwork) */
  (void) memset((void *)&model_DW, 0,
                sizeof(DW_model_T));

  /* Matfile logging */
  rt_StartDataLoggingWithStartTime(model_M->rtwLogInfo, 0.0, rtmGetTFinal
    (model_M), model_M->Timing.stepSize0, (&rtmGetErrorStatus(model_M)));

  /* Start for S-Function (sfun_spssw_discc): '<S15>/State-Space' */

  /* S-Function block: <S15>/State-Space */
  {
    model_DW.StateSpace_PWORK.DS = (real_T*)calloc(2 * 2, sizeof(real_T));
    model_DW.StateSpace_PWORK.DX_COL = (real_T*)calloc(2, sizeof(real_T));
    model_DW.StateSpace_PWORK.TMP2 = (real_T*)calloc(2, sizeof(real_T));
  }

  /* InitializeConditions for UnitDelay: '<S3>/Unit Delay' */
  model_DW.UnitDelay_DSTATE = model_P.UnitDelay_InitialCondition;

  /* InitializeConditions for S-Function (sfun_spssw_discc): '<S15>/State-Space' */
  {
    int32_T i, j;
    real_T *Ds = (real_T*)model_DW.StateSpace_PWORK.DS;

    /* Copy and transpose D */
    for (i=0; i<2; i++) {
      for (j=0; j<2; j++)
        Ds[i*2 + j] = (model_P.StateSpace_DS_param[i + j*2]);
    }
  }
}

/* Model terminate function */
void model_terminate(void)
{
  /* Terminate for S-Function (sfun_spssw_discc): '<S15>/State-Space' */

  /* S-Function block: <S15>/State-Space */
  {
    /* Free memory */
    free(model_DW.StateSpace_PWORK.DS);
    free(model_DW.StateSpace_PWORK.DX_COL);
    free(model_DW.StateSpace_PWORK.TMP2);
  }
}
