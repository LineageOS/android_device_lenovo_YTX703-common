# This product makefile is parsed during the lunch command,
# which takes it from vendorsetup.sh

COMMON_LUNCH_CHOICES := \
    lineage_YTX703L-userdebug \
    lineage_YTX703L-eng

$(call inherit-product, device/lenovo/YTX703-common/YTX703L/device.mk)

# Inherit some common Lineage stuff.
$(call inherit-product, vendor/lineage/config/common_full_phone.mk)

PRODUCT_NAME := lineage_YTX703L
PRODUCT_BRAND := Lenovo
PRODUCT_MANUFACTURER := LENOVO
PRODUCT_DEVICE := YTX703L
PRODUCT_MODEL := Lenovo Yoga Tab 3 Plus LTE

PRODUCT_GMS_CLIENTID_BASE := android-lenovo

# Use the latest approved GMS identifiers
PRODUCT_BUILD_PROP_OVERRIDES += \
    PRODUCT_NAME=YT-X703L \
    PRIVATE_BUILD_DESC="msm8952_64-user 7.1.1 NMF26F eng.maojia.20180610.122353 release-keys"

BUILD_FINGERPRINT := Lenovo/YT-X703L/YT-X703L:7.1.1/S100/YT-X703L_S000973_180524_ROW:user/release-keys
