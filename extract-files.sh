#!/bin/bash
#
# Copyright (C) 2017-2018 The LineageOS Project
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
MY_DIR=$(dirname $(readlink -f "${BASH_SOURCE[0]}"))
LINEAGE_ROOT=$(readlink -f "${MY_DIR}/../../..")

HELPER="${LINEAGE_ROOT}/vendor/lineage/build/tools/extract_utils.sh"
if [ ! -f "${HELPER}" ]; then
	echo "Unable to find helper script at $HELPER"
	exit 1
fi
source "${HELPER}"

# Default to sanitizing the vendor folder before extraction
CLEAN_VENDOR=true
KANG=

while [ "$#" -gt 0 ]; do
	case "$1" in
	-n|--no-cleanup)
		CLEAN_VENDOR=false
		;;
	-k|--kang)
		KANG="--kang"
		;;
	-s|--section)
		SECTION="$2"; shift
		CLEAN_VENDOR=false
		;;
	*)
		SRC="$1"
		;;
	esac
	shift
done

if [ -z "$SRC" ]; then
	SRC=adb
fi

shopt -s extglob

function blob_fixup() {
	case "${1}" in
	vendor/bin/cnd)
		sed -i -e 's|libprotobuf-cpp-lite\.so|libprotobuf-cpp-Hlte.so|g' "${2}"
		;;
	vendor/bin/sensors.qcom)
		# See commit 45e37256 for details
		sed -i -e 's|sns\.reg|sns.los|g' "${2}"
		sed -i -e 's|etc/sensors|vendor/snsc|g' "${2}"
		;;
	vendor/bin/thermal-engine)
		sed -i -e 's|system/etc|vendor/etc|g' "${2}"
		;;
	vendor/bin/xtra-daemon)
		sed -i -e 's|system/priv-app|vendor/priv-app|g' "${2}"
		;;
	vendor/lib/hw/sound_trigger.primary.msm8952.so)
		sed -i -e 's|system/lib|vendor/lib|g' "${2}"
		sed -i -e 's|system/etc|vendor/etc|g' "${2}"
		sed -i -e 's|system/lib/hw|vendor/lib/hw|g' "${2}"
		sed -i -e 's|etc/acdbdata|vendor/etc/a|g' "${2}"
		;;
	vendor/lib/mediadrm/libwvdrmengine.so)
		sed -i -e 's|libprotobuf-cpp-lite\.so|libprotobuf-cpp-Hlte.so|g' "${2}"
		;;
	vendor/lib/soundfx/libqcbassboost.so)
		sed -i -e 's|system/etc|vendor/etc|g' "${2}"
		sed -i -e 's|system/lib/hw|vendor/lib/hw|g' "${2}"
		sed -i -e 's|etc/acdbdata|vendor/etc/a|g' "${2}"
		;;
	vendor/lib/soundfx/libqcreverb.so)
		sed -i -e 's|system/etc|vendor/etc|g' "${2}"
		sed -i -e 's|system/lib/hw|vendor/lib/hw|g' "${2}"
		sed -i -e 's|etc/acdbdata|vendor/etc/a|g' "${2}"
		;;
	vendor/lib/soundfx/libqcvirt.so)
		sed -i -e 's|system/etc|vendor/etc|g' "${2}"
		sed -i -e 's|system/lib/hw|vendor/lib/hw|g' "${2}"
		sed -i -e 's|etc/acdbdata|vendor/etc/a|g' "${2}"
		;;
	vendor/lib?(64)/libacdb-fts.so)
		sed -i -e 's|system/etc|vendor/etc|g' "${2}"
		sed -i -e 's|system/lib/hw|vendor/lib/hw|g' "${2}"
		sed -i -e 's|etc/acdbdata|vendor/etc/a|g' "${2}"
		;;
	vendor/lib?(64)/libacdbloader.so)
		sed -i -e 's|system/etc|vendor/etc|g' "${2}"
		sed -i -e 's|system/lib/hw|vendor/lib/hw|g' "${2}"
		sed -i -e 's|etc/acdbdata|vendor/etc/a|g' "${2}"
		;;
	vendor/lib?(64)/libacdbmapper.so)
		sed -i -e 's|system/etc|vendor/etc|g' "${2}"
		sed -i -e 's|system/lib/hw|vendor/lib/hw|g' "${2}"
		sed -i -e 's|etc/acdbdata|vendor/etc/a|g' "${2}"
		;;
	vendor/lib?(64)/libacdbrtac.so)
		sed -i -e 's|system/etc|vendor/etc|g' "${2}"
		sed -i -e 's|system/lib/hw|vendor/lib/hw|g' "${2}"
		sed -i -e 's|etc/acdbdata|vendor/etc/a|g' "${2}"
		;;
	vendor/lib?(64)/libadiertac.so)
		sed -i -e 's|system/etc|vendor/etc|g' "${2}"
		sed -i -e 's|system/lib/hw|vendor/lib/hw|g' "${2}"
		sed -i -e 's|etc/acdbdata|vendor/etc/a|g' "${2}"
		;;
	vendor/lib/libadm.so)
		sed -i -e 's|system/etc|vendor/etc|g' "${2}"
		sed -i -e 's|system/lib/hw|vendor/lib/hw|g' "${2}"
		sed -i -e 's|etc/acdbdata|vendor/etc/a|g' "${2}"
		;;
	vendor/lib/libadpcmdec.so)
		sed -i -e 's|system/etc|vendor/etc|g' "${2}"
		sed -i -e 's|system/lib/hw|vendor/lib/hw|g' "${2}"
		sed -i -e 's|etc/acdbdata|vendor/etc/a|g' "${2}"
		;;
	vendor/lib?(64)/libadsprpc.so)
		sed -i -e 's|system/lib|vendor/lib|g' "${2}"
		;;
	vendor/lib?(64)/libaudcal.so)
		sed -i -e 's|system/etc|vendor/etc|g' "${2}"
		sed -i -e 's|system/lib/hw|vendor/lib/hw|g' "${2}"
		sed -i -e 's|etc/acdbdata|vendor/etc/a|g' "${2}"
		;;
	vendor/lib?(64)/libaudioalsa.so)
		sed -i -e 's|system/etc|vendor/etc|g' "${2}"
		sed -i -e 's|system/lib/hw|vendor/lib/hw|g' "${2}"
		sed -i -e 's|etc/acdbdata|vendor/etc/a|g' "${2}"
		;;
	vendor/lib?(64)/libcne.so)
		sed -i -e 's|system/etc|vendor/etc|g' "${2}"
		sed -i -e 's|libprotobuf-cpp-lite\.so|libprotobuf-cpp-Hlte.so|g' "${2}"
		;;
	vendor/lib?(64)/libcneapiclient.so)
		sed -i -e 's|libprotobuf-cpp-lite\.so|libprotobuf-cpp-Hlte.so|g' "${2}"
		;;
	vendor/lib?(64)/libdpmframework.so)
		sed -i -e 's|system/etc|vendor/etc|g' "${2}"
		;;
	vendor/lib?(64)/libmm-qdcm.so)
		sed -i -e 's|system/etc|vendor/etc|g' "${2}"
		;;
	vendor/lib/liboemcrypto.so)
		sed -i -e 's|system/etc|vendor/etc|g' "${2}"
		;;
	vendor/lib?(64)/librs_adreno.so)
		sed -i -e 's|system/lib|vendor/lib|g' "${2}"
		;;
	vendor/lib/libsmwrapper.so)
		sed -i -e 's|system/etc|vendor/etc|g' "${2}"
		sed -i -e 's|system/lib/hw|vendor/lib/hw|g' "${2}"
		sed -i -e 's|etc/acdbdata|vendor/etc/a|g' "${2}"
		;;
	vendor/lib/libvpplibrary.so)
		sed -i -e 's|system/etc|vendor/etc|g' "${2}"
		;;
	vendor/lib64/liblbs_core.so)
		sed -i -e 's|system/priv-app|vendor/priv-app|g' "${2}"
		;;
	vendor/lib64/librpmb.so)
		sed -i -e 's|system/etc|vendor/etc|g' "${2}"
		;;
	vendor/lib64/libSecureUILib.so)
		sed -i -e 's|system/etc|vendor/etc|g' "${2}"
		;;
	vendor/lib64/vendor.qti.gnss@1.0.so)
		patchelf --replace-needed "android.hardware.gnss@1.0.so" "android.hardware.gnss@1.0-v27.so" "${2}"
		;;
	vendor/lib64/vendor.qti.gnss@1.0.so_vendor.so)
		patchelf --replace-needed "android.hardware.gnss@1.0.so" "android.hardware.gnss@1.0-v27.so" "${2}"
		;;
	recovery/root/sbin/qseecomd)
		# Inspired by bootable/recovery-twrp/prebuilt/relink.sh
		sed -i \
			-e "s|/system/bin/linker64\x00|/sbin/linker64\x00\x00\x00\x00\x00\x00\x00|g" \
			-e "s|/system/bin/linker\x00|/sbin/linker\x00\x00\x00\x00\x00\x00\x00|g" \
			-e "s|/system/bin/sh\x00|/sbin/sh\x00\x00\x00\x00\x00\x00\x00|g" \
			-e "s|/system/lib64\x00|/sbin\x00\x00\x00\x00\x00\x00\x00\x00\x00|g" \
			-e "s|/system/lib\x00|/sbin\x00\x00\x00\x00\x00\x00\x00|g" "${2}"
		;;
	vendor/bin/netmgrd)
		sed -i -e 's|system/etc|vendor/etc|g' "${2}"
		# Replace AID 2950 with 2901 (see commit eb1abadf)
		sed -i -e "s|\xBC\x0B\x00\x00\xBB\x0B\x00\x00\x86\x0B\x00\x00\xE8\x03\x00\x00|\xBC\x0B\x00\x00\x55\x0B\x00\x00\x86\x0B\x00\x00\xE8\x03\x00\x00|g" "${2}"
		;;
	vendor/bin/qmuxd)
		sed -i -e 's|system/etc|vendor/etc|g' "${2}"
		;;
	vendor/lib?(64)/libdsi_netctrl.so)
		sed -i -e 's|system/etc|vendor/etc|g' "${2}"
		;;
	vendor/lib?(64)/libril-qc-qmi-1.so)
		sed -i -e 's|system/etc|vendor/etc|g' "${2}"
		;;
	esac
}

