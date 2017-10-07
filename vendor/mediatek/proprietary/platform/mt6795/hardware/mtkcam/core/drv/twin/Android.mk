################################################################################
#
################################################################################

LOCAL_PATH := $(call my-dir)

################################################################################
#
################################################################################
include $(CLEAR_VARS)

#-----------------------------------------------------------
sinclude $(TOP)/device/leeco/x3/vendor/mediatek/proprietary/platform/mt6795/hardware/mtkcam/mtkcam.mk

#-----------------------------------------------------------
LOCAL_SRC_FILES := $(call all-c-cpp-files-under, .)

#-----------------------------------------------------------
LOCAL_C_INCLUDES += $(MTKCAM_C_INCLUDES)
LOCAL_C_INCLUDES += $(TOP)/device/leeco/x3/vendor/mediatek/proprietary/hardware/include
LOCAL_C_INCLUDES += $(TOP)/device/leeco/x3/vendor/mediatek/proprietary/platform/mt6795/hardware/include
#
LOCAL_C_INCLUDES += $(TOP)/bionic
LOCAL_C_INCLUDES += $(TOP)/external/stlport/stlport
LOCAL_C_INCLUDES += $(TOP)/$(LOCAL_PATH)/../inc
LOCAL_C_INCLUDES += $(TOP)/device/leeco/x3/vendor/mediatek/proprietary/platform/mt6795/external/ldvt/include
LOCAL_C_INCLUDES += $(TOP)/device/leeco/x3/vendor/mediatek/proprietary/platform/mt6795/kernel/core/include/mach
LOCAL_C_INCLUDES += $(TOP)/device/leeco/x3/vendor/mediatek/proprietary/platform/mt6795/hardware/mtkcam/core/imageio/inc

#LOCAL_C_INCLUDES += $(TOP)/device/leeco/x3/vendor/mediatek/proprietary/platform/mt6795/hardware/camera/core/src/imageio/inc
#LOCAL_C_INCLUDES += $(TOP)/device/leeco/x3/vendor/mediatek/proprietary/platform/mt6795/kernel/core/include/mach
#LOCAL_C_INCLUDES += $(TOP)/device/leeco/x3/vendor/mediatek/proprietary/custom/mt6795/hal/inc/isp_tuning

#-----------------------------------------------------------
LOCAL_CFLAGS += $(MTKCAM_CFLAGS)
#
# Add a define value that can be used in the code to indicate that it's using LDVT now.
# For print message function when using LDVT.
# Note: It will be cleared by "CLEAR_VARS", so if this line needed in other module, it
# have to be set in other module again.
ifeq ($(BUILD_MTK_LDVT),true)
    LOCAL_CFLAGS += -DUSING_MTK_LDVT
endif

#-----------------------------------------------------------
LOCAL_WHOLE_STATIC_LIBRARIES += 

#
LOCAL_STATIC_LIBRARIES += 

LOCAL_SHARED_LIBRARIES += libstlport

#-----------------------------------------------------------
LOCAL_MODULE := libcamdrv_twin

#-----------------------------------------------------------
include $(BUILD_STATIC_LIBRARY)

