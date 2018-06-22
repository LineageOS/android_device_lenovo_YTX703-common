LOCAL_PATH := $(call my-dir)

include $(CLEAR_VARS)
LOCAL_C_INCLUDES := hardware/qcom/power
LOCAL_CFLAGS := -Wall -Werror
LOCAL_SRC_FILES := power-8976.c
LOCAL_MODULE := libpower_8976
include $(BUILD_STATIC_LIBRARY)
