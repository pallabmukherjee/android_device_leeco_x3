# Copyright Statement:
#
# This software/firmware and related documentation ("MediaTek Software") are
# protected under relevant copyright laws. The information contained herein
# is confidential and proprietary to MediaTek Inc. and/or its licensors.
# Without the prior written permission of MediaTek inc. and/or its licensors,
# any reproduction, modification, use or disclosure of MediaTek Software,
# and information contained herein, in whole or in part, shall be strictly prohibited.
#
# MediaTek Inc. (C) 2010. All rights reserved.
#
# BY OPENING THIS FILE, RECEIVER HEREBY UNEQUIVOCALLY ACKNOWLEDGES AND AGREES
# THAT THE SOFTWARE/FIRMWARE AND ITS DOCUMENTATIONS ("MEDIATEK SOFTWARE")
# RECEIVED FROM MEDIATEK AND/OR ITS REPRESENTATIVES ARE PROVIDED TO RECEIVER ON
# AN "AS-IS" BASIS ONLY. MEDIATEK EXPRESSLY DISCLAIMS ANY AND ALL WARRANTIES,
# EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE IMPLIED WARRANTIES OF
# MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE OR NONINFRINGEMENT.
# NEITHER DOES MEDIATEK PROVIDE ANY WARRANTY WHATSOEVER WITH RESPECT TO THE
# SOFTWARE OF ANY THIRD PARTY WHICH MAY BE USED BY, INCORPORATED IN, OR
# SUPPLIED WITH THE MEDIATEK SOFTWARE, AND RECEIVER AGREES TO LOOK ONLY TO SUCH
# THIRD PARTY FOR ANY WARRANTY CLAIM RELATING THERETO. RECEIVER EXPRESSLY ACKNOWLEDGES
# THAT IT IS RECEIVER'S SOLE RESPONSIBILITY TO OBTAIN FROM ANY THIRD PARTY ALL PROPER LICENSES
# CONTAINED IN MEDIATEK SOFTWARE. MEDIATEK SHALL ALSO NOT BE RESPONSIBLE FOR ANY MEDIATEK
# SOFTWARE RELEASES MADE TO RECEIVER'S SPECIFICATION OR TO CONFORM TO A PARTICULAR
# STANDARD OR OPEN FORUM. RECEIVER'S SOLE AND EXCLUSIVE REMEDY AND MEDIATEK'S ENTIRE AND
# CUMULATIVE LIABILITY WITH RESPECT TO THE MEDIATEK SOFTWARE RELEASED HEREUNDER WILL BE,
# AT MEDIATEK'S OPTION, TO REVISE OR REPLACE THE MEDIATEK SOFTWARE AT ISSUE,
# OR REFUND ANY SOFTWARE LICENSE FEES OR SERVICE CHARGE PAID BY RECEIVER TO
# MEDIATEK FOR SUCH MEDIATEK SOFTWARE AT ISSUE.
#
# The following software/firmware and/or related documentation ("MediaTek Software")
# have been modified by MediaTek Inc. All revisions are subject to any receiver's
# applicable license agreements with MediaTek Inc.
#===============================================================================


LOCAL_PATH:= $(call my-dir)

include $(CLEAR_VARS)

ifeq ($(BUILD_MTK_LDVT),true)
    LOCAL_CFLAGS += -DUSING_MTK_LDVT
endif

LOCAL_SRC_FILES += \
    flicker_hal.cpp flicker_util.cpp flicker_hal_base.cpp

