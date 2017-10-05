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
    $(TOP)/vendor/mediatek/proprietary/kernel/drivers/video \
    $(TOP)/vendor/mediatek/proprietary/platform/mt6795/hardware/ \
    $(TOP)/vendor/mediatek/proprietary/platform/mt6795/hardware/mtkcam/ \
    $(TOP)/vendor/mediatek/proprietary/platform/mt6795/hardware/mtkcam/inc \
    $(TOP)/vendor/mediatek/proprietary/platform/mt6795/hardware/mtkcam/inc/drv \
    $(TOP)/vendor/mediatek/proprietary/platform/mt6795/hardware/mtkcam/inc/acdk \
    $(TOP)/vendor/mediatek/proprietary/platform/mt6795/hardware/mtkcam/inc/imageio \
    $(TOP)/vendor/mediatek/proprietary/platform/mt6795/hardware/mtkcam/inc/common \
    $(TOP)/vendor/mediatek/proprietary/platform/mt6795/hardware/mtkcam/acdk/inc/acdk \
    $(TOP)/vendor/mediatek/proprietary/platform/mt6795/hardware/mtkcam/acdk/inc/cct \
    $(TOP)/vendor/mediatek/proprietary/platform/mt6795/hardware/mtkcam/core/drv/imgsensor \
    $(TOP)/vendor/mediatek/proprietary/platform/mt6795/hardware/mtkcam/inc/featureio \
    $(TOP)/vendor/mediatek/proprietary/platform/mt6795/hardware/mtkcam/core/featureio/drv/inc \
    $(TOP)/vendor/mediatek/proprietary/custom/mt6795/hal/inc \
    $(TOP)/vendor/mediatek/proprietary/custom/mt6795/hal/inc/isp_tuning \
    $(TOP)/vendor/mediatek/proprietary/custom/mt6795/hal/inc/aaa \
    $(TOP)/vendor/mediatek/proprietary/custom/mt6795/hal/inc/aaa/debug_exif/aaa \
    $(TOP)/vendor/mediatek/proprietary/custom/mt6795/hal/inc/aaa/debug_exif/cam \
    $(TOP)/$(MTK_PATH_CUSTOM_PLATFORM)/hal/inc \
    $(TOP)/$(MTK_PATH_CUSTOM_PLATFORM)/hal/inc/isp_tuning \
    $(TOP)/$(MTK_PATH_CUSTOM_PLATFORM)/hal/inc/aaa \
    $(TOP)/$(MTK_PATH_CUSTOM_PLATFORM)/hal/inc/aaa/debug_exif/aaa \
    $(TOP)/$(MTK_PATH_CUSTOM_PLATFORM)/hal/inc/aaa/debug_exif/cam \
    $(TOP)/vendor/mediatek/proprietary/platform/mt6795/hardware/mtkcam/core/imageio/inc \
    $(TOP)/vendor/mediatek/proprietary/platform/mt6795/hardware/mtkcam/core/imageio/pipe/inc \
    $(TOP)/vendor/mediatek/proprietary/platform/mt6795/kernel/core/include/mach \
    $(TOP)/vendor/mediatek/proprietary/platform/mt6795/external/ldvt/include \
    $(TOP)/vendor/mediatek/proprietary/custom/common/kernel/imgsensor/inc \
    $(TOP)/mediatek/source/external/mhal/src/core/drv/inc \
    $(TOP)/vendor/mediatek/proprietary/kernel/include \
    vendor/mediatek/proprietary/hardware/mtkcam/inc/acdk \
    vendor/mediatek/proprietary/hardware/mtkcam/inc/drv \
    vendor/mediatek/proprietary/hardware/mtkcam/inc/featureio \
    vendor/mediatek/proprietary/platform/mt6795/hardware/mtkcam/core/featureio/pipe/aaa/isp_mgr \
    vendor/mediatek/proprietary/platform/mt6795/hardware/mtkcam/core/featureio/pipe/aaa/isp_tuning \
    vendor/mediatek/proprietary/platform/mt6795/hardware/mtkcam/core/featureio/pipe/aaa/ispdrv_mgr \
    vendor/mediatek/proprietary/platform/mt6795/hardware/mtkcam/core/featureio/pipe/aaa/nvram_mgr \
    vendor/mediatek/proprietary/platform/mt6795/hardware/mtkcam/core/featureio/pipe/aaa/awb_mgr \
    vendor/mediatek/proprietary/platform/mt6795/hardware/mtkcam/core/featureio/pipe/aaa/af_mgr \
    vendor/mediatek/proprietary/platform/mt6795/hardware/mtkcam/core/featureio/pipe/aaa/ae_mgr \
    vendor/mediatek/proprietary/platform/mt6795/hardware/mtkcam/core/featureio/pipe/aaa/flash_mgr \
    vendor/mediatek/proprietary/platform/mt6795/hardware/mtkcam/core/featureio/pipe/aaa/sensor_mgr \
    vendor/mediatek/proprietary/platform/mt6795/hardware/mtkcam/core/featureio/pipe/aaa/lsc_mgr \
    vendor/mediatek/proprietary/platform/mt6795/hardware/mtkcam/core/featureio/pipe/aaa \
    $(TOP)/vendor/mediatek/proprietary/platform/mt6795/hardware/mtkcam/inc/algorithm/lib3a \
    $(TOP)/vendor/mediatek/proprietary/platform/mt6795/hardware/include/mtkcam/algorithm/liblsctrans \
    $(TOP)/vendor/mediatek/proprietary/platform/mt6795/hardware/mtkcam/inc/algorithm/libtsf \
    $(TOP)/vendor/mediatek/proprietary/platform/mt6795/hardware/include/mtkcam/featureio \

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
sinclude $(TOP)/vendor/mediatek/proprietary/platform/mt6795/hardware/mtkcam/mtkcam.mk

#-----------------------------------------------------------
LOCAL_CFLAGS += $(MTKCAM_CFLAGS)

#-----------------------------------------------------------
LOCAL_C_INCLUDES += $(MTKCAM_C_INCLUDES)

#-----------------------------------------------------------
LOCAL_C_INCLUDES += $(TOP)/vendor/mediatek/proprietary/hardware/include
LOCAL_C_INCLUDES += $(TOP)/vendor/mediatek/proprietary/platform/mt6795/hardware/include

# End of common part ---------------------------------------
#
include $(BUILD_STATIC_LIBRARY)


#include $(BUILD_SHARED_LIBRARY)
