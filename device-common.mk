#
# Copyright (C) 2016 The CyanogenMod Project
# Copyright (C) 2017 The LineageOS Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

# inherit from the proprietary version
$(call inherit-product, vendor/lenovo/YTX703-common/YTX703-common-vendor.mk)

# Overlays
DEVICE_PACKAGE_OVERLAYS += $(LOCAL_PATH)/overlay

# Screen density
PRODUCT_AAPT_CONFIG := normal large xlarge
PRODUCT_AAPT_PREF_CONFIG := xhdpi

# Needed by vendor/cm/bootanimation/
TARGET_SCREEN_WIDTH  := 2560
TARGET_SCREEN_HEIGHT := 1600

# Device characteristics
PRODUCT_CHARACTERISTICS := tablet

$(call inherit-product-if-exists, frameworks/native/build/tablet-10in-xhdpi-2048-dalvik-heap.mk)

#
# PRODUCT_PACKAGES rules
#

# ANT+
PRODUCT_PACKAGES += \
    AntHalService \
    com.dsi.ant.antradio_library \
    libantradio \

# Audio
PRODUCT_PACKAGES += \
    audiod \
    audio.a2dp.default \
    audio.primary.msm8952 \
    audio.r_submix.default \
    audio.usb.default \
    libaudio-resampler \
    libaudioroute \
    libqcompostprocbundle \
    libqcomvisualizer \
    libqcomvoiceprocessing \
    libtinycompress \
    tinymix

# Bluetooth
PRODUCT_PACKAGES += \
    libbt-vendor

# Camera
PRODUCT_PACKAGES += \
    Snap \
    camera.msm8952 \
    libmm-qcamera \

# Keystore
PRODUCT_PACKAGES += \
    keystore.msm8952 \

# Display
PRODUCT_PACKAGES += \
    copybit.msm8952 \
    gralloc.msm8952 \
    hwcomposer.msm8952 \
    memtrack.msm8952 \
    liboverlay \

# For android_filesystem_config.h
PRODUCT_PACKAGES += \
    fs_config_files \

# GPS
PRODUCT_PACKAGES += \
    libcurl \
    libgnss \
    libgnsspps

PRODUCT_PACKAGES += \
    android.hardware.gnss@1.0-impl-qti \
    android.hardware.gnss@1.0-service-qti

# IPv6
PRODUCT_PACKAGES += \
    ebtables \
    ethertypes \
    libebtc \

# Lights
PRODUCT_PACKAGES += \
    lights.msm8952 \

# OMX
PRODUCT_PACKAGES += \
    libc2dcolorconvert \
    libextmedia_jni \
    libOmxAacEnc \
    libOmxAmrEnc \
    libOmxCore \
    libOmxEvrcEnc \
    libOmxQcelp13Enc \
    libOmxSwVencHevc \
    libOmxVdec \
    libOmxVenc \
    libstagefrighthw \

# Qualcomm dependencies
PRODUCT_PACKAGES += \
    libtinyxml \
    libxml2 \

# Ramdisk
PRODUCT_PACKAGES += \
    fstab.qcom \
    init.qcom.power.rc \
    init.qcom.radio.sh \
    init.qcom.rc \
    init.qcom.usb.rc \
    ueventd.qcom.rc \

# Libshims
PRODUCT_PACKAGES += \
    libshims_sensor

# Sensors
PRODUCT_PACKAGES += \
    sensors.msm8952 \

# TimeKeep
PRODUCT_PACKAGES += \
    timekeep \
    TimeKeep \

# Seccomp policy
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/configs/seccomp_policy/mediacodec-seccomp.policy:$(TARGET_COPY_OUT_VENDOR)/etc/seccomp_policy/mediacodec.policy \
    $(LOCAL_PATH)/configs/seccomp_policy/mediaextractor-seccomp.policy:$(TARGET_COPY_OUT_VENDOR)/etc/seccomp_policy/mediaextractor.policy

# Thermal
PRODUCT_PACKAGES += \
    thermal.msm8952

# Wifi
PRODUCT_PACKAGES += \
    libqsap_sdk \
    libQWiFiSoftApCfg \
    libwpa_client \
    wificond \
    wifilogd \
    hostapd \
    libwifi-hal-qcom \
    wcnss_service \
    libwcnss_qmi \
    wpa_supplicant \
    wpa_supplicant.conf \

# data-ipa-cfg-mgr
PRODUCT_PACKAGES += \
    ipacm \
    IPACM_cfg.xml \
    libipanat \

#
# PRODUCT_COPY_FILES rules
#

