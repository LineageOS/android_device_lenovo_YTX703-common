#!/bin/bash
#
# Copyright (C) 2016 The CyanogenMod Project
# Copyright (C) 2017-2020 The LineageOS Project
#
# SPDX-License-Identifier: Apache-2.0
#

# If we're being sourced by the common script that we called,
# stop right here. No need to go down the rabbit hole.
if [ "${BASH_SOURCE[0]}" != "${0}" ]; then
	return
fi

set -e -u -o pipefail

# Required!
export DEVICE=YTX703F
export DEVICE_COMMON=YTX703-common
export VENDOR=lenovo

MY_DIR=$(dirname $(readlink -f "${BASH_SOURCE[0]}"))

${MY_DIR}/../extract-files.sh "$@"
