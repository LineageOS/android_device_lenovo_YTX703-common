LOCAL_PATH := $(call my-dir)

include $(CLEAR_VARS)

LOCAL_C_INCLUDES := hardware/qcom/power
LOCAL_CFLAGS := -Wall -Werror

ifeq ($(TARGET_USES_INTERACTION_BOOST),true)
    LOCAL_CFLAGS += -DINTERACTION_BOOST
endif

LOCAL_SRC_FILES := power-8976.c
LOCAL_MODULE := libpower_8976
include $(BUILD_STATIC_LIBRARY)
