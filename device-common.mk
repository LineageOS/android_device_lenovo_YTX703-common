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
    gps.msm8952 \
    libgps.utils \
    libloc_core \
    libloc_eng \
    libcurl \

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

# Power
PRODUCT_PACKAGES += \
    power.msm8952 \

# Qualcomm dependencies
PRODUCT_PACKAGES += \
    libtinyxml \
    libxml2 \

# Ramdisk
PRODUCT_PACKAGES += \
    fstab.qcom \
    init.qcom.bt.sh \
    init.qcom.post_boot.sh \
    init.qcom.power.rc \
    init.qcom.radio.sh \
    init.qcom.rc \
    init.qcom.usb.rc \
    ueventd.qcom.rc \

# Sensors
PRODUCT_PACKAGES += \
    sensors.msm8952 \

# TimeKeep
PRODUCT_PACKAGES += \
    timekeep \
    TimeKeep \

# Wifi
PRODUCT_PACKAGES += \
    libqsap_sdk \
    libQWiFiSoftApCfg \
    libwpa_client \
    wificond \
    wifilogd \
    hostapd \
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
    $(permission):$(addprefix system/etc/permissions/, $(notdir $(permission))) )

# Standard permissions
PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.hardware.audio.low_latency.xml:system/etc/permissions/android.hardware.audio.low_latency.xml \
    frameworks/native/data/etc/android.hardware.bluetooth_le.xml:system/etc/permissions/android.hardware.bluetooth_le.xml \
    frameworks/native/data/etc/android.hardware.bluetooth.xml:system/etc/permissions/android.hardware.bluetooth.xml \
    frameworks/native/data/etc/android.hardware.camera.autofocus.xml:system/etc/permissions/android.hardware.camera.autofocus.xml \
    frameworks/native/data/etc/android.hardware.camera.front.xml:system/etc/permissions/android.hardware.camera.front.xml \
    frameworks/native/data/etc/android.hardware.camera.full.xml:system/etc/permissions/android.hardware.camera.full.xml \
    frameworks/native/data/etc/android.hardware.camera.raw.xml:system/etc/permissions/android.hardware.camera.raw.xml \
    frameworks/native/data/etc/android.hardware.location.gps.xml:system/etc/permissions/android.hardware.location.gps.xml \
    frameworks/native/data/etc/android.hardware.opengles.aep.xml:system/etc/permissions/android.hardware.opengles.aep.xml \
    frameworks/native/data/etc/android.hardware.sensor.accelerometer.xml:system/etc/permissions/android.hardware.sensor.accelerometer.xml \
    frameworks/native/data/etc/android.hardware.sensor.compass.xml:system/etc/permissions/android.hardware.sensor.compass.xml \
    frameworks/native/data/etc/android.hardware.sensor.gyroscope.xml:system/etc/permissions/android.hardware.sensor.gyroscope.xml \
    frameworks/native/data/etc/android.hardware.sensor.light.xml:system/etc/permissions/android.hardware.sensor.light.xml \
    frameworks/native/data/etc/android.hardware.touchscreen.multitouch.jazzhand.xml:system/etc/permissions/android.hardware.touchscreen.multitouch.jazzhand.xml \
    frameworks/native/data/etc/android.hardware.usb.accessory.xml:system/etc/permissions/android.hardware.usb.accessory.xml \
    frameworks/native/data/etc/android.hardware.usb.host.xml:system/etc/permissions/android.hardware.usb.host.xml \
    frameworks/native/data/etc/android.hardware.vulkan.level-0.xml:system/etc/permissions/android.hardware.vulkan.level-0.xml \
    frameworks/native/data/etc/android.hardware.vulkan.version-1_0_3.xml:system/etc/permissions/android.hardware.vulkan.version-1_0_3.xml \
    frameworks/native/data/etc/android.hardware.wifi.xml:system/etc/permissions/android.hardware.wifi.xml \
    frameworks/native/data/etc/android.hardware.wifi.direct.xml:system/etc/permissions/android.hardware.wifi.direct.xml \
    frameworks/native/data/etc/android.software.freeform_window_management.xml:system/etc/permissions/android.software.freeform_window_management.xml \
    frameworks/native/data/etc/android.software.midi.xml:system/etc/permissions/android.software.midi.xml \
    frameworks/native/data/etc/android.software.sip.voip.xml:system/etc/permissions/android.software.sip.voip.xml \
    frameworks/native/data/etc/handheld_core_hardware.xml:system/etc/permissions/handheld_core_hardware.xml \

