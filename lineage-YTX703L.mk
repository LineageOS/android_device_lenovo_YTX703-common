# This product makefile is parsed during the lunch command,
# which takes it from vendorsetup.sh

$(call inherit-product, device/lenovo/YTX703/YTX703L.mk)

# Inherit some common Lineage stuff.
$(call inherit-product, vendor/cm/config/common_full_phone.mk)

PRODUCT_NAME := lineage_YTX703L
PRODUCT_BRAND := Lenovo
PRODUCT_MANUFACTURER := LENOVO
PRODUCT_DEVICE := YTX703L
PRODUCT_MODEL := Lenovo Yoga Tab 3 Plus LTE

PRODUCT_GMS_CLIENTID_BASE := android-lenovo

# Use the latest approved GMS identifiers
PRODUCT_BUILD_PROP_OVERRIDES += \
    PRODUCT_NAME=YT-X703L \
    BUILD_FINGERPRINT=Lenovo/YT-X703L/YT-X703L:6.0.1/S100/YT-X703L_S000734_170307_ROW:user/release-keys \
    PRIVATE_BUILD_DESC="msm8952_64-user 6.0.1 MMB29M eng.maojialu.20161230.160517 release-keys"
