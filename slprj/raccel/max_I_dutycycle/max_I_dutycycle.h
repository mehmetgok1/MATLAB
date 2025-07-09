#ifndef max_I_dutycycle_h_
#define max_I_dutycycle_h_
#ifndef max_I_dutycycle_COMMON_INCLUDES_
#define max_I_dutycycle_COMMON_INCLUDES_
#include <stdlib.h>
#include "rtwtypes.h"
#include "sigstream_rtw.h"
#include "simtarget/slSimTgtSigstreamRTW.h"
#include "simtarget/slSimTgtSlioCoreRTW.h"
#include "simtarget/slSimTgtSlioClientsRTW.h"
#include "simtarget/slSimTgtSlioSdiRTW.h"
#include "simstruc.h"
#include "fixedpoint.h"
#include "raccel.h"
#include "slsv_diagnostic_codegen_c_api.h"
#include "rt_logging_simtarget.h"
#include "rt_nonfinite.h"
#include "math.h"
#include "dt_info.h"
#include "ext_work.h"
#endif
#include "max_I_dutycycle_types.h"
#include "rtGetInf.h"
#include <stddef.h>
#include "rtw_modelmap_simtarget.h"
#include "rt_defines.h"
#include <string.h>
#define MODEL_NAME max_I_dutycycle
#define NSAMPLE_TIMES (5) 
#define NINPUTS (0)       
#define NOUTPUTS (0)     
#define NBLOCKIO (18) 
#define NUM_ZC_EVENTS (0) 
#ifndef NCSTATES
#define NCSTATES (0)   
#elif NCSTATES != 0
#error Invalid specification of NCSTATES defined in compiler command
#endif
#ifndef rtmGetDataMapInfo
#define rtmGetDataMapInfo(rtm) (*rt_dataMapInfoPtr)
#endif
#ifndef rtmSetDataMapInfo
#define rtmSetDataMapInfo(rtm, val) (rt_dataMapInfoPtr = &val)
#endif
#ifndef IN_RACCEL_MAIN
#endif
typedef struct { real_T mzpip0bwqa ; real_T ectzrserex [ 8 ] ; real_T
bvtsrcs5qf [ 4 ] ; real_T ai1jmox3el ; real_T jn3yy0pplo ; real_T fjuvc31hed
; real_T mwyverf4rq ; real_T gxp1pfce0w ; real_T m5egozilov ; real_T
iitgowgawd ; real_T ate1zx5an4 ; real_T mijk53iy5v ; real_T ke2w1amc5d ;
real_T k1o0wmy3qb ; real_T fbsyboay3c ; real_T cyqfylhq5l ; real_T fkvi0lsqg3
; uint8_T lqm5fmnuma ; } B ; typedef struct { real_T mminpo5024 ; real_T
djksolzyus [ 4 ] ; real_T fom2xtbnuw ; real_T lr1ooejihk ; real_T lqm1dvfvxs
; uint64_T nolnqwxnel ; struct { void * AS ; void * BS ; void * CS ; void *
DS ; void * DX_COL ; void * BD_COL ; void * TMP1 ; void * TMP2 ; void * XTMP
; void * SWITCH_STATUS ; void * SWITCH_STATUS_INIT ; void * SW_CHG ; void *
G_STATE ; void * USWLAST ; void * XKM12 ; void * XKP12 ; void * XLAST ; void
* ULAST ; void * IDX_SW_CHG ; void * Y_SWITCH ; void * SWITCH_TYPES ; void *
IDX_OUT_SW ; void * SWITCH_TOPO_SAVED_IDX ; void * SWITCH_MAP ; } dytl2oqz3i
; struct { void * LoggedData [ 4 ] ; } lzhnjwrpkr ; struct { void *
LoggedData [ 2 ] ; } jwzsfigw0c ; int_T b4wyf5afdw [ 11 ] ; uint8_T
op0zj40xk4 ; boolean_T kb4hx0puig ; boolean_T jhvnjdl2p3 ; boolean_T
p4waz02w00 ; boolean_T hmnjp3gdve ; } DW ; typedef struct {
rtwCAPI_ModelMappingInfo mmi ; } DataMapInfo ; struct P_ { real_T
DCVoltageSource_Amplitude ; real_T PVArray_Npar ; real_T
RepeatingSequenceStair_OutValues [ 16 ] ; real_T PWM_Period ; uint8_T
WrapToZero_Threshold ; real_T UnitDelay_InitialCondition ; real_T
StateSpace_AS_param [ 16 ] ; real_T StateSpace_BS_param [ 36 ] ; real_T
StateSpace_CS_param [ 32 ] ; real_T StateSpace_DS_param [ 72 ] ; real_T
StateSpace_X0_param [ 4 ] ; real_T donotdeletethisgain_Gain ; real_T
donotdeletethisgain_Gain_d4jhy2psxl ; real_T
donotdeletethisgain_Gain_mp54r4l1oy ; real_T
donotdeletethisgain_Gain_fo1neunnau ; real_T SwitchCurrents_Value [ 4 ] ;
real_T Constant_Value ; real_T Constant1_Value ; real_T Constant2_Value ;
real_T Constant3_Value ; real_T Constant4_Value ; real_T u_K_Value ; real_T
uSref_Gain ; real_T Tref_K_Value ; real_T alpha_Isc_Gain ; real_T
IL_module_Value ; real_T Rs_array_Value ; real_T one1_Value ; real_T
Tref_K1_Value ; real_T dEgdT_Gain ; real_T EgRef_Gain ; real_T Tref_K2_Value
; real_T I0_array_Gain ; real_T EgRef_Value ; real_T k1_Gain ; real_T
Rsh_array_Value ; real_T Rsh_array_5Sref_Value ; real_T VT_ref_array_Gain ;
real_T one_Value ; real_T eee_Value ; real_T eee_Value_mymnzp31cs ; uint8_T
Output_InitialCondition ; uint8_T FixPtConstant_Value ; uint8_T
Constant_Value_dkcolwy3k2 ; } ; extern const char_T *
RT_MEMORY_ALLOCATION_ERROR ; extern B rtB ; extern DW rtDW ; extern P rtP ;
extern mxArray * mr_max_I_dutycycle_GetDWork ( ) ; extern void
mr_max_I_dutycycle_SetDWork ( const mxArray * ssDW ) ; extern mxArray *
mr_max_I_dutycycle_GetSimStateDisallowedBlocks ( ) ; extern const
rtwCAPI_ModelMappingStaticInfo * max_I_dutycycle_GetCAPIStaticMap ( void ) ;
extern SimStruct * const rtS ; extern DataMapInfo * rt_dataMapInfoPtr ;
extern rtwCAPI_ModelMappingInfo * rt_modelMapInfoPtr ; void MdlOutputs ( int_T
tid ) ; void MdlOutputsParameterSampleTime ( int_T tid ) ; void MdlUpdate ( int_T tid ) ; void MdlTerminate ( void ) ; void MdlInitializeSizes ( void ) ; void MdlInitializeSampleTimes ( void ) ; SimStruct * raccel_register_model ( ssExecutionInfo * executionInfo ) ;
#endif
