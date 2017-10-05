#
# camshottest
#
LOCAL_PATH := $(call my-dir)

include $(CLEAR_VARS)

# don't build this under ldvt
ifeq "'1'" "$(strip $(MTKCAM_USE_LEGACY_SIMAGER))"
#-----------------------------------------------------------
sinclude $(TOP)/vendor/mediatek/proprietary/platform/mt6795/hardware/mtkcam/mtkcam.mk

#
LOCAL_SRC_FILES := \
    test_simager.cpp \

#-----------------------------------------------------------
LOCAL_C_INCLUDES += $(MTKCAM_C_INCLUDES)
LOCAL_C_INCLUDES += $(TOP)/vendor/mediatek/proprietary/hardware/include
LOCAL_C_INCLUDES += $(TOP)/vendor/mediatek/proprietary/platform/mt6795/hardware/include
#
#
# Note: "/bionic" and "/external/stlport/stlport" is for stlport.
LOCAL_C_INCLUDES += $(TOP)/bionic
LOCAL_C_INCLUDES += $(TOP)/external/stlport/stlport
# 
# camera Hardware 
LOCAL_C_INCLUDES += $(TOP)/vendor/mediatek/proprietary/platform/mt6795/hardware/camera/
LOCAL_C_INCLUDES += $(TOP)/vendor/mediatek/proprietary/platform/mt6795/hardware/camera/inc
LOCAL_C_INCLUDES += $(TOP)/vendor/mediatek/proprietary/platform/mt6795/hardware/camera/inc/common

#-----------------------------------------------------------
LOCAL_CFLAGS += $(MTKCAM_CFLAGS)
#

# vector
LOCAL_SHARED_LIBRARIES := \
    libcutils \
    libstlport \

# Simager
LOCAL_SHARED_LIBRARIES += \
    libcam.iopipe \

#utils 
LOCAL_SHARED_LIBRARIES += \
    libcam_utils \

## Imem
#LOCAL_SHARED_LIBRARIES += \
#    libcamdrv \

#
LOCAL_STATIC_LIBRARIES := \

#
LOCAL_WHOLE_STATIC_LIBRARIES := \

#
LOCAL_MODULE := simagertest

#
LOCAL_MODULE_TAGS := optional

#
LOCAL_PRELINK_MODULE := false

#
include $(BUILD_EXECUTABLE)

#
#include $(call all-makefiles-under,$(LOCAL_PATH))
endif
