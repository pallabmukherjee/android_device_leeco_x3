LOCAL_PATH := $(call my-dir)

include $(CLEAR_VARS)

#-----------------------------------------------------------
LOCAL_SRC_FILES += \
		Hdr_shim.cpp

#-----------------------------------------------------------
LOCAL_CPPFLAGS = -std=c++0x

#-----------------------------------------------------------
LOCAL_SHARED_LIBRARIES := liblog libcutils libstdc++ libc \
                          libhardware libfeatureiopipe
#-----------------------------------------------------------
LOCAL_MODULE := libcam.camadapter.scenario.shot.hdrshot

LOCAL_MODULE_TAGS := optional
LOCAL_MODULE_CLASS := SHARED_LIBRARIES
#-----------------------------------------------------------
include $(BUILD_STATIC_LIBRARY)

LOCAL_PATH := $(call my-dir)

include $(CLEAR_VARS)


LOCAL_SRC_FILES += isp_drv_shim.cpp



LOCAL_SHARED_LIBRARIES := liblog libcutils libutils \
                          libcamdrv 
#-----------------------------------------------------------
LOCAL_MODULE := libcamdrv_isp

LOCAL_MODULE_TAGS := optional
#-----------------------------------------------------------
include $(BUILD_STATIC_LIBRARY)


