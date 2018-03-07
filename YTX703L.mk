#
# Copyright (C) 2016 The CyanogenMod Project
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
#

# This product makefile is inherited from lineage-YTX703L.mk

# Inherit from those products. Most specific first.
$(call inherit-product, $(SRC_TARGET_DIR)/product/core_64_bit.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/full_base_telephony.mk)

# Inherit from common YT-X703* device
$(call inherit-product, device/lenovo/YTX703/YTX703-common.mk)

# RIL
PRODUCT_PACKAGES += \
    libcnefeatureconfig \
    librmnetctl \
    libxml2 \
    libqsap_sdk \
    telephony-ext \
    libminui \
    libnfnetlink \
    libnetfilter_conntrack

# Extra init scripts
PRODUCT_PACKAGES += \
    init.target.rc \
    init.qcom.console.sh \
    init.qcom.radio.sh

# Device identifier. This must come after all inclusions
PRODUCT_DEVICE := YTX703L
PRODUCT_NAME := lineage_YTX703L
PRODUCT_BRAND := Lenovo
PRODUCT_MODEL := YTX703L
PRODUCT_MANUFACTURER := LENOVO
