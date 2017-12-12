
LOCAL_PATH := $(call my-dir)

include $(CLEAR_VARS)

LOCAL_SRC_FILES += isp_drv.cpp

LOCAL_C_INCLUDES += $(TOP)/bionic
LOCAL_C_INCLUDES += $(TOP)/external/stlport/stlport

LOCAL_C_INCLUDES += $(TOP)/$(LOCAL_PATH)/../../../../kernel/include
LOCAL_C_INCLUDES += $(TOP)/$(LOCAL_PATH)/../../../../kernel/core/include/mach

LOCAL_CFLAGS += $(MTKCAM_CFLAGS)
#
# Add a define value that can be used in the code to indicate that it's using LDVT now.
# For print message function when using LDVT.
# Note: It will be cleared by "CLEAR_VARS", so if this line needed in other module, it
# have to be set in other module again.
ifeq ($(BUILD_MTK_LDVT),true)
    LOCAL_CFLAGS += -DUSING_MTK_LDVT
endif

#temp for 64 bit,need remove
ifeq ($(MTK_K64_SUPPORT),yes)
    LOCAL_CFLAGS += -DUSING_64
endif

LOCAL_WHOLE_STATIC_LIBRARIES += 

LOCAL_STATIC_LIBRARIES += 

LOCAL_MODULE := libcamdrv_isp

include $(BUILD_STATIC_LIBRARY)

