#ifndef max_I_dutycycle_cap_host_h__
#define max_I_dutycycle_cap_host_h__
#ifdef HOST_CAPI_BUILD
#include "rtw_capi.h"
#include "rtw_modelmap_simtarget.h"
typedef struct { rtwCAPI_ModelMappingInfo mmi ; }
max_I_dutycycle_host_DataMapInfo_T ;
#ifdef __cplusplus
extern "C" {
#endif
void max_I_dutycycle_host_InitializeDataMapInfo ( max_I_dutycycle_host_DataMapInfo_T * dataMap , const char * path ) ;
#ifdef __cplusplus
}
#endif
#endif
#endif
