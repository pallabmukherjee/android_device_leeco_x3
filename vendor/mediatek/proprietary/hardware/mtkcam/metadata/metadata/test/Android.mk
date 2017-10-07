
################################################################################
#
################################################################################

LOCAL_PATH := $(call my-dir)

################################################################################
#
################################################################################
include $(CLEAR_VARS)

#-----------------------------------------------------------
sinclude $(TOP)/device/leeco/x3/vendor/mediatek/proprietary/hardware/mtkcam/mtkcam.mk

#-----------------------------------------------------------
LOCAL_SRC_FILES += test_metadata.cpp

#-----------------------------------------------------------
LOCAL_C_INCLUDES += $(MTKCAM_C_INCLUDES)
LOCAL_C_INCLUDES += $(TOP)/device/leeco/x3/vendor/mediatek/proprietary/hardware/include
#
#-----------------------------------------------------------
LOCAL_CFLAGS += $(MTKCAM_CFLAGS)
#
#-----------------------------------------------------------
LOCAL_WHOLE_STATIC_LIBRARIES +=
#
#-----------------------------------------------------------
LOCAL_STATIC_LIBRARIES +=
#
#-----------------------------------------------------------
LOCAL_SHARED_LIBRARIES += liblog
LOCAL_SHARED_LIBRARIES += libutils
LOCAL_SHARED_LIBRARIES += libcutils
LOCAL_SHARED_LIBRARIES += libcam.metadata

#-----------------------------------------------------------
LOCAL_MODULE := testmetadata

#-----------------------------------------------------------
LOCAL_MODULE_TAGS := eng

#-----------------------------------------------------------
LOCAL_PRELINK_MODULE := false

#-----------------------------------------------------------
include $(BUILD_EXECUTABLE)

#-----------------------------------------------------------
#include $(call all-makefiles-under,$(LOCAL_PATH))


