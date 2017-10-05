#
# libacdk
#
LOCAL_PATH := $(call my-dir)

include $(CLEAR_VARS)

#
LOCAL_SRC_FILES := \
    $(call all-c-cpp-files-under, acdk) \
    $(call all-c-cpp-files-under, surfaceview)

#
# Note: "/bionic" and "/external/stlport/stlport" is for stlport.
LOCAL_C_INCLUDES += \
    $(TOP)/bionic \
    $(TOP)/vendor/mediatek/proprietary/kernel/drivers/video \
    $(TOP)/vendor/mediatek/proprietary/platform/mt6795/kernel/core/include/mach \
    $(TOP)/vendor/mediatek/proprietary/platform/mt6795/hardware/m4u \
    $(TOP)/vendor/mediatek/proprietary/kernel/include \
    $(TOP)/vendor/mediatek/proprietary/platform/mt6795/external/ldvt/include \
    $(TOP)/external/stlport/stlport \
    $(TOP)/vendor/mediatek/proprietary/hardware/mtkcam/inc \
    $(TOP)/vendor/mediatek/proprietary/hardware/mtkcam/inc/acdk \
    $(TOP)/vendor/mediatek/proprietary/hardware/mtkcam/inc/common \
    $(TOP)/vendor/mediatek/proprietary/hardware/mtkcam/inc/drv \
    $(TOP)/vendor/mediatek/proprietary/platform/mt6795/hardware/mtkcam \
    $(TOP)/vendor/mediatek/proprietary/platform/mt6795/hardware/mtkcam/inc \
    $(TOP)/vendor/mediatek/proprietary/platform/mt6795/hardware/mtkcam/inc/drv \
    $(TOP)/vendor/mediatek/proprietary/platform/mt6795/hardware/mtkcam/inc/common \
    $(TOP)/vendor/mediatek/proprietary/platform/mt6795/hardware/mtkcam/acdk/inc/acdk \
    $(TOP)/vendor/mediatek/proprietary/platform/mt6795/hardware \
    $(TOP)/vendor/mediatek/proprietary/platform/mt6795/hardware/mtkcam\
    $(TOP)/vendor/mediatek/proprietary/platform/mt6795/hardware/mtkcam/core/drv/imgsensor \
    $(TOP)/vendor/mediatek/proprietary/platform/mt6795/hardware/mtkcam/core/drv/res_mgr \
    $(TOP)/vendor/mediatek/proprietary/platform/mt6795/hardware/mtkcam/core/imageio/inc \
    $(TOP)/vendor/mediatek/proprietary/platform/mt6795/hardware/mtkcam/core/imageio/pipe/inc \
    $(TOP)/vendor/mediatek/proprietary/platform/mt6795/hardware/mtkcam/v1/hal/adapter/inc \
    $(TOP)/vendor/mediatek/proprietary/platform/mt6795/hardware/mtkcam/core/featureio/pipe/aaa/isp_tuning \
    $(TOP)/vendor/mediatek/proprietary/platform/mt6795/hardware/mtkcam/core/featureio/pipe/aaa/ae_mgr \
    $(TOP)/vendor/mediatek/proprietary/platform/mt6795/hardware/mtkcam/core/featureio/pipe/aaa \
    $(TOP)/vendor/mediatek/proprietary/platform/mt6795/hardware/m4u \
    $(TOP)/vendor/mediatek/proprietary/platform/mt6795/kernel/core/include/mach \
    $(TOP)/vendor/mediatek/proprietary/platform/mt6795/external/ldvt/include \
    $(TOP)/vendor/mediatek/proprietary/custom/common/kernel/imgsensor/inc \
    $(TOP)/vendor/mediatek/proprietary/custom/mt6795/hal/inc/isp_tuning \
    $(TOP)/vendor/mediatek/proprietary/custom/mt6795/hal/inc/aaa \
    $(TOP)/$(MTK_PATH_CUSTOM_PLATFORM)/hal/inc \
    $(TOP)/$(MTK_PATH_CUSTOM_PLATFORM)/hal/inc/debug_exif/aaa \
    $(TOP)/vendor/mediatek/proprietary/hardware/mtkcam/inc/common/camexif \
    $(TOP)/mediatek/hardware \
    $(TOP)/mediatek/hardware/include \
    $(TOP)/vendor/mediatek/proprietary/hardware/include/mtkcam \
    $(TOP)/vendor/mediatek/proprietary/platform/mt6795/hardware/include/mtkcam \
    $(TOP)/vendor/mediatek/proprietary/platform/mt6795/hardware/include \
    $(TOP)/vendor/mediatek/proprietary/custom/mt6795/hal/inc \
    $(TOP)/$(MTK_PATH_CUSTOM_PLATFORM)/hal/inc \
    $(TOP)/$(MTK_PATH_CUSTOM_PLATFORM)/hal/inc/isp_tuning \
    $(TOP)/$(MTK_PATH_CUSTOM_PLATFORM)/hal/inc/aaa \
    $(TOP)/vendor/mediatek/proprietary/platform/mt6795/hardware/include/mtkcam/featureio


