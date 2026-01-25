/*
 * model.h
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

#ifndef model_h_
#define model_h_
#ifndef model_COMMON_INCLUDES_
#define model_COMMON_INCLUDES_
#include "rtwtypes.h"
#include "rtw_continuous.h"
#include "rtw_solver.h"
#include "rt_logging.h"
#include "rt_nonfinite.h"
#include "math.h"
#endif                                 /* model_COMMON_INCLUDES_ */

#include "model_types.h"
#include "rtGetInf.h"
#include "rtGetNaN.h"
#include <float.h>
#include <string.h>
#include <stddef.h>

/* Macros for accessing real-time model data structure */
#ifndef rtmGetFinalTime
#define rtmGetFinalTime(rtm)           ((rtm)->Timing.tFinal)
#endif

#ifndef rtmGetRTWLogInfo
#define rtmGetRTWLogInfo(rtm)          ((rtm)->rtwLogInfo)
#endif

#ifndef rtmGetErrorStatus
#define rtmGetErrorStatus(rtm)         ((rtm)->errorStatus)
#endif

#ifndef rtmSetErrorStatus
#define rtmSetErrorStatus(rtm, val)    ((rtm)->errorStatus = (val))
#endif

#ifndef rtmGetStopRequested
#define rtmGetStopRequested(rtm)       ((rtm)->Timing.stopRequestedFlag)
#endif

#ifndef rtmSetStopRequested
#define rtmSetStopRequested(rtm, val)  ((rtm)->Timing.stopRequestedFlag = (val))
#endif

#ifndef rtmGetStopRequestedPtr
#define rtmGetStopRequestedPtr(rtm)    (&((rtm)->Timing.stopRequestedFlag))
#endif

#ifndef rtmGetT
#define rtmGetT(rtm)                   ((rtm)->Timing.taskTime0)
#endif

#ifndef rtmGetTFinal
#define rtmGetTFinal(rtm)              ((rtm)->Timing.tFinal)
#endif

#ifndef rtmGetTPtr
#define rtmGetTPtr(rtm)                (&(rtm)->Timing.taskTime0)
#endif

/* Block signals (default storage) */
typedef struct {
  real_T UnitDelay;                    /* '<S3>/Unit Delay' */
  real_T Tcell_K;                      /* '<S6>/Add2' */
  real_T Add3;                         /* '<S6>/Add3' */
  real_T alpha_Isc;                    /* '<S6>/alpha_Isc' */
  real_T Add;                          /* '<S6>/Add' */
  real_T Npar;                         /* '<S6>/Npar' */
  real_T SSref;                        /* '<S6>/1//Sref' */
  real_T IL;                           /* '<S6>/Product1' */
  real_T StateSpace[2];                /* '<S15>/State-Space' */
  real_T donotdeletethisgain;          /* '<S7>/do not delete this gain' */
  real_T donotdeletethisgain_e;        /* '<S9>/do not delete this gain' */
  real_T Product2;                     /* '<S10>/Product2' */
  real_T Vd;                           /* '<S10>/Add1' */
  real_T Tcell_KTref_K;                /* '<S3>/Product3' */
  real_T VT;                           /* '<S3>/VT_ref_array' */
  real_T Product1;                     /* '<S3>/Product1' */
  real_T expVdVT;                      /* '<S3>/Math Function' */
  real_T Add_d;                        /* '<S3>/Add' */
  real_T Add4;                         /* '<S3>/Add4' */
  real_T dEgdT;                        /* '<S3>/dEgdT' */
  real_T Add3_o;                       /* '<S3>/Add3' */
  real_T E_g;                          /* '<S3>/EgRef' */
  real_T k1;                           /* '<S12>/k1' */
  real_T Product;                      /* '<S12>/Product' */
  real_T Add_o;                        /* '<S12>/Add' */
  real_T MathFunction;                 /* '<S12>/Math Function' */
  real_T Fcn;                          /* '<S3>/Fcn' */
  real_T I0_array;                     /* '<S3>/I0_array' */
  real_T Product4;                     /* '<S3>/Product4' */
  real_T Idiode;                       /* '<S3>/Product' */
  real_T IRsh;                         /* '<S3>/Product2' */
  real_T IRsh_5;                       /* '<S3>/Product5' */
  real_T Add1;                         /* '<S3>/Add1' */
} B_model_T;

/* Block states (default storage) for system '<Root>' */
typedef struct {
  real_T UnitDelay_DSTATE;             /* '<S3>/Unit Delay' */
  struct {
    void *AS;
    void *BS;
    void *CS;
    void *DS;
    void *DX_COL;
    void *BD_COL;
    void *TMP1;
    void *TMP2;
    void *XTMP;
    void *SWITCH_STATUS;
    void *SWITCH_STATUS_INIT;
    void *SW_CHG;
    void *G_STATE;
    void *USWLAST;
    void *XKM12;
    void *XKP12;
    void *XLAST;
    void *ULAST;
    void *IDX_SW_CHG;
    void *Y_SWITCH;
    void *SWITCH_TYPES;
    void *IDX_OUT_SW;
    void *SWITCH_TOPO_SAVED_IDX;
    void *SWITCH_MAP;
  } StateSpace_PWORK;                  /* '<S15>/State-Space' */

  int_T StateSpace_IWORK[11];          /* '<S15>/State-Space' */
} DW_model_T;