# Initialize the helper for YTX703-common
(
	setup_vendor "${DEVICE_COMMON}" "${VENDOR}" "${LINEAGE_ROOT}" true "${CLEAN_VENDOR}"
	extract "${MY_DIR}/proprietary-files.txt" "${SRC}" \
			${KANG} --section "${SECTION}"
	if [ -s "${MY_DIR}/proprietary-files-twrp.txt" ]; then
		extract "${MY_DIR}/proprietary-files-twrp.txt" "${SRC}" \
			${KANG} --section "${SECTION}"
	fi
)

# Reinitialize the helper for YTX703-common/${device}
(
	setup_vendor "${DEVICE}" "${VENDOR}/${DEVICE_COMMON}" "${LINEAGE_ROOT}" false "${CLEAN_VENDOR}"
	extract "${MY_DIR}/${DEVICE}/proprietary-files.txt" "${SRC}" \
			${KANG} --section "${SECTION}"
	if [ -s "${MY_DIR}/${DEVICE}/proprietary-files-twrp.txt" ]; then
		extract "${MY_DIR}/${DEVICE}/proprietary-files-twrp.txt" "$SRC" \
			${KANG} --section "${SECTION}"
	fi
)

"${MY_DIR}/setup-makefiles.sh" "${CLEAN_VENDOR}"
