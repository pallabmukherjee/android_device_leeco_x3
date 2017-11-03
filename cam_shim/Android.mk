# wrapper library for libcam.halsensor
#
LOCAL_PATH := $(call my-dir)
ifeq ($(USE_MTK_CAMERA_WRAPPER),true)
include $(CLEAR_VARS)
LOCAL_CLANG := true

LOCAL_SRC_FILES := \
    isp_drv_shim.cpp



LOCAL_SHARED_LIBRARIES := liblog libcutils libdl libutils \
			  libcamdrv
LOCAL_MODULE := libcamdrv_isp
LOCAL_MODULE_TAGS := optional
include $(BUILD_SHARED_LIBRARY)
#-----------------------------------------------------------------
include $(CLEAR_VARS)
LOCAL_CLANG := true

LOCAL_SRC_FILES := \
    Hdr_shim.cpp



LOCAL_SHARED_LIBRARIES := liblog libcutils libstdc++ libc \
			  libhardware libfeatureiopipe
LOCAL_MODULE := libcam.camadapter.scenario.shot.hdrshot
LOCAL_MODULE_TAGS := optional
include $(BUILD_SHARED_LIBRARY)

endif