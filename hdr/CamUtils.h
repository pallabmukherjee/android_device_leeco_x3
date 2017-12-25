#ifndef _MTK_CAMERA_CAMADAPTER_INC_CAMUTILS_H_
#define _MTK_CAMERA_CAMADAPTER_INC_CAMUTILS_H_


/******************************************************************************
*
*******************************************************************************/
//
#include <stdlib.h>
//
#include <hardware/camera.h>
#include <system/camera.h>
//
#include "../isp/Log.h"
#include "../isp/common.h"
#include "utils/common.h"
//
#include "CamFormatTransform.h"
//
#if '1'==MTKCAM_HAVE_CAMPROFILE
#include "CameraProfile.h" 
#endif
//
#include "camutils/CamInfo.h"
//
#include "camutils/IBuffer.h"
#include "camutils/ICameraBuffer.h"
//
#include "camutils/IImgBufQueue.h"
#include "camutils/ImgBufQueue.h" 
//


#endif  //_MTK_CAMERA_CAMADAPTER_INC_CAMUTILS_H_