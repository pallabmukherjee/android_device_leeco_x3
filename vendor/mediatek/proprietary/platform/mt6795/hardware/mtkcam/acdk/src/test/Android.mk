#
# camshottest
#
LOCAL_PATH := $(call my-dir)

include $(CLEAR_VARS)

#
LOCAL_SRC_FILES := \
    main.cpp \
    test_singleshot.cpp \
#    test_simager.cpp \

#
# Note: "/bionic" and "/external/stlport/stlport" is for stlport.
LOCAL_C_INCLUDES += \
    $(TOP)/bionic \
    $(TOP)/device/leeco/x3/vendor/mediatek/proprietary/kernel/drivers/video \
    $(TOP)/device/leeco/x3/vendor/mediatek/proprietary/platform/mt6795/kernel/core/include/mach \
    $(TOP)/device/leeco/x3/vendor/mediatek/proprietary/platform/mt6795/hardware/m4u \
    $(TOP)/device/leeco/x3/vendor/mediatek/proprietary/kernel/include \
    $(TOP)/device/leeco/x3/vendor/mediatek/proprietary/platform/mt6795/external/ldvt/include \
    $(TOP)/external/stlport/stlport \
    $(TOP)/device/leeco/x3/vendor/mediatek/proprietary/hardware/mtkcam/inc/acdk \
    $(TOP)/device/leeco/x3/vendor/mediatek/proprietary/platform/mt6795/hardware/mtkcam/acdk/inc/acdk \
    $(TOP)/device/leeco/x3/vendor/mediatek/proprietary/platform/mt6795/hardware \
    $(TOP)/device/leeco/x3/vendor/mediatek/proprietary/platform/mt6795/hardware/mtkcam\
    $(TOP)/device/leeco/x3/vendor/mediatek/proprietary/platform/mt6795/hardware/mtkcam/core/drv/imgsensor \
    $(TOP)/device/leeco/x3/vendor/mediatek/proprietary/platform/mt6795/hardware/mtkcam/core/drv/res_mgr \
    $(TOP)/device/leeco/x3/vendor/mediatek/proprietary/platform/mt6795/hardware/mtkcam/core/imageio/inc \
    $(TOP)/device/leeco/x3/vendor/mediatek/proprietary/platform/mt6795/hardware/mtkcam/core/imageio/pipe/inc \
    $(TOP)/device/leeco/x3/vendor/mediatek/proprietary/custom/common/kernel/imgsensor/inc \
    $(TOP)/mediatek/hardware \
    $(TOP)/mediatek/hardware/include \
    $(TOP)/device/leeco/x3/vendor/mediatek/proprietary/hardware/include/mtkcam \
    $(TOP)/device/leeco/x3/vendor/mediatek/proprietary/platform/mt6795/hardware/include/mtkcam \
    $(TOP)/device/leeco/x3/vendor/mediatek/proprietary/platform/mt6795/hardware/include \

LOCAL_C_INCLUDES += $(TOP)/device/leeco/x3/vendor/mediatek/proprietary/frameworks/av/include

# vector
LOCAL_SHARED_LIBRARIES := \
    libstlport \
    libcutils \
    libimageio \
    libcamdrv \
    libcam.iopipe \
    libcam_utils \
    libcam.halsensor \
    libcam.metadata \
    libm4u \
    libutils \
    libstlport \
    libcam.camshot \

LOCAL_SHARED_LIBRARIES += libhardware
LOCAL_SHARED_LIBRARIES += libutils
LOCAL_SHARED_LIBRARIES += libbinder
LOCAL_SHARED_LIBRARIES += libdl

LOCAL_SHARED_LIBRARIES += libcamera_client libcamera_client_mtk


#
LOCAL_STATIC_LIBRARIES := \

#
LOCAL_WHOLE_STATIC_LIBRARIES := \

#
LOCAL_MODULE := acdk_camshottest

#
LOCAL_MODULE_TAGS := eng

#
LOCAL_PRELINK_MODULE := false

#

#
# Start of common part ------------------------------------
sinclude $(TOP)/device/leeco/x3/vendor/mediatek/proprietary/platform/mt6795/hardware/mtkcam/mtkcam.mk

#-----------------------------------------------------------
LOCAL_CFLAGS += $(MTKCAM_CFLAGS)

#-----------------------------------------------------------
LOCAL_C_INCLUDES += $(MTKCAM_C_INCLUDES)

#-----------------------------------------------------------
LOCAL_C_INCLUDES += $(TOP)/device/leeco/x3/vendor/mediatek/proprietary/hardware/include
LOCAL_C_INCLUDES += $(TOP)/device/leeco/x3/vendor/mediatek/proprietary/platform/mt6795/hardware/include
LOCAL_C_INCLUDES += $(TOP)/system/media/camera/include

# End of common part ---------------------------------------
#
include $(BUILD_EXECUTABLE)


#
#include $(call all-makefiles-under,$(LOCAL_PATH))
