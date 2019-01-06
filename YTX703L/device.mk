#
# Copyright (C) 2017-2018 The LineageOS Project
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

# This product makefile is inherited from YTX703L/lineage.mk

# Inherit from those products. Most specific first.
$(call inherit-product, $(SRC_TARGET_DIR)/product/core_64_bit.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/full_base_telephony.mk)

# Inherit from common YTX703 device
$(call inherit-product, device/lenovo/YTX703-common/device-common.mk)

# Call the proprietary device makefile
$(call inherit-product, vendor/lenovo/YTX703-common/YTX703L/YTX703L-vendor.mk)

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

# data-ipa-cfg-mgr
PRODUCT_PACKAGES += \
    ipacm \
    IPACM_cfg.xml \
    libipanat \