# Device-specific permissions
PRODUCT_COPY_FILES += $(foreach permission, $(wildcard $(LOCAL_PATH)/configs/permissions/*), \
    $(permission):$(addprefix $(TARGET_COPY_OUT_VENDOR)/etc/permissions/, $(notdir $(permission))) )

# Standard permissions
PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.hardware.audio.low_latency.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.audio.low_latency.xml \
    frameworks/native/data/etc/android.hardware.bluetooth_le.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.bluetooth_le.xml \
    frameworks/native/data/etc/android.hardware.bluetooth.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.bluetooth.xml \
    frameworks/native/data/etc/android.hardware.camera.autofocus.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.camera.autofocus.xml \
    frameworks/native/data/etc/android.hardware.camera.front.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.camera.front.xml \
    frameworks/native/data/etc/android.hardware.camera.full.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.camera.full.xml \
    frameworks/native/data/etc/android.hardware.camera.raw.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.camera.raw.xml \
    frameworks/native/data/etc/android.hardware.location.gps.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.location.gps.xml \
    frameworks/native/data/etc/android.hardware.opengles.aep.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.opengles.aep.xml \
    frameworks/native/data/etc/android.hardware.sensor.accelerometer.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.sensor.accelerometer.xml \
    frameworks/native/data/etc/android.hardware.sensor.compass.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.sensor.compass.xml \
    frameworks/native/data/etc/android.hardware.sensor.gyroscope.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.sensor.gyroscope.xml \
    frameworks/native/data/etc/android.hardware.sensor.light.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.sensor.light.xml \
    frameworks/native/data/etc/android.hardware.touchscreen.multitouch.jazzhand.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.touchscreen.multitouch.jazzhand.xml \
    frameworks/native/data/etc/android.hardware.usb.accessory.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.usb.accessory.xml \
    frameworks/native/data/etc/android.hardware.usb.host.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.usb.host.xml \
    frameworks/native/data/etc/android.hardware.vulkan.level-0.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.vulkan.level-0.xml \
    frameworks/native/data/etc/android.hardware.vulkan.version-1_0_3.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.vulkan.version-1_0_3.xml \
    frameworks/native/data/etc/android.hardware.wifi.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.wifi.xml \
    frameworks/native/data/etc/android.hardware.wifi.direct.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.wifi.direct.xml \
    frameworks/native/data/etc/android.software.freeform_window_management.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.software.freeform_window_management.xml \
    frameworks/native/data/etc/android.software.midi.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.software.midi.xml \
    frameworks/native/data/etc/android.software.sip.voip.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.software.sip.voip.xml \
    frameworks/native/data/etc/handheld_core_hardware.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/handheld_core_hardware.xml \

PRODUCT_COPY_FILES += \
    external/ant-wireless/antradio-library/com.dsi.ant.antradio_library.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/com.dsi.ant.antradio_library.xml

# Device-specific audio configs
PRODUCT_COPY_FILES += $(foreach audio_config, $(wildcard $(LOCAL_PATH)/configs/audio/*), \
    $(audio_config):$(addprefix $(TARGET_COPY_OUT_VENDOR)/etc/, $(notdir $(audio_config))) )

# Standard audio configs
PRODUCT_COPY_FILES += \
    frameworks/av/services/audiopolicy/config/a2dp_audio_policy_configuration.xml:$(TARGET_COPY_OUT_VENDOR)/etc/a2dp_audio_policy_configuration.xml \
    frameworks/av/services/audiopolicy/config/audio_policy_volumes.xml:$(TARGET_COPY_OUT_VENDOR)/etc/audio_policy_volumes.xml \
    frameworks/av/services/audiopolicy/config/default_volume_tables.xml:$(TARGET_COPY_OUT_VENDOR)/etc/default_volume_tables.xml \
    frameworks/av/services/audiopolicy/config/r_submix_audio_policy_configuration.xml:$(TARGET_COPY_OUT_VENDOR)/etc/r_submix_audio_policy_configuration.xml \
    frameworks/av/services/audiopolicy/config/usb_audio_policy_configuration.xml:$(TARGET_COPY_OUT_VENDOR)/etc/usb_audio_policy_configuration.xml \

# IPC router config
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/configs/sec_config:$(TARGET_COPY_OUT_VENDOR)/etc/sec_config

# Device-specific codec configuration
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/configs/media/media_codecs_8956_v1.xml:$(TARGET_COPY_OUT_VENDOR)/etc/media_codecs.xml \
    $(LOCAL_PATH)/configs/media/media_codecs_performance_8956_v1.xml:$(TARGET_COPY_OUT_VENDOR)/etc/media_codecs_performance.xml \
    $(LOCAL_PATH)/configs/media/media_profiles_V1_0.xml:$(TARGET_COPY_OUT_VENDOR)/etc/media_profiles_V1_0.xml \

# Standard (software) codec configuration
PRODUCT_COPY_FILES += \
    frameworks/av/media/libstagefright/data/media_codecs_google_audio.xml:$(TARGET_COPY_OUT_VENDOR)/etc/media_codecs_google_audio.xml \
    frameworks/av/media/libstagefright/data/media_codecs_google_telephony.xml:$(TARGET_COPY_OUT_VENDOR)/etc/media_codecs_google_telephony.xml \
    frameworks/av/media/libstagefright/data/media_codecs_google_video.xml:$(TARGET_COPY_OUT_VENDOR)/etc/media_codecs_google_video.xml \

# Sensors configuration files
PRODUCT_COPY_FILES += $(foreach sensor_config, $(wildcard $(LOCAL_PATH)/configs/sensors/*), \
    $(sensor_config):$(addprefix $(TARGET_COPY_OUT_VENDOR)/etc/sensors/, $(notdir $(sensor_config))) )

# Wi-Fi and WCNSS configuration files
PRODUCT_COPY_FILES += $(foreach wifi_config, $(wildcard $(LOCAL_PATH)/configs/wifi/*), \
    $(wifi_config):$(addprefix $(TARGET_COPY_OUT_VENDOR)/etc/wifi/, $(notdir $(wifi_config))) ) \
    $(LOCAL_PATH)/configs/hostapd_default.conf:$(TARGET_COPY_OUT_VENDOR)/etc/hostapd/hostapd_default.conf \

# Cellular data configuration files
PRODUCT_COPY_FILES += $(foreach data_config, $(wildcard $(LOCAL_PATH)/configs/data/*), \
    $(data_config):$(addprefix $(TARGET_COPY_OUT_VENDOR)/etc/data/, $(notdir $(data_config))) )

# GPS configuration files
PRODUCT_COPY_FILES += $(foreach gps_config, $(wildcard $(LOCAL_PATH)/configs/gps/*), \
    $(gps_config):$(addprefix $(TARGET_COPY_OUT_VENDOR)/etc/, $(notdir $(gps_config))) )

# Thermal engine configuration file
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/configs/thermal-engine.conf:$(TARGET_COPY_OUT_VENDOR)/etc/thermal-engine.conf \

# Profiles for perfd
PRODUCT_COPY_FILES += $(foreach perf_profile, $(wildcard $(LOCAL_PATH)/configs/perf-profiles/*), \
    $(perf_profile):$(addprefix $(TARGET_COPY_OUT_VENDOR)/etc/perf/, $(notdir $(perf_profile))) )

PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/configs/perfd/powerhint.xml:$(TARGET_COPY_OUT_VENDOR)/etc/powerhint.xml

# Configs for dpm and nsrm
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/configs/dpm/dpm.conf:$(TARGET_COPY_OUT_VENDOR)/etc/dpm/dpm.conf \
    $(LOCAL_PATH)/configs/dpm/nsrm/NsrmConfiguration.xml:$(TARGET_COPY_OUT_VENDOR)/etc/dpm/nsrm/NsrmConfiguration.xml \

# Configs for msm_irqbalance
PRODUCT_COPY_FILES += $(foreach irqbalance_config, $(wildcard $(LOCAL_PATH)/configs/irqbalance/*), \
    $(irqbalance_config):$(addprefix $(TARGET_COPY_OUT_VENDOR)/etc/, $(notdir $(irqbalance_config))) )

# Vendor-provided service definitions (executed by init scripts)
PRODUCT_COPY_FILES += $(foreach service, $(wildcard $(LOCAL_PATH)/configs/init/*), \
    $(service):$(addprefix $(TARGET_COPY_OUT_VENDOR)/etc/init/, $(notdir $(service))) )

#
# Ramdisk symlinks.
# Parsed by system/core/rootdir/Android.mk
#

# Create RFS MSM ADSP folder structure
BOARD_ROOT_EXTRA_SYMLINKS += \
    /data/tombstones/lpass:rfs/msm/adsp/ramdumps \
    /persist/rfs/msm/adsp:rfs/msm/adsp/readwrite \
    /persist/rfs/shared:rfs/msm/adsp/shared \
    /persist/hlos_rfs/shared:rfs/msm/adsp/hlos \
    /vendor/firmware:rfs/msm/adsp/readonly/firmware \

# Create RFS MSM MPSS folder structure
BOARD_ROOT_EXTRA_SYMLINKS += \
    /data/tombstones/modem:rfs/msm/mpss/ramdumps \
    /persist/rfs/msm/mpss:rfs/msm/mpss/readwrite \
    /persist/rfs/shared:rfs/msm/mpss/shared \
    /persist/hlos_rfs/shared:rfs/msm/mpss/hlos \
    /vendor/firmware:rfs/msm/mpss/readonly/firmware \

#
# System partition symlinks.
# Parsed by vendor/cm/build/tasks/target_symlinks.mk
#

# Discussion on files required by the WCN36xx WLAN driver (drivers/staging/prima).
# The wcnss_service userspace application triggers an ancilliary kernel driver
# by writing to /dev/wcnss_ctrl.
# This triggers the main driver to load, and as it does that (hdd_wlan_startup),
# it requests 3 firmware files from userspace:
#   * /vendor/firmware/wlan/prima/WCNSS_qcom_cfg.ini
#   * /vendor/firmware/wlan/prima/WCNSS_wlan_dictionary.dat
#   * /vendor/firmware/wlan/prima/WCNSS_qcom_wlan_nv.bin
# In stock, Lenovo places the firmware/config files in /persist, and the
# firmware folder is a symlink to that.
# We do not want to use Lenovo's firmware files from /persist, as they may be
# out of sync with the prima WLAN driver, that is receiving continuous updates.
# For this reason, we ship the firmware files (in the board repo,
# under configs/wifi; in the target rootfs, under /vendor/etc/wifi) and in
# /vendor/firmware/wlan/prima/ we create symbolic links to those.
#
# Comments on other actions done by wcnss_service:
#   * it has code for copying WCNSS_qcom_cfg.ini et.al. from /vendor/etc/wifi
#     to /data/misc/wifi. This serves absolutely no purpose to us.
#   * it has code for creating /persist/WCNSS_qcom_wlan_nv.bin from a file in
#     /system/etc/wifi/nvbin/ that matches the pattern of
#     msm8952_${soc_id}_0x${platform_subtype_id}_0x${major_hwver}_${minor_hwver}_nv.bin
#     This code is under conditional compilation with DYNAMIC_NV, which is not
#     defined anywhere in the open source release. Presumably this is how the
#     firmware in /persist was generated by our OEM in the first place.
#   * It calls into proprietary QMI/QCCI services through an ancilliary library
#     (libwcnss_qmi) in order to retrieve the correct MAC address. This is the
#     only other useful purpose we have for the service.
#   * It performs a so-called "calibration" by opening a
#     /data/misc/wifi/WCNSS_qcom_wlan_cal.bin file and writing it to
#     /dev/wcnss_wlan.
#     This operation has a very high chance to serving no purpose at all and
#     not being in fact used by anybody, since on cleanup, it attempts to close
#     the file "WCNSS_CAL_FILE" instead of the actual macro that lies behind it
#     ("/data/misc/wifi/WCNSS_qcom_wlan_cal.bin").
#
BOARD_VENDOR_EXTRA_SYMLINKS += \
    /vendor/etc/wifi/WCNSS_qcom_cfg.ini:firmware/wlan/prima/WCNSS_qcom_cfg.ini \
    /vendor/etc/wifi/WCNSS_wlan_dictionary.dat:firmware/wlan/prima/WCNSS_wlan_dictionary.dat \
    /vendor/etc/wifi/WCNSS_qcom_wlan_nv.bin:firmware/wlan/prima/WCNSS_qcom_wlan_nv.bin

# Create a link for acdbdata which is needed for the hacked libacdbloader.so library,
# which is modified to load its configuration files from /vendor. Due the fact,
# that it is initially loads the data from /etc/acdbdata the string provides
# not more space than /vendor/etc/a which is linked here to the right folder.
BOARD_VENDOR_EXTRA_SYMLINKS += \
    /vendor/etc/acdbdata:etc/a

# Create a link for sensors.qcom which expects the default sensor configuration at /etc/sensors
# To be able to move this file to /vendor a link /vendor/snsc is created, which points to
# /vendor/etc/sensors
BOARD_VENDOR_EXTRA_SYMLINKS += \
    /vendor/etc/sensors:snsc

# HIDL
$(call inherit-product, $(LOCAL_PATH)/common-treble.mk)
DEVICE_MANIFEST_FILE := $(LOCAL_PATH)/manifest.xml
DEVICE_MATRIX_FILE   := $(LOCAL_PATH)/compatibility_matrix.xml
