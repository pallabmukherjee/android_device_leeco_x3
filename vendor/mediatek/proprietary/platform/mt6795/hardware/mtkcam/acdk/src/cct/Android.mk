#
# libacdk
#
LOCAL_PATH := $(call my-dir)

include $(CLEAR_VARS)

#
LOCAL_SRC_FILES := \
    $(call all-c-cpp-files-under, if) \
LOCAL_SRC_FILES += \
    calibration/cct_calibration.cpp \
    calibration/cct_flash_cali.cpp \
    calibration/cct_imgtool.cpp \
#    $(call all-c-cpp-files-under, ctrl)


#
# Note: "/bionic" and "/external/stlport/stlport" is for stlport.
LOCAL_C_INCLUDES += \
    $(TOP)/bionic \
    $(TOP)/external/stlport/stlport \
    $(TOP)/device/leeco/x3/vendor/mediatek/proprietary/kernel/drivers/video \
    $(TOP)/device/leeco/x3/vendor/mediatek/proprietary/platform/mt6795/hardware/ \
    $(TOP)/device/leeco/x3/vendor/mediatek/proprietary/platform/mt6795/hardware/mtkcam/ \
    $(TOP)/device/leeco/x3/vendor/mediatek/proprietary/platform/mt6795/hardware/mtkcam/inc \
    $(TOP)/device/leeco/x3/vendor/mediatek/proprietary/platform/mt6795/hardware/mtkcam/inc/drv \
    $(TOP)/device/leeco/x3/vendor/mediatek/proprietary/platform/mt6795/hardware/mtkcam/inc/acdk \
    $(TOP)/device/leeco/x3/vendor/mediatek/proprietary/platform/mt6795/hardware/mtkcam/inc/imageio \
    $(TOP)/device/leeco/x3/vendor/mediatek/proprietary/platform/mt6795/hardware/mtkcam/inc/common \
    $(TOP)/device/leeco/x3/vendor/mediatek/proprietary/platform/mt6795/hardware/mtkcam/acdk/inc/acdk \
    $(TOP)/device/leeco/x3/vendor/mediatek/proprietary/platform/mt6795/hardware/mtkcam/acdk/inc/cct \
    $(TOP)/device/leeco/x3/vendor/mediatek/proprietary/platform/mt6795/hardware/mtkcam/core/drv/imgsensor \
    $(TOP)/device/leeco/x3/vendor/mediatek/proprietary/platform/mt6795/hardware/mtkcam/inc/featureio \
    $(TOP)/device/leeco/x3/vendor/mediatek/proprietary/platform/mt6795/hardware/mtkcam/core/featureio/drv/inc \
    $(TOP)/device/leeco/x3/vendor/mediatek/proprietary/custom/mt6795/hal/inc \
    $(TOP)/device/leeco/x3/vendor/mediatek/proprietary/custom/mt6795/hal/inc/isp_tuning \
    $(TOP)/device/leeco/x3/vendor/mediatek/proprietary/custom/mt6795/hal/inc/aaa \
    $(TOP)/device/leeco/x3/vendor/mediatek/proprietary/custom/mt6795/hal/inc/aaa/debug_exif/aaa \
    $(TOP)/device/leeco/x3/vendor/mediatek/proprietary/custom/mt6795/hal/inc/aaa/debug_exif/cam \
    $(TOP)/$(MTK_PATH_CUSTOM_PLATFORM)/hal/inc \
    $(TOP)/$(MTK_PATH_CUSTOM_PLATFORM)/hal/inc/isp_tuning \
    $(TOP)/$(MTK_PATH_CUSTOM_PLATFORM)/hal/inc/aaa \
    $(TOP)/$(MTK_PATH_CUSTOM_PLATFORM)/hal/inc/aaa/debug_exif/aaa \
    $(TOP)/$(MTK_PATH_CUSTOM_PLATFORM)/hal/inc/aaa/debug_exif/cam \
    $(TOP)/device/leeco/x3/vendor/mediatek/proprietary/platform/mt6795/hardware/mtkcam/core/imageio/inc \
    $(TOP)/device/leeco/x3/vendor/mediatek/proprietary/platform/mt6795/hardware/mtkcam/core/imageio/pipe/inc \
    $(TOP)/device/leeco/x3/vendor/mediatek/proprietary/platform/mt6795/kernel/core/include/mach \
    $(TOP)/device/leeco/x3/vendor/mediatek/proprietary/platform/mt6795/external/ldvt/include \
    $(TOP)/device/leeco/x3/vendor/mediatek/proprietary/custom/common/kernel/imgsensor/inc \
    $(TOP)/mediatek/source/external/mhal/src/core/drv/inc \
    $(TOP)/device/leeco/x3/vendor/mediatek/proprietary/kernel/include \
    device/leeco/x3/vendor/mediatek/proprietary/hardware/mtkcam/inc/acdk \
    device/leeco/x3/vendor/mediatek/proprietary/hardware/mtkcam/inc/drv \
    device/leeco/x3/vendor/mediatek/proprietary/hardware/mtkcam/inc/featureio \
    device/leeco/x3/vendor/mediatek/proprietary/platform/mt6795/hardware/mtkcam/core/featureio/pipe/aaa/isp_mgr \
    device/leeco/x3/vendor/mediatek/proprietary/platform/mt6795/hardware/mtkcam/core/featureio/pipe/aaa/isp_tuning \
    device/leeco/x3/vendor/mediatek/proprietary/platform/mt6795/hardware/mtkcam/core/featureio/pipe/aaa/ispdrv_mgr \
    device/leeco/x3/vendor/mediatek/proprietary/platform/mt6795/hardware/mtkcam/core/featureio/pipe/aaa/nvram_mgr \
    device/leeco/x3/vendor/mediatek/proprietary/platform/mt6795/hardware/mtkcam/core/featureio/pipe/aaa/awb_mgr \
    device/leeco/x3/vendor/mediatek/proprietary/platform/mt6795/hardware/mtkcam/core/featureio/pipe/aaa/af_mgr \
    device/leeco/x3/vendor/mediatek/proprietary/platform/mt6795/hardware/mtkcam/core/featureio/pipe/aaa/ae_mgr \
    device/leeco/x3/vendor/mediatek/proprietary/platform/mt6795/hardware/mtkcam/core/featureio/pipe/aaa/flash_mgr \
    device/leeco/x3/vendor/mediatek/proprietary/platform/mt6795/hardware/mtkcam/core/featureio/pipe/aaa/sensor_mgr \
    device/leeco/x3/vendor/mediatek/proprietary/platform/mt6795/hardware/mtkcam/core/featureio/pipe/aaa/lsc_mgr \
    device/leeco/x3/vendor/mediatek/proprietary/platform/mt6795/hardware/mtkcam/core/featureio/pipe/aaa \
    $(TOP)/device/leeco/x3/vendor/mediatek/proprietary/platform/mt6795/hardware/mtkcam/inc/algorithm/lib3a \
    $(TOP)/device/leeco/x3/vendor/mediatek/proprietary/platform/mt6795/hardware/include/mtkcam/algorithm/liblsctrans \
    $(TOP)/device/leeco/x3/vendor/mediatek/proprietary/platform/mt6795/hardware/mtkcam/inc/algorithm/libtsf \
    $(TOP)/device/leeco/x3/vendor/mediatek/proprietary/platform/mt6795/hardware/include/mtkcam/featureio \

# Add a define value that can be used in the code to indicate that it's using LDVT now.
# For print message function when using LDVT.
# Note: It will be cleared by "CLEAR_VARS", so if it is needed in other module, it
# has to be set in other module again.
ifeq ($(BUILD_MTK_LDVT),true)
    LOCAL_CFLAGS += -DUSING_MTK_LDVT
endif

#
LOCAL_STATIC_LIBRARIES := \

ifeq ($(BUILD_MTK_LDVT),true)
   LOCAL_WHOLE_STATIC_LIBRARIES += libuvvf
endif

#
LOCAL_WHOLE_STATIC_LIBRARIES := \
   liblsctrans \
#    libimageio_plat_pipe_mgr \
#    libimageio_plat_drv \
#    libcamdrv_imgsensor \

#
#LOCAL_SHARED_LIBRARIES := \
#     libstlport \
#     libcutils \
#     libimageio \
#     libcamdrv \

#
LOCAL_PRELINK_MODULE := false

#
LOCAL_MODULE_TAGS := optional

#
LOCAL_MODULE := libcct

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

# End of common part ---------------------------------------
#
include $(BUILD_STATIC_LIBRARY)


#include $(BUILD_SHARED_LIBRARY)
