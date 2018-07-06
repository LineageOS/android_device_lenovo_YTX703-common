# Copyright (C) 2018 The LineageOS Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

LOCAL_PATH := $(call my-dir)

include $(CLEAR_VARS)

LOCAL_MODULE := libwcnss_qmi
LOCAL_MODULE_TAGS := optional
LOCAL_SRC_FILES := wcnss_qmi.c
LOCAL_CFLAGS += -Wall -Wextra -Werror
LOCAL_SHARED_LIBRARIES := libc libcutils libutils liblog
# qmi_client_init, qmi_client_send_msg_sync, qmi_client_release
LOCAL_SHARED_LIBRARIES += libqcci_legacy
# dms_get_service_object_internal_v01
LOCAL_SHARED_LIBRARIES += libqmiservices
# qmi_init, qmi_release
LOCAL_SHARED_LIBRARIES += libqmi
LOCAL_VENDOR_MODULE := true
include $(BUILD_SHARED_LIBRARY)