PRODUCT_COPY_FILES += \
    external/ant-wireless/antradio-library/com.dsi.ant.antradio_library.xml:system/etc/permissions/com.dsi.ant.antradio_library.xml

# Device-specific audio configs
PRODUCT_COPY_FILES += $(foreach audio_config, $(wildcard $(LOCAL_PATH)/configs/audio/*), \
    $(audio_config):$(addprefix system/etc/, $(notdir $(audio_config))) )

# Standard audio configs
PRODUCT_COPY_FILES += \
    frameworks/av/services/audiopolicy/config/a2dp_audio_policy_configuration.xml:system/etc/a2dp_audio_policy_configuration.xml \
    frameworks/av/services/audiopolicy/config/audio_policy_volumes.xml:system/etc/audio_policy_volumes.xml \
    frameworks/av/services/audiopolicy/config/default_volume_tables.xml:system/etc/default_volume_tables.xml \
    frameworks/av/services/audiopolicy/config/r_submix_audio_policy_configuration.xml:system/etc/r_submix_audio_policy_configuration.xml \
    frameworks/av/services/audiopolicy/config/usb_audio_policy_configuration.xml:system/etc/usb_audio_policy_configuration.xml \

# IPC router config
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/configs/sec_config:system/etc/sec_config

# Device-specific codec configuration
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/configs/media/media_codecs_8956_v1.xml:system/etc/media_codecs.xml \
    $(LOCAL_PATH)/configs/media/media_codecs_performance_8956_v1.xml:system/etc/media_codecs_performance.xml \
    $(LOCAL_PATH)/configs/media/media_profiles_8956.xml:system/etc/media_profiles.xml \

# Standard (software) codec configuration
PRODUCT_COPY_FILES += \
    frameworks/av/media/libstagefright/data/media_codecs_google_audio.xml:system/etc/media_codecs_google_audio.xml \
    frameworks/av/media/libstagefright/data/media_codecs_google_telephony.xml:system/etc/media_codecs_google_telephony.xml \
    frameworks/av/media/libstagefright/data/media_codecs_google_video.xml:system/etc/media_codecs_google_video.xml \

# Sensors configuration files
PRODUCT_COPY_FILES += $(foreach sensor_config, $(wildcard $(LOCAL_PATH)/configs/sensors/*), \
    $(sensor_config):$(addprefix system/etc/sensors/, $(notdir $(sensor_config))) )

# Wi-Fi and WCNSS configuration files
PRODUCT_COPY_FILES += $(foreach wifi_config, $(wildcard $(LOCAL_PATH)/configs/wifi/*), \
    $(wifi_config):$(addprefix system/etc/wifi/, $(notdir $(wifi_config))) ) \
    $(LOCAL_PATH)/configs/hostapd_default.conf:system/etc/hostapd/hostapd_default.conf \

# Cellular data configuration files
PRODUCT_COPY_FILES += $(foreach data_config, $(wildcard $(LOCAL_PATH)/configs/data/*), \
    $(data_config):$(addprefix system/etc/data/, $(notdir $(data_config))) )

# GPS configuration files
PRODUCT_COPY_FILES += $(foreach gps_config, $(wildcard $(LOCAL_PATH)/configs/gps/*), \
    $(gps_config):$(addprefix system/etc/, $(notdir $(gps_config))) )

# Thermal engine configuration file
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/configs/thermal-engine.conf:system/etc/thermal-engine.conf \

# Profiles for perfd
PRODUCT_COPY_FILES += $(foreach perf_profile, $(wildcard $(LOCAL_PATH)/configs/perf-profiles/*), \
    $(perf_profile):$(addprefix system/etc/, $(notdir $(perf_profile))) )

# Configs for dpm and nsrm
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/configs/dpm/dpm.conf:system/etc/dpm/dpm.conf \
    $(LOCAL_PATH)/configs/dpm/nsrm/NsrmConfiguration.xml:system/etc/dpm/nsrm/NsrmConfiguration.xml \

# Configs for msm_irqbalance
PRODUCT_COPY_FILES += $(foreach irqbalance_config, $(wildcard $(LOCAL_PATH)/configs/irqbalance/*), \
    $(irqbalance_config):$(addprefix system/vendor/etc/, $(notdir $(irqbalance_config))) )

# Vendor-provided service definitions (executed by init scripts)
PRODUCT_COPY_FILES += $(foreach service, $(wildcard $(LOCAL_PATH)/configs/init/*), \
    $(service):$(addprefix system/etc/init/, $(notdir $(service))) )

