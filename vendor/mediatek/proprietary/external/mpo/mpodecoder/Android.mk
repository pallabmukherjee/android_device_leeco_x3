#
# libmpodecoder
#
LOCAL_PATH:= $(call my-dir)

include $(CLEAR_VARS)

LOCAL_SRC_FILES:= MpoDecoder.cpp

LOCAL_C_INCLUDES += device/leeco/x3/vendor/mediatek/proprietary/external/mpo \
	$(JNI_H_INCLUDE) \
	external/skia/include/core \
	external/skia/include/effects \
	external/skia/include/images \
	external/skia/src/ports \
	external/skia/include/utils \
	frameworks/base/core/jni/android/graphics 

LOCAL_C_INCLUDES += \
        device/leeco/x3/vendor/mediatek/proprietary/external/mpo \
        device/leeco/x3/vendor/mediatek/proprietary/external/mpo/inc \
        device/leeco/x3/vendor/mediatek/proprietary/external/mpo/mpodecoder \
        device/leeco/x3/vendor/mediatek/proprietary/external/mpo/mpodecoder/inc \

LOCAL_SHARED_LIBRARIES:= \
	libcutils \
	libskia \
	libandroid_runtime \
        libmpo

LOCAL_PRELINK_MODULE := false

LOCAL_MODULE:= libmpodecoder
LOCAL_MULTILIB := 32

LOCAL_MODULE_TAGS := optional

include $(BUILD_SHARED_LIBRARY)

