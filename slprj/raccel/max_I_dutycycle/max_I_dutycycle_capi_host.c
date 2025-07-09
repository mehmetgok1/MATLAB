#include "max_I_dutycycle_capi_host.h"
static max_I_dutycycle_host_DataMapInfo_T root;
static int initialized = 0;
rtwCAPI_ModelMappingInfo *getRootMappingInfo()
{
    if (initialized == 0) {
        initialized = 1;
        max_I_dutycycle_host_InitializeDataMapInfo(&(root), "max_I_dutycycle");
    }
    return &root.mmi;
}

rtwCAPI_ModelMappingInfo *mexFunction(){return(getRootMappingInfo());}
