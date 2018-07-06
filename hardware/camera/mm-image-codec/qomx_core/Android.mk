OMX_CORE_PATH := $(call my-dir)

# ------------------------------------------------------------------------------
#                Make the shared library (libqomx_core)
# ------------------------------------------------------------------------------

include $(CLEAR_VARS)
LOCAL_PATH := $(OMX_CORE_PATH)
LOCAL_MODULE_TAGS := optional

omx_core_defines:= -Werror \
                   -g -O0

LOCAL_CFLAGS := $(omx_core_defines)

OMX_HEADER_DIR := frameworks/native/include/media/openmax

LOCAL_C_INCLUDES := $(OMX_HEADER_DIR)
LOCAL_C_INCLUDES += $(LOCAL_PATH)/../qexif

LOCAL_SRC_FILES := qomx_core.c

LOCAL_MODULE           := libqomx_core
LOCAL_SHARED_LIBRARIES := libcutils libdl liblog libutils
ifeq (1,$(filter 1,$(shell echo "$$(( $(PLATFORM_SDK_VERSION) >= 26 ))" )))
LOCAL_MODULE_OWNER := qcom
LOCAL_VENDOR_MODULE  := true
endif

LOCAL_32_BIT_ONLY := true
include $(BUILD_SHARED_LIBRARY)
