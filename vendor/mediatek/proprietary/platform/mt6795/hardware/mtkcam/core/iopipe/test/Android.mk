#
# iotest
#
LOCAL_PATH := $(call my-dir)

include $(CLEAR_VARS)

#
LOCAL_SRC_FILES := \
    test_normalstream.cpp \
    main.cpp \
    main_iopipe.cpp \
    main_camio.cpp \
    test_ef_bond.cpp \
#
# Note: "/bionic" and "/external/stlport/stlport" is for stlport.
LOCAL_C_INCLUDES += $(TOP)/bionic
LOCAL_C_INCLUDES += $(TOP)/external/stlport/stlport
# camera_vendor_tags.h
LOCAL_C_INCLUDES += $(TOP)/system/media/camera/include
# camera Hardware 
LOCAL_C_INCLUDES += $(TOP)/device/leeco/x3/vendor/mediatek/proprietary/frameworks/av/include
LOCAL_C_INCLUDES += $(TOP)/device/leeco/x3/vendor/mediatek/proprietary/platform/mt6795/hardware/mtkcam/
LOCAL_C_INCLUDES += $(TOP)/device/leeco/x3/vendor/mediatek/proprietary/platform/mt6795/hardware/mtkcam/inc
LOCAL_C_INCLUDES += $(TOP)/device/leeco/x3/vendor/mediatek/proprietary/platform/mt6795/hardware/mtkcam/inc/common
LOCAL_C_INCLUDES += $(TOP)/device/leeco/x3/vendor/mediatek/proprietary/hardware/mtkcam/inc
# temp for using iopipe
LOCAL_C_INCLUDES += $(TOP)/device/leeco/x3/vendor/mediatek/proprietary/platform/mt6795/hardware
LOCAL_C_INCLUDES += $(TOP)/device/leeco/x3/vendor/mediatek/proprietary/platform/mt6795/hardware/mtkcam/core/imageio/inc/
LOCAL_C_INCLUDES += $(TOP)/device/leeco/x3/vendor/mediatek/proprietary/platform/mt6795/kernel/core/include/mach/

# vector
LOCAL_SHARED_LIBRARIES := \
    libcutils \
    libutils \
    libstlport \

# iopipe
LOCAL_SHARED_LIBRARIES += \
    libcam.iopipe \
    libimageio \
    libimageio_plat_drv \

# Imem
LOCAL_SHARED_LIBRARIES += \
    libcamdrv \

LOCAL_SHARED_LIBRARIES += \
	libcam.halsensor

LOCAL_SHARED_LIBRARIES += \
	libcam_utils

LOCAL_SHARED_LIBRARIES += \
	libfeatureio
#
LOCAL_STATIC_LIBRARIES := \

#
LOCAL_WHOLE_STATIC_LIBRARIES := \

#
LOCAL_MODULE := iopipetest

#
LOCAL_MODULE_TAGS := eng

#
LOCAL_PRELINK_MODULE := false

#


#
# Start of common part ------------------------------------
-include $(TOP)/device/leeco/x3/vendor/mediatek/proprietary/platform/mt6795/hardware/mtkcam/mtkcam.mk

#-----------------------------------------------------------
LOCAL_CFLAGS += $(MTKCAM_CFLAGS)

#-----------------------------------------------------------
LOCAL_C_INCLUDES += $(MTKCAM_C_INCLUDES)

#-----------------------------------------------------------
LOCAL_C_INCLUDES += $(TOP)/device/leeco/x3/vendor/mediatek/proprietary/hardware/include
LOCAL_C_INCLUDES += $(TOP)/device/leeco/x3/vendor/mediatek/proprietary/platform/mt6795/hardware/include

# End of common part ---------------------------------------
#
include $(BUILD_EXECUTABLE)


#
#include $(call all-makefiles-under,$(LOCAL_PATH))
