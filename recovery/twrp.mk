TW_USE_TOOLBOX := true
TW_EXCLUDE_TWRPAPP := true
TW_THEME := landscape_hdpi
TW_TARGET_USES_QCOM_BSP := true
TW_NEW_ION_HEAP := true
# If you change TW_HWROTATION, you'll have to either use:
#   RECOVERY_TOUCHSCREEN_SWAP_XY := true
#   RECOVERY_TOUCHSCREEN_FLIP_X := true
# Or make the same change in the DTS (preferable):
#   synaptics,swap-axes;
#   synaptics,y-flip;
TW_HWROTATION := 90
# Encryption support
TW_INCLUDE_CRYPTO := true
# Asian region languages
TW_EXTRA_LANGUAGES := true
TW_DEFAULT_BRIGHTNESS := 128

# Unshare the TWRP-specific recovery/root/etc/twrp.fstab
# and the AOSP rootdir/etc/fstab.qcom files. TWRP will give
# precedence to reading its own file if present.

# $(TARGET_RECOVERY_DEVICE_DIRS) are copied directly
# to $(TARGET_RECOVERY_ROOT_OUT) with cp -rf.
TARGET_RECOVERY_DEVICE_DIRS += $(DEVICE_PATH)
TARGET_RECOVERY_FSTAB := $(DEVICE_PATH)/rootdir/etc/fstab.qcom

TARGET_USERIMAGES_USE_EXT4 := true
TARGET_USERIMAGES_USE_F2FS := true

# For USB OTG
TARGET_USE_CUSTOM_LUN_FILE_PATH := "/sys/devices/platform/msm_hsusb/gadget/lun0/file"

TARGET_RECOVERY_QCOM_RTC_FIX := true

