#!/bin/bash
#
# Copyright (C) 2016 The CyanogenMod Project
# Copyright (C) 2017-2020 The LineageOS Project
#
# SPDX-License-Identifier: Apache-2.0
#

# Sourced by the common device repo when extracting device-specific blobs
function blob_fixup() {
	case "${1}" in
	vendor/bin/netmgrd)
		sed -i -e 's|system/etc|vendor/etc|g' "${2}"
		# Replace AID 2950 with 2901 (see commit eb1abadf)
		sed -i -e "s|\xBC\x0B\x00\x00\xBB\x0B\x00\x00\x86\x0B\x00\x00\xE8\x03\x00\x00|\xBC\x0B\x00\x00\x55\x0B\x00\x00\x86\x0B\x00\x00\xE8\x03\x00\x00|g" "${2}"
		;;
	vendor/bin/qmuxd)
		sed -i -e 's|system/etc|vendor/etc|g' "${2}"
		;;
	vendor/lib/libdsi_netctrl.so | vendor/lib64/libdsi_netctrl.so)
		sed -i -e 's|system/etc|vendor/etc|g' "${2}"
		;;
	vendor/lib/libril-qc-qmi-1.so | vendor/lib64/libril-qc-qmi-1.so)
		sed -i -e 's|system/etc|vendor/etc|g' "${2}"
		;;
	vendor/lib/libsettings.so | vendor/lib64/libsettings.so)
		patchelf --replace-needed "libprotobuf-cpp-full.so" "libprotobuf-cpp-full-v28.so" "${2}"
		;;
	esac
}

# If we're being sourced by the common script that we called,
# stop right here. No need to go down the rabbit hole.
if [ "${BASH_SOURCE[0]}" != "${0}" ]; then
	return
fi

# Normal execution path when ran interactively from shell
set -e -u -o pipefail

# Required!
export DEVICE=YTX703L
export DEVICE_COMMON=YTX703-common
export VENDOR=lenovo

MY_DIR=$(dirname $(readlink -f "${BASH_SOURCE[0]}"))

${MY_DIR}/../extract-files.sh "$@"