/* Parameters (default storage) */
struct P_model_T_ {
  real_T PVArray1_Npar;                /* Mask Parameter: PVArray1_Npar
                                        * Referenced by:
                                        *   '<S3>/Rsh_array'
                                        *   '<S3>/I0_array'
                                        *   '<S6>/Npar'
                                        *   '<S10>/Rs_array_'
                                        */
  real_T PVArray1_Nser;                /* Mask Parameter: PVArray1_Nser
                                        * Referenced by:
                                        *   '<S3>/Rsh_array'
                                        *   '<S3>/VT_ref_array'
                                        *   '<S10>/Rs_array_'
                                        */
  real_T UnitDelay_InitialCondition;   /* Expression: 0
                                        * Referenced by: '<S3>/Unit Delay'
                                        */
  real_T u_K_Value;                    /* Expression: 273.15
                                        * Referenced by: '<S6>/0_K'
                                        */
  real_T Tref_K_Value;                 /* Expression: Tref_K
                                        * Referenced by: '<S6>/Tref_K'
                                        */
  real_T alpha_Isc_Gain;               /* Expression: alpha_Isc
                                        * Referenced by: '<S6>/alpha_Isc'
                                        */
  real_T IL_module_Value;              /* Expression: IL
                                        * Referenced by: '<S6>/IL_module'
                                        */
  real_T uSref_Gain;                   /* Expression: 1e-3
                                        * Referenced by: '<S6>/1//Sref'
                                        */
  real_T StateSpace_DS_param[4];       /* Expression: S.D
                                        * Referenced by: '<S15>/State-Space'
                                        */
  real_T donotdeletethisgain_Gain;     /* Expression: 1
                                        * Referenced by: '<S7>/do not delete this gain'
                                        */
  real_T donotdeletethisgain_Gain_j;   /* Expression: 1
                                        * Referenced by: '<S9>/do not delete this gain'
                                        */
  real_T Tref_K2_Value;                /* Expression: Tref_K
                                        * Referenced by: '<S3>/Tref_K2'
                                        */
  real_T one_Value;                    /* Expression: 1
                                        * Referenced by: '<S3>/one'
                                        */
  real_T EgRef_Value;                  /* Expression: EgRef/(k1*Tref_K)
                                        * Referenced by: '<S12>/EgRef'
                                        */
  real_T one1_Value;                   /* Expression: 1
                                        * Referenced by: '<S3>/one1'
                                        */
  real_T Tref_K1_Value;                /* Expression: Tref_K
                                        * Referenced by: '<S3>/Tref_K1'
                                        */
  real_T dEgdT_Gain;                   /* Expression: dEgdT
                                        * Referenced by: '<S3>/dEgdT'
                                        */
  real_T EgRef_Gain;                   /* Expression: EgRef
                                        * Referenced by: '<S3>/EgRef'
                                        */
  real_T k1_Gain;                      /* Expression: k1
                                        * Referenced by: '<S12>/k1'
                                        */
  real_T Rsh_array_5Sref_Value;        /* Expression: Rsh_array5pc
                                        * Referenced by: '<S3>/Rsh_array_5%Sref'
                                        */
};

/* Real-time Model Data Structure */
struct tag_RTM_model_T {
  const char_T *errorStatus;
  RTWLogInfo *rtwLogInfo;

  /*
   * Timing:
   * The following substructure contains information regarding
   * the timing information for the model.
   */
  struct {
    time_T taskTime0;
    uint32_T clockTick0;
    uint32_T clockTickH0;
    time_T stepSize0;
    time_T tFinal;
    boolean_T stopRequestedFlag;
  } Timing;
};

/* Block parameters (default storage) */
extern P_model_T model_P;

/* Block signals (default storage) */
extern B_model_T model_B;

/* Block states (default storage) */
extern DW_model_T model_DW;

/* Model entry point functions */
extern void model_initialize(void);
extern void model_step(void);
extern void model_terminate(void);

/* Real-time Model object */
extern RT_MODEL_model_T *const model_M;

/*-
 * The generated code includes comments that allow you to trace directly
 * back to the appropriate location in the model.  The basic format
 * is <system>/block_name, where system is the system number (uniquely
 * assigned by Simulink) and block_name is the name of the block.
 *
 * Use the MATLAB hilite_system command to trace the generated code back
 * to the model.  For example,
 *
 * hilite_system('<S3>')    - opens system 3
 * hilite_system('<S3>/Kp') - opens and selects block Kp which resides in S3
 *
 * Here is the system hierarchy for this model
 *
 * '<Root>' : 'model'
 * '<S1>'   : 'model/PV Array1'
 * '<S2>'   : 'model/powergui'
 * '<S3>'   : 'model/PV Array1/Diode Rsh'
 * '<S4>'   : 'model/PV Array1/I Filter'
 * '<S5>'   : 'model/PV Array1/IL'
 * '<S6>'   : 'model/PV Array1/IL ctrl'
 * '<S7>'   : 'model/PV Array1/I_PV'
 * '<S8>'   : 'model/PV Array1/V Filter'
 * '<S9>'   : 'model/PV Array1/V_PV'
 * '<S10>'  : 'model/PV Array1/Vdiode'
 * '<S11>'  : 'model/PV Array1/Diode Rsh/Id+IRsh'
 * '<S12>'  : 'model/PV Array1/Diode Rsh/Subsystem'
 * '<S13>'  : 'model/PV Array1/I_PV/Model'
 * '<S14>'  : 'model/PV Array1/V_PV/Model'
 * '<S15>'  : 'model/powergui/EquivalentModel1'
 * '<S16>'  : 'model/powergui/EquivalentModel1/Sources'
 * '<S17>'  : 'model/powergui/EquivalentModel1/Yout'
 */
#endif                                 /* model_h_ */
