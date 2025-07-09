#include "rtw_capi.h"
#ifdef HOST_CAPI_BUILD
#include "max_I_dutycycle_capi_host.h"
#define sizeof(...) ((size_t)(0xFFFF))
#undef rt_offsetof
#define rt_offsetof(s,el) ((uint16_T)(0xFFFF))
#define TARGET_CONST
#define TARGET_STRING(s) (s)
#ifndef SS_UINT64
#define SS_UINT64 18
#endif
#ifndef SS_INT64
#define SS_INT64 19
#endif
#else
#include "builtin_typeid_types.h"
#include "max_I_dutycycle.h"
#include "max_I_dutycycle_capi.h"
#include "max_I_dutycycle_private.h"
#ifdef LIGHT_WEIGHT_CAPI
#define TARGET_CONST
#define TARGET_STRING(s)               ((NULL))
#else
#define TARGET_CONST                   const
#define TARGET_STRING(s)               (s)
#endif
#endif
static const rtwCAPI_Signals rtBlockSignals [ ] = { { 0 , 0 , TARGET_STRING ( "max_I_dutycycle/Product1" ) , TARGET_STRING ( "" ) , 0 , 0 , 0 , 0 , 0 } , { 1 , 0 , TARGET_STRING ( "max_I_dutycycle/Product2" ) , TARGET_STRING ( "" ) , 0 , 0 , 0 , 0 , 0 } , { 2 , 0 , TARGET_STRING ( "max_I_dutycycle/Product4" ) , TARGET_STRING ( "output efficiency" ) , 0 , 0 , 0 , 0 , 0 } , { 3 , 0 , TARGET_STRING ( "max_I_dutycycle/Current Measurement/do not delete this gain" ) , TARGET_STRING ( "" ) , 0 , 0 , 0 , 0 , 0 } , { 4 , 0 , TARGET_STRING ( "max_I_dutycycle/PWM/Variable Pulse Generator" ) , TARGET_STRING ( "" ) , 0 , 0 , 0 , 0 , 1 } , { 5 , 0 , TARGET_STRING ( "max_I_dutycycle/Repeating Sequence Stair/Out" ) , TARGET_STRING ( "" ) , 0 , 0 , 0 , 0 , 2 } , { 6 , 0 , TARGET_STRING ( "max_I_dutycycle/Voltage Measurement/do not delete this gain" ) , TARGET_STRING ( "" ) , 0 , 0 , 0 , 0 , 0 } , { 7 , 0 , TARGET_STRING ( "max_I_dutycycle/PV Array/Diode Rsh/VT_ref_array" ) , TARGET_STRING ( "VT" ) , 0 , 0 , 0 , 0 , 3 } , { 8 , 0 , TARGET_STRING ( "max_I_dutycycle/PV Array/Diode Rsh/Product4" ) , TARGET_STRING ( "" ) , 0 , 0 , 0 , 0 , 3 } , { 9 , 0 , TARGET_STRING ( "max_I_dutycycle/PV Array/Diode Rsh/Add1" ) , TARGET_STRING ( "" ) , 0 , 0 , 0 , 0 , 0 } , { 10 , 0 , TARGET_STRING ( "max_I_dutycycle/PV Array/Diode Rsh/Unit Delay" ) , TARGET_STRING ( "" ) , 0 , 0 , 0 , 0 , 0 } , { 11 , 0 , TARGET_STRING ( "max_I_dutycycle/PV Array/IL ctrl/1//Sref" ) , TARGET_STRING ( "S/Sref" ) , 0 , 0 , 0 , 0 , 3 } , { 12 , 0 , TARGET_STRING ( "max_I_dutycycle/PV Array/IL ctrl/Product1" ) , TARGET_STRING ( "IL" ) , 0 , 0 , 0 , 0 , 3 } , { 13 , 0 , TARGET_STRING ( "max_I_dutycycle/PV Array/I_PV/do not delete this gain" ) , TARGET_STRING ( "" ) , 0 , 0 , 0 , 0 , 0 } , { 14 , 0 , TARGET_STRING ( "max_I_dutycycle/PV Array/V_PV/do not delete this gain" ) , TARGET_STRING ( "" ) , 0 , 0 , 0 , 0 , 0 } , { 15 , 0 , TARGET_STRING ( "max_I_dutycycle/powergui/EquivalentModel1/State-Space" ) , TARGET_STRING ( "" ) , 0 , 0 , 1 , 0 , 0 } , { 16 , 0 , TARGET_STRING ( "max_I_dutycycle/powergui/EquivalentModel1/State-Space" ) , TARGET_STRING ( "" ) , 1 , 0 , 2 , 0 , 0 } , { 17 , 0 , TARGET_STRING ( "max_I_dutycycle/Repeating Sequence Stair/LimitedCounter/Wrap To Zero/FixPt Switch" ) , TARGET_STRING ( "" ) , 0 , 1 , 0 , 0 , 2 } , { 0 , 0 , ( NULL ) , ( NULL ) , 0 , 0 , 0 , 0 , 0 } } ; static const rtwCAPI_BlockParameters rtBlockParameters [ ] = { { 18 , TARGET_STRING ( "max_I_dutycycle/DC Voltage Source" ) , TARGET_STRING ( "Amplitude" ) , 0 , 0 , 0 } , { 19 , TARGET_STRING ( "max_I_dutycycle/PV Array" ) , TARGET_STRING ( "Npar" ) , 0 , 0 , 0 } , { 20 , TARGET_STRING ( "max_I_dutycycle/PWM" ) , TARGET_STRING ( "Period" ) , 0 , 0 , 0 } , { 21 , TARGET_STRING ( "max_I_dutycycle/Repeating Sequence Stair" ) , TARGET_STRING ( "OutValues" ) , 0 , 3 , 0 } , { 22 , TARGET_STRING ( "max_I_dutycycle/Constant" ) , TARGET_STRING ( "Value" ) , 0 , 0 , 0 } , { 23 , TARGET_STRING ( "max_I_dutycycle/Constant1" ) , TARGET_STRING ( "Value" ) , 0 , 0 , 0 } , { 24 , TARGET_STRING ( "max_I_dutycycle/Constant2" ) , TARGET_STRING ( "Value" ) , 0 , 0 , 0 } , { 25 , TARGET_STRING ( "max_I_dutycycle/Constant3" ) , TARGET_STRING ( "Value" ) , 0 , 0 , 0 } , { 26 , TARGET_STRING ( "max_I_dutycycle/Constant4" ) , TARGET_STRING ( "Value" ) , 0 , 0 , 0 } , { 27 , TARGET_STRING ( "max_I_dutycycle/Current Measurement/do not delete this gain" ) , TARGET_STRING ( "Gain" ) , 0 , 0 , 0 } , { 28 , TARGET_STRING ( "max_I_dutycycle/Voltage Measurement/do not delete this gain" ) , TARGET_STRING ( "Gain" ) , 0 , 0 , 0 } , { 29 , TARGET_STRING ( "max_I_dutycycle/Diode/Model/eee" ) , TARGET_STRING ( "Value" ) , 0 , 0 , 0 } , { 30 , TARGET_STRING ( "max_I_dutycycle/Diode2/Model/eee" ) , TARGET_STRING ( "Value" ) , 0 , 0 , 0 } , { 31 , TARGET_STRING ( "max_I_dutycycle/PV Array/Diode Rsh/Rsh_array" ) , TARGET_STRING ( "Value" ) , 0 , 0 , 0 } , { 32 , TARGET_STRING ( "max_I_dutycycle/PV Array/Diode Rsh/Rsh_array_5%Sref" ) , TARGET_STRING ( "Value" ) , 0 , 0 , 0 } , { 33 , TARGET_STRING ( "max_I_dutycycle/PV Array/Diode Rsh/Tref_K1" ) , TARGET_STRING ( "Value" ) , 0 , 0 , 0 } , { 34 , TARGET_STRING ( "max_I_dutycycle/PV Array/Diode Rsh/Tref_K2" ) , TARGET_STRING ( "Value" ) , 0 , 0 , 0 } , { 35 , TARGET_STRING ( "max_I_dutycycle/PV Array/Diode Rsh/one" ) , TARGET_STRING ( "Value" ) , 0 , 0 , 0 } , { 36 , TARGET_STRING ( "max_I_dutycycle/PV Array/Diode Rsh/one1" ) , TARGET_STRING ( "Value" ) , 0 , 0 , 0 } , { 37 , TARGET_STRING ( "max_I_dutycycle/PV Array/Diode Rsh/EgRef" ) , TARGET_STRING ( "Gain" ) , 0 , 0 , 0 } , { 38 , TARGET_STRING ( "max_I_dutycycle/PV Array/Diode Rsh/I0_array" ) , TARGET_STRING ( "Gain" ) , 0 , 0 , 0 } , { 39 , TARGET_STRING ( "max_I_dutycycle/PV Array/Diode Rsh/VT_ref_array" ) , TARGET_STRING ( "Gain" ) , 0 , 0 , 0 } , { 40 , TARGET_STRING ( "max_I_dutycycle/PV Array/Diode Rsh/dEgdT" ) , TARGET_STRING ( "Gain" ) , 0 , 0 , 0 } , { 41 , TARGET_STRING ( "max_I_dutycycle/PV Array/Diode Rsh/Unit Delay" ) , TARGET_STRING ( "InitialCondition" ) , 0 , 0 , 0 } , { 42 , TARGET_STRING ( "max_I_dutycycle/PV Array/IL ctrl/0_K" ) , TARGET_STRING ( "Value" ) , 0 , 0 , 0 } , { 43 , TARGET_STRING ( "max_I_dutycycle/PV Array/IL ctrl/IL_module" ) , TARGET_STRING ( "Value" ) , 0 , 0 , 0 } , { 44 , TARGET_STRING ( "max_I_dutycycle/PV Array/IL ctrl/Tref_K" ) , TARGET_STRING ( "Value" ) , 0 , 0 , 0 } , { 45 , TARGET_STRING ( "max_I_dutycycle/PV Array/IL ctrl/1//Sref" ) , TARGET_STRING ( "Gain" ) , 0 , 0 , 0 } , { 46 , TARGET_STRING ( "max_I_dutycycle/PV Array/IL ctrl/alpha_Isc" ) , TARGET_STRING ( "Gain" ) , 0 , 0 , 0 } , { 47 , TARGET_STRING ( "max_I_dutycycle/PV Array/I_PV/do not delete this gain" ) , TARGET_STRING ( "Gain" ) , 0 , 0 , 0 } , { 48 , TARGET_STRING ( "max_I_dutycycle/PV Array/V_PV/do not delete this gain" ) , TARGET_STRING ( "Gain" ) , 0 , 0 , 0 } , { 49 , TARGET_STRING ( "max_I_dutycycle/PV Array/Vdiode/Rs_array_" ) , TARGET_STRING ( "Value" ) , 0 , 0 , 0 } , { 50 , TARGET_STRING ( "max_I_dutycycle/Repeating Sequence Stair/LimitedCounter/Wrap To Zero" ) , TARGET_STRING ( "Threshold" ) , 1 , 0 , 0 } , { 51 , TARGET_STRING ( "max_I_dutycycle/Repeating Sequence Stair/LimitedCounter/Output" ) , TARGET_STRING ( "InitialCondition" ) , 1 , 0 , 0 } , { 52 , TARGET_STRING ( "max_I_dutycycle/powergui/EquivalentModel1/State-Space" ) , TARGET_STRING ( "AS_param" ) , 0 , 4 , 0 } , { 53 , TARGET_STRING ( "max_I_dutycycle/powergui/EquivalentModel1/State-Space" ) , TARGET_STRING ( "BS_param" ) , 0 , 5 , 0 } , { 54 , TARGET_STRING ( "max_I_dutycycle/powergui/EquivalentModel1/State-Space" ) , TARGET_STRING ( "CS_param" ) , 0 , 6 , 0 } , { 55 , TARGET_STRING ( "max_I_dutycycle/powergui/EquivalentModel1/State-Space" ) , TARGET_STRING ( "DS_param" ) , 0 , 7 , 0 } , { 56 , TARGET_STRING ( "max_I_dutycycle/powergui/EquivalentModel1/State-Space" ) , TARGET_STRING ( "X0_param" ) , 0 , 2 , 0 } , { 57 , TARGET_STRING ( "max_I_dutycycle/PV Array/Diode Rsh/Subsystem/EgRef" ) , TARGET_STRING ( "Value" ) , 0 , 0 , 0 } , { 58 , TARGET_STRING ( "max_I_dutycycle/PV Array/Diode Rsh/Subsystem/k1" ) , TARGET_STRING ( "Gain" ) , 0 , 0 , 0 } , { 59 , TARGET_STRING ( "max_I_dutycycle/Repeating Sequence Stair/LimitedCounter/Increment Real World/FixPt Constant" ) , TARGET_STRING ( "Value" ) , 1 , 0 , 0 } , { 60 , TARGET_STRING ( "max_I_dutycycle/Repeating Sequence Stair/LimitedCounter/Wrap To Zero/Constant" ) , TARGET_STRING ( "Value" ) , 1 , 0 , 0 } , { 61 , TARGET_STRING ( "max_I_dutycycle/powergui/EquivalentModel1/Sources/SwitchCurrents" ) , TARGET_STRING ( "Value" ) , 0 , 2 , 0 } , { 0 , ( NULL ) , ( NULL ) , 0 , 0 , 0 } } ; static int_T rt_LoggedStateIdxList [ ] = { - 1 } ; static const rtwCAPI_Signals rtRootInputs [ ] = { { 0 , 0 , ( NULL ) , ( NULL ) , 0 , 0 , 0 , 0 , 0 } } ; static const rtwCAPI_Signals rtRootOutputs [ ] = { { 0 , 0 , ( NULL ) , ( NULL ) , 0 , 0 , 0 , 0 , 0 } } ; static const rtwCAPI_ModelParameters rtModelParameters [ ] = { { 0 , ( NULL ) , 0 , 0 , 0 } } ;
#ifndef HOST_CAPI_BUILD
static void * rtDataAddrMap [ ] = { & rtB . fjuvc31hed , & rtB . iitgowgawd ,
& rtB . ate1zx5an4 , & rtB . mwyverf4rq , & rtB . mijk53iy5v , & rtB .
gxp1pfce0w , & rtB . m5egozilov , & rtB . fkvi0lsqg3 , & rtB . cyqfylhq5l , &
rtB . ke2w1amc5d , & rtB . mzpip0bwqa , & rtB . k1o0wmy3qb , & rtB .
fbsyboay3c , & rtB . jn3yy0pplo , & rtB . ai1jmox3el , & rtB . ectzrserex [ 0
] , & rtB . bvtsrcs5qf [ 0 ] , & rtB . lqm5fmnuma , & rtP .
DCVoltageSource_Amplitude , & rtP . PVArray_Npar , & rtP . PWM_Period , & rtP
. RepeatingSequenceStair_OutValues [ 0 ] , & rtP . Constant_Value , & rtP .
Constant1_Value , & rtP . Constant2_Value , & rtP . Constant3_Value , & rtP .
Constant4_Value , & rtP . donotdeletethisgain_Gain_mp54r4l1oy , & rtP .
donotdeletethisgain_Gain_fo1neunnau , & rtP . eee_Value , & rtP .
eee_Value_mymnzp31cs , & rtP . Rsh_array_Value , & rtP .
Rsh_array_5Sref_Value , & rtP . Tref_K1_Value , & rtP . Tref_K2_Value , & rtP
. one_Value , & rtP . one1_Value , & rtP . EgRef_Gain , & rtP . I0_array_Gain
, & rtP . VT_ref_array_Gain , & rtP . dEgdT_Gain , & rtP .
UnitDelay_InitialCondition , & rtP . u_K_Value , & rtP . IL_module_Value , &
rtP . Tref_K_Value , & rtP . uSref_Gain , & rtP . alpha_Isc_Gain , & rtP .
donotdeletethisgain_Gain_d4jhy2psxl , & rtP . donotdeletethisgain_Gain , &
rtP . Rs_array_Value , & rtP . WrapToZero_Threshold , & rtP .
Output_InitialCondition , & rtP . StateSpace_AS_param [ 0 ] , & rtP .
StateSpace_BS_param [ 0 ] , & rtP . StateSpace_CS_param [ 0 ] , & rtP .
StateSpace_DS_param [ 0 ] , & rtP . StateSpace_X0_param [ 0 ] , & rtP .
EgRef_Value , & rtP . k1_Gain , & rtP . FixPtConstant_Value , & rtP .
Constant_Value_dkcolwy3k2 , & rtP . SwitchCurrents_Value [ 0 ] , } ; static
int32_T * rtVarDimsAddrMap [ ] = { ( NULL ) } ;
#endif
static TARGET_CONST rtwCAPI_DataTypeMap rtDataTypeMap [ ] = { { "double" ,
"real_T" , 0 , 0 , sizeof ( real_T ) , ( uint8_T ) SS_DOUBLE , 0 , 0 , 0 } ,
{ "unsigned char" , "uint8_T" , 0 , 0 , sizeof ( uint8_T ) , ( uint8_T )
SS_UINT8 , 0 , 0 , 0 } } ;
#ifdef HOST_CAPI_BUILD
#undef sizeof
#endif
static TARGET_CONST rtwCAPI_ElementMap rtElementMap [ ] = { { ( NULL ) , 0 ,
0 , 0 , 0 } , } ; static const rtwCAPI_DimensionMap rtDimensionMap [ ] = { {
rtwCAPI_SCALAR , 0 , 2 , 0 } , { rtwCAPI_VECTOR , 2 , 2 , 0 } , {
rtwCAPI_VECTOR , 4 , 2 , 0 } , { rtwCAPI_VECTOR , 6 , 2 , 0 } , {
rtwCAPI_MATRIX_COL_MAJOR , 8 , 2 , 0 } , { rtwCAPI_MATRIX_COL_MAJOR , 10 , 2
, 0 } , { rtwCAPI_MATRIX_COL_MAJOR , 12 , 2 , 0 } , {
rtwCAPI_MATRIX_COL_MAJOR , 14 , 2 , 0 } } ; static const uint_T
rtDimensionArray [ ] = { 1 , 1 , 8 , 1 , 4 , 1 , 16 , 1 , 4 , 4 , 4 , 9 , 8 ,
4 , 8 , 9 } ; static const real_T rtcapiStoredFloats [ ] = { 1.0E-9 , 0.0 ,
1.0 , 0.005 } ; static const rtwCAPI_FixPtMap rtFixPtMap [ ] = { { ( NULL ) ,
( NULL ) , rtwCAPI_FIX_RESERVED , 0 , 0 , ( boolean_T ) 0 } , } ; static
const rtwCAPI_SampleTimeMap rtSampleTimeMap [ ] = { { ( const void * ) &
rtcapiStoredFloats [ 0 ] , ( const void * ) & rtcapiStoredFloats [ 1 ] , ( int8_T ) 1 , ( uint8_T ) 0 } , { ( const void * ) & rtcapiStoredFloats [ 1 ] , ( const void * ) & rtcapiStoredFloats [ 2 ] , ( int8_T ) 0 , ( uint8_T ) 0 } , { ( const void * ) & rtcapiStoredFloats [ 3 ] , ( const void * ) & rtcapiStoredFloats [ 1 ] , ( int8_T ) 2 , ( uint8_T ) 0 } , { ( NULL ) , ( NULL ) , 4 , 0 } } ; static rtwCAPI_ModelMappingStaticInfo mmiStatic = { { rtBlockSignals , 18 , rtRootInputs , 0 , rtRootOutputs , 0 } , { rtBlockParameters , 44 , rtModelParameters , 0 } , { ( NULL ) , 0 } , { rtDataTypeMap , rtDimensionMap , rtFixPtMap , rtElementMap , rtSampleTimeMap , rtDimensionArray } , "float" , { 271480689U , 3186349354U , 4153339654U , 2395623712U } , ( NULL ) , 0 , ( boolean_T ) 0 , rt_LoggedStateIdxList } ; const rtwCAPI_ModelMappingStaticInfo * max_I_dutycycle_GetCAPIStaticMap ( void ) { return & mmiStatic ; }
#ifndef HOST_CAPI_BUILD
void max_I_dutycycle_InitializeDataMapInfo ( void ) { rtwCAPI_SetVersion ( ( *
rt_dataMapInfoPtr ) . mmi , 1 ) ; rtwCAPI_SetStaticMap ( ( *
rt_dataMapInfoPtr ) . mmi , & mmiStatic ) ; rtwCAPI_SetLoggingStaticMap ( ( *
rt_dataMapInfoPtr ) . mmi , ( NULL ) ) ; rtwCAPI_SetDataAddressMap ( ( *
rt_dataMapInfoPtr ) . mmi , rtDataAddrMap ) ; rtwCAPI_SetVarDimsAddressMap ( ( *
rt_dataMapInfoPtr ) . mmi , rtVarDimsAddrMap ) ;
rtwCAPI_SetInstanceLoggingInfo ( ( * rt_dataMapInfoPtr ) . mmi , ( NULL ) ) ;
rtwCAPI_SetChildMMIArray ( ( * rt_dataMapInfoPtr ) . mmi , ( NULL ) ) ;
rtwCAPI_SetChildMMIArrayLen ( ( * rt_dataMapInfoPtr ) . mmi , 0 ) ; }
#else
#ifdef __cplusplus
extern "C" {
#endif
void max_I_dutycycle_host_InitializeDataMapInfo ( max_I_dutycycle_host_DataMapInfo_T * dataMap , const char * path ) { rtwCAPI_SetVersion ( dataMap -> mmi , 1 ) ; rtwCAPI_SetStaticMap ( dataMap -> mmi , & mmiStatic ) ; rtwCAPI_SetDataAddressMap ( dataMap -> mmi , ( NULL ) ) ; rtwCAPI_SetVarDimsAddressMap ( dataMap -> mmi , ( NULL ) ) ; rtwCAPI_SetPath ( dataMap -> mmi , path ) ; rtwCAPI_SetFullPath ( dataMap -> mmi , ( NULL ) ) ; rtwCAPI_SetChildMMIArray ( dataMap -> mmi , ( NULL ) ) ; rtwCAPI_SetChildMMIArrayLen ( dataMap -> mmi , 0 ) ; }
#ifdef __cplusplus
}
#endif
#endif
