ifeq ($(strip $(MTK_SENSOR_HUB_SUPPORT)),yes)

LOCAL_PATH := $(call my-dir)

include $(CLEAR_VARS)

LOCAL_PRELINK_MODULE := false

LOCAL_SHARED_LIBRARIES := \
	liblog \
	libcutils \
	libutils
	
LOCAL_SRC_FILES := \
	shf_types.cpp \
	shf_debug.cpp \
	shf_communicator.cpp \
	shf_hal.cpp
	
LOCAL_C_INCLUDES+= \
        vendor/mediatek/proprietary/hardware/sensorhub/

LOCAL_MODULE := libhwsensorhub

LOCAL_MODULE_TAGS := optional

include $(BUILD_SHARED_LIBRARY)

else

ifeq ($(strip $(CUSTOM_KERNEL_SENSORHUB)),CWSTM32)

include vendor/mediatek/proprietary/hardware/sensorhub/cwmcu/Android.mk

endif

endif