LOCAL_C_INCLUDES += $(TOP)/vendor/mediatek/proprietary/frameworks/av/include

# Add a define value that can be used in the code to indicate that it's using LDVT now.
# For print message function when using LDVT.
# Note: It will be cleared by "CLEAR_VARS", so if it is needed in other module, it
# has to be set in other module again.
LOCAL_WHOLE_STATIC_LIBRARIES := \
    libcct \
#
ifeq ($(BUILD_MTK_LDVT),true)
    LOCAL_CFLAGS += -DUSING_MTK_LDVT
    LOCAL_WHOLE_STATIC_LIBRARIES += libuvvf
endif

LOCAL_SHARED_LIBRARIES := \
    libstlport \
    libcutils \
    libimageio \
    libcamdrv \
    libcam.iopipe \
    libcam_utils \
    libcam.halsensor \
    libcam.metadata \
    libm4u

LOCAL_SHARED_LIBRARIES += libhardware
LOCAL_SHARED_LIBRARIES += libutils
LOCAL_SHARED_LIBRARIES += libbinder
LOCAL_SHARED_LIBRARIES += libdl

LOCAL_SHARED_LIBRARIES += libcamera_client libcamera_client_mtk

ifneq ($(BUILD_MTK_LDVT),true)
LOCAL_SHARED_LIBRARIES += libcamalgo
LOCAL_SHARED_LIBRARIES += libcam.exif
LOCAL_SHARED_LIBRARIES += libfeatureio
LOCAL_SHARED_LIBRARIES += libcameracustom
LOCAL_SHARED_LIBRARIES += libcam.camshot
endif
LOCAL_SHARED_LIBRARIES += liblog
#
LOCAL_PRELINK_MODULE := false

#
LOCAL_MODULE := libacdk

#

#
# Start of common part ------------------------------------
sinclude $(TOP)/vendor/mediatek/proprietary/platform/mt6795/hardware/mtkcam/mtkcam.mk

#-----------------------------------------------------------
LOCAL_CFLAGS += $(MTKCAM_CFLAGS)

#-----------------------------------------------------------
LOCAL_C_INCLUDES += $(MTKCAM_C_INCLUDES)

#-----------------------------------------------------------
LOCAL_C_INCLUDES += $(TOP)/vendor/mediatek/proprietary/hardware/include
LOCAL_C_INCLUDES += $(TOP)/vendor/mediatek/proprietary/platform/mt6795/hardware/include
LOCAL_C_INCLUDES += $(TOP)/system/media/camera/include
# End of common part ---------------------------------------
#
include $(BUILD_SHARED_LIBRARY)

#
include $(call all-makefiles-under, $(LOCAL_PATH))
