

LOCAL_PATH := $(call my-dir)



include $(CLEAR_VARS)

ifeq ($(MTK_CAM_HDR_SUPPORT), yes)
#-----------------------------------------------------------
LOCAL_SRC_FILES += \
                HDRUtils.cpp


#---------------------------------------------------------

LOCAL_CFLAGS += $(MTKCAM_CFLAGS)

LOCAL_CPPFLAGS = -std=c++0x

#---------------------------------------------------------
LOCAL_MODULE := libcam.camadapter.scenario.shot.hdrshot
LOCAL_MODULE_TAGS := optional

#-----------------------------------------------------------
include $(BUILD_STATIC_LIBRARY)


endif