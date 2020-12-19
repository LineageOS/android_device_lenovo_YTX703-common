#!/bin/bash
#
# Copyright (C) 2016 The CyanogenMod Project
# Copyright (C) 2017-2020 The LineageOS Project
#
# SPDX-License-Identifier: Apache-2.0
#

set -e -u -o pipefail

# Required!
export DEVICE=YTX703L
export DEVICE_COMMON=YTX703-common
export VENDOR=lenovo

MY_DIR=$(cd "$(dirname "${BASH_SOURCE[0]}" )" && pwd)

${MY_DIR}/../setup-makefiles.sh "$@"
