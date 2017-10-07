#
# libimageio
#
LOCAL_PATH := $(call my-dir)

include $(CLEAR_VARS)

#-----------------------------------------------------------
sinclude $(TOP)/device/leeco/x3/vendor/mediatek/proprietary/platform/mt6795/hardware/mtkcam/mtkcam.mk

#-----------------------------------------------------------
LOCAL_SRC_FILES += 


#-----------------------------------------------------------
LOCAL_C_INCLUDES += $(MTKCAM_C_INCLUDES)
LOCAL_C_INCLUDES += $(TOP)/device/leeco/x3/vendor/mediatek/proprietary/hardware/include
LOCAL_C_INCLUDES += $(TOP)/device/leeco/x3/vendor/mediatek/proprietary/platform/mt6795/hardware/include
#

#-----------------------------------------------------------
LOCAL_CFLAGS += $(MTKCAM_CFLAGS)
#
ifeq ($(HAVE_AEE_FEATURE),yes)
	LOCAL_CFLAGS += -DHAVE_AEE_FEATURE
endif

#-----------------------------------------------------------
LOCAL_WHOLE_STATIC_LIBRARIES += libimageio_plat_pipe
#LOCAL_WHOLE_STATIC_LIBRARIES += libimageio_plat_drv
#
#LOCAL_STATIC_LIBRARIES += libimageio_plat_drv
#LOCAL_STATIC_LIBRARIES += libimageio_plat_pipe
#LOCAL_STATIC_LIBRARIES += libimageio_plat_pipe_mgr

#-----------------------------------------------------------
LOCAL_SHARED_LIBRARIES += liblog
LOCAL_SHARED_LIBRARIES += libcutils
LOCAL_SHARED_LIBRARIES += libstlport
#
LOCAL_SHARED_LIBRARIES += libimageio_plat_drv
LOCAL_SHARED_LIBRARIES += libcamdrv
LOCAL_SHARED_LIBRARIES += libm4u
#

ifneq ($(BUILD_MTK_LDVT),true)

endif

ifeq ($(HAVE_AEE_FEATURE),yes)
    LOCAL_SHARED_LIBRARIES += libaed
endif
#
ifeq ($(MTK_ION_SUPPORT), yes)
  LOCAL_CFLAGS += -DUSING_MTK_ION
endif
#-----------------------------------------------------------
LOCAL_MODULE := libimageio

#-----------------------------------------------------------
LOCAL_PRELINK_MODULE := false
LOCAL_MODULE_TAGS := optional

include $(BUILD_SHARED_LIBRARY)


################################################################################
#
################################################################################
include $(CLEAR_VARS)
include $(call all-makefiles-under,$(LOCAL_PATH))
