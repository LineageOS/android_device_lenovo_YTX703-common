# This product makefile is parsed during the lunch command,
# which takes it from vendorsetup.sh

$(call inherit-product, device/lenovo/YTX703-common/YTX703F/device.mk)

# Inherit some common Lineage stuff.
$(call inherit-product, vendor/cm/config/common_full_tablet_wifionly.mk)

PRODUCT_NAME := lineage_YTX703F
PRODUCT_BRAND := Lenovo
PRODUCT_MANUFACTURER := LENOVO
PRODUCT_DEVICE := YTX703F
PRODUCT_MODEL := Lenovo Yoga Tab 3 Plus Wi-Fi

PRODUCT_GMS_CLIENTID_BASE := android-lenovo

# Use the latest approved GMS identifiers
PRODUCT_BUILD_PROP_OVERRIDES += \
    PRODUCT_NAME="YT-X703F" \
    BUILD_FINGERPRINT="Lenovo/YT-X703F/YT-X703F:7.1.1/S100/YT-X703F_S000963_171111_ROW:user/release-keys" \
    PRIVATE_BUILD_DESC="msm8952_64-user 7.1.1 NMF26F 18 release-keys"
