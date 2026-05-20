/*
 * model_data.c
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

/* Block parameters (default storage) */
P_model_T model_P = {
  /* Mask Parameter: PVArray1_Npar
   * Referenced by:
   *   '<S3>/Rsh_array'
   *   '<S3>/I0_array'
   *   '<S6>/Npar'
   *   '<S10>/Rs_array_'
   */
  1.0,

  /* Mask Parameter: PVArray1_Nser
   * Referenced by:
   *   '<S3>/Rsh_array'
   *   '<S3>/VT_ref_array'
   *   '<S10>/Rs_array_'
   */
  1.0,

  /* Expression: 0
   * Referenced by: '<S3>/Unit Delay'
   */
  0.0,

  /* Expression: 273.15
   * Referenced by: '<S6>/0_K'
   */
  273.15,

  /* Expression: Tref_K
   * Referenced by: '<S6>/Tref_K'
   */
  298.15,

  /* Expression: alpha_Isc
   * Referenced by: '<S6>/alpha_Isc'
   */
  0.007983,

  /* Expression: IL
   * Referenced by: '<S6>/IL_module'
   */
  8.2383,

  /* Expression: 1e-3
   * Referenced by: '<S6>/1//Sref'
   */
  0.001,

  /* Expression: S.D
   * Referenced by: '<S15>/State-Space'
   */
  { -3938.5559999999996, 0.0, 3938.5559999999996, 0.0 },

  /* Expression: 1
   * Referenced by: '<S7>/do not delete this gain'
   */
  1.0,

  /* Expression: 1
   * Referenced by: '<S9>/do not delete this gain'
   */
  1.0,

  /* Expression: Tref_K
   * Referenced by: '<S3>/Tref_K2'
   */
  298.15,

  /* Expression: 1
   * Referenced by: '<S3>/one'
   */
  1.0,

  /* Expression: EgRef/(k1*Tref_K)
   * Referenced by: '<S12>/EgRef'
   */
  43.63127955055414,

  /* Expression: 1
   * Referenced by: '<S3>/one1'
   */
  1.0,

  /* Expression: Tref_K
   * Referenced by: '<S3>/Tref_K1'
   */
  298.15,

  /* Expression: dEgdT
   * Referenced by: '<S3>/dEgdT'
   */
  -0.0002677,

  /* Expression: EgRef
   * Referenced by: '<S3>/EgRef'
   */
  1.121,

  /* Expression: k1
   * Referenced by: '<S12>/k1'
   */
  8.617332478E-5,

  /* Expression: Rsh_array5pc
   * Referenced by: '<S3>/Rsh_array_5%Sref'
   */
  3938.5559999999996
};
