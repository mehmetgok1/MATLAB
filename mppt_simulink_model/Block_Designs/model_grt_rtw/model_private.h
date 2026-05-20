/*
 * model_private.h
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

#ifndef model_private_h_
#define model_private_h_
#include "rtwtypes.h"
#include "builtin_typeid_types.h"
#include "multiword_types.h"
#include "model_types.h"
#include "rtw_continuous.h"
#include "rtw_solver.h"
#include <math.h>
#include <stdlib.h>
#include <string.h>

/* Private macros used by the generated code to access rtModel */
#ifndef rtmSetTFinal
#define rtmSetTFinal(rtm, val)         ((rtm)->Timing.tFinal = (val))
#endif

#ifndef CodeFormat
#define CodeFormat                     S-Function
#else
#undef CodeFormat
#define CodeFormat                     S-Function
#endif

#ifndef S_FUNCTION_NAME
#define S_FUNCTION_NAME                simulink_only_sfcn
#else
#undef S_FUNCTION_NAME
#define S_FUNCTION_NAME                simulink_only_sfcn
#endif

#ifndef S_FUNCTION_LEVEL
#define S_FUNCTION_LEVEL               2
#else
#undef S_FUNCTION_LEVEL
#define S_FUNCTION_LEVEL               2
#endif

#ifndef RTW_GENERATED_S_FUNCTION
#define RTW_GENERATED_S_FUNCTION
#endif

#ifndef rtmGetDataMapInfo
# define rtmGetDataMapInfo(rtm)        NULL
#endif

#ifndef rtmSetDataMapInfo
# define rtmSetDataMapInfo(rtm, val)
#endif

#if !defined(RTW_SFUNCTION_DEFINES)
#define RTW_SFUNCTION_DEFINES
#ifndef _RTW_COMMON_DEFINES_
#define _RTW_COMMON_DEFINES_
#endif
#endif

extern real_T rt_powd_snf(real_T u0, real_T u1);

#endif                                 /* model_private_h_ */
