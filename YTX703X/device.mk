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

# This product makefile is inherited from YTX703X/lineage.mk

# Inherit from those products. Most specific first.
$(call inherit-product, $(SRC_TARGET_DIR)/product/core_64_bit.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/full_base_telephony.mk)

# Inherit from common YTX703 device
$(call inherit-product, device/lenovo/YTX703-common/device-common.mk)

# Call the proprietary device makefile, if present
$(call inherit-product-if-exists, vendor/lenovo/YTX703-common/YTX703X/YTX703X-vendor.mk)

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
    init.qcom.console.sh \
    init.qcom.radio.sh