LOCAL_C_INCLUDES:= \
    $(TOP)/bionic \
    $(TOP)/external/stlport/stlport \
    vendor/mediatek/proprietary/platform/mt6795/hardware/include/mtkcam/algorithm/libflicker \
    vendor/mediatek/proprietary/platform/mt6795/hardware/include/mtkcam/featureio \
    vendor/mediatek/proprietary/platform/mt6795/hardware/mtkcam/core/featureio/drv/inc \
    vendor/mediatek/proprietary/platform/mt6795/hardware/mtkcam/core/featureio/pipe/aaa \
    vendor/mediatek/proprietary/platform/mt6795/hardware/mtkcam/core/featureio/pipe/aaa/sensor_mgr \
    vendor/mediatek/proprietary/platform/mt6795/hardware/mtkcam/core/featureio/pipe/aaa/isp_mgr    \
    vendor/mediatek/proprietary/platform/mt6795/hardware/mtkcam/core/featureio/pipe/aaa/ispdrv_mgr    \
    $(TOP)/vendor/mediatek/proprietary/hardware/include                              \
    vendor/mediatek/proprietary/platform/mt6795/hardware/mtkcam/core/featureio/pipe/aaa/isp_tuning \
    vendor/mediatek/proprietary/platform/mt6795/hardware/include                       \
    $(TOP)/vendor/mediatek/proprietary/platform/mt6795/hardware/camera/inc/common \
    $(TOP)/vendor/mediatek/proprietary/platform/mt6795/hardware/camera \
    $(TOP)/vendor/mediatek/proprietary/platform/mt6795/hardware/camera/inc/featureio \
    $(TOP)/vendor/mediatek/proprietary/platform/mt6795/hardware/camera/core/drv/imgsensor \
    $(TOP)/vendor/mediatek/proprietary/platform/mt6795/hardware/camera/inc/drv \
    $(TOP)/vendor/mediatek/proprietary/platform/mt6795/hardware/camera/custom/hal/inc \
    $(TOP)/vendor/mediatek/proprietary/platform/mt6795/hardware/camera/custom/hal/inc/aaa \
    $(TOP)/vendor/mediatek/proprietary/platform/mt6795/hardware/camera/custom/hal/inc/isp_tuning \
    $(TOP)/vendor/mediatek/proprietary/platform/mt6795/hardware/camera/core/featureio/pipe/aaa/isp_mgr \
    $(TOP)/vendor/mediatek/proprietary/platform/mt6795/hardware/camera/core/featureio/pipe/aaa/sensor_mgr \
    $(TOP)/vendor/mediatek/proprietary/platform/mt6795/hardware/camera/core/featureio/pipe/aaa/ae_mgr \
    $(TOP)/vendor/mediatek/proprietary/platform/mt6795/hardware/camera/core/featureio/pipe/aaa/af_mgr \
    $(TOP)/vendor/mediatek/proprietary/platform/mt6795/hardware/camera/core/featureio/drv/inc \
    $(TOP)/vendor/mediatek/proprietary/platform/mt6795/hardware/camera/core/featureio/pipe/aaa/ispdrv_mgr \
    $(TOP)/vendor/mediatek/proprietary/custom/mt6795/hal/inc/aaa \
    $(TOP)/vendor/mediatek/proprietary/custom/common/kernel/imgsensor/inc \
    $(TOP)/vendor/mediatek/proprietary/custom/mt6795/hal/camera/inc \
    $(TOP)/vendor/mediatek/proprietary/custom/mt6795/hal/inc \
    $(TOP)/vendor/mediatek/proprietary/custom/mt6795/hal/inc/debug_exif/aaa \
    $(TOP)/vendor/mediatek/proprietary/custom/mt6795/hal/imgsensor \
    vendor/mediatek/proprietary/custom/mt6795/hal/inc \
    vendor/mediatek/proprietary/custom/mt6795/hal/inc/aaa \
    vendor/mediatek/proprietary/custom/mt6795/hal/inc/isp_tuning \
    vendor/mediatek/proprietary/custom/mt6795/hal/inc/camera_feature \
    vendor/mediatek/proprietary/custom/mt6795/hal/inc/debug_exif/aaa \
    vendor/mediatek/proprietary/custom/mt6795/hal/inc/debug_exif/cam \
    $(MTK_PATH_CUSTOM_PLATFORM)/hal/inc \
    $(MTK_PATH_CUSTOM_PLATFORM)/hal/inc/aaa \
    $(MTK_PATH_CUSTOM_PLATFORM)/hal/inc/isp_tuning \
    $(MTK_PATH_CUSTOM_PLATFORM)/hal/inc/camera_feature \
    $(MTK_PATH_CUSTOM_PLATFORM)/hal/inc/debug_exif/aaa \
    $(MTK_PATH_CUSTOM_PLATFORM)/hal/inc/debug_exif/cam \
    vendor/mediatek/proprietary/platform/mt6795/hardware/mtkcam/core/featureio/drv/inc \
    vendor/mediatek/proprietary/platform/mt6795/hardware/mtkcam/core/featureio/drv/cam_cal \
    vendor/mediatek/proprietary/platform/mt6795/hardware/mtkcam/core/featureio/pipe/aaa/awb_mgr \
    vendor/mediatek/proprietary/platform/mt6795/hardware/mtkcam/core/featureio/pipe/aaa/nvram_mgr \
    vendor/mediatek/proprietary/platform/mt6795/hardware/mtkcam/core/featureio/pipe/aaa/isp_mgr \
    vendor/mediatek/proprietary/platform/mt6795/hardware/mtkcam/core/featureio/pipe/aaa/buf_mgr \
    vendor/mediatek/proprietary/platform/mt6795/hardware/mtkcam/core/featureio/pipe/aaa/ispdrv_mgr \
    vendor/mediatek/proprietary/platform/mt6795/hardware/mtkcam/core/featureio/pipe/aaa/isp_tuning \
    vendor/mediatek/proprietary/platform/mt6795/hardware/mtkcam/core/featureio/pipe/aaa/isp_tuning/paramctrl/inc \
    vendor/mediatek/proprietary/platform/mt6795/hardware/mtkcam/core/featureio/pipe/aaa/isp_tuning/paramctrl/pca_mgr/ \
    vendor/mediatek/proprietary/platform/mt6795/hardware/mtkcam/core/featureio/pipe/aaa/isp_tuning/paramctrl/ccm_mgr/ \
    vendor/mediatek/proprietary/platform/mt6795/hardware/mtkcam/core/featureio/pipe/aaa/lsc_mgr \
    vendor/mediatek/proprietary/platform/mt6795/hardware/mtkcam/core/featureio/pipe/aaa/ae_mgr \
    vendor/mediatek/proprietary/platform/mt6795/hardware/mtkcam/core/featureio/pipe/aaa/flash_mgr \
    vendor/mediatek/proprietary/platform/mt6795/hardware/mtkcam/core/featureio/pipe/aaa/af_mgr \
    vendor/mediatek/proprietary/platform/mt6795/hardware/mtkcam/core/featureio/pipe/aaa/sensor_mgr \
    vendor/mediatek/proprietary/platform/mt6795/hardware/hardware/include/mtkcam/algorithm/lib3a \
    vendor/mediatek/proprietary/platform/mt6795/hardware/hardware/include/mtkcam/algorithm/liblsctrans \
    vendor/mediatek/proprietary/platform/mt6795/hardware/hardware/include/mtkcam/algorithm/libtsf\
    $(TOP)/vendor/mediatek/proprietary/platform/mt6795/hardware \
    vendor/mediatek/proprietary/platform/mt6795/hardware/mtkcam/core/drv/imgsensor \
    vendor/mediatek/proprietary/platform/mt6795/hardware/mtkcam/core/imageio/inc \


#.MT6595.SB.DEV\alps\mediatek\platform\mt6595\hardware\include\mtkcam\drv
#e\mtkcam\core\featureio\pipe\aaa\ispdrv_mgr
#EV\KK0.MT6595.SB.DEV\alps\mediatek\platform\mt6595\hardware\mtkcam\core\featureio\pipe\aaa\isp_mgr
#595.SB.DEV\alps\mediatek\hardware\include\mtkcam\hal

LOCAL_C_INCLUDES += $(TOP)/vendor/mediatek/proprietary/hardware/camera/inc/featureio
LOCAL_C_INCLUDES += $(TOP)/vendor/mediatek/proprietary/hardware/camera/inc/drv

LOCAL_STATIC_LIBRARIES := \

LOCAL_WHOLE_STATIC_LIBRARIES := \





LOCAL_MODULE := libfeatureiopipe_flk


include $(BUILD_STATIC_LIBRARY)
