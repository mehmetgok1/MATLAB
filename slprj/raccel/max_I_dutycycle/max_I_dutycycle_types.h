#ifndef max_I_dutycycle_types_h_
#define max_I_dutycycle_types_h_
#include "rtwtypes.h"
#ifndef DEFINED_TYPEDEF_FOR_struct_4icDSdU2UYZGXsHgUyMZBD_
#define DEFINED_TYPEDEF_FOR_struct_4icDSdU2UYZGXsHgUyMZBD_
typedef struct { real_T SwitchResistance [ 4 ] ; real_T SwitchVf [ 8 ] ;
real_T SwitchType [ 4 ] ; real_T SwitchGateInitialValue [ 4 ] ; real_T
EnableUseOfTLC ; real_T OutputsToResetToZero [ 4 ] ; real_T
NoErrorOnMaxIteration ; real_T Ts ; real_T Interpolate ; real_T SaveMatrices
; real_T BufferSize ; boolean_T TBEON ; uint8_T sl_padding0 [ 7 ] ; real_T A
[ 16 ] ; real_T B [ 36 ] ; real_T C [ 32 ] ; real_T D [ 72 ] ; real_T x0 [ 4
] ; } struct_4icDSdU2UYZGXsHgUyMZBD ;
#endif
#ifndef SS_UINT64
#define SS_UINT64 18
#endif
#ifndef SS_INT64
#define SS_INT64 19
#endif
typedef struct P_ P ;
#endif
