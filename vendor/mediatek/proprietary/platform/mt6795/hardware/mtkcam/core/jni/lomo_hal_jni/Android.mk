
LOCAL_PATH := $(call my-dir)

################################################################################
#
################################################################################
include $(CLEAR_VARS)
#After Jonas' review in KK
#-----------------------------------------------------------
LOCAL_SRC_FILES += $(call all-c-cpp-files-under, .)

#-----------------------------------------------------------
#
LOCAL_C_INCLUDES += $(TOP)/bionic
LOCAL_C_INCLUDES += $(TOP)/external/stlport/stlport
LOCAL_C_INCLUDES += $(TOP)/device/leeco/x3/vendor/mediatek/proprietary/custom/mt6795/hal/inc/aaa
LOCAL_C_INCLUDES += $(TOP)/device/leeco/x3/vendor/mediatek/proprietary/custom/mt6795/hal/inc/lomo
LOCAL_C_INCLUDES += $(TOP)/device/leeco/x3/vendor/mediatek/proprietary/custom/mt6795/hal/inc/isp_tuning
LOCAL_C_INCLUDES += $(TOP)/device/leeco/x3/vendor/mediatek/proprietary/custom/mt6795/hal/inc/lomo_jni
LOCAL_C_INCLUDES += $(TOP)/$(MTK_PATH_CUSTOM_PLATFORM)/hal/inc
LOCAL_C_INCLUDES += $(TOP)/$(MTK_PATH_CUSTOM_PLATFORM)/hal/inc/aaa
LOCAL_C_INCLUDES += $(TOP)/$(MTK_PATH_CUSTOM_PLATFORM)/hal/inc/lomo
LOCAL_C_INCLUDES += $(TOP)/$(MTK_PATH_CUSTOM_PLATFORM)/hal/inc/isp_tuning
LOCAL_C_INCLUDES += $(TOP)/$(MTK_PATH_CUSTOM_PLATFORM)/hal/inc/lomo_jni
LOCAL_C_INCLUDES += $(TOP)/device/leeco/x3/vendor/mediatek/proprietary/hardware/dpframework/inc
LOCAL_C_INCLUDES += $(TOP)/device/leeco/x3/vendor/mediatek/proprietary/platform/mt6795/hardware/mtkcam/inc
LOCAL_C_INCLUDES += $(TOP)/device/leeco/x3/vendor/mediatek/proprietary/platform/mt6795/hardware/mtkcam/core/drv/inc
LOCAL_C_INCLUDES += $(TOP)/device/leeco/x3/vendor/mediatek/proprietary/platform/mt6795/hardware/include/mtkcam/featureio
#LOCAL_C_INCLUDES += $(TOP)/device/leeco/x3/vendor/mediatek/proprietary/platform/mt6795/hardware/include/mtkcam/drv
LOCAL_C_INCLUDES += $(TOP)/device/leeco/x3/vendor/mediatek/proprietary/platform/mt6795/hardware/include/mtkcam/jni
LOCAL_C_INCLUDES += $(TOP)/device/leeco/x3/vendor/mediatek/proprietary/platform/mt6795/hardware/mtkcam/core/imageio/inc
# for log.h
LOCAL_C_INCLUDES += $(TOP)/device/leeco/x3/vendor/mediatek/proprietary/hardware/include/mtkcam

# temp for using iopipe
LOCAL_C_INCLUDES += $(TOP)/device/leeco/x3/vendor/mediatek/proprietary/platform/mt6795/hardware
LOCAL_C_INCLUDES += $(TOP)/device/leeco/x3/vendor/mediatek/proprietary/platform/mt6795/hardware/include/mtkcam/iopipe/PostProc

LOCAL_SHARED_LIBRARIES := \
    libcutils \
    liblog \
    libstlport \
    libutils

#-----------------------------------------------------------
# iopipe 
LOCAL_SHARED_LIBRARIES += \
	libcam.iopipe

#-----------------------------------------------------------

# camUtils 
LOCAL_SHARED_LIBRARIES +=\
    libcam_utils \

# for feature stream
LOCAL_SHARED_LIBRARIES += libcameracustom
LOCAL_SHARED_LIBRARIES += libfeatureio
LOCAL_SHARED_LIBRARIES += libdpframework

#LOCAL_STATIC_LIBRARIES := \


     
#

#-----------------------------------------------------------
LOCAL_MODULE := libcam.jni.lomohaljni

LOCAL_MODULE_TAGS := optional

#-----------------------------------------------------------
LOCAL_CFLAGS += $(MTKCAM_CFLAGS)
LOCAL_C_INCLUDES += $(MTKCAM_C_INCLUDES)
LOCAL_C_INCLUDES += $(TOP)/device/leeco/x3/vendor/mediatek/proprietary/hardware/include
LOCAL_C_INCLUDES += $(TOP)/device/leeco/x3/vendor/mediatek/proprietary/platform/mt6795/hardware/include
include $(BUILD_SHARED_LIBRARY)


################################################################################
#
################################################################################
#include $(CLEAR_VARS)
include $(call all-makefiles-under,$(LOCAL_PATH))

