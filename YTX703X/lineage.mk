# This product makefile is parsed during the lunch command,
# which takes it from vendorsetup.sh

$(call inherit-product, device/lenovo/YTX703-common/YTX703X/device.mk)

# Inherit some common Lineage stuff.
$(call inherit-product, vendor/lineage/config/common_full_phone.mk)

PRODUCT_NAME := lineage_YTX703X
PRODUCT_BRAND := Lenovo
PRODUCT_MANUFACTURER := LENOVO
PRODUCT_DEVICE := YTX703X
PRODUCT_MODEL := Lenovo YT-X703X

PRODUCT_GMS_CLIENTID_BASE := android-lenovo

# Use the latest approved GMS identifiers
PRODUCT_BUILD_PROP_OVERRIDES += \
    PRODUCT_NAME=YT-X703L \
    PRIVATE_BUILD_DESC="msm8952_64-user 7.1.1 NMF26F eng.maojia.20180610.124234 release-keys"

BUILD_FINGERPRINT := Lenovo/YT-X703X/YT-X703X:7.1.1/S100/YT-X703X_S000973_180524_ROW:user/release-keys
