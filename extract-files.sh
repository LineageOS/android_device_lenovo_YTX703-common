#!/bin/bash
#
# Copyright (C) 2016 The CyanogenMod Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

set -e

# Load extractutils and do some sanity checks
MY_DIR=$(cd "$(dirname "${BASH_SOURCE[0]}" )" && pwd)
if [[ ! -d "${MY_DIR}" ]]; then MY_DIR="${PWD}"; fi

LINEAGE_ROOT="${MY_DIR}"/../../..

HELPER="${LINEAGE_ROOT}/vendor/lineage/build/tools/extract_utils.sh"
if [ ! -f "${HELPER}" ]; then
	echo "Unable to find helper script at $HELPER"
	exit 1
fi
. "${HELPER}"

while getopts ":nhd:" options
do
	case $options in
	n ) CLEANUP="false" ;;
	d ) SRC=$OPTARG ;;
	x ) DEVICE_ONLY=1 ;;
	h ) echo "Usage: `basename $0` [OPTIONS] "
	    echo "  -n  No cleanup"
	    echo "  -d  Fetch blob from filesystem"
	    echo "  -x  Only device specific extraction"
	    echo "  -h  Show this help"
	    exit ;;
	* ) ;;
	esac
done

if [ -z $SRC ]; then
	SRC=adb
fi

# Initialize the helper for YTX703-common
if [ -z "${DEVICE_ONLY}" ]; then
	(
	setup_vendor "${DEVICE_COMMON}" "${VENDOR}" "${LINEAGE_ROOT}" true "${CLEANUP}"
	extract "${MY_DIR}/proprietary-files.txt" "${SRC}"
	if [ -s "${MY_DIR}/proprietary-files-twrp.txt" ]; then
		extract "${MY_DIR}/proprietary-files-twrp.txt" "${SRC}"
	fi
	)
fi
	
if [ -s "${MY_DIR}/${DEVICE}/proprietary-files.txt" ]; then
	# Reinitialize the helper for YTX703-common/${device}
	(
	setup_vendor "${DEVICE}" "${VENDOR}/${DEVICE_COMMON}" "${LINEAGE_ROOT}" false "${CLEANUP}"
	extract "${MY_DIR}/${DEVICE}/proprietary-files.txt" "${SRC}"
	if [ -s "${MY_DIR}/${DEVICE}/proprietary-files-twrp.txt" ]; then
		extract "${MY_DIR}/${DEVICE}/proprietary-files-twrp.txt" "$SRC"
	fi
	)
fi

"${MY_DIR}/setup-makefiles.sh" "${CLEANUP}"
